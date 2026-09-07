local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Visuals = {}

local ROLE_COLORS = {
    Murderer = Color3.fromRGB(255, 66, 77),
    Sheriff = Color3.fromRGB(64, 143, 255),
    Hero = Color3.fromRGB(255, 218, 62),
    Innocent = Color3.fromRGB(67, 220, 124),
    Unknown = Color3.fromRGB(205, 215, 235),
}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function destroy(object)
    if object then pcall(function() object:Destroy() end) end
end

function Visuals:Create(options)
    if type(_G.__HMENU_VISUAL_CLEANUP) == "function" then
        pcall(_G.__HMENU_VISUAL_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local connections = {}
    local playerVisuals = {}
    local gunVisuals = {}
    local coinVisuals = {}
    local roles = {}
    local destroyed = false
    local roleBusy = false
    local cleanupFunction

    local settings = {
        EspEnabled = false,
        PlayerNames = false,
        ShowRoles = false,
        ShowDistance = false,
        ShowHealth = false,
        XRay = false,
        FillTransparency = 68,
        DroppedGun = false,
        ShowCoins = false,
        Fov = 70,
        Crosshair = "Off",
        FullBright = false,
        NoFog = false,
    }

    local camera = Workspace.CurrentCamera
    local originalFov = camera and camera.FieldOfView or 70
    local originalLighting = {
        Brightness = Lighting.Brightness,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
    }
    local atmosphereState = {}

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = make("ScreenGui", {
        Name = "HMenuVisualOverlay",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 996,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local crosshair = make("Frame", {
        Name = "Crosshair",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        Visible = false,
    }, overlay)
    local dot = make("Frame", {
        Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(4, 4),
        BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0,
    }, crosshair)
    make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
    local crosshairLines = {
        make("Frame", { Size = UDim2.fromOffset(1, 7), Position = UDim2.new(0.5, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(1, 7), Position = UDim2.new(0.5, 0, 1, -7), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(7, 1), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(7, 1), Position = UDim2.new(1, -7, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
    }

    local function updateCrosshair()
        crosshair.Visible = settings.Crosshair ~= "Off"
        dot.Visible = settings.Crosshair == "Dot"
        for _, line in ipairs(crosshairLines) do
            line.Visible = settings.Crosshair == "Classic"
        end
    end

    local function roleFromTools(player)
        local function hasTool(container, name)
            return container and container:FindFirstChild(name) ~= nil
        end
        if hasTool(player.Character, "Knife") or hasTool(player:FindFirstChild("Backpack"), "Knife") then
            return "Murderer"
        end
        if hasTool(player.Character, "Gun") or hasTool(player:FindFirstChild("Backpack"), "Gun") then
            return "Sheriff"
        end
        return "Innocent"
    end

    local function getRole(player)
        local data = roles[player.Name]
        local role = data and data.Role
        if role == "Murderer" or role == "Sheriff" or role == "Hero" or role == "Innocent" then
            return role
        end
        return roleFromTools(player)
    end

    local function isAlive(player)
        local data = roles[player.Name]
        if data and (data.Dead or data.Killed) then return false end
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        return humanoid == nil or humanoid.Health > 0
    end

    local function refreshRoles()
        if roleBusy or destroyed or not settings.EspEnabled then return end
        roleBusy = true
        local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
        if remote and remote:IsA("RemoteFunction") then
            local ok, result = pcall(function() return remote:InvokeServer() end)
            if ok and type(result) == "table" then roles = result end
        end
        roleBusy = false
    end

    local function removePlayerVisual(player)
        local entry = playerVisuals[player]
        if not entry then return end
        destroy(entry.Highlight)
        destroy(entry.Billboard)
        playerVisuals[player] = nil
    end

    local function removeAllPlayerVisuals()
        local players = {}
        for player in pairs(playerVisuals) do table.insert(players, player) end
        for _, player in ipairs(players) do removePlayerVisual(player) end
    end

    local function ensurePlayerVisual(player)
        local character = player.Character
        if not character then
            removePlayerVisual(player)
            return nil
        end
        local head = character:FindFirstChild("Head")
        if not head then return nil end

        local entry = playerVisuals[player]
        if entry and entry.Character ~= character then
            removePlayerVisual(player)
            entry = nil
        end
        if entry then return entry end

        local highlight = make("Highlight", {
            Name = "HMenuPlayerHighlight",
            Adornee = character,
            FillTransparency = settings.FillTransparency / 100,
            OutlineTransparency = 0.05,
            DepthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded,
        }, character)
        local billboard = make("BillboardGui", {
            Name = "HMenuPlayerLabel",
            Adornee = head,
            Size = UDim2.fromOffset(220, 38),
            StudsOffset = Vector3.new(0, 3.15, 0),
            AlwaysOnTop = settings.XRay,
            LightInfluence = 0,
            MaxDistance = 1500,
        }, head)
        local label = make("TextLabel", {
            Name = "Label", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            Text = "", TextColor3 = Color3.new(1, 1, 1),
            TextStrokeColor3 = Color3.fromRGB(5, 8, 14), TextStrokeTransparency = 0.25,
            Font = Enum.Font.GothamBold, TextSize = 13,
        }, billboard)
        entry = { Character = character, Highlight = highlight, Billboard = billboard, Label = label }
        playerVisuals[player] = entry
        return entry
    end

    local function updatePlayers()
        if not settings.EspEnabled then return end
        local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Parent and isAlive(player) then
                local entry = ensurePlayerVisual(player)
                if entry then
                    local role = getRole(player)
                    local color = ROLE_COLORS[role] or ROLE_COLORS.Unknown
                    entry.Highlight.Enabled = true
                    entry.Highlight.FillColor = color
                    entry.Highlight.OutlineColor = color
                    entry.Highlight.FillTransparency = settings.FillTransparency / 100
                    entry.Highlight.DepthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                    entry.Billboard.AlwaysOnTop = settings.XRay

                    local parts = {}
                    if settings.PlayerNames then table.insert(parts, player.DisplayName) end
                    if settings.ShowRoles then table.insert(parts, string.upper(role)) end
                    if settings.ShowDistance and localRoot then
                        local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            table.insert(parts, tostring(math.floor((targetRoot.Position - localRoot.Position).Magnitude + 0.5)) .. "m")
                        end
                    end
                    if settings.ShowHealth then
                        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.MaxHealth > 0 then
                            table.insert(parts, tostring(math.floor((humanoid.Health / humanoid.MaxHealth) * 100 + 0.5)) .. "% HP")
                        end
                    end
                    entry.Label.Text = table.concat(parts, "  |  ")
                    entry.Label.TextColor3 = color
                    entry.Billboard.Enabled = #parts > 0
                end
            else
                removePlayerVisual(player)
            end
        end
    end

    local function gunAdornee(instance)
        if instance:IsA("BasePart") or instance:IsA("Model") then return instance end
        local model = instance:FindFirstAncestorOfClass("Model")
        return model or instance
    end

    local function gunLabelPart(instance)
        if instance:IsA("BasePart") then return instance end
        if instance:IsA("Model") then
            return instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
        end
        return instance:FindFirstChildWhichIsA("BasePart", true)
    end

    local function removeGunVisual(instance)
        local entry = gunVisuals[instance]
        if not entry then return end
        destroy(entry.Highlight)
        destroy(entry.Billboard)
        gunVisuals[instance] = nil
    end

    local function removeAllGunVisuals()
        local instances = {}
        for instance in pairs(gunVisuals) do table.insert(instances, instance) end
        for _, instance in ipairs(instances) do removeGunVisual(instance) end
    end

    local function normalizedCoin(part)
        local name = string.lower(part.Name)
        local parent = part.Parent
        if name == "coinvisual" and parent and parent:IsA("BasePart") then
            return parent
        end
        if part:FindFirstChild("CoinVisual") then return part end
        if name == "coin" or name == "coin_server" or name == "currencycoin" then return part end
        local current = parent
        for _ = 1, 4 do
            if not current or current == Workspace then break end
            local currentName = string.lower(current.Name)
            if string.find(currentName, "coincontainer", 1, true) and string.find(name, "coin", 1, true) then
                return part
            end
            current = current.Parent
        end
        return nil
    end

    local function removeAllCoinVisuals()
        for coin, highlight in pairs(coinVisuals) do
            destroy(highlight)
            coinVisuals[coin] = nil
        end
    end

    local function scanCoinVisuals()
        if not settings.ShowCoins then return end
        local found = {}
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                local coin = normalizedCoin(descendant)
                if coin and coin.Parent then
                    found[coin] = true
                    if not coinVisuals[coin] then
                        coinVisuals[coin] = make("Highlight", {
                            Name = "HMenuCoinHighlight",
                            Adornee = coin,
                            FillColor = Color3.fromRGB(255, 205, 45),
                            OutlineColor = Color3.fromRGB(255, 248, 185),
                            FillTransparency = 0.5,
                            OutlineTransparency = 0.05,
                            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                        }, coin)
                    end
                end
            end
        end
        for coin, highlight in pairs(coinVisuals) do
            if not found[coin] or not coin.Parent then
                destroy(highlight)
                coinVisuals[coin] = nil
            end
        end
    end

    local function addGunVisual(instance)
        if destroyed or not settings.DroppedGun or gunVisuals[instance] or not instance:IsDescendantOf(Workspace) then return end
        local adornee = gunAdornee(instance)
        local part = gunLabelPart(adornee)
        if not adornee or not part then return end
        local color = Color3.fromRGB(255, 205, 48)
        local highlight = make("Highlight", {
            Name = "HMenuGunDropHighlight", Adornee = adornee,
            FillColor = color, OutlineColor = Color3.fromRGB(255, 245, 170),
            FillTransparency = 0.35, OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        }, adornee)
        local billboard = make("BillboardGui", {
            Name = "HMenuGunDropLabel", Adornee = part,
            Size = UDim2.fromOffset(170, 30), StudsOffset = Vector3.new(0, 1.7, 0),
            AlwaysOnTop = true, LightInfluence = 0, MaxDistance = 1800,
        }, part)
        make("TextLabel", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            Text = "DROPPED GUN", TextColor3 = color,
            TextStrokeColor3 = Color3.fromRGB(20, 15, 0), TextStrokeTransparency = 0.2,
            Font = Enum.Font.GothamBold, TextSize = 12,
        }, billboard)
        gunVisuals[instance] = { Highlight = highlight, Billboard = billboard }
    end

    local function scanGunDrops()
        if not settings.DroppedGun then return end
        local found = {}
        for _, instance in ipairs(Workspace:GetDescendants()) do
            if instance.Name == "GunDrop" then
                found[instance] = true
                addGunVisual(instance)
            end
        end
        local stale = {}
        for instance in pairs(gunVisuals) do
            if not found[instance] or not instance:IsDescendantOf(Workspace) then table.insert(stale, instance) end
        end
        for _, instance in ipairs(stale) do removeGunVisual(instance) end
    end

    local function rememberAtmospheres()
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:IsA("Atmosphere") and not atmosphereState[child] then
                atmosphereState[child] = { Density = child.Density, Haze = child.Haze, Glare = child.Glare }
            end
        end
    end

    local function applyFullBright(enabled)
        if enabled then
            Lighting.Brightness = 3
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(185, 185, 185)
            Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
        else
            Lighting.Brightness = originalLighting.Brightness
            Lighting.GlobalShadows = originalLighting.GlobalShadows
            Lighting.Ambient = originalLighting.Ambient
            Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        end
    end

    local function applyNoFog(enabled)
        if enabled then
            rememberAtmospheres()
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000000
            for atmosphere in pairs(atmosphereState) do
                if atmosphere.Parent then
                    atmosphere.Density = 0
                    atmosphere.Haze = 0
                    atmosphere.Glare = 0
                end
            end
        else
            Lighting.FogStart = originalLighting.FogStart
            Lighting.FogEnd = originalLighting.FogEnd
            for atmosphere, values in pairs(atmosphereState) do
                if atmosphere.Parent then
                    atmosphere.Density = values.Density
                    atmosphere.Haze = values.Haze
                    atmosphere.Glare = values.Glare
                end
            end
        end
    end

    local roleElapsed, visualElapsed, gunElapsed, coinElapsed = 0, 0, 0, 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        roleElapsed = roleElapsed + deltaTime
        visualElapsed = visualElapsed + deltaTime
        gunElapsed = gunElapsed + deltaTime
        coinElapsed = coinElapsed + deltaTime
        if settings.EspEnabled and roleElapsed >= 0.75 then
            roleElapsed = 0
            task.spawn(refreshRoles)
        end
        if settings.EspEnabled and visualElapsed >= 0.12 then
            visualElapsed = 0
            updatePlayers()
        end
        if settings.DroppedGun and gunElapsed >= 1 then
            gunElapsed = 0
            scanGunDrops()
        end
        if settings.ShowCoins and coinElapsed >= 1 then
            coinElapsed = 0
            scanCoinVisuals()
        end
        if settings.FullBright then applyFullBright(true) end
        if settings.NoFog then applyNoFog(true) end
    end)

    connect(Players.PlayerRemoving, removePlayerVisual)
    connect(Workspace.DescendantAdded, function(instance)
        if settings.DroppedGun and instance.Name == "GunDrop" then
            task.defer(function() addGunVisual(instance) end)
        end
    end)
    connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), function()
        camera = Workspace.CurrentCamera
        if camera then camera.FieldOfView = settings.Fov end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "Fov" then
            camera = Workspace.CurrentCamera
            if camera then camera.FieldOfView = value end
        elseif name == "Crosshair" then
            updateCrosshair()
        elseif name == "FullBright" then
            applyFullBright(value)
        elseif name == "NoFog" then
            applyNoFog(value)
        elseif name == "EspEnabled" then
            if value then
                task.spawn(refreshRoles)
                updatePlayers()
            else
                removeAllPlayerVisuals()
            end
        elseif name == "DroppedGun" then
            if value then scanGunDrops() else removeAllGunVisuals() end
        elseif name == "ShowCoins" then
            if value then scanCoinVisuals() else removeAllCoinVisuals() end
        elseif settings.EspEnabled then
            updatePlayers()
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        removeAllPlayerVisuals()
        removeAllGunVisuals()
        removeAllCoinVisuals()
        applyFullBright(false)
        applyNoFog(false)
        camera = Workspace.CurrentCamera
        if camera then camera.FieldOfView = originalFov end
        for _, connection in ipairs(connections) do pcall(function() connection:Disconnect() end) end
        connections = {}
        destroy(overlay)
        if _G.__HMENU_VISUAL_CLEANUP == cleanupFunction then _G.__HMENU_VISUAL_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_VISUAL_CLEANUP = cleanupFunction
    return runtime
end

return Visuals
