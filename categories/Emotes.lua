return {
    Id = "Emotes", Label = "Emotes", Icon = "☺", Bookmarked = false,
    Sections = {
        { Title = "Animations", Icon = "☺", Controls = {
            { Kind = "Dropdown", Id = "emote", Label = "Selected Emote", Options = { "Wave", "Dance", "Cheer", "Laugh" }, Default = "Wave" },
            { Kind = "Button", Id = "play_emote", Label = "Preview Emote", ButtonText = "Reproduzir" },
            { Kind = "Toggle", Id = "loop_emote", Label = "Loop", Default = false },
        }},
    },
}
