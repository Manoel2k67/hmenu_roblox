local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local Misc = {}

function Misc:Create(options)
    if type(_G.__HMENU_MISC_CLEANUP) == "function" then
        pcall(_G.__HMENU_MISC_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local connections = {}
    local disabledEffects = {}
    local destroyed = false
    local cleanupFunction

    local settings = {
        ShowFPS = false,
        PerformanceMode = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = Instance.new("ScreenGui")
    overlay.Name = "HMenuMiscOverlay"
    overlay.ResetOnSpawn = false
    overlay.IgnoreGuiInset = true
    overlay.DisplayOrder = 998
    overlay.Parent = parent
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "PerformanceStats"
    statsLabel.Position = UDim2.new(1, -12, 1, -12)
    statsLabel.AnchorPoint = Vector2.new(1, 1)
    statsLabel.Size = UDim2.fromOffset(170, 28)
    statsLabel.BackgroundColor3 = Color3.fromRGB(15, 22, 38)
    statsLabel.BackgroundTransparency = 0.18
    statsLabel.BorderSizePixel = 0
    statsLabel.TextColor3 = Color3.fromRGB(235, 242, 255)
    statsLabel.Font = Enum.Font.Code
    statsLabel.TextSize = 13
    statsLabel.TextXAlignment = Enum.TextXAlignment.Center
    statsLabel.Visible = false
    statsLabel.Parent = overlay

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = statsLabel

    local function setEffectEnabled(effect, enabled)
        if effect:IsA("PostEffect") or effect:IsA("ParticleEmitter")
            or effect:IsA("Trail") or effect:IsA("Beam") then
            if disabledEffects[effect] == nil then
                disabledEffects[effect] = effect.Enabled
            end
            effect.Enabled = enabled
        end
    end

    local function applyPerformanceMode()
        if not settings.PerformanceMode then
            for effect, wasEnabled in pairs(disabledEffects) do
                if effect and effect.Parent then effect.Enabled = wasEnabled end
            end
            disabledEffects = {}
            return
        end

        for _, instance in ipairs(Workspace:GetDescendants()) do
            setEffectEnabled(instance, false)
        end
        for _, instance in ipairs(Lighting:GetChildren()) do
            setEffectEnabled(instance, false)
        end
    end

    local function refreshStats()
        local ping = "--"
        local ok, value = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
        end)
        if ok and value then ping = tostring(value):gsub(" ms", "") .. " ms" end
        return ping
    end

    local elapsed = 0
    local frames = 0
    connect(RunService.RenderStepped, function(deltaTime)
        if destroyed then return end
        frames = frames + 1
        elapsed = elapsed + deltaTime
        if elapsed >= 0.5 then
            local fps = math.floor(frames / elapsed + 0.5)
            statsLabel.Text = string.format("FPS %d  |  Ping %s", fps, refreshStats())
            statsLabel.Visible = settings.ShowFPS
            frames = 0
            elapsed = 0
        end
    end)

    connect(Workspace.DescendantAdded, function(instance)
        if settings.PerformanceMode then setEffectEnabled(instance, false) end
    end)
    connect(Lighting.ChildAdded, function(instance)
        if settings.PerformanceMode then setEffectEnabled(instance, false) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "ShowFPS" then
            statsLabel.Visible = value
        elseif name == "PerformanceMode" then
            applyPerformanceMode()
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        for effect, wasEnabled in pairs(disabledEffects) do
            if effect and effect.Parent then effect.Enabled = wasEnabled end
        end
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_MISC_CLEANUP == cleanupFunction then _G.__HMENU_MISC_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_MISC_CLEANUP = cleanupFunction
    return runtime
end

return Misc
