return {
    Id = "Emotes", Label = "Emotes", Icon = "smile", Bookmarked = false,
    RuntimeModule = "runtime/Emotes.lua",
    Sections = {
        { Title = "Animations", Icon = "music", Controls = {
            { Kind = "Dropdown", Setting = "SelectedEmote", Id = "emote", Label = "Selected Emote", Options = { "Sit", "Zen", "Ninja Rest", "Dab", "Floss", "Zombie", "Headless" }, Default = "Sit" },
            { Kind = "Button", Setting = "PlayEmote", Id = "play_emote", Label = "Play Emote", ButtonText = "Reproduzir" },
            { Kind = "Toggle", Setting = "LoopEmote", Id = "loop_emote", Label = "Loop", Default = false },
        }},
    },
}
