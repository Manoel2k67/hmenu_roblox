return {
    Id = "Misc", Label = "Misc", Icon = "settings", Bookmarked = false,
    RuntimeModule = "runtime/Misc.lua",
    Sections = {
        { Title = "Themes", Icon = "palette", Controls = {
            { Kind = "Dropdown", Setting = "MenuTheme", Id = "menu_theme", Label = "Menu Theme", Description = "Changes the menu palette and background while keeping controls easy to read.", Options = { "Default", "Purple", "Orange" }, Default = "Default", UseList = true },
        }},
        { Title = "Utilities", Icon = "sliders", Controls = {
            { Kind = "Toggle", Setting = "ShowFPS", Id = "show_fps", Label = "Show FPS", Description = "Displays live FPS and network ping.", Default = false },
            { Kind = "Toggle", Setting = "PerformanceMode", Id = "performance_mode", Label = "Performance Mode", Description = "Temporarily reduces local visual effects to improve performance.", Default = false },
        }},
    },
}
