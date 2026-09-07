return {
    Id = "Combat", Label = "Combat", Icon = "◎", Bookmarked = true,
    Sections = {
        { Title = "Combat settings", Icon = "◎", Controls = {
            { Kind = "Toggle", Id = "combat_assist", Label = "Combat Assist", Description = "Demonstração; nenhuma lógica conectada.", Default = false },
            { Kind = "Slider", Id = "assist_radius", Label = "Assist Radius", Min = 10, Max = 100, Default = 35 },
            { Kind = "Dropdown", Id = "target_part", Label = "Target Part", Options = { "Head", "Upper Torso", "Nearest" }, Default = "Nearest" },
        }},
    },
}
