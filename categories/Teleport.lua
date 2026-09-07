return {
    Id = "Teleport",
    Label = "Teleport",
    Icon = "navigation",
    Bookmarked = false,
    RuntimeModule = "runtime/Teleport.lua",
    Sections = {
        {
            Title = "Role Teleports",
            Icon = "users",
            Controls = {
                { Kind = "Button", Setting = "TeleportMurderer", Id = "tp_murderer", Label = "Teleport to Murderer", Description = "Moves behind the current murderer.", ButtonText = "Teleport" },
                { Kind = "Button", Setting = "TeleportSheriff", Id = "tp_sheriff", Label = "Teleport to Sheriff", Description = "Also finds the Hero carrying the gun.", ButtonText = "Teleport" },
                { Kind = "Button", Setting = "TeleportGun", Id = "tp_gun", Label = "Teleport to Dropped Gun", ButtonText = "Teleport" },
            },
        },
        {
            Title = "Player Teleport",
            Icon = "player",
            Controls = {
                { Kind = "Dropdown", Setting = "SelectedPlayer", OptionsSource = "Players", Id = "target_player", Label = "Target Player", Default = "Select a player" },
                { Kind = "Dropdown", Setting = "ArrivalMode", Id = "arrival_mode", Label = "Arrival Position", Options = { "Behind", "In Front", "Above" }, Default = "Behind" },
                { Kind = "Slider", Setting = "ArrivalDistance", Id = "arrival_distance", Label = "Arrival Distance", Min = 2, Max = 12, Default = 4, Step = 1 },
                { Kind = "Button", Setting = "TeleportSelected", Id = "tp_selected", Label = "Teleport to Selected Player", ButtonText = "Teleport" },
                { Kind = "Button", Setting = "TeleportNearest", Id = "tp_nearest", Label = "Teleport to Nearest Player", ButtonText = "Teleport" },
                { Kind = "Button", Setting = "TeleportRandom", Id = "tp_random", Label = "Teleport to Random Player", ButtonText = "Teleport" },
            },
        },
        {
            Title = "Saved Location",
            Icon = "map",
            Controls = {
                { Kind = "Button", Setting = "SavePosition", Id = "save_position", Label = "Save Current Position", Description = "Stores the exact position for this session.", ButtonText = "Save" },
                { Kind = "Button", Setting = "LoadPosition", Id = "load_position", Label = "Return to Saved Position", ButtonText = "Return" },
                { Kind = "Button", Setting = "TeleportLobby", Id = "tp_lobby", Label = "Teleport to Lobby", Description = "Finds the lobby spawn and uses an MM2 fallback if needed.", ButtonText = "Teleport" },
            },
        },
    },
}
