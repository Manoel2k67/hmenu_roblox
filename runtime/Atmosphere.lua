local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Atmosphere = {}

local CUSTOM_SKY = {
    SkyboxBk = "rbxassetid://159454299",
    SkyboxDn = "rbxassetid://159454296",
    SkyboxFt = "rbxassetid://159454293",
    SkyboxLf = "rbxassetid://159454286",
    SkyboxRt = "rbxassetid://159454300",
    SkyboxUp = "rbxassetid://159454288",
}

function Atmosphere:Create()
    if type(_G.__HMENU_ATMOSPHERE_CLEANUP) == "function" then
        pcall(_G.__HMENU_ATMOSPHERE_CLEANUP)
    end

    local runtime = {}
    local destroyed = false
    local active = false
    local weatherOverride = false
    local brightnessOverride = false
    local connections = {}
    local atmosphereState = {}
    local skyState = {}
    local generatedSky = nil
    local cleanupFunction

    local originalLighting = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ExposureCompensation = Lighting.ExposureCompensation,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
    }

    local settings = {
        Weather = "Default",
        Brightness = originalLighting.Brightness,
        CustomSky = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function rememberAtmosphere(instance)
        if not instance:IsA("Atmosphere") or atmosphereState[instance] then return end
        atmosphereState[instance] = {
            Density = instance.Density,
            Offset = instance.Offset,
            Color = instance.Color,
            Decay = instance.Decay,
            Glare = instance.Glare,
            Haze = instance.Haze,
        }
    end

    local function rememberSky(instance)
        if not instance:IsA("Sky") or instance == generatedSky or skyState[instance] then return end
        skyState[instance] = {
            SkyboxBk = instance.SkyboxBk,
            SkyboxDn = instance.SkyboxDn,
            SkyboxFt = instance.SkyboxFt,
            SkyboxLf = instance.SkyboxLf,
            SkyboxRt = instance.SkyboxRt,
            SkyboxUp = instance.SkyboxUp,
            CelestialBodiesShown = instance.CelestialBodiesShown,
            StarCount = instance.StarCount,
        }
    end

    local function rememberEffects()
        for _, child in ipairs(Lighting:GetChildren()) do
            rememberAtmosphere(child)
            rememberSky(child)
        end
    end

    local function restoreAtmospheres()
        for instance, values in pairs(atmosphereState) do
            if instance.Parent then
                for property, value in pairs(values) do instance[property] = value end
            end
        end
    end

    local function restoreSkies(removeGenerated)
        for instance, values in pairs(skyState) do
            if instance.Parent then
                for property, value in pairs(values) do instance[property] = value end
            end
        end
        if removeGenerated and generatedSky then
            generatedSky:Destroy()
            generatedSky = nil
        end
    end

    local function restoreWeather()
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.ExposureCompensation = originalLighting.ExposureCompensation
        Lighting.FogStart = originalLighting.FogStart
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.FogColor = originalLighting.FogColor
        restoreAtmospheres()
    end

    local function restoreLighting()
        Lighting.Brightness = originalLighting.Brightness
        restoreWeather()
        restoreSkies(true)
    end

    local function applyCustomSky()
        local foundSky = false
        for instance in pairs(skyState) do
            if instance.Parent then
                foundSky = true
                for property, value in pairs(CUSTOM_SKY) do instance[property] = value end
                instance.CelestialBodiesShown = true
                instance.StarCount = 3000
            end
        end
        if foundSky and generatedSky then
            generatedSky:Destroy()
            generatedSky = nil
        end
        if not foundSky then
            generatedSky = generatedSky or Instance.new("Sky")
            generatedSky.Name = "HMenuCustomSky"
            for property, value in pairs(CUSTOM_SKY) do generatedSky[property] = value end
            generatedSky.CelestialBodiesShown = true
            generatedSky.StarCount = 3000
            generatedSky.Parent = Lighting
        end
    end

    local function applyWeather()
        if settings.Weather == "Clear" then
            Lighting.ClockTime = 14
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000000
            for instance in pairs(atmosphereState) do
                if instance.Parent then
                    instance.Density = 0
                    instance.Haze = 0
                    instance.Glare = 0
                end
            end
        elseif settings.Weather == "Night" then
            Lighting.ClockTime = 0
            Lighting.Ambient = Color3.fromRGB(35, 40, 65)
            Lighting.OutdoorAmbient = Color3.fromRGB(20, 24, 45)
            Lighting.ExposureCompensation = -0.35
        elseif settings.Weather == "Fog" then
            Lighting.FogStart = 0
            Lighting.FogEnd = 120
            Lighting.FogColor = Color3.fromRGB(185, 190, 200)
            for instance in pairs(atmosphereState) do
                if instance.Parent then
                    instance.Density = 0.45
                    instance.Haze = 2
                    instance.Glare = 0
                end
            end
        end
    end

    local function applySettings()
        if destroyed or not active then return end

        rememberEffects()
        if brightnessOverride then Lighting.Brightness = settings.Brightness end
        if weatherOverride then applyWeather() end

        if settings.CustomSky then applyCustomSky() end
    end

    rememberEffects()

    local elapsed = 0
    connect(RunService.Heartbeat, function(deltaTime)
        if not active or destroyed then return end
        elapsed = elapsed + deltaTime
        if elapsed >= 0.2 then
            elapsed = 0
            applySettings()
        end
    end)

    connect(Lighting.ChildAdded, function(instance)
        if instance == generatedSky then return end
        rememberAtmosphere(instance)
        rememberSky(instance)
        if active then task.defer(applySettings) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "Weather" then
            restoreWeather()
            weatherOverride = value ~= "Default"
        elseif name == "Brightness" then
            brightnessOverride = true
        elseif name == "CustomSky" and not value then
            restoreSkies(true)
        end
        active = weatherOverride or brightnessOverride or settings.CustomSky
        applySettings()
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        active = false
        restoreLighting()
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if _G.__HMENU_ATMOSPHERE_CLEANUP == cleanupFunction then
            _G.__HMENU_ATMOSPHERE_CLEANUP = nil
        end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_ATMOSPHERE_CLEANUP = cleanupFunction
    return runtime
end

return Atmosphere
