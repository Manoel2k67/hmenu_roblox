return {
    Id = "Farm",
    Label = "Farm",
    Icon = "farm",
    Bookmarked = false,
    RuntimeModule = "runtime/Farm.lua",
    Sections = {
        {
            Title = "Coin Farm",
            Icon = "farm",
            Controls = {
                { Kind = "Toggle", Setting = "AutoCoins", Id = "auto_coins", Label = "Auto Collect Coins", Description = "Continuously collects the nearest available coin.", Default = false },
                { Kind = "Button", Setting = "NearestCoin", Id = "nearest_coin", Label = "Teleport to Nearest Coin", ButtonText = "Collect" },
                { Kind = "Button", Setting = "CollectAllCoins", Id = "collect_all_coins", Label = "Collect All Coins", Description = "Runs through the current coin list once.", ButtonText = "Collect" },
                { Kind = "Toggle", Setting = "ReturnAfterSweep", Id = "return_after_sweep", Label = "Return After Sweep", Description = "Returns to the starting position after one-time collection.", Default = false },
            },
        },
        {
            Title = "Event Items",
            Icon = "refresh",
            Controls = {
                { Kind = "Dropdown", Setting = "EventFilter", Id = "event_filter", Label = "Event Item", Options = { "All", "Eggs", "Beach Balls", "Candy" }, Default = "All" },
                { Kind = "Toggle", Setting = "AutoEventItems", Id = "auto_event_items", Label = "Auto Collect Event Items", Description = "Looks for eggs, beach balls, candy and event tokens.", Default = false },
                { Kind = "Button", Setting = "CollectAllEvents", Id = "collect_all_events", Label = "Collect All Event Items", ButtonText = "Collect" },
            },
        },
        {
            Title = "Movement Settings",
            Icon = "settings",
            Controls = {
                { Kind = "Dropdown", Setting = "MovementMode", Id = "farm_mode", Label = "Movement Mode", Options = { "Teleport", "Smooth", "Walk" }, Default = "Teleport" },
                { Kind = "Slider", Setting = "ActionDelay", Id = "farm_delay", Label = "Action Delay", Min = 0.1, Max = 1, Default = 0.2, Step = 0.1 },
                { Kind = "Slider", Setting = "SmoothSpeed", Id = "smooth_speed", Label = "Smooth Speed", Min = 20, Max = 200, Default = 70, Step = 5 },
                { Kind = "Slider", Setting = "FarmWalkSpeed", Id = "farm_walk_speed", Label = "Farm Walk Speed", Min = 16, Max = 100, Default = 32, Step = 2 },
            },
        },
    },
}
