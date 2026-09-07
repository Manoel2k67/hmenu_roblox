return {
    Id = "Atmosphere", Label = "Atmosphere", Icon = "atmosphere", Bookmarked = false,
    Sections = {
        { Title = "World appearance", Icon = "cloud", Controls = {
            { Kind = "Dropdown", Id = "weather", Label = "Weather", Options = { "Default", "Clear", "Night", "Fog" }, Default = "Default" },
            { Kind = "Slider", Id = "brightness", Label = "Brightness", Min = 0, Max = 10, Default = 3 },
            { Kind = "Toggle", Id = "custom_sky", Label = "Custom Sky", Default = false },
        }},
    },
}
