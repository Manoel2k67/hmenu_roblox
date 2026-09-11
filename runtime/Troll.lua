local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local TrollRuntime = {}

local FLING_DURATION = 1.4
local TARGET_DEBOUNCE = 0.8
local PREDICTION_TIME = 0.05
local FLING_OFFSETS = {
	CFrame.new(0, 1.2, 0),
	CFrame.new(0, -1.2, 0),
	CFrame.new(1.8, 0.8, -1.8),
	CFrame.new(-1.8, -0.8, 1.8),
	CFrame.new(0, 0, 2.2),
	CFrame.new(0, 0, -2.2),
}

function TrollRuntime:Create()
	if type(_G.__HMENU_TROLL_CLEANUP) == "function" then
		pcall(_G.__HMENU_TROLL_CLEANUP)
	end

	local runtime = {}
	local localPlayer = Players.LocalPlayer
	local connections = {}
	local touchConnections = {}
	local targetDebounce = {}
	local destroyed = false
	local cleanupFunction
	local actionToken = 0
	local flinging = false
	local activeRestore

	local settings = {
		SelectedPlayer = "Select a player",
		FlingSelected = false,
		TouchFling = false,
	}

	local function connect(bucket, signal, callback)
		local connection = signal:Connect(callback)
		table.insert(bucket, connection)
		return connection
	end

	local function disconnectAll(bucket)
		for index = #bucket, 1, -1 do
			pcall(function()
				bucket[index]:Disconnect()
			end)
			table.remove(bucket, index)
		end
	end

	local function livingCharacter(player)
		local character = player and player.Character
		if not character then
			return nil
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart") or (humanoid and humanoid.RootPart)
		if not humanoid or humanoid.Health <= 0 or not root or not root:IsA("BasePart") then
			return nil
		end
		return character, root, humanoid
	end

	local function playerFromPart(part)
		local ancestor = part
		while ancestor do
			if ancestor:IsA("Model") then
				local player = Players:GetPlayerFromCharacter(ancestor)
				if player then
					return player
				end
			end
			ancestor = ancestor.Parent
		end
		return nil
	end

	local function selectedPlayer()
		local name = settings.SelectedPlayer
		if type(name) ~= "string" or name == "Select a player" then
			return nil
		end
		return Players:FindFirstChild(name)
	end

	local function fling(targetPlayer, requireTouchEnabled)
		if destroyed or flinging or not targetPlayer or targetPlayer == localPlayer then
			return false
		end
		if requireTouchEnabled and not settings.TouchFling then
			return false
		end

		local now = os.clock()
		if (targetDebounce[targetPlayer] or 0) > now then
			return false
		end

		local targetCharacter, targetRoot, targetHumanoid = livingCharacter(targetPlayer)
		local localCharacter, localRoot, localHumanoid = livingCharacter(localPlayer)
		if not targetCharacter or not targetRoot or not targetHumanoid
			or not localCharacter or not localRoot or not localHumanoid then
			return false
		end

		targetDebounce[targetPlayer] = now + TARGET_DEBOUNCE
		flinging = true
		actionToken = actionToken + 1
		local token = actionToken

		local originalPivot = localCharacter:GetPivot()
		local originalAutoRotate = localHumanoid.AutoRotate
		local camera = Workspace.CurrentCamera
		local originalCameraSubject = camera and camera.CameraSubject
		local restored = false

		local function restore()
			if restored then
				return
			end
			restored = true

			pcall(function()
				if localCharacter and localCharacter.Parent then
					for _, part in ipairs(localCharacter:GetDescendants()) do
						if part:IsA("BasePart") then
							part.AssemblyLinearVelocity = Vector3.zero
							part.AssemblyAngularVelocity = Vector3.zero
						end
					end
					localCharacter:PivotTo(originalPivot + Vector3.new(0, 1, 0))
				end
			end)

			pcall(function()
				if localHumanoid and localHumanoid.Parent then
					localHumanoid.AutoRotate = originalAutoRotate
					localHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end)

			pcall(function()
				if camera and camera.Parent then
					camera.CameraSubject = originalCameraSubject or localHumanoid
				end
			end)

			if activeRestore == restore then
				activeRestore = nil
			end
			flinging = false
		end
		activeRestore = restore

		task.spawn(function()
			local ok, err = pcall(function()
				localHumanoid.AutoRotate = false
				pcall(function()
					if camera then
						camera.CameraSubject = targetHumanoid
					end
				end)

				local startedAt = os.clock()
				local angle = 0

				while not destroyed and token == actionToken and (os.clock() - startedAt) < FLING_DURATION do
					if requireTouchEnabled and not settings.TouchFling then
						break
					end

					local currentTargetCharacter, currentTargetRoot, currentTargetHumanoid = livingCharacter(targetPlayer)
					local currentLocalCharacter, currentLocalRoot, currentLocalHumanoid = livingCharacter(localPlayer)

					if not currentTargetCharacter or not currentTargetRoot or not currentTargetHumanoid
						or not currentLocalCharacter or not currentLocalRoot or not currentLocalHumanoid
						or currentTargetCharacter ~= targetCharacter
						or currentLocalHumanoid.Health <= 0 then
						break
					end

					if currentTargetRoot.AssemblyLinearVelocity.Magnitude > 400 then
						break
					end

					angle += 120

					local predicted = currentTargetRoot.Position
						+ currentTargetRoot.AssemblyLinearVelocity * PREDICTION_TIME

					for _, offset in ipairs(FLING_OFFSETS) do
						if destroyed or token ~= actionToken then
							break
						end

						currentLocalCharacter:PivotTo(
							CFrame.new(predicted) * offset * CFrame.Angles(math.rad(angle), math.rad(angle * 0.6), 0)
						)

						currentLocalRoot.AssemblyLinearVelocity = Vector3.new(9e7, 9e8, 9e7)
						currentLocalRoot.AssemblyAngularVelocity = Vector3.new(9e8, 9e8, 9e8)

						RunService.Heartbeat:Wait()
					end
				end
			end)

			restore()
			if not ok then
				warn("[HMenu] Fling error:", err)
			end
		end)

		return true
	end

	local function onTouched(part)
		if destroyed or not settings.TouchFling or not part or not part.Parent then
			return
		end
		if localPlayer.Character and part:IsDescendantOf(localPlayer.Character) then
			return
		end
		local targetPlayer = playerFromPart(part)
		if targetPlayer and targetPlayer ~= localPlayer then
			fling(targetPlayer, true)
		end
	end

	local function watchPart(part)
		if part:IsA("BasePart") then
			connect(touchConnections, part.Touched, onTouched)
		end
	end

	local function bindCharacter(character)
		disconnectAll(touchConnections)
		if not settings.TouchFling or not character then
			return
		end
		for _, descendant in ipairs(character:GetDescendants()) do
			watchPart(descendant)
		end
		connect(touchConnections, character.DescendantAdded, watchPart)
	end

	connect(connections, localPlayer.CharacterAdded, function(character)
		actionToken = actionToken + 1
		if activeRestore then
			activeRestore()
		end
		task.defer(function()
			if not destroyed and settings.TouchFling and character == localPlayer.Character then
				bindCharacter(character)
			end
		end)
	end)

	connect(connections, Players.PlayerRemoving, function(player)
		targetDebounce[player] = nil
		if player == selectedPlayer() then
			settings.SelectedPlayer = "Select a player"
		end
	end)

	function runtime:GetOptions(source)
		if source ~= "Players" then
			return { "None" }
		end
		local names = {}
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				table.insert(names, player.Name)
			end
		end
		table.sort(names, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		if #names == 0 then
			return { "No players" }
		end
		return names
	end

	function runtime:Set(name, value)
		if destroyed or settings[name] == nil then
			return
		end

		if name == "SelectedPlayer" then
			settings.SelectedPlayer = tostring(value)
			return
		elseif name == "FlingSelected" then
			settings.FlingSelected = false
			if value == true then
				local target = selectedPlayer()
				if target then
					fling(target, false)
				else
					warn("[HMenu] Select a valid player before using Fling Target.")
				end
			end
			return
		end

		settings.TouchFling = value == true
		actionToken = actionToken + 1
		if activeRestore then
			activeRestore()
		end
		if settings.TouchFling then
			bindCharacter(localPlayer.Character)
		else
			disconnectAll(touchConnections)
			targetDebounce = {}
		end
	end

	function runtime:Destroy()
		if destroyed then
			return
		end
		destroyed = true
		settings.TouchFling = false
		actionToken = actionToken + 1
		if activeRestore then
			activeRestore()
		end
		disconnectAll(touchConnections)
		disconnectAll(connections)
		targetDebounce = {}
		if _G.__HMENU_TROLL_CLEANUP == cleanupFunction then
			_G.__HMENU_TROLL_CLEANUP = nil
		end
	end

	cleanupFunction = function()
		runtime:Destroy()
	end
	_G.__HMENU_TROLL_CLEANUP = cleanupFunction
	return runtime
end

return TrollRuntime