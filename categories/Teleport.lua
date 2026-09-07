return {
    Id = "Teleport", Label = "Teleport", Icon = "◇", Bookmarked = false,
    Sections = {
        { Title = "Locations", Icon = "◇", Controls = {
            { Kind = "Dropdown", Id = "location", Label = "Destination", Options = { "Spawn", "Lobby", "Checkpoint" }, Default = "Spawn" },
            { Kind = "Button", Id = "teleport", Label = "Go to destination", ButtonText = "Ir agora" },
            { Kind = "Button", Id = "save_location", Label = "Save current location", ButtonText = "Salvar" },
        }},
    },
}
