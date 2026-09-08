local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Combat = {}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function rootPart(player)
    local character = player and player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function humanoidOf(player)
    local character = player and player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function toolIn(player, name)
    if not player then return nil end
    local character = player.Character
    local backpack = player:FindFirstChild("Backpack")
    return (character and character:FindFirstChild(name)) or (backpack and backpack:FindFirstChild(name))
end

local function partFromDrop(drop)
    if not drop then return nil end
    if drop:IsA("BasePart") then return drop end
    if drop:IsA("Model") then
        return drop.PrimaryPart or drop:FindFirstChildWhichIsA("BasePart", true)
    end
    return drop:FindFirstChildWhichIsA("BasePart", true)
end

function Combat:Create(options)
    if type(_G.__HMENU_COMBAT_CLEANUP) == "function" then
        pcall(_G.__HMENU_COMBAT_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local localMouse = localPlayer:GetMouse()
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local destroyed = false
    local cleanupFunction
    local connections = {}
    local roles = {}
    local roleRemote = nil
    local roleBusy = false
    local gunActivationConnection = nil
    local boundGun = nil
    local shootBusy = false
    local killAllBusy = false
    local grabBusy = false
    local lastAutoShot = 0
    local lastPerfectShot = 0
    local lastPerfectRedirect = 0
    local lastGrabAttempt = 0
    local lastEvade = 0
    local lastAuraAttack = 0
    local unsupportedGrabWarned = false
    local hitboxOriginals = {}
    local perfectHookState = nil
    local perfectHookHandler = nil
    local perfectMouseHookState = nil
    local perfectMouseHookHandler = nil
    local suppressedGunConnections = {}
    local nativeGunSuppressed = false

    local settings = {
        MurderKillAura = false,
        MurderAuraRadius = 12,
        MurderAttackDelay = 0.15,
        MurderTargetPriority = "Nearest",
        MurderAutoEquipKnife = false,
        MurderEquipKnife = false,
        MurderKillNearest = false,
        MurderKillSheriff = false,
        MurderKillAll = false,

        SheriffPerfectShots = false,
        SheriffShootMurderer = false,
        SheriffAutoShootMurderer = false,
        SheriffShootCooldown = 1.1,
        SheriffTargetPart = "HumanoidRootPart",
        SheriffPrediction = 0.08,
        SheriffIgnoreWalls = false,
        SheriffAutoEquipGun = false,
        SheriffEquipGun = false,
        SheriffAutoGrabGun = false,
        SheriffGrabGunNow = false,

        UtilsAutoEvadeMurderer = false,
        UtilsDangerRadius = 15,
        UtilsEvadeDistance = 30,
        UtilsHitboxExpander = false,
        UtilsHitboxSize = 6,
        UtilsHitboxTarget = "Murderer",
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = make("ScreenGui", {
        Name = "HMenuCombatOverlay",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 997,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local toast = make("Frame", {
        Name = "Toast",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, -60),
        Size = UDim2.fromOffset(350, 44),
        BackgroundColor3 = Color3.fromRGB(24, 38, 65),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Visible = false,
    }, overlay)
    make("UICorner", { CornerRadius = UDim.new(0, 8) }, toast)
    make("UIStroke", { Color = Color3.fromRGB(83, 122, 190), Transparency = 0.25, Thickness = 1 }, toast)
    local toastMarker = make("Frame", {
        Size = UDim2.fromOffset(3, 26), Position = UDim2.fromOffset(0, 9),
        BackgroundColor3 = Color3.fromRGB(102, 151, 246), BorderSizePixel = 0,
    }, toast)
    make("UICorner", { CornerRadius = UDim.new(0, 2) }, toastMarker)
    local toastText = make("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.fromOffset(17, 0),
        BackgroundTransparency = 1, Text = "", TextColor3 = Color3.fromRGB(235, 241, 255),
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)
    local toastVersion = 0

    local function notify(message, success)
        if destroyed then return end
        toastVersion = toastVersion + 1
        local version = toastVersion
        toastText.Text = tostring(message)
        toastMarker.BackgroundColor3 = success and Color3.fromRGB(83, 220, 145) or Color3.fromRGB(255, 118, 126)
        toast.Visible = true
        TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, 0, 0, 20),
        }):Play()
        task.delay(2.2, function()
            if destroyed or version ~= toastVersion then return end
            local tween = TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0, -60),
            })
            tween:Play()
            tween.Completed:Wait()
            if not destroyed and version == toastVersion then toast.Visible = false end
        end)
    end

    local function character()
        return localPlayer.Character
    end

    local function localHumanoid()
        return humanoidOf(localPlayer)
    end

    local function localRoot()
        return rootPart(localPlayer)
    end

    local function refreshRoles()
        if destroyed or roleBusy then return end
        roleBusy = true
        if not roleRemote or not roleRemote.Parent then
            local candidate = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
            if candidate and candidate:IsA("RemoteFunction") then roleRemote = candidate end
        end
        if roleRemote then
            local ok, result = pcall(function()
                return roleRemote:InvokeServer()
            end)
            if ok and type(result) == "table" then roles = result end
        end
        roleBusy = false
    end

    local function roleFromTools(player)
        if toolIn(player, "Knife") then return "Murderer" end
        if toolIn(player, "Gun") then return "Sheriff" end
        return "Innocent"
    end

    local function roleOf(player)
        if not player then return "Unknown" end
        local data = roles[player.Name]
        local role = data and data.Role
        if role == "Murderer" or role == "Sheriff" or role == "Hero" or role == "Innocent" then
            return role
        end
        return roleFromTools(player)
    end

    local function isAlive(player)
        if not player or not player.Parent or not player.Character then return false end
        local root = rootPart(player)
        if not root then return false end
        local humanoid = humanoidOf(player)
        if humanoid then return humanoid.Health > 0 end
        local data = roles[player.Name]
        return not (data and (data.Dead or data.Killed))
    end

    local function findMurderer()
        -- Tool ownership is the freshest role signal during round transitions.
        -- Prefer it over cached GetPlayerData so a stale Innocent role cannot make
        -- Perfect Shots silently keep the original mouse target.
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and toolIn(player, "Knife") then
                return player
            end
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and roleOf(player) == "Murderer" then
                return player
            end
        end
        return nil
    end

    local function isGunCarrier(player)
        if not player or not isAlive(player) then return false end
        local role = roleOf(player)
        return role == "Sheriff" or role == "Hero" or toolIn(player, "Gun") ~= nil
    end

    local function findSheriffOrHero()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isGunCarrier(player) then return player end
        end
        return nil
    end

    local function equipNamedTool(name)
        local currentCharacter = character()
        if not currentCharacter then return nil end
        local equipped = currentCharacter:FindFirstChild(name)
        if equipped then return equipped end
        local backpack = localPlayer:FindFirstChild("Backpack")
        local tool = backpack and backpack:FindFirstChild(name)
        if not tool then return nil end
        local humanoid = localHumanoid()
        if humanoid then
            pcall(function() humanoid:EquipTool(tool) end)
        else
            tool.Parent = currentCharacter
        end
        task.wait()
        return currentCharacter:FindFirstChild(name) or tool
    end

    local function equipKnife(showError)
        local knife = equipNamedTool("Knife")
        if not knife and showError then notify("Knife not found. You must be the Murderer.", false) end
        return knife
    end

    local function equipGun(showError)
        local gun = equipNamedTool("Gun")
        if not gun and showError then notify("Gun not found in Character or Backpack.", false) end
        return gun
    end

    local function targetPartFor(player)
        local currentCharacter = player and player.Character
        if not currentCharacter then return nil end
        if settings.SheriffTargetPart == "Head" then
            return currentCharacter:FindFirstChild("Head") or currentCharacter:FindFirstChild("HumanoidRootPart")
        elseif settings.SheriffTargetPart == "UpperTorso" then
            return currentCharacter:FindFirstChild("UpperTorso") or currentCharacter:FindFirstChild("Torso") or currentCharacter:FindFirstChild("HumanoidRootPart")
        end
        return currentCharacter:FindFirstChild("HumanoidRootPart") or currentCharacter:FindFirstChild("Head")
    end

    local function predictedPosition(player)
        local part = targetPartFor(player)
        if not part then return nil end
        local velocity = Vector3.zero
        pcall(function() velocity = part.AssemblyLinearVelocity end)
        return part.Position + velocity * settings.SheriffPrediction
    end

    local function hasLineOfSight(player)
        if settings.SheriffIgnoreWalls then return true end
        local target = targetPartFor(player)
        if not target then return false end
        local camera = Workspace.CurrentCamera
        local origin = camera and camera.CFrame.Position or (localRoot() and localRoot().Position)
        if not origin then return false end
        local direction = target.Position - origin
        if direction.Magnitude < 0.01 then return true end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = character() and { character() } or {}
        params.IgnoreWater = true
        local result = Workspace:Raycast(origin, direction, params)
        return result == nil or (result.Instance and result.Instance:IsDescendantOf(player.Character))
    end

    local function gunRemote(gun)
        if not gun then return nil end
        local knifeLocal = gun:FindFirstChild("KnifeLocal")
        local createBeam = knifeLocal and knifeLocal:FindFirstChild("CreateBeam", true)
        local direct = createBeam and createBeam:FindFirstChild("RemoteFunction", true)
        if direct and direct:IsA("RemoteFunction") then
            return direct
        end
        for _, descendant in ipairs(gun:GetDescendants()) do
            if descendant:IsA("RemoteFunction") and descendant.Name == "RemoteFunction" then
                local node = descendant.Parent
                for _ = 1, 8 do
                    if not node then break end
                    if node.Name == "CreateBeam" then return descendant end
                    node = node.Parent
                end
            end
        end
        return nil
    end

    local function fireGunAt(player, showError)
        if shootBusy or not player or not isAlive(player) then return false end
        shootBusy = true
        local gun = equipGun(showError)
        if not gun then
            shootBusy = false
            return false
        end
        local remote = gunRemote(gun)
        local position = predictedPosition(player)
        if not remote or not position then
            if showError then notify("Gun shot remote or target part was not found.", false) end
            shootBusy = false
            return false
        end
        local ok = pcall(function()
            remote:InvokeServer(1, position, "AH2")
        end)
        shootBusy = false
        if showError then
            notify(ok and "Shot sent directly to Murderer." or "Could not fire the Gun remote.", ok)
        end
        return ok
    end

    local function shootMurderer(showError)
        refreshRoles()
        local murderer = findMurderer()
        if not murderer then
            if showError then notify("Murderer not found yet.", false) end
            return false
        end
        return fireGunAt(murderer, showError)
    end

    local function remoteLooksLikeGunShot(remote)
        if typeof(remote) ~= "Instance" or not remote:IsA("RemoteFunction") then return false end

        -- Prefer comparing against the remote discovered from the Gun the player
        -- actually owns. Some MM2 versions add wrappers between CreateBeam and the
        -- RemoteFunction, which made the old ancestry-only check miss the shot.
        local currentGun = toolIn(localPlayer, "Gun")
        if currentGun and gunRemote(currentGun) == remote then return true end

        local node = remote.Parent
        local hasCreateBeam = false
        for _ = 1, 12 do
            if not node then break end
            if node.Name == "CreateBeam" then
                hasCreateBeam = true
            elseif hasCreateBeam and node:IsA("Tool") and node.Name == "Gun" then
                return true
            end
            node = node.Parent
        end
        return false
    end

    local function ensurePerfectShotHook()
        local existing = rawget(_G, "__HMENU_COMBAT_NAMECALL_HOOK")
        if type(existing) == "table" and existing.Installed then
            perfectHookState = existing
            return existing
        end
        if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" or type(newcclosure) ~= "function" then
            return nil
        end

        local state = { Installed = false, Handler = nil, Busy = false }
        local oldNamecall
        local ok, result = pcall(function()
            oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local handler = state.Handler
                if handler and not state.Busy and method == "InvokeServer" then
                    state.Busy = true
                    local handledOk, handled, packed = pcall(handler, self, ...)
                    state.Busy = false
                    if handledOk and handled and packed then
                        return oldNamecall(self, table.unpack(packed, 1, packed.n))
                    end
                end
                return oldNamecall(self, ...)
            end))
            return oldNamecall
        end)
        if not ok or not result then return nil end

        state.Old = oldNamecall
        state.Installed = true
        _G.__HMENU_COMBAT_NAMECALL_HOOK = state
        perfectHookState = state
        return state
    end

    perfectHookHandler = function(remote, ...)
        if destroyed or not settings.SheriffPerfectShots or not remoteLooksLikeGunShot(remote) then
            return false
        end
        local murderer = findMurderer()
        local position = murderer and predictedPosition(murderer)
        if not position then return false end
        local args = table.pack(...)

        -- MM2's normal signature stores the hit position in argument 2. Prefer it
        -- when several spatial arguments exist so an origin CFrame is not changed.
        local order = {}
        if args.n >= 2 then table.insert(order, 2) end
        for index = 1, args.n do
            if index ~= 2 then table.insert(order, index) end
        end
        for _, index in ipairs(order) do
            local argumentType = typeof(args[index])
            if argumentType == "Vector3" then
                args[index] = position
                lastPerfectRedirect = tick()
                return true, args
            elseif argumentType == "CFrame" then
                args[index] = CFrame.new(position)
                lastPerfectRedirect = tick()
                return true, args
            end
        end
        return false
    end

    local function enablePerfectShotHook()
        local state = ensurePerfectShotHook()
        if not state then return false end
        state.Handler = perfectHookHandler
        return true
    end

    local function disablePerfectShotHook()
        local state = perfectHookState or rawget(_G, "__HMENU_COMBAT_NAMECALL_HOOK")
        if type(state) == "table" and state.Handler == perfectHookHandler then
            state.Handler = nil
        end
    end

    local function ensurePerfectMouseHook()
        local existing = rawget(_G, "__HMENU_COMBAT_MOUSE_HOOK")
        if type(existing) == "table" and existing.Installed then
            perfectMouseHookState = existing
            return existing
        end
        if type(hookmetamethod) ~= "function" or type(newcclosure) ~= "function" then
            return nil
        end

        local state = { Installed = false, Handler = nil, Busy = false }
        local oldIndex
        local ok, result = pcall(function()
            oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
                local handler = state.Handler
                if handler and not state.Busy then
                    state.Busy = true
                    local handledOk, handled, value = pcall(handler, self, key)
                    state.Busy = false
                    if handledOk and handled then return value end
                end
                return oldIndex(self, key)
            end))
            return oldIndex
        end)
        if not ok or not result then return nil end

        state.Old = oldIndex
        state.Installed = true
        _G.__HMENU_COMBAT_MOUSE_HOOK = state
        perfectMouseHookState = state
        return state
    end

    perfectMouseHookHandler = function(object, key)
        if destroyed or not settings.SheriffPerfectShots or object ~= localMouse then
            return false
        end
        if key ~= "Hit" and key ~= "Target" and key ~= "UnitRay" then
            return false
        end

        local murderer = findMurderer()
        local part = murderer and targetPartFor(murderer)
        local position = murderer and predictedPosition(murderer)
        if not part or not position then return false end
        lastPerfectRedirect = tick()

        if key == "Target" then return true, part end
        if key == "Hit" then return true, CFrame.new(position) end

        local camera = Workspace.CurrentCamera
        local origin = camera and camera.CFrame.Position or (localRoot() and localRoot().Position)
        if not origin or (position - origin).Magnitude < 0.01 then return false end
        return true, Ray.new(origin, (position - origin).Unit * 1000)
    end

    local function enablePerfectMouseHook()
        local state = ensurePerfectMouseHook()
        if not state then return false end
        state.Handler = perfectMouseHookHandler
        return true
    end

    local function disablePerfectMouseHook()
        local state = perfectMouseHookState or rawget(_G, "__HMENU_COMBAT_MOUSE_HOOK")
        if type(state) == "table" and state.Handler == perfectMouseHookHandler then
            state.Handler = nil
        end
    end

    local function restoreGunConnections()
        for _, connection in ipairs(suppressedGunConnections) do
            pcall(function()
                if type(connection.Enable) == "function" then connection:Enable() end
            end)
        end
        suppressedGunConnections = {}
        nativeGunSuppressed = false
    end

    local function suppressGunConnections(gun)
        if type(getconnections) ~= "function" or not gun then return false end
        local ok, found = pcall(function() return getconnections(gun.Activated) end)
        if not ok or type(found) ~= "table" then return false end

        for _, connection in ipairs(found) do
            local disabled = pcall(function()
                if type(connection.Disable) ~= "function" then error("unsupported connection") end
                connection:Disable()
            end)
            if disabled then table.insert(suppressedGunConnections, connection) end
        end
        return #suppressedGunConnections > 0
    end

    local function disconnectGunActivation()
        if gunActivationConnection then
            gunActivationConnection:Disconnect()
            gunActivationConnection = nil
        end
        restoreGunConnections()
        boundGun = nil
    end

    local function bindGunActivation()
        if not settings.SheriffPerfectShots then
            if gunActivationConnection or #suppressedGunConnections > 0 then disconnectGunActivation() end
            return
        end
        local currentCharacter = character()
        local gun = currentCharacter and currentCharacter:FindFirstChild("Gun")
        if gun == boundGun and gunActivationConnection then return end
        disconnectGunActivation()
        if not gun then return end
        boundGun = gun
        nativeGunSuppressed = suppressGunConnections(gun)
        gunActivationConnection = gun.Activated:Connect(function()
            if destroyed or not settings.SheriffPerfectShots then return end
            local now = tick()
            if now - lastPerfectShot < 0.15 then return end
            lastPerfectShot = now

            -- Tool.Activated is also a per-shot safety net. A hook being installed
            -- does not guarantee that a particular game remote was recognized.
            -- Defer until the Gun's own Activated callbacks have had the chance to
            -- invoke the remote, then only send a direct shot if no redirect occurred.
            task.defer(function()
                if destroyed or not settings.SheriffPerfectShots then return end
                if not nativeGunSuppressed and tick() - lastPerfectRedirect < 0.12 then return end
                refreshRoles()
                local murderer = findMurderer()
                if murderer then fireGunAt(murderer, false) end
            end)
        end)
    end

    local function nearestGunDrop()
        -- MM2 normally exposes a single GunDrop. Using FindFirstChild avoids scanning
        -- the entire workspace every Auto Grab tick.
        return Workspace:FindFirstChild("GunDrop", true)
    end

    local function hasGunAnywhere()
        return toolIn(localPlayer, "Gun") ~= nil
    end

    local function grabGunWithoutMoving(showMessage)
        if grabBusy or hasGunAnywhere() then return hasGunAnywhere() end
        local now = tick()
        if now - lastGrabAttempt < 0.18 then return false end
        lastGrabAttempt = now
        grabBusy = true

        local root = localRoot()
        local drop = nearestGunDrop()
        local part = partFromDrop(drop)
        if not root or not part then
            if showMessage then notify("No dropped Gun found.", false) end
            grabBusy = false
            return false
        end

        local attempted = false
        if type(firetouchinterest) == "function" then
            attempted = true
            pcall(function()
                firetouchinterest(root, part, 0)
                task.wait()
                firetouchinterest(root, part, 1)
            end)
        end

        if not hasGunAnywhere() and type(fireproximityprompt) == "function" then
            local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                attempted = true
                pcall(function() fireproximityprompt(prompt) end)
            end
        end

        if not attempted then
            if showMessage or not unsupportedGrabWarned then
                notify("Executor has no firetouchinterest/fireproximityprompt support. No teleport fallback was used.", false)
                unsupportedGrabWarned = true
            end
            grabBusy = false
            return false
        end

        task.wait(0.08)
        local acquired = hasGunAnywhere()
        if showMessage then
            notify(acquired and "Gun pickup triggered without moving your character." or "Pickup was triggered; server may reject remote-distance collection.", acquired)
        end
        grabBusy = false
        return acquired
    end

    local function triggerKnife(knife, targetRoot)
        if not knife or not targetRoot then return false end
        local used = false
        local stab = knife:FindFirstChild("Stab")
        if stab and stab:IsA("RemoteEvent") then
            used = true
            pcall(function()
                stab:FireServer("Down")
                stab:FireServer("Down")
            end)
        end
        pcall(function()
            knife:Activate()
            used = true
        end)
        local handle = knife:FindFirstChild("Handle")
        if handle and type(firetouchinterest) == "function" then
            used = true
            pcall(function()
                firetouchinterest(handle, targetRoot, 0)
                firetouchinterest(handle, targetRoot, 1)
            end)
        end
        return used
    end

    local function attackTarget(player, blink)
        if not player or not isAlive(player) then return false end
        local knife = equipKnife(false)
        local root = localRoot()
        local targetRoot = rootPart(player)
        if not knife or not root or not targetRoot then return false end
        local oldCFrame = root.CFrame
        local moved = false
        if blink and (targetRoot.Position - root.Position).Magnitude > settings.MurderAuraRadius then
            moved = true
            root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1.6)
            RunService.Heartbeat:Wait()
        end
        local ok = triggerKnife(knife, targetRoot)
        task.wait(0.04)
        if moved and root.Parent then root.CFrame = oldCFrame end
        return ok
    end

    local function validMurderTargets()
        local root = localRoot()
        local list = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and roleOf(player) ~= "Murderer" then
                local targetRoot = rootPart(player)
                if targetRoot then
                    table.insert(list, {
                        Player = player,
                        Distance = root and (targetRoot.Position - root.Position).Magnitude or math.huge,
                        GunCarrier = isGunCarrier(player),
                    })
                end
            end
        end
        table.sort(list, function(a, b)
            if settings.MurderTargetPriority == "Sheriff First" and a.GunCarrier ~= b.GunCarrier then
                return a.GunCarrier
            end
            return a.Distance < b.Distance
        end)
        return list
    end

    local function killNearest()
        refreshRoles()
        if not equipKnife(true) then return end
        local targets = validMurderTargets()
        local target = targets[1] and targets[1].Player
        if not target then
            notify("No alive target found.", false)
            return
        end
        local ok = attackTarget(target, true)
        notify(ok and ("Attacked " .. target.Name .. ".") or "Could not attack target.", ok)
    end

    local function killSheriff()
        refreshRoles()
        if not equipKnife(true) then return end
        local target = findSheriffOrHero()
        if not target then
            notify("Sheriff/Hero with Gun not found.", false)
            return
        end
        local ok = attackTarget(target, true)
        notify(ok and ("Attacked Gun carrier: " .. target.Name) or "Could not attack Sheriff/Hero.", ok)
    end

    local function killAll()
        if killAllBusy then return end
        refreshRoles()
        if not equipKnife(true) then return end
        killAllBusy = true
        task.spawn(function()
            local targets = validMurderTargets()
            if #targets == 0 then
                notify("No alive targets found.", false)
                killAllBusy = false
                return
            end
            local original = localRoot() and localRoot().CFrame
            for _, entry in ipairs(targets) do
                if destroyed then break end
                attackTarget(entry.Player, true)
                task.wait(settings.MurderAttackDelay)
            end
            local root = localRoot()
            if root and original then root.CFrame = original end
            notify("Kill All sequence finished.", true)
            killAllBusy = false
        end)
    end

    local function restoreHitbox(part)
        local original = hitboxOriginals[part]
        if not original then return end
        if part and part.Parent then
            part.Size = original.Size
            part.Transparency = original.Transparency
            part.CanCollide = original.CanCollide
        end
        hitboxOriginals[part] = nil
    end

    local function restoreAllHitboxes()
        local parts = {}
        for part in pairs(hitboxOriginals) do table.insert(parts, part) end
        for _, part in ipairs(parts) do restoreHitbox(part) end
    end

    local function shouldExpandHitbox(player)
        if player == localPlayer or not isAlive(player) then return false end
        if settings.UtilsHitboxTarget == "Everyone" then return true end
        if settings.UtilsHitboxTarget == "Sheriff" then return isGunCarrier(player) end
        return roleOf(player) == "Murderer"
    end

    local function updateHitboxes()
        if not settings.UtilsHitboxExpander then
            restoreAllHitboxes()
            return
        end
        local keep = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if shouldExpandHitbox(player) then
                local part = rootPart(player)
                if part then
                    keep[part] = true
                    if not hitboxOriginals[part] then
                        hitboxOriginals[part] = {
                            Size = part.Size,
                            Transparency = part.Transparency,
                            CanCollide = part.CanCollide,
                        }
                    end
                    part.Size = Vector3.new(settings.UtilsHitboxSize, settings.UtilsHitboxSize, settings.UtilsHitboxSize)
                    part.Transparency = 0.72
                    part.CanCollide = false
                end
            end
        end
        local stale = {}
        for part in pairs(hitboxOriginals) do
            if not keep[part] then table.insert(stale, part) end
        end
        for _, part in ipairs(stale) do restoreHitbox(part) end
    end

    local function autoEvade()
        if not settings.UtilsAutoEvadeMurderer then return end
        local murderer = findMurderer()
        local root = localRoot()
        local murdererRoot = rootPart(murderer)
        if not root or not murdererRoot then return end
        local offset = root.Position - murdererRoot.Position
        local distance = offset.Magnitude
        if distance > settings.UtilsDangerRadius or tick() - lastEvade < 0.55 then return end
        local direction
        if distance < 0.05 then
            direction = Vector3.new(1, 0, 0)
        else
            direction = Vector3.new(offset.X, 0, offset.Z)
            if direction.Magnitude < 0.05 then direction = Vector3.new(1, 0, 0) end
            direction = direction.Unit
        end
        lastEvade = tick()
        root.AssemblyLinearVelocity = Vector3.zero
        root.CFrame = root.CFrame + direction * settings.UtilsEvadeDistance
    end

    local function updateKillAura()
        if not settings.MurderKillAura then return end
        local now = tick()
        if now - lastAuraAttack < settings.MurderAttackDelay then return end
        local knife = toolIn(localPlayer, "Knife")
        if not knife then return end
        if settings.MurderAutoEquipKnife then knife = equipKnife(false) or knife end
        local root = localRoot()
        if not root then return end
        local targets = validMurderTargets()
        for _, entry in ipairs(targets) do
            if entry.Distance <= settings.MurderAuraRadius then
                lastAuraAttack = now
                attackTarget(entry.Player, false)
                break
            end
        end
    end

    local function updateAutoShoot()
        if not settings.SheriffAutoShootMurderer then return end
        local now = tick()
        if now - lastAutoShot < settings.SheriffShootCooldown then return end
        local murderer = findMurderer()
        if not murderer or not hasLineOfSight(murderer) then return end
        local gun = toolIn(localPlayer, "Gun")
        if not gun then
            if settings.SheriffAutoGrabGun then grabGunWithoutMoving(false) end
            return
        end
        lastAutoShot = now
        fireGunAt(murderer, false)
    end

    local function updateAutoEquip()
        if settings.MurderAutoEquipKnife and toolIn(localPlayer, "Knife") then
            equipKnife(false)
        end
        if settings.SheriffAutoEquipGun and toolIn(localPlayer, "Gun") then
            equipGun(false)
        end
    end

    local roleElapsed, mainElapsed, hitboxElapsed, grabElapsed = 0, 0, 0, 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        roleElapsed = roleElapsed + deltaTime
        mainElapsed = mainElapsed + deltaTime
        hitboxElapsed = hitboxElapsed + deltaTime
        grabElapsed = grabElapsed + deltaTime

        local needsRoles = settings.MurderKillAura
            or settings.SheriffPerfectShots
            or settings.SheriffAutoShootMurderer
            or settings.UtilsAutoEvadeMurderer
            or settings.UtilsHitboxExpander

        if needsRoles and roleElapsed >= 0.45 then
            roleElapsed = 0
            task.spawn(refreshRoles)
        end

        if mainElapsed >= 0.08 then
            mainElapsed = 0
            bindGunActivation()
            updateAutoEquip()
            updateKillAura()
            updateAutoShoot()
            autoEvade()
        end

        if settings.UtilsHitboxExpander and hitboxElapsed >= 0.18 then
            hitboxElapsed = 0
            updateHitboxes()
        end

        if settings.SheriffAutoGrabGun and not hasGunAnywhere() and grabElapsed >= 0.35 then
            grabElapsed = 0
            task.spawn(function() grabGunWithoutMoving(false) end)
        end
    end)

    connect(Workspace.DescendantAdded, function(instance)
        if destroyed or not settings.SheriffAutoGrabGun or instance.Name ~= "GunDrop" then return end
        task.delay(0.08, function()
            if destroyed or not settings.SheriffAutoGrabGun then return end
            grabGunWithoutMoving(false)
        end)
    end)

    connect(localPlayer.CharacterAdded, function()
        disconnectGunActivation()
        task.delay(0.5, function()
            if destroyed then return end
            bindGunActivation()
            updateAutoEquip()
        end)
    end)

    connect(Players.PlayerRemoving, function(player)
        local part = rootPart(player)
        if part then restoreHitbox(part) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value

        if name == "MurderEquipKnife" then
            local knife = equipKnife(true)
            notify(knife and "Knife equipped." or "Knife not found.", knife ~= nil)
            settings[name] = false
        elseif name == "MurderKillNearest" then
            killNearest()
            settings[name] = false
        elseif name == "MurderKillSheriff" then
            killSheriff()
            settings[name] = false
        elseif name == "MurderKillAll" then
            killAll()
            settings[name] = false
        elseif name == "SheriffShootMurderer" then
            shootMurderer(true)
            settings[name] = false
        elseif name == "SheriffEquipGun" then
            local gun = equipGun(true)
            notify(gun and "Gun equipped." or "Gun not found.", gun ~= nil)
            settings[name] = false
        elseif name == "SheriffGrabGunNow" then
            task.spawn(function() grabGunWithoutMoving(true) end)
            settings[name] = false
        elseif name == "SheriffPerfectShots" then
            if value then
                refreshRoles()
                local hooked = enablePerfectShotHook()
                local mouseHooked = enablePerfectMouseHook()
                disconnectGunActivation()
                bindGunActivation()
                if not hooked and not mouseHooked and type(getconnections) ~= "function" then
                    notify("Perfect Shots has limited support in this executor.", false)
                end
            else
                disablePerfectShotHook()
                disablePerfectMouseHook()
                disconnectGunActivation()
            end
        elseif name == "UtilsHitboxExpander" then
            if value then
                refreshRoles()
                updateHitboxes()
            else
                restoreAllHitboxes()
            end
        elseif name == "UtilsHitboxSize" or name == "UtilsHitboxTarget" then
            if settings.UtilsHitboxExpander then
                refreshRoles()
                updateHitboxes()
            end
        elseif name == "SheriffAutoShootMurderer" or name == "MurderKillAura" or name == "UtilsAutoEvadeMurderer" then
            if value then refreshRoles() end
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.MurderKillAura = false
        settings.SheriffPerfectShots = false
        settings.SheriffAutoShootMurderer = false
        settings.SheriffAutoGrabGun = false
        settings.UtilsAutoEvadeMurderer = false
        settings.UtilsHitboxExpander = false
        disablePerfectShotHook()
        disablePerfectMouseHook()
        disconnectGunActivation()
        restoreAllHitboxes()
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_COMBAT_CLEANUP == cleanupFunction then _G.__HMENU_COMBAT_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_COMBAT_CLEANUP = cleanupFunction
    return runtime
end

return Combat
