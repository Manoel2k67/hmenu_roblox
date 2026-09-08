local Lighting = game:GetService("Lighting")

return {
    Id = "Atmosphere",
    Label = "Atmosphere",
    Icon = "atmosphere",
    Bookmarked = false,
    RuntimeModule = "runtime/Atmosphere.lua",
    Sections = {
        {
            Title = "World Appearance",
            Icon = "cloud",
            Controls = {
                { Kind = "Dropdown", Setting = "Weather", Id = "weather", Label = "Weather", Options = { "Default", "Clear", "Night", "Fog" }, Default = "Default" },
                { Kind = "Slider", Setting = "Brightness", Id = "brightness", Label = "Brightness", Min = 0, Max = 10, Default = Lighting.Brightness, Step = 0.1 },
                { Kind = "Toggle", Setting = "CustomSky", Id = "custom_sky", Label = "Custom Sky", Default = false },
            },
        },
    },
}
