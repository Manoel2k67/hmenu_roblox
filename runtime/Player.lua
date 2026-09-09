local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local PlayerRuntime = {}

local function destroy(object)
    if object then pcall(function() object:Destroy() end) end
end

function PlayerRuntime:Create()
    if type(_G.__HMENU_PLAYER_CLEANUP) == "function" then
        pcall(_G.__HMENU_PLAYER_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local connections = {}
    local collisionState = {}
    local humanoidOriginals = {}
    local destroyed = false
    local cleanupFunction
    local antiAfkConnection
    local flyRoot, flyHumanoid, flyVelocity, flyGyro
    local flyPlatformStand, flyAutoRotate
    local lastSafeCFrame
    local statsTouched = { WalkSpeed = false, JumpPower = false }

    local settings = {
        WalkSpeed = 16,
        LockWalkSpeed = false,
        JumpPower = 50,
        LockJumpPower = false,
        InfiniteJump = false,
        Fly = false,
        FlySpeed = 60,
        Noclip = false,
        AntiFling = false,
        AntiVoid = false,
        AntiAFK = false,
        AntiSit = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function character()
        return localPlayer.Character
    end

    local function humanoid()
        local current = character()
        return current and current:FindFirstChildOfClass("Humanoid")
    end

    local function rootPart()
        local current = character()
        return current and current:FindFirstChild("HumanoidRootPart")
    end

    local function rememberHumanoid(currentHumanoid)
        if currentHumanoid and not humanoidOriginals[currentHumanoid] then
            humanoidOriginals[currentHumanoid] = {
                WalkSpeed = currentHumanoid.WalkSpeed,
                JumpPower = currentHumanoid.JumpPower,
                UseJumpPower = currentHumanoid.UseJumpPower,
            }
        end
    end

    local function applyWalkSpeed()
        local currentHumanoid = humanoid()
        if not currentHumanoid then return end
        rememberHumanoid(currentHumanoid)
        currentHumanoid.WalkSpeed = settings.WalkSpeed
    end

    local function applyJumpPower()
        local currentHumanoid = humanoid()
        if not currentHumanoid then return end
        rememberHumanoid(currentHumanoid)
        currentHumanoid.UseJumpPower = true
        currentHumanoid.JumpPower = settings.JumpPower
    end

    local function restoreCollisions()
        for part, canCollide in pairs(collisionState) do
            if part and part.Parent then part.CanCollide = canCollide end
        end
        collisionState = {}
    end

    local function applyNoclip()
        local current = character()
        if not current then return end
        for _, part in ipairs(current:GetDescendants()) do
            if part:IsA("BasePart") then
                if collisionState[part] == nil then collisionState[part] = part.CanCollide end
                part.CanCollide = false
            end
        end
    end

    local function stopFly()
        destroy(flyVelocity)
        destroy(flyGyro)
        flyVelocity, flyGyro = nil, nil
        if flyHumanoid and flyHumanoid.Parent then
            flyHumanoid.PlatformStand = flyPlatformStand == true
            flyHumanoid.AutoRotate = flyAutoRotate ~= false
            flyHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        flyRoot, flyHumanoid = nil, nil
        flyPlatformStand, flyAutoRotate = nil, nil
    end

    local function ensureFly()
        if not settings.Fly then
            stopFly()
            return false
        end
        local root = rootPart()
        local currentHumanoid = humanoid()
        if not root or not currentHumanoid then
            stopFly()
            return false
        end
        if flyRoot == root and flyVelocity and flyVelocity.Parent and flyGyro and flyGyro.Parent then
            return true
        end

        stopFly()
        flyRoot, flyHumanoid = root, currentHumanoid
        flyPlatformStand, flyAutoRotate = currentHumanoid.PlatformStand, currentHumanoid.AutoRotate
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.Name = "HMenuFlyVelocity"
        flyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        flyVelocity.P = 12500
        flyVelocity.Velocity = Vector3.zero
        flyVelocity.Parent = root
        flyGyro = Instance.new("BodyGyro")
        flyGyro.Name = "HMenuFlyGyro"
        flyGyro.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
        flyGyro.P = 20000
        flyGyro.D = 500
        flyGyro.CFrame = root.CFrame
        flyGyro.Parent = root
        currentHumanoid.PlatformStand = true
        currentHumanoid.AutoRotate = false
        return true
    end

    local function flyDirection(camera, currentHumanoid)
        local direction = Vector3.zero
        local keyboardDirection = false
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + camera.CFrame.LookVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - camera.CFrame.LookVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camera.CFrame.RightVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camera.CFrame.RightVector
            keyboardDirection = true
        end
        if not keyboardDirection and currentHumanoid.MoveDirection.Magnitude > 0 then
            direction = direction + currentHumanoid.MoveDirection
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        return direction.Magnitude > 0 and direction.Unit or Vector3.zero
    end

    local function updateFly()
        if not settings.Fly or not ensureFly() then return end
        local camera = Workspace.CurrentCamera
        if not camera or not flyRoot or not flyHumanoid then return end
        flyHumanoid.PlatformStand = true
        flyHumanoid.AutoRotate = false
        flyVelocity.Velocity = flyDirection(camera, flyHumanoid) * settings.FlySpeed
        local look = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
        if look.Magnitude > 0.001 then
            flyGyro.CFrame = CFrame.lookAt(flyRoot.Position, flyRoot.Position + look.Unit)
        end
    end

    local function captureSafePosition()
        local root = rootPart()
        local currentHumanoid = humanoid()
        if not root or not currentHumanoid then return end
        local voidLevel = Workspace.FallenPartsDestroyHeight
        local grounded = currentHumanoid.FloorMaterial ~= Enum.Material.Air
        local stable = root.AssemblyLinearVelocity.Magnitude < 90 and root.AssemblyAngularVelocity.Magnitude < 35
        if grounded and stable and root.Position.Y > voidLevel + 30 then
            lastSafeCFrame = root.CFrame
        end
    end

    local function recover(messageCondition)
        local root = rootPart()
        if not root or not lastSafeCFrame or not messageCondition then return false end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = lastSafeCFrame
        return true
    end

    local safetyElapsed = 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        if settings.LockWalkSpeed then applyWalkSpeed() end
        if settings.LockJumpPower then applyJumpPower() end

        local currentHumanoid = humanoid()
        if settings.AntiSit and currentHumanoid and currentHumanoid.Sit then
            currentHumanoid.Sit = false
            currentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        safetyElapsed = safetyElapsed + deltaTime
        if safetyElapsed < 0.12 then return end
        safetyElapsed = 0
        if settings.AntiFling or settings.AntiVoid then captureSafePosition() end
        local root = rootPart()
        if not root or settings.Fly then return end
        local ownTrollImpulse = rawget(_G, "__HMENU_TROLL_IMPULSE") ~= nil
        if settings.AntiFling and not ownTrollImpulse then
            local flung = root.AssemblyLinearVelocity.Magnitude > 250 or root.AssemblyAngularVelocity.Magnitude > 100
            recover(flung)
        end
        if settings.AntiVoid then
            recover(root.Position.Y <= Workspace.FallenPartsDestroyHeight + 25)
        end
    end)

    connect(RunService.Stepped, function()
        if settings.Noclip then applyNoclip() end
    end)
    connect(RunService.RenderStepped, updateFly)
    connect(UserInputService.JumpRequest, function()
        if not settings.InfiniteJump then return end
        local currentHumanoid = humanoid()
        if currentHumanoid then currentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    connect(localPlayer.CharacterAdded, function(newCharacter)
        stopFly()
        restoreCollisions()
        lastSafeCFrame = nil
        task.delay(0.5, function()
            if destroyed or newCharacter ~= character() then return end
            if statsTouched.WalkSpeed or settings.LockWalkSpeed then applyWalkSpeed() end
            if statsTouched.JumpPower or settings.LockJumpPower then applyJumpPower() end
            captureSafePosition()
        end)
    end)

    local function setAntiAfk(enabled)
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
        if not enabled then return end
        antiAfkConnection = localPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.zero, Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or CFrame.new())
                task.wait(0.1)
                VirtualUser:Button2Up(Vector2.zero, Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or CFrame.new())
            end)
        end)
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "WalkSpeed" then
            statsTouched.WalkSpeed = true
            applyWalkSpeed()
        elseif name == "JumpPower" then
            statsTouched.JumpPower = true
            applyJumpPower()
        elseif name == "LockWalkSpeed" and value then
            applyWalkSpeed()
        elseif name == "LockJumpPower" and value then
            applyJumpPower()
        elseif name == "Fly" then
            if value then ensureFly() else stopFly() end
        elseif name == "Noclip" and not value then
            restoreCollisions()
        elseif name == "AntiFling" or name == "AntiVoid" then
            if value then captureSafePosition() end
        elseif name == "AntiAFK" then
            setAntiAfk(value)
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.Fly = false
        stopFly()
        restoreCollisions()
        setAntiAfk(false)
        for currentHumanoid, originals in pairs(humanoidOriginals) do
            if currentHumanoid and currentHumanoid.Parent then
                currentHumanoid.WalkSpeed = originals.WalkSpeed
                currentHumanoid.JumpPower = originals.JumpPower
                currentHumanoid.UseJumpPower = originals.UseJumpPower
            end
        end
        for _, connection in ipairs(connections) do pcall(function() connection:Disconnect() end) end
        connections = {}
        if _G.__HMENU_PLAYER_CLEANUP == cleanupFunction then _G.__HMENU_PLAYER_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_PLAYER_CLEANUP = cleanupFunction
    return runtime
end

return PlayerRuntime
