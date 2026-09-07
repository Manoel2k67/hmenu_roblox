local Config = {}

Config.GuiName = "HMenu"
Config.Version = "v1.0"
Config.ToggleKey = Enum.KeyCode.RightShift
Config.DefaultCategory = "Main"
Config.Window = { Width = 720, Height = 520, MinScale = 0.68, Margin = 24 }

Config.Theme = {
    Window = Color3.fromRGB(31, 48, 80),
    WindowDark = Color3.fromRGB(18, 29, 51),
    Sidebar = Color3.fromRGB(27, 42, 70),
    Header = Color3.fromRGB(29, 45, 76),
    Surface = Color3.fromRGB(32, 49, 82),
    SurfaceHover = Color3.fromRGB(41, 61, 99),
    Control = Color3.fromRGB(25, 40, 68),
    Accent = Color3.fromRGB(102, 151, 246),
    Bookmark = Color3.fromRGB(255, 218, 0),
    Text = Color3.fromRGB(238, 243, 255),
    Muted = Color3.fromRGB(169, 183, 211),
    Dim = Color3.fromRGB(112, 130, 165),
    Border = Color3.fromRGB(83, 112, 169),
    Success = Color3.fromRGB(96, 218, 151),
    Danger = Color3.fromRGB(255, 112, 124),
}

Config.CategoryModules = {
    "categories/Main.lua", "categories/Visuals.lua", "categories/Combat.lua",
    "categories/Player.lua", "categories/Farm.lua", "categories/Whitelist.lua",
    "categories/Emotes.lua", "categories/Teleport.lua", "categories/Misc.lua",
    "categories/Atmosphere.lua", "categories/Credits.lua",
}

return Config
