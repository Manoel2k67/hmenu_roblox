return {
    Id = "Misc", Label = "Misc", Icon = "settings", Bookmarked = false,
    RuntimeModule = "runtime/Misc.lua",
    Sections = {
        { Title = "Utilities", Icon = "sliders", Controls = {
            { Kind = "Toggle", Id = "anti_afk", Label = "Anti AFK", Default = false },
            { Kind = "Toggle", Setting = "ShowFPS", Id = "show_fps", Label = "Show FPS", Description = "Displays live FPS and network ping.", Default = false },
            { Kind = "Toggle", Setting = "PerformanceMode", Id = "performance_mode", Label = "Performance Mode", Description = "Temporarily reduces local visual effects to improve performance.", Default = false },
            { Kind = "Slider", Id = "interface_scale", Label = "Interface Scale", Min = 70, Max = 110, Default = 100, Step = 5 },
        }},
    },
}
