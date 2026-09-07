local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Teleport = {}

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

local function isAlive(player)
    local character = player and player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return rootPart(player) ~= nil and (humanoid == nil or humanoid.Health > 0)
end

function Teleport:Create(options)
    if type(_G.__HMENU_TELEPORT_CLEANUP) == "function" then
        pcall(_G.__HMENU_TELEPORT_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local destroyed = false
    local cleanupFunction
    local toastVersion = 0
    local roles = {}

    local settings = {
        SelectedPlayer = "Select a player",
        ArrivalMode = "Behind",
        ArrivalDistance = 4,
        TeleportMurderer = false,
        TeleportSheriff = false,
        TeleportGun = false,
        TeleportSelected = false,
        TeleportNearest = false,
        TeleportRandom = false,
        SavePosition = false,
        LoadPosition = false,
    }

    local overlay = make("ScreenGui", {
        Name = "HMenuTeleportOverlay",
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
        Size = UDim2.fromOffset(330, 44),
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

    local function notify(message, success)
        if destroyed then return end
        toastVersion = toastVersion + 1
        local version = toastVersion
        toastText.Text = message
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
            if version == toastVersion then toast.Visible = false end
        end)
    end

    local function refreshRoles()
        local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
        if remote and remote:IsA("RemoteFunction") then
            local ok, result = pcall(function() return remote:InvokeServer() end)
            if ok and type(result) == "table" then roles = result end
        end
    end

    local function heldTool(player, toolName)
        local character = player and player.Character
        local backpack = player and player:FindFirstChild("Backpack")
        return (character and character:FindFirstChild(toolName)) or (backpack and backpack:FindFirstChild(toolName))
    end

    local function findRole(roleName)
        refreshRoles()
        local hero
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) then
                local data = roles[player.Name]
                local role = data and data.Role
                if role == roleName then return player end
                if roleName == "Sheriff" and role == "Hero" then hero = player end
            end
        end
        if hero then return hero end
        local toolName = roleName == "Murderer" and "Knife" or "Gun"
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and heldTool(player, toolName) then return player end
        end
        return nil
    end

    local function arrivalCFrame(targetRoot)
        local distance = math.clamp(tonumber(settings.ArrivalDistance) or 4, 2, 12)
        if settings.ArrivalMode == "In Front" then
            return targetRoot.CFrame * CFrame.new(0, 0, -distance)
        elseif settings.ArrivalMode == "Above" then
            return targetRoot.CFrame * CFrame.new(0, distance + 3, 0)
        end
        return targetRoot.CFrame * CFrame.new(0, 0, distance)
    end

    local function teleportTo(cf, message)
        local root = rootPart(localPlayer)
        if not root then
            notify("Your character is not ready.", false)
            return false
        end
        local ok = pcall(function()
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = cf
        end)
        if ok then
            notify(message or "Teleported.", true)
            return true
        end
        notify("Teleport failed.", false)
        return false
    end

    local function teleportToPlayer(player, description)
        local targetRoot = rootPart(player)
        if not player or player == localPlayer or not isAlive(player) or not targetRoot then
            notify("Target player is unavailable.", false)
            return false
        end
        return teleportTo(arrivalCFrame(targetRoot), "Teleported to " .. (description or player.Name) .. ".")
    end

    local function selectedPlayer()
        local name = settings.SelectedPlayer
        if name == "Select a player" or name == "No players available" then return nil end
        return Players:FindFirstChild(name)
    end

    local function nearestPlayer()
        local localRoot = rootPart(localPlayer)
        if not localRoot then return nil end
        local nearest, nearestDistance
        for _, player in ipairs(Players:GetPlayers()) do
            local targetRoot = rootPart(player)
            if player ~= localPlayer and isAlive(player) and targetRoot then
                local distance = (targetRoot.Position - localRoot.Position).Magnitude
                if not nearestDistance or distance < nearestDistance then
                    nearest, nearestDistance = player, distance
                end
            end
        end
        return nearest
    end

    local function randomPlayer()
        local available = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) then table.insert(available, player) end
        end
        return #available > 0 and available[math.random(1, #available)] or nil
    end

    local function teleportToGun()
        local gun = Workspace:FindFirstChild("GunDrop", true)
        if not gun then
            notify("No dropped gun found.", false)
            return
        end
        local part
        if gun:IsA("BasePart") then
            part = gun
        elseif gun:IsA("Model") then
            part = gun.PrimaryPart or gun:FindFirstChildWhichIsA("BasePart", true)
        else
            part = gun:FindFirstChildWhichIsA("BasePart", true)
        end
        if part then
            teleportTo(part.CFrame * CFrame.new(0, 2.5, 0), "Teleported to dropped gun.")
        else
            notify("Dropped gun has no valid part.", false)
        end
    end

    function runtime:GetOptions(source)
        if source ~= "Players" then return { "None" } end
        local names = { "Select a player" }
        local players = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then table.insert(players, player.Name) end
        end
        table.sort(players, function(a, b) return string.lower(a) < string.lower(b) end)
        for _, name in ipairs(players) do table.insert(names, name) end
        if #names == 1 then return { "No players available" } end
        return names
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "TeleportMurderer" then
            local player = findRole("Murderer")
            if player then teleportToPlayer(player, "Murderer") else notify("Murderer not found yet.", false) end
        elseif name == "TeleportSheriff" then
            local player = findRole("Sheriff")
            if player then teleportToPlayer(player, "Sheriff") else notify("Sheriff or Hero not found.", false) end
        elseif name == "TeleportGun" then
            teleportToGun()
        elseif name == "TeleportSelected" then
            teleportToPlayer(selectedPlayer())
        elseif name == "TeleportNearest" then
            teleportToPlayer(nearestPlayer(), "nearest player")
        elseif name == "TeleportRandom" then
            teleportToPlayer(randomPlayer(), "random player")
        elseif name == "SavePosition" then
            local root = rootPart(localPlayer)
            if root then
                _G.__HMENU_SAVED_CFRAME = root.CFrame
                notify("Current position saved.", true)
            else
                notify("Your character is not ready.", false)
            end
        elseif name == "LoadPosition" then
            if _G.__HMENU_SAVED_CFRAME then
                teleportTo(_G.__HMENU_SAVED_CFRAME, "Returned to saved position.")
            else
                notify("Save a position first.", false)
            end
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_TELEPORT_CLEANUP == cleanupFunction then _G.__HMENU_TELEPORT_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_TELEPORT_CLEANUP = cleanupFunction
    return runtime
end

return Teleport
