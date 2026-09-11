local function fling(targetPlayer, requireTouchEnabled)
	if destroyed or flinging then
		return false
	end

	if not targetPlayer
		or targetPlayer == localPlayer
		or targetPlayer.Parent ~= Players then
		return false
	end

	if requireTouchEnabled and not settings.TouchFling then
		return false
	end

	local now = os.clock()
	if (targetDebounce[targetPlayer] or 0) > now then
		return false
	end

	local character, root, humanoid = livingCharacter(localPlayer)
	local targetCharacter, targetRoot, targetHumanoid =
		livingCharacter(targetPlayer)

	if not character or not root or not humanoid
		or not targetCharacter or not targetRoot or not targetHumanoid then
		return false
	end

	if root.Anchored or targetRoot.Anchored
		or humanoid.SeatPart or targetHumanoid.SeatPart then
		return false
	end

	local DURATION = 0.65
	local COOLDOWN = tonumber(TARGET_DEBOUNCE) or 0.8
	local MAX_SPEED = 85
	local MAX_TARGET_SPEED = 120
	local MAX_DISTANCE = 18

	local originalPivot = character:GetPivot()
	local originalRoot = root.CFrame
	local originalAutoRotate = humanoid.AutoRotate
	local pivotToRoot = originalPivot:ToObjectSpace(originalRoot)

	local parts = {}
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			parts[#parts + 1] = part
		end
	end

	-- Manter o mesmo lado durante a tentativa.
	local offset = root.Position - targetRoot.Position
	local side = Vector3.new(offset.X, 0, offset.Z)

	if side.Magnitude < 0.01 then
		side = Vector3.new(1, 0, 0)
	else
		side = side.Unit
	end

	actionToken += 1
	local token = actionToken
	local startedAt = os.clock()
	local restored = false
	local moved = false
	local watchdog

	flinging = true
	targetDebounce[targetPlayer] = now + COOLDOWN

	local function sameCharacter()
		return localPlayer.Character == character
			and character:IsDescendantOf(Workspace)
			and root:IsDescendantOf(character)
			and humanoid:IsDescendantOf(character)
			and humanoid.Health > 0
	end

	local function zeroVelocity()
		for _, part in ipairs(parts) do
			if part:IsDescendantOf(character) then
				pcall(function()
					part.AssemblyLinearVelocity = Vector3.zero
					part.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end
	end

	local function returnToOrigin()
		if not sameCharacter() then
			return
		end

		zeroVelocity()
		character:PivotTo(originalPivot)
		zeroVelocity()
	end

	local function restore()
		if restored then
			return
		end

		restored = true

		if watchdog then
			watchdog:Disconnect()
			watchdog = nil
		end

		-- Não interferir em outra ação.
		if activeRestore ~= restore then
			return
		end

		pcall(function()
			if moved then
				returnToOrigin()
			end
		end)

		pcall(function()
			if humanoid.Parent then
				humanoid.AutoRotate = originalAutoRotate
			end

			if moved and sameCharacter() then
				humanoid:ChangeState(
					Enum.HumanoidStateType.GettingUp
				)
			end
		end)

		if targetPlayer.Parent == Players then
			targetDebounce[targetPlayer] = os.clock() + COOLDOWN
		else
			targetDebounce[targetPlayer] = nil
		end

		activeRestore = nil
		flinging = false

		-- Corrigir movimento residual sem afetar uma ação nova.
		if moved then
			task.spawn(function()
				for _ = 1, 6 do
					RunService.PostSimulation:Wait()

					if destroyed
						or token ~= actionToken
						or flinging
						or not sameCharacter() then
						return
					end

					local ok = pcall(returnToOrigin)
					if not ok then
						return
					end
				end
			end)
		end
	end

	activeRestore = restore

	local function valid()
		if destroyed or restored or token ~= actionToken then
			return false
		end

		if requireTouchEnabled and not settings.TouchFling then
			return false
		end

		if os.clock() - startedAt >= DURATION then
			return false
		end

		if not sameCharacter() then
			return false
		end

		if targetPlayer.Parent ~= Players
			or targetPlayer.Character ~= targetCharacter
			or not targetCharacter:IsDescendantOf(Workspace)
			or not targetRoot:IsDescendantOf(targetCharacter)
			or not targetHumanoid:IsDescendantOf(targetCharacter)
			or targetHumanoid.Health <= 0 then
			return false
		end

		return not root.Anchored
			and not targetRoot.Anchored
			and not humanoid.SeatPart
			and not targetHumanoid.SeatPart
	end

	local function unsafe()
		if not moved then
			return false
		end

		return root.Position.Y < Workspace.FallenPartsDestroyHeight + 60
			or root.Position.Y < originalRoot.Position.Y - 25
			or (root.Position - targetRoot.Position).Magnitude > MAX_DISTANCE
			or root.AssemblyLinearVelocity.Magnitude > 150
			or targetRoot.AssemblyLinearVelocity.Magnitude > MAX_TARGET_SPEED
	end

	-- Verificar também depois da simulação física.
	watchdog = RunService.PostSimulation:Connect(function()
		local ok, stop = pcall(function()
			return not valid() or unsafe()
		end)

		if not ok or stop then
			restore()
		end
	end)

	task.spawn(function()
		local ok, err = pcall(function()
			if not valid() then
				return
			end

			humanoid.AutoRotate = false

			while valid() do
				RunService.PreSimulation:Wait()

				if not valid() or unsafe() then
					break
				end

				local targetVelocity = targetRoot.AssemblyLinearVelocity
				if targetVelocity.Magnitude > MAX_TARGET_SPEED then
					break
				end

				-- Previsão horizontal curta e limitada.
				local prediction = Vector3.new(
					targetVelocity.X,
					0,
					targetVelocity.Z
				) * 0.025

				if prediction.Magnitude > 1 then
					prediction = prediction.Unit
				end

				local predicted = targetRoot.Position + prediction
				local position = predicted + side * 1.15
					+ Vector3.new(0, 0.35, 0)

				-- Não iniciar uma tentativa perto do vazio.
				if position.Y < Workspace.FallenPartsDestroyHeight + 60
					or position.Y < originalRoot.Position.Y - 25 then
					break
				end

				local desiredRoot = CFrame.new(position)
					* originalRoot.Rotation

				moved = true
				zeroVelocity()

				character:PivotTo(
					desiredRoot * pivotToRoot:Inverse()
				)

				local velocity = targetVelocity
					- side * 50
					+ Vector3.new(0, 8, 0)

				if velocity.Magnitude > MAX_SPEED then
					velocity = velocity.Unit * MAX_SPEED
				end

				root.AssemblyLinearVelocity = velocity
				root.AssemblyAngularVelocity = Vector3.new(0, 80, 0)
			end
		end)

		restore()

		if not ok then
			warn("[HMenu] Fling error:", err)
		end
	end)

	-- Retaguarda caso a rotina principal não finalize normalmente.
	task.delay(DURATION + 0.2, function()
		if not restored and activeRestore == restore then
			restore()
		end
	end)

	-- true significa tentativa iniciada, não alvo lançado.
	return true
end