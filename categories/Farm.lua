return {
    Id = "Farm", Label = "Farm", Icon = "◉", Bookmarked = false,
    Sections = {
        { Title = "Automation", Icon = "↻", Controls = {
            { Kind = "Paragraph", Label = "Área reservada", Description = "Adicione aqui suas rotinas e respectivos callbacks." },
            { Kind = "Dropdown", Id = "farm_mode", Label = "Mode", Options = { "Safe", "Balanced", "Fast" }, Default = "Safe" },
            { Kind = "Toggle", Id = "auto_farm", Label = "Auto Farm", Default = false },
        }},
    },
}
