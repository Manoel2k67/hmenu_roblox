local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local TrollRuntime = {}

local TARGET_DEBOUNCE = 0.8

function TrollRuntime:Create()
    if type(_G.__HMENU_TROLL_CLEANUP) == "function" then
        pcall(_G.__HMENU_TROLL_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local connections = {}
    local touchConnections = {}
    local targetDebounce = setmetatable({}, { __mode = "k" })
    local destroyed = false
    local cleanupFunction
    local actionToken = 0
    local flinging = false
    local activeRestore
    local ownImpulseActive = false

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
        if not character then return nil end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
            or (humanoid and humanoid.RootPart)

        if not humanoid
            or humanoid.Health <= 0
            or not root
            or not root:IsA("BasePart") then
            return nil
        end

        return character, root, humanoid
    end

    local function playerFromPart(part)
        local ancestor = part
        while ancestor and ancestor ~= Workspace do
            if ancestor:IsA("Model") then
                local player = Players:GetPlayerFromCharacter(ancestor)
                if player then return player end
            end
            ancestor = ancestor.Parent
        end
        return nil
    end

    local function selectedPlayer()
        local name = settings.SelectedPlayer
        if type(name) ~= "string"
            or name == "Select a player"
            or name == "No players available" then
            return nil
        end
        return Players:FindFirstChild(name)
    end

    local function fling(targetPlayer, requireTouchEnabled)
        if destroyed or flinging then return false end

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
        local targetCharacter, targetRoot, targetHumanoid = livingCharacter(targetPlayer)

        if not character or not root or not humanoid
            or not targetCharacter or not targetRoot or not targetHumanoid then
            return false
        end

        if root.Anchored or targetRoot.Anchored
            or humanoid.SeatPart or targetHumanoid.SeatPart then
            return false
        end

        local duration = 1.1
        local cooldown = tonumber(TARGET_DEBOUNCE) or 0.8
        local maxSpeed = 240

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
        ownImpulseActive = true
        _G.__HMENU_TROLL_IMPULSE = true
        targetDebounce[targetPlayer] = now + cooldown

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
            if not sameCharacter() then return end
            zeroVelocity()
            character:PivotTo(originalPivot)
            zeroVelocity()
        end

        local function restore()
            if restored then return end
            restored = true

            if watchdog then
                watchdog:Disconnect()
                watchdog = nil
            end

            if activeRestore ~= restore then return end

            pcall(function()
                if moved then returnToOrigin() end
            end)

            pcall(function()
                if humanoid.Parent then
                    humanoid.AutoRotate = originalAutoRotate
                end
                if moved and sameCharacter() then
                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)

            if targetPlayer.Parent == Players then
                targetDebounce[targetPlayer] = os.clock() + cooldown
            else
                targetDebounce[targetPlayer] = nil
            end

            activeRestore = nil
            flinging = false
            if ownImpulseActive then
                ownImpulseActive = false
                _G.__HMENU_TROLL_IMPULSE = nil
            end

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
                        if not ok then return end
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
            if os.clock() - startedAt >= duration then
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

        watchdog = RunService.PostSimulation:Connect(function()
            local ok, stop = pcall(function()
                return not valid()
            end)
            if not ok or stop then restore() end
        end)

        task.spawn(function()
            local ok, err = pcall(function()
                if not valid() then return end

                humanoid.AutoRotate = false

                while valid() do
                    RunService.Heartbeat:Wait()
                    if not valid() then break end

                    local targetVelocity = targetRoot.AssemblyLinearVelocity

                    local prediction = Vector3.new(
                        targetVelocity.X,
                        0,
                        targetVelocity.Z
                    ) * 0.025
                    if prediction.Magnitude > 1 then
                        prediction = prediction.Unit
                    end

                    local predicted = targetRoot.Position + prediction
                    local position = predicted + side * 1.05
                        + Vector3.new(0, 0.35, 0)

                    if position.Y < Workspace.FallenPartsDestroyHeight + 60 then
                        break
                    end

                    local desiredRoot = CFrame.new(position) * originalRoot.Rotation

                    moved = true
                    zeroVelocity()
                    character:PivotTo(desiredRoot * pivotToRoot:Inverse())

                    local velocity = targetVelocity
                        - side * 180
                        + Vector3.new(0, 35, 0)
                    if velocity.Magnitude > maxSpeed then
                        velocity = velocity.Unit * maxSpeed
                    end

                    root.AssemblyLinearVelocity = velocity
                    root.AssemblyAngularVelocity = Vector3.new(0, 2500, 0)
                end
            end)

            restore()
            if not ok then
                warn("[HMenu] Fling error:", err)
            end
        end)

        task.delay(duration + 0.2, function()
            if not restored and activeRestore == restore then
                restore()
            end
        end)

        return true
    end

    local function onTouched(part)
        if destroyed
            or not settings.TouchFling
            or not part
            or not part.Parent then
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
        if not settings.TouchFling or not character then return end

        for _, descendant in ipairs(character:GetDescendants()) do
            watchPart(descendant)
        end
        connect(touchConnections, character.DescendantAdded, watchPart)
    end

    connect(connections, localPlayer.CharacterAdded, function(character)
        actionToken += 1
        if activeRestore then activeRestore() end

        task.defer(function()
            if not destroyed
                and settings.TouchFling
                and character == localPlayer.Character then
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
        if source ~= "Players" then return { "None" } end

        local names = { "Select a player" }
        local playerNames = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        table.sort(playerNames, function(a, b)
            return string.lower(a) < string.lower(b)
        end)
        for _, name in ipairs(playerNames) do
            table.insert(names, name)
        end
        if #names == 1 then
            table.insert(names, "No players available")
        end
        return names
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end

        if name == "SelectedPlayer" then
            settings.SelectedPlayer = tostring(value)
            return
        end

        if name == "FlingSelected" then
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
        actionToken += 1
        if activeRestore then activeRestore() end

        if settings.TouchFling then
            bindCharacter(localPlayer.Character)
        else
            disconnectAll(touchConnections)
            targetDebounce = setmetatable({}, { __mode = "k" })
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.TouchFling = false
        actionToken += 1
        if activeRestore then activeRestore() end
        disconnectAll(touchConnections)
        disconnectAll(connections)
        targetDebounce = setmetatable({}, { __mode = "k" })
        if ownImpulseActive then
            ownImpulseActive = false
            _G.__HMENU_TROLL_IMPULSE = nil
        end

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
