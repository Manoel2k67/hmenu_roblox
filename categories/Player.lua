return {
    Id = "Player", Label = "Player", Icon = "♙", Bookmarked = false,
    Sections = {
        { Title = "Player settings", Icon = "♙", Controls = {
            { Kind = "Slider", Id = "walk_speed", Label = "Walk Speed", Min = 8, Max = 32, Default = 16 },
            { Kind = "Slider", Id = "jump_power", Label = "Jump Power", Min = 25, Max = 100, Default = 50 },
            { Kind = "Toggle", Id = "player_trail", Label = "Player Trail", Default = false },
        }},
    },
}
