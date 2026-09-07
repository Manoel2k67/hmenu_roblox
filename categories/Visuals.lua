return {
    Id = "Visuals", Label = "Visuals", Icon = "◉", Bookmarked = true,
    Sections = {
        { Title = "ESP Settings", Icon = "◉", Controls = {
            { Kind = "Toggle", Id = "esp_enabled", Label = "Enable ESP", Default = false },
            { Kind = "Toggle", Id = "player_names", Label = "Player Names", Default = true },
            { Kind = "Toggle", Id = "dropped_items", Label = "Show Dropped Items", Default = false },
            { Kind = "Toggle", Id = "show_markers", Label = "Show Markers", Default = false },
        }},
        { Title = "Camera", Icon = "▣", Controls = {
            { Kind = "Slider", Id = "fov", Label = "FOV", Min = 50, Max = 120, Default = 70, Step = 1 },
            { Kind = "Toggle", Id = "xray", Label = "X-Ray", Default = false },
        }},
        { Title = "Visual Mods", Icon = "◇", Controls = {
            { Kind = "Toggle", Id = "low_detail", Label = "Improve FPS (Enhanced)", Default = false },
            { Kind = "Dropdown", Id = "crosshair", Label = "Crosshair", Options = { "Off", "Dot", "Classic" }, Default = "Off" },
        }},
    },
}
