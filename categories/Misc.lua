return {
    Id = "Misc", Label = "Misc", Icon = "settings", Bookmarked = false,
    Sections = {
        { Title = "Utilities", Icon = "sliders", Controls = {
            { Kind = "Toggle", Id = "anti_afk", Label = "Anti AFK", Default = false },
            { Kind = "Toggle", Id = "performance_mode", Label = "Performance Mode", Default = false },
            { Kind = "Slider", Id = "interface_scale", Label = "Interface Scale", Min = 70, Max = 110, Default = 100, Step = 5 },
        }},
    },
}
