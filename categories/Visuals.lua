return {
    Id = "Visuals",
    Label = "Visuals",
    Icon = "eye",
    Bookmarked = false,
    RuntimeModule = "runtime/Visuals.lua",
    Sections = {
        {
            Title = "Player ESP",
            Icon = "eye",
            Controls = {
                { Kind = "Toggle", Setting = "EspEnabled", Id = "esp_enabled", Label = "Enable ESP", Description = "Innocent: green | Murderer: red | Sheriff: blue", Default = false },
                { Kind = "Toggle", Setting = "PlayerNames", Id = "player_names", Label = "Player Names", Default = false },
                { Kind = "Toggle", Setting = "ShowRoles", Id = "show_roles", Label = "Show Roles", Default = false },
                { Kind = "Toggle", Setting = "ShowDistance", Id = "show_distance", Label = "Show Distance", Default = false },
                { Kind = "Toggle", Setting = "ShowHealth", Id = "show_health", Label = "Show Health", Default = false },
                { Kind = "Toggle", Setting = "XRay", Id = "xray", Label = "X-Ray ESP", Description = "Keep role highlights visible through walls.", Default = false },
                { Kind = "Slider", Setting = "FillTransparency", Id = "esp_fill", Label = "Fill Transparency", Min = 0, Max = 100, Default = 68, Step = 1 },
            },
        },
        {
            Title = "Item ESP",
            Icon = "map",
            Controls = {
                { Kind = "Toggle", Setting = "ShowCoins", Id = "show_coins", Label = "Show Coins", Description = "Highlights detected coins in gold.", Default = false },
            },
        },
        {
            Title = "Dropped Items",
            Icon = "map",
            Controls = {
                { Kind = "Toggle", Setting = "DroppedGun", Id = "dropped_items", Label = "Show Dropped Gun", Description = "Highlights GunDrop in gold and adds a world label.", Default = false },
            },
        },
        {
            Title = "Camera",
            Icon = "camera",
            Controls = {
                { Kind = "Slider", Setting = "Fov", Id = "fov", Label = "Field of View", Min = 50, Max = 120, Default = 70, Step = 1 },
                { Kind = "Dropdown", Setting = "Crosshair", Id = "crosshair", Label = "Crosshair", Options = { "Off", "Dot", "Classic" }, Default = "Off" },
            },
        },
        {
            Title = "World Visibility",
            Icon = "atmosphere",
            Controls = {
                { Kind = "Toggle", Setting = "FullBright", Id = "full_bright", Label = "Full Bright", Description = "Brightens dark maps while preserving the original settings.", Default = false },
                { Kind = "Toggle", Setting = "NoFog", Id = "no_fog", Label = "Remove Fog", Default = false },
            },
        },
    },
}
