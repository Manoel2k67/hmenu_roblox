local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local TrollRuntime = {}

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
    local impulseMarker = {}

    local settings = {
        TouchFling = false,
    }

    local function connect(bucket, signal, callback)
        local connection = signal:Connect(callback)
        table.insert(bucket, connection)
        return connection
    end

    local function disconnectAll(bucket)
        for index = #bucket, 1, -1 do
            pcall(function() bucket[index]:Disconnect() end)
            table.remove(bucket, index)
        end
    end

    local function livingRoot(character)
        if not character then return nil end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
        if not humanoid or humanoid.Health <= 0 or not root or not root:IsA("BasePart") then
            return nil
        end
        return root, humanoid
    end

    local function playerFromPart(part)
        local ancestor = part
        while ancestor do
            if ancestor:IsA("Model") then
                local player = Players:GetPlayerFromCharacter(ancestor)
                if player then return player end
            end
            ancestor = ancestor.Parent
        end
        return nil
    end

    local function fling(targetPlayer)
        if destroyed or not settings.TouchFling or flinging or targetPlayer == localPlayer then return end

        local now = os.clock()
        if (targetDebounce[targetPlayer] or 0) > now then return end
        targetDebounce[targetPlayer] = now + 1

        local targetRoot, targetHumanoid = livingRoot(targetPlayer.Character)
        local localRoot = livingRoot(localPlayer.Character)
        if not targetRoot or not targetHumanoid or not localRoot then return end

        flinging = true
        _G.__HMENU_TROLL_IMPULSE = impulseMarker
        actionToken = actionToken + 1
        local token = actionToken
        local savedCFrame = targetRoot.CFrame
        local savedLinearVelocity = targetRoot.AssemblyLinearVelocity
        local savedAngularVelocity = targetRoot.AssemblyAngularVelocity
        local savedAutoRotate = targetHumanoid.AutoRotate
        local restored = false

        local function restore()
            if restored then return end
            restored = true
            if targetRoot and targetRoot.Parent then
                targetRoot.AssemblyLinearVelocity = savedLinearVelocity
                targetRoot.AssemblyAngularVelocity = savedAngularVelocity
                targetRoot.CFrame = savedCFrame
            end
            if targetHumanoid and targetHumanoid.Parent then
                targetHumanoid.AutoRotate = savedAutoRotate
            end
            if _G.__HMENU_TROLL_IMPULSE == impulseMarker then
                _G.__HMENU_TROLL_IMPULSE = nil
            end
            if activeRestore == restore then activeRestore = nil end
            flinging = false
        end
        activeRestore = restore

        task.spawn(function()
            local ok, err = pcall(function()
                local startedAt = os.clock()
                targetHumanoid.AutoRotate = false

                while not destroyed and settings.TouchFling and token == actionToken
                    and os.clock() - startedAt < 0.28 do
                    local currentTargetRoot = livingRoot(targetPlayer.Character)
                    local currentLocalRoot = livingRoot(localPlayer.Character)
                    if not currentTargetRoot or not currentLocalRoot then break end

                    local horizontal = currentTargetRoot.Position - currentLocalRoot.Position
                    horizontal = Vector3.new(horizontal.X, 0, horizontal.Z)
                    if horizontal.Magnitude < 0.05 then
                        horizontal = Vector3.new(currentLocalRoot.CFrame.LookVector.X, 0,
                            currentLocalRoot.CFrame.LookVector.Z)
                    end
                    local direction = horizontal.Magnitude > 0.05 and horizontal.Unit or Vector3.new(1, 0, 0)

                    currentTargetRoot.AssemblyLinearVelocity = Vector3.new(direction.X * 9000, 12000,
                        direction.Z * 9000)
                    currentTargetRoot.AssemblyAngularVelocity = Vector3.new(0, 100000, 0)
                    RunService.Heartbeat:Wait()
                end
            end)

            restore()
            if not ok then warn("[HMenu] Touch Fling error:", err) end
        end)
    end

    local function onTouched(part)
        if destroyed or not settings.TouchFling or not part or not part.Parent then return end
        local targetPlayer = playerFromPart(part)
        if targetPlayer and targetPlayer ~= localPlayer then fling(targetPlayer) end
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
        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        task.defer(function()
            if not destroyed and settings.TouchFling and character == localPlayer.Character then
                bindCharacter(character)
            end
        end)
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value == true
        if name ~= "TouchFling" then return end

        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        if settings.TouchFling then
            bindCharacter(localPlayer.Character)
        else
            disconnectAll(touchConnections)
            targetDebounce = {}
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.TouchFling = false
        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        disconnectAll(touchConnections)
        disconnectAll(connections)
        targetDebounce = {}
        if _G.__HMENU_TROLL_IMPULSE == impulseMarker then _G.__HMENU_TROLL_IMPULSE = nil end
        if _G.__HMENU_TROLL_CLEANUP == cleanupFunction then _G.__HMENU_TROLL_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_TROLL_CLEANUP = cleanupFunction
    return runtime
end

return TrollRuntime
