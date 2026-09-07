local Config = {}

Config.GuiName = "HMenu"
Config.ToggleKey = Enum.KeyCode.LeftShift

Config.Theme = {
    Background = Color3.fromRGB(13, 14, 18),
    Sidebar = Color3.fromRGB(18, 19, 25),
    Surface = Color3.fromRGB(22, 23, 30),
    SurfaceActive = Color3.fromRGB(61, 25, 33),
    Accent = Color3.fromRGB(255, 77, 93),
    AccentSoft = Color3.fromRGB(255, 105, 117),
    Text = Color3.fromRGB(238, 239, 243),
    MutedText = Color3.fromRGB(135, 138, 150),
    Border = Color3.fromRGB(75, 29, 38),
}

Config.Categories = {
    {
        Id = "Dashboard",
        Label = "Dashboard",
        Subtitle = "Overview of your current profile",
        Cards = {
            {"Session status", "Your interface is ready to use.", "ACTIVE", "Accent"},
            {"Profile", "Mock configuration loaded successfully.", "DEMO", "Warning"},
            {"Update channel", "All visual components are up to date.", "STABLE", "Success"},
        },
    },
    {
        Id = "Combat",
        Label = "Combat",
        Subtitle = "Combat features will appear here",
        Cards = {
            {"Combat module", "Placeholder for future controls.", "MOCK", "Accent"},
            {"Presets", "Organize profiles and configurations.", "SOON", "Warning"},
        },
    },
    {
        Id = "Visuals",
        Label = "Visuals",
        Subtitle = "Visual customization and display options",
        Cards = {
            {"Visual module", "Placeholder for visual settings.", "MOCK", "Info"},
            {"Theme", "Current accent and layout preview.", "RED", "Accent"},
        },
    },
    {
        Id = "Movement",
        Label = "Movement",
        Subtitle = "Movement options will appear here",
        Cards = {
            {"Movement module", "Placeholder for future controls.", "MOCK", "Info"},
        },
    },
    {
        Id = "Settings",
        Label = "Settings",
        Subtitle = "Interface and profile preferences",
        Cards = {
            {"Interface", "Menu is currently in visual preview mode.", "READY", "Success"},
            {"Toggle key", "Press Shift to show or hide the menu.", "SHIFT", "Warning"},
        },
    },
}

Config.StatusColors = {
    Accent = Config.Theme.Accent,
    Warning = Color3.fromRGB(255, 160, 80),
    Success = Color3.fromRGB(105, 210, 150),
    Info = Color3.fromRGB(120, 160, 255),
}

return Config
