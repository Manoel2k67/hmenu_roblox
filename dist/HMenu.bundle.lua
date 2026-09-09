-- AUTO-GENERATED FILE. DO NOT EDIT DIRECTLY.
-- Run tools/Build-Bundle.ps1 after changing a source module.
-- Release is read from VERSION at runtime.

local __modules = {}

-- BEGIN HMenuConfig.lua
__modules["HMenuConfig.lua"] = function()
local Config = {}

Config.GuiName = "HMenu"
Config.Version = "v" .. tostring(rawget(_G, "__HMENU_RELEASE_VERSION") or "unknown")
Config.ToggleKey = Enum.KeyCode.RightShift
Config.DefaultCategory = "Main"
Config.Window = { Width = 720, Height = 520, MinScale = 0.68, Margin = 24 }

Config.Theme = {
    Window = Color3.fromRGB(31, 48, 80),
    WindowHighlight = Color3.fromRGB(38, 58, 96),
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

Config.Themes = {
    Default = {
        Colors = Config.Theme,
    },
    Purple = {
        Wallpaper = "theme/wallpapers/Purple.png",
        WallpaperTransparency = 0.42,
        ShadeTransparency = 0.5,
        Colors = {
            Window = Color3.fromRGB(37, 24, 61),
            WindowHighlight = Color3.fromRGB(69, 43, 108),
            WindowDark = Color3.fromRGB(18, 11, 33),
            Sidebar = Color3.fromRGB(29, 19, 49),
            Header = Color3.fromRGB(34, 21, 56),
            Surface = Color3.fromRGB(45, 29, 73),
            SurfaceHover = Color3.fromRGB(61, 40, 96),
            Control = Color3.fromRGB(32, 21, 54),
            Accent = Color3.fromRGB(177, 105, 255),
            Bookmark = Color3.fromRGB(255, 220, 78),
            Text = Color3.fromRGB(247, 242, 255),
            Muted = Color3.fromRGB(198, 181, 224),
            Dim = Color3.fromRGB(143, 120, 176),
            Border = Color3.fromRGB(111, 77, 151),
            Success = Color3.fromRGB(105, 224, 158),
            Danger = Color3.fromRGB(255, 119, 144),
        },
    },
    Orange = {
        Wallpaper = "theme/wallpapers/Orange.png",
        WallpaperTransparency = 0.42,
        ShadeTransparency = 0.5,
        Colors = {
            Window = Color3.fromRGB(58, 31, 18),
            WindowHighlight = Color3.fromRGB(108, 55, 24),
            WindowDark = Color3.fromRGB(31, 15, 8),
            Sidebar = Color3.fromRGB(48, 25, 14),
            Header = Color3.fromRGB(55, 28, 16),
            Surface = Color3.fromRGB(68, 35, 20),
            SurfaceHover = Color3.fromRGB(91, 48, 26),
            Control = Color3.fromRGB(49, 25, 14),
            Accent = Color3.fromRGB(255, 145, 58),
            Bookmark = Color3.fromRGB(255, 220, 78),
            Text = Color3.fromRGB(255, 246, 237),
            Muted = Color3.fromRGB(222, 190, 163),
            Dim = Color3.fromRGB(171, 128, 94),
            Border = Color3.fromRGB(158, 88, 44),
            Success = Color3.fromRGB(112, 222, 151),
            Danger = Color3.fromRGB(255, 116, 104),
        },
    },
}

-- Lucide line icons published as Roblox image assets.
Config.Icons = {
    home = "rbxassetid://7733960981",
    eye = "rbxassetid://7733774602",
    target = "rbxassetid://7743872758",
    player = "rbxassetid://7743871002",
    farm = "rbxassetid://8997382987",
    shield = "rbxassetid://7734056411",
    smile = "rbxassetid://7734059095",
    navigation = "rbxassetid://7734020989",
    settings = "rbxassetid://7734053495",
    atmosphere = "rbxassetid://7733746880",
    info = "rbxassetid://7733964719",
    overview = "rbxassetid://7733970318",
    sliders = "rbxassetid://7734058803",
    camera = "rbxassetid://7733708692",
    palette = "rbxassetid://7734021595",
    refresh = "rbxassetid://7734051052",
    users = "rbxassetid://7743876054",
    music = "rbxassetid://7734020554",
    map = "rbxassetid://7733992424",
    cloud = "rbxassetid://7733920519",
    bookmark = "rbxassetid://7733692043",
    search = "rbxassetid://7734052925",
    laptop = "rbxassetid://7733965386",
    fire = "rbxassetid://7733965386",
    sparkles = "rbxassetid://7734052925",
}

Config.CategoryModules = {
    "categories/Main.lua", "categories/Visuals.lua", "categories/Combat.lua",
    "categories/Player.lua", "categories/Farm.lua", "categories/Whitelist.lua",
    "categories/Emotes.lua", "categories/Teleport.lua", "categories/Misc.lua",
    "categories/Troll.lua", "categories/Atmosphere.lua", "categories/Credits.lua",
}

return Config
end
-- END HMenuConfig.lua

-- BEGIN HMenuSchema.lua
__modules["HMenuSchema.lua"] = function()
local Schema = {}

local VALID_CONTROL_KINDS = {
    Toggle = true,
    Slider = true,
    Dropdown = true,
    Button = true,
    Paragraph = true,
}

local REQUIRED_THEME_KEYS = {
    "Window", "WindowHighlight", "WindowDark", "Sidebar", "Header",
    "Surface", "SurfaceHover", "Control", "Accent", "Bookmark",
    "Text", "Muted", "Dim", "Border", "Success", "Danger",
}

local function requireNonEmptyString(value, context)
    if type(value) ~= "string" or value:match("^%s*$") then
        error(context .. " deve ser uma string não vazia", 0)
    end
end

function Schema.ValidateConfig(config)
    if type(config) ~= "table" then error("HMenuConfig.lua deve retornar uma tabela", 0) end
    requireNonEmptyString(config.GuiName, "Config.GuiName")
    requireNonEmptyString(config.Version, "Config.Version")
    requireNonEmptyString(config.DefaultCategory, "Config.DefaultCategory")
    if config.ToggleKey == nil then error("Config.ToggleKey não pode ser nil", 0) end
    if type(config.Theme) ~= "table" then error("Config.Theme deve ser uma tabela", 0) end
    for _, key in ipairs(REQUIRED_THEME_KEYS) do
        if config.Theme[key] == nil then
            error("Config.Theme não possui a cor obrigatória " .. key, 0)
        end
    end
    if type(config.Icons) ~= "table" then error("Config.Icons deve ser uma tabela", 0) end
    if type(config.Window) ~= "table" or type(config.Window.Width) ~= "number"
        or type(config.Window.Height) ~= "number" then
        error("Config.Window deve informar Width e Height numéricos", 0)
    end
    if config.Window.Width <= 0 or config.Window.Height <= 0
        or type(config.Window.MinScale) ~= "number" or config.Window.MinScale <= 0
        or type(config.Window.Margin) ~= "number" or config.Window.Margin < 0 then
        error("Config.Window possui dimensões, MinScale ou Margin inválidos", 0)
    end
    if type(config.CategoryModules) ~= "table" or #config.CategoryModules == 0 then
        error("Config.CategoryModules não pode estar vazio", 0)
    end
end

function Schema.ValidateCategory(category, path, categoryIds, controlIds)
    if type(category) ~= "table" then
        error(path .. " deve retornar uma tabela", 0)
    end
    requireNonEmptyString(category.Id, path .. ".Id")
    requireNonEmptyString(category.Label, path .. ".Label")
    requireNonEmptyString(category.Icon, path .. ".Icon")
    if categoryIds[category.Id] then
        error("Id de categoria duplicado '" .. category.Id .. "' em " .. path, 0)
    end
    categoryIds[category.Id] = path

    if category.RuntimeModule ~= nil then
        requireNonEmptyString(category.RuntimeModule, path .. ".RuntimeModule")
    end
    if type(category.Sections) ~= "table" or #category.Sections == 0 then
        error(path .. ".Sections deve conter ao menos uma seção", 0)
    end

    for sectionIndex, section in ipairs(category.Sections) do
        local sectionContext = path .. ".Sections[" .. tostring(sectionIndex) .. "]"
        if type(section) ~= "table" then error(sectionContext .. " deve ser uma tabela", 0) end
        requireNonEmptyString(section.Title, sectionContext .. ".Title")
        if section.Icon ~= nil then requireNonEmptyString(section.Icon, sectionContext .. ".Icon") end
        if type(section.Controls) ~= "table" then
            error(sectionContext .. ".Controls deve ser uma tabela", 0)
        end

        for controlIndex, control in ipairs(section.Controls) do
            local context = sectionContext .. ".Controls[" .. tostring(controlIndex) .. "]"
            if type(control) ~= "table" then error(context .. " deve ser uma tabela", 0) end
            if not VALID_CONTROL_KINDS[control.Kind] then
                error(context .. " possui Kind inválido: " .. tostring(control.Kind), 0)
            end
            requireNonEmptyString(control.Label, context .. ".Label")
            if control.Description ~= nil and type(control.Description) ~= "string" then
                error(context .. ".Description deve ser uma string", 0)
            end
            if control.Callback ~= nil and type(control.Callback) ~= "function" then
                error(context .. ".Callback deve ser uma função", 0)
            end

            if control.Kind ~= "Paragraph" then
                requireNonEmptyString(control.Id, context .. ".Id")
                if controlIds[control.Id] then
                    error("Id de controle duplicado '" .. control.Id .. "' em " .. context, 0)
                end
                controlIds[control.Id] = context
            end
            if control.Setting ~= nil then
                requireNonEmptyString(control.Setting, context .. ".Setting")
                if not category.RuntimeModule then
                    error(context .. " possui Setting, mas a categoria não possui RuntimeModule", 0)
                end
            end
            if control.OptionsSource ~= nil then
                requireNonEmptyString(control.OptionsSource, context .. ".OptionsSource")
                if not category.RuntimeModule then
                    error(context .. " possui OptionsSource, mas a categoria não possui RuntimeModule", 0)
                end
            end

            if control.Kind == "Slider" then
                if type(control.Min) ~= "number" or type(control.Max) ~= "number" or control.Max <= control.Min then
                    error(context .. " precisa de Min e Max numéricos, com Max maior que Min", 0)
                end
                if control.Step ~= nil and (type(control.Step) ~= "number" or control.Step <= 0) then
                    error(context .. ".Step deve ser um número positivo", 0)
                end
                if control.Default ~= nil and (type(control.Default) ~= "number"
                    or control.Default < control.Min or control.Default > control.Max) then
                    error(context .. ".Default deve estar entre Min e Max", 0)
                end
            elseif control.Kind == "Dropdown" then
                local optionsType = type(control.Options)
                if optionsType ~= "table" and optionsType ~= "function"
                    and type(control.OptionsSource) ~= "string" then
                    error(context .. " precisa de Options ou OptionsSource", 0)
                end
                if optionsType == "table" and #control.Options == 0 then
                    error(context .. ".Options não pode estar vazio", 0)
                end
                if optionsType == "table" and control.Default ~= nil then
                    local defaultExists = false
                    for _, option in ipairs(control.Options) do
                        if option == control.Default then defaultExists = true break end
                    end
                    if not defaultExists then
                        error(context .. ".Default não existe em Options", 0)
                    end
                end
            elseif control.Kind == "Toggle" and control.Default ~= nil
                and type(control.Default) ~= "boolean" then
                error(context .. ".Default deve ser booleano", 0)
            elseif control.Kind == "Button" and control.ButtonText ~= nil
                and type(control.ButtonText) ~= "string" then
                error(context .. ".ButtonText deve ser uma string", 0)
            end
        end
    end
end

function Schema.RequireModulePath(path, context)
    requireNonEmptyString(path, context or "caminho do módulo")
end

return Schema
end
-- END HMenuSchema.lua

-- BEGIN HMenu.lua
__modules["HMenu.lua"] = function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local HMenu = {}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function round(parent, radius)
    return make("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function stroke(parent, color, transparency)
    return make("UIStroke", { Color = color, Thickness = 1, Transparency = transparency or 0 }, parent)
end

local function pad(parent, left, right, top, bottom)
    return make("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0), PaddingRight = UDim.new(0, right or left or 0),
        PaddingTop = UDim.new(0, top or 0), PaddingBottom = UDim.new(0, bottom or top or 0),
    }, parent)
end

local function text(parent, value, properties)
    properties = properties or {}
    properties.BackgroundTransparency = properties.BackgroundTransparency == nil and 1 or properties.BackgroundTransparency
    properties.Text = value
    properties.BorderSizePixel = 0
    local object = make("TextLabel", properties, parent)
    return object
end

local function lower(value)
    return string.lower(tostring(value or ""))
end

function HMenu:Create(options)
    assert(options and type(options.Import) == "function", "HMenu requires an Import function")
    local Schema = options.Import("HMenuSchema.lua")
    local Config = options.Import("HMenuConfig.lua")
    Schema.ValidateConfig(Config)
    local Theme = {}
    for key, value in pairs(Config.Theme) do Theme[key] = value end
    local Parent = options.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")
    local function icon(parent, iconName, properties)
        properties = properties or {}
        properties.BackgroundTransparency = 1
        properties.BorderSizePixel = 0
        properties.Image = Config.Icons[iconName] or iconName or ""
        properties.ImageColor3 = properties.ImageColor3 or Theme.Muted
        return make("ImageLabel", properties, parent)
    end
    local categories = {}
    local categoryIds = {}
    local controlIds = {}
    local runtimeModules = {}
    for _, path in ipairs(Config.CategoryModules) do
        Schema.RequireModulePath(path, "Config.CategoryModules[]")
        local ok, category = pcall(options.Import, path)
        if not ok then
            error("Falha ao importar categoria " .. tostring(path) .. ": " .. tostring(category), 0)
        end
        Schema.ValidateCategory(category, path, categoryIds, controlIds)
        table.insert(categories, category)
    end
    if not categoryIds[Config.DefaultCategory] then
        error("Config.DefaultCategory aponta para uma categoria inexistente: "
            .. tostring(Config.DefaultCategory), 0)
    end

    for _, category in ipairs(categories) do
        local path = category.RuntimeModule
        if path and not runtimeModules[path] then
            local ok, runtimeModule = pcall(options.Import, path)
            if not ok then
                error("Falha ao importar runtime " .. path .. ": " .. tostring(runtimeModule), 0)
            end
            if type(runtimeModule) ~= "table" or type(runtimeModule.Create) ~= "function" then
                error(path .. " deve retornar uma tabela com função Create", 0)
            end
            runtimeModules[path] = runtimeModule
        end
    end

    if type(_G.__HMENU_CLEANUP) == "function" then pcall(_G.__HMENU_CLEANUP) end
    local connections = {}
    local pageConnections = {}
    local popupConnections = {}
    local runtimes = {}
    local activeDropdownPopup
    local wallpaperRequest = 0
    local themeSetter
    local cameraViewportConnection
    local destroyed = false
    local cleanupFunction

    local function connectTracked(bucket, signal, callback)
        local connection = signal:Connect(callback)
        table.insert(bucket, connection)
        return connection
    end

    local function connect(signal, callback)
        return connectTracked(connections, signal, callback)
    end

    local function connectPage(signal, callback)
        return connectTracked(pageConnections, signal, callback)
    end

    local function connectPopup(signal, callback)
        return connectTracked(popupConnections, signal, callback)
    end

    local function disconnectAll(bucket)
        for index = #bucket, 1, -1 do
            pcall(function() bucket[index]:Disconnect() end)
            table.remove(bucket, index)
        end
    end

    local previous = Parent:FindFirstChild(Config.GuiName)
    if previous then previous:Destroy() end
    local gui = make("ScreenGui", {
        Name = Config.GuiName, ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 998,
    }, Parent)
    if type(protect_gui) == "function" then pcall(protect_gui, gui) end

    cleanupFunction = function()
        if destroyed then return end
        destroyed = true
        wallpaperRequest = wallpaperRequest + 1
        disconnectAll(popupConnections)
        disconnectAll(pageConnections)
        disconnectAll(connections)
        if cameraViewportConnection then
            pcall(function() cameraViewportConnection:Disconnect() end)
            cameraViewportConnection = nil
        end
        if activeDropdownPopup then
            activeDropdownPopup:Destroy()
            activeDropdownPopup = nil
        end
        for index = #runtimes, 1, -1 do
            local runtime = runtimes[index]
            if type(runtime.Destroy) == "function" then
                pcall(function() runtime:Destroy() end)
            end
            table.remove(runtimes, index)
        end
        if gui and gui.Parent then gui:Destroy() end
        if _G.__HMENU_SET_THEME == themeSetter then _G.__HMENU_SET_THEME = nil end
        if _G.__HMENU_CLEANUP == cleanupFunction then _G.__HMENU_CLEANUP = nil end
    end
    _G.__HMENU_CLEANUP = cleanupFunction

    for _, category in ipairs(categories) do
        if category.RuntimeModule then
            local runtimeModule = runtimeModules[category.RuntimeModule]
            local runtimeOk, runtime = pcall(function()
                return runtimeModule:Create({ Parent = Parent })
            end)
            if not runtimeOk or type(runtime) ~= "table" or type(runtime.Set) ~= "function"
                or type(runtime.Destroy) ~= "function" then
                cleanupFunction()
                error("Falha ao iniciar runtime " .. category.RuntimeModule .. ": "
                    .. tostring(runtime), 0)
            end

            table.insert(runtimes, runtime)
            for _, section in ipairs(category.Sections) do
                for _, control in ipairs(section.Controls) do
                    if control.OptionsSource then
                        if type(runtime.GetOptions) ~= "function" then
                            cleanupFunction()
                            error(category.RuntimeModule .. " precisa implementar GetOptions para "
                                .. control.Id, 0)
                        end
                        local optionsSource = control.OptionsSource
                        control.Options = function()
                            return runtime:GetOptions(optionsSource)
                        end
                    end
                    if control.Setting then
                        local settingName = control.Setting
                        local settingRuntime = runtime
                        local previousCallback = control.Callback
                        control.Callback = function(value, state)
                            settingRuntime:Set(settingName, value)
                            if type(previousCallback) == "function" then
                                previousCallback(value, state)
                            end
                        end
                    end
                end
            end
        end
    end

    local root = make("Frame", {
        Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Config.Window.Width, Config.Window.Height),
        BackgroundColor3 = Theme.Window, BackgroundTransparency = 0.13,
        BorderSizePixel = 0, ClipsDescendants = true,
    }, gui)
    round(root, 12)
    stroke(root, Theme.Border, 0.3)
    local rootGradient = make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.WindowHighlight),
            ColorSequenceKeypoint.new(1, Theme.WindowDark),
        }), Rotation = 135,
    }, root)
    local wallpaper = make("ImageLabel", {
        Name = "ThemeWallpaper",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "",
        ImageColor3 = Color3.fromRGB(225, 225, 235),
        ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Crop,
        Visible = false,
    }, root)
    local wallpaperShade = make("Frame", {
        Name = "ThemeWallpaperShade",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Theme.WindowDark,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
    }, root)
    local scale = make("UIScale", { Scale = 1 }, root)
    local accentLine = make("Frame", {
        Name = "AccentLine", Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0, ZIndex = 8,
    }, root)
    make("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.22, 0.15),
            NumberSequenceKeypoint.new(0.78, 0.15), NumberSequenceKeypoint.new(1, 1),
        }),
    }, accentLine)

    local header = make("Frame", {
        Name = "Header", Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = Theme.Header,
        BackgroundTransparency = 0.22, BorderSizePixel = 0, Active = true, ZIndex = 2,
    }, root)
    text(header, "HMenu " .. Config.Version, {
        Size = UDim2.fromOffset(230, 54), Position = UDim2.fromOffset(20, 0),
        TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    icon(header, "laptop", {
        Size = UDim2.fromOffset(14, 14), Position = UDim2.new(1, -193, 0.5, -7),
        ImageColor3 = Theme.Dim,
    })
    text(header, "Desktop PC", {
        Size = UDim2.fromOffset(95, 54), Position = UDim2.new(1, -175, 0, 0),
        TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local minimize = make("TextButton", {
        Name = "Minimize", Size = UDim2.fromOffset(36, 54), Position = UDim2.new(1, -80, 0, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0, Text = "-", TextColor3 = Theme.Muted,
        Font = Enum.Font.Gotham, TextSize = 15, AutoButtonColor = false,
    }, header)
    local close = make("TextButton", {
        Name = "Close", Size = UDim2.fromOffset(38, 54), Position = UDim2.new(1, -42, 0, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0, Text = "X", TextColor3 = Theme.Muted,
        Font = Enum.Font.Gotham, TextSize = 14, AutoButtonColor = false,
    }, header)
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Border, BackgroundTransparency = 0.7, BorderSizePixel = 0,
    }, header)

    local sidebar = make("Frame", {
        Name = "Sidebar", Size = UDim2.new(0, 178, 1, -54), Position = UDim2.fromOffset(0, 54),
        BackgroundColor3 = Theme.Sidebar, BackgroundTransparency = 0.24, BorderSizePixel = 0, ZIndex = 2,
    }, root)
    make("Frame", {
        Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = Theme.Border, BackgroundTransparency = 0.73, BorderSizePixel = 0,
    }, sidebar)

    local search = make("TextBox", {
        Name = "Search", Size = UDim2.new(1, -26, 0, 34), Position = UDim2.fromOffset(13, 12),
        BackgroundColor3 = Theme.Control, BackgroundTransparency = 0.25, BorderSizePixel = 0,
        Text = "", PlaceholderText = "Pesquisar...", ClearTextOnFocus = false,
        PlaceholderColor3 = Theme.Dim, TextColor3 = Theme.Text, Font = Enum.Font.Gotham,
        TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    }, sidebar)
    round(search, 7)
    stroke(search, Theme.Border, 0.48)
    pad(search, 32, 11)
    icon(sidebar, "search", {
        Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(23, 22),
        ImageColor3 = Theme.Dim, ZIndex = 3,
    })

    local nav = make("ScrollingFrame", {
        Name = "Navigation", Size = UDim2.new(1, -14, 1, -89), Position = UDim2.fromOffset(7, 58),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Border, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    local navLayout = make("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }, nav)
    pad(nav, 0, 3, 0, 8)
    text(sidebar, "RIGHTSHIFT  |  MOSTRAR / OCULTAR", {
        Size = UDim2.new(1, -20, 0, 22), Position = UDim2.new(0, 12, 1, -27),
        TextColor3 = Theme.Dim, Font = Enum.Font.GothamMedium, TextSize = 8,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local content = make("Frame", {
        Name = "Content", Size = UDim2.new(1, -178, 1, -54), Position = UDim2.fromOffset(178, 54),
        BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
    }, root)
    local titleIcon = icon(content, "home", {
        Size = UDim2.fromOffset(21, 21), Position = UDim2.fromOffset(25, 26),
        ImageColor3 = Theme.Accent,
    })
    local title = text(content, "", {
        Size = UDim2.new(1, -70, 0, 42), Position = UDim2.fromOffset(55, 16),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local titleAccent = make("Frame", {
        Size = UDim2.fromOffset(34, 2), Position = UDim2.fromOffset(56, 57),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
    }, content)
    round(titleAccent, 1)
    local page = make("ScrollingFrame", {
        Name = "Page", Size = UDim2.new(1, -39, 1, -76), Position = UDim2.fromOffset(24, 66),
        BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Border, ScrollingDirection = Enum.ScrollingDirection.Y,
    }, content)
    local pageLayout = make("UIListLayout", {
        Padding = UDim.new(0, 13), SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
    }, page)
    pad(page, 0, 8, 0, 14)

    local state = {}
    local activeButton, activeCategory
    local navButtons = {}

    local function closeDropdown()
        disconnectAll(popupConnections)
        if activeDropdownPopup then
            activeDropdownPopup:Destroy()
            activeDropdownPopup = nil
        end
    end

    local function fire(control, value)
        state[control.Id or control.Label] = value
        if type(control.Callback) == "function" then
            local ok, err = pcall(control.Callback, value, state)
            if not ok then warn("[HMenu] Callback error:", err) end
        end
    end

    local function createToggle(parent, control, row)
        local saved = state[control.Id or control.Label]
        local enabled = saved == nil and control.Default == true or saved == true
        local track = make("Frame", {
            Size = UDim2.fromOffset(36, 19), Position = UDim2.new(1, -50, 0.5, -10),
            BackgroundColor3 = enabled and Theme.Accent or Theme.Control, BorderSizePixel = 0,
        }, row)
        round(track, 10)
        stroke(track, enabled and Theme.Accent or Theme.Border, 0.28)
        local knob = make("Frame", {
            Size = UDim2.fromOffset(13, 13), Position = enabled and UDim2.fromOffset(20, 3) or UDim2.fromOffset(3, 3),
            BackgroundColor3 = Theme.Text, BorderSizePixel = 0,
        }, track)
        round(knob, 7)
        local hit = make("TextButton", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", AutoButtonColor = false,
        }, row)
        state[control.Id or control.Label] = enabled
        connectPage(hit.MouseButton1Click, function()
            enabled = not enabled
            TweenService:Create(track, TweenInfo.new(0.14), { BackgroundColor3 = enabled and Theme.Accent or Theme.Control }):Play()
            TweenService:Create(knob, TweenInfo.new(0.14), { Position = enabled and UDim2.fromOffset(20, 3) or UDim2.fromOffset(3, 3) }):Play()
            fire(control, enabled)
        end)
    end

    local function createSlider(parent, control, row)
        local minimum, maximum = control.Min or 0, control.Max or 100
        local saved = state[control.Id or control.Label]
        local value = math.clamp(saved == nil and (control.Default or minimum) or saved, minimum, maximum)
        local valueText = text(row, tostring(value), {
            Size = UDim2.fromOffset(42, 18), Position = UDim2.new(1, -166, 0.5, -9),
            TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Right,
        })
        local bar = make("Frame", {
            Size = UDim2.fromOffset(104, 4), Position = UDim2.new(1, -116, 0.5, -2),
            BackgroundColor3 = Theme.Control, BorderSizePixel = 0,
        }, row)
        round(bar, 3)
        local fill = make("Frame", {
            Size = UDim2.fromScale((value - minimum) / (maximum - minimum), 1),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        }, bar)
        round(fill, 3)
        local knob = make("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.fromOffset(15, 15), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0,
        }, fill)
        round(knob, 8)
        local dragging = false
        local function update(x)
            local alpha = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            value = math.floor((minimum + (maximum - minimum) * alpha) / (control.Step or 1) + 0.5) * (control.Step or 1)
            value = math.clamp(value, minimum, maximum)
            fill.Size = UDim2.fromScale((value - minimum) / (maximum - minimum), 1)
            valueText.Text = tostring(value)
            fire(control, value)
        end
        local hit = make("TextButton", {
            Size = UDim2.new(1, 12, 0, 22), Position = UDim2.fromOffset(-6, -9),
            BackgroundTransparency = 1, Text = "", AutoButtonColor = false,
        }, bar)
        connectPage(hit.InputBegan, function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(inputObject.Position.X)
            end
        end)
        connectPage(UserInputService.InputChanged, function(inputObject)
            if dragging and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
                update(inputObject.Position.X)
            end
        end)
        connectPage(UserInputService.InputEnded, function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
        state[control.Id or control.Label] = value
    end

    local function createChoice(control, row)
        local function readChoices()
            local choices = control.Options
            if type(choices) == "function" then
                local ok, result = pcall(choices)
                choices = ok and result or nil
            end
            if type(choices) ~= "table" or #choices == 0 then
                return { "None" }
            end
            return choices
        end
        local choices = readChoices()
        local saved = state[control.Id or control.Label]
        local index = table.find(choices, saved == nil and control.Default or saved) or 1
        local button = make("TextButton", {
            Size = UDim2.fromOffset(152, 27), Position = UDim2.new(1, -165, 0.5, -14),
            BackgroundColor3 = Theme.Control, BorderSizePixel = 0, Text = tostring(choices[index]) .. "  v",
            TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 10, AutoButtonColor = false,
        }, row)
        round(button, 5)
        stroke(button, Theme.Border, 0.55)
        state[control.Id or control.Label] = choices[index]
        connectPage(button.MouseButton1Click, function()
            local current = choices[index]
            choices = readChoices()
            if not control.UseList then
                index = table.find(choices, current) or 0
                index = index % #choices + 1
                button.Text = tostring(choices[index]) .. "  v"
                fire(control, choices[index])
                return
            end
            index = table.find(choices, current) or 1

            if activeDropdownPopup then
                closeDropdown()
                button.Text = tostring(choices[index]) .. "  v"
                return
            end

            button.Text = tostring(choices[index]) .. "  ^"
            local optionCount = math.max(#choices, 1)
            local popup = make("Frame", {
                Name = "DropdownPopup",
                Position = UDim2.fromOffset(button.AbsolutePosition.X, button.AbsolutePosition.Y + button.AbsoluteSize.Y + 4),
                Size = UDim2.fromOffset(button.AbsoluteSize.X, math.min(optionCount * 29 + 8, 182)),
                BackgroundColor3 = Theme.WindowDark,
                BackgroundTransparency = 0.03,
                BorderSizePixel = 0,
                ZIndex = 80,
            }, gui)
            activeDropdownPopup = popup
            round(popup, 7)
            stroke(popup, Theme.Border, 0.2)

            local list = make("ScrollingFrame", {
                Size = UDim2.new(1, -8, 1, -8), Position = UDim2.fromOffset(4, 4),
                BackgroundTransparency = 1, BorderSizePixel = 0,
                CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Border,
                ZIndex = 81,
            }, popup)
            make("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, list)

            for optionIndex, option in ipairs(choices) do
                local optionButton = make("TextButton", {
                    Size = UDim2.new(1, -3, 0, 27), BackgroundColor3 = Theme.Surface,
                    BackgroundTransparency = option == current and 0.25 or 1,
                    BorderSizePixel = 0, Text = tostring(option), TextColor3 = option == current and Theme.Text or Theme.Muted,
                    Font = Enum.Font.Gotham, TextSize = 10, AutoButtonColor = false,
                    ZIndex = 82, LayoutOrder = optionIndex,
                }, list)
                round(optionButton, 5)
                connectPopup(optionButton.MouseButton1Click, function()
                    index = optionIndex
                    button.Text = tostring(option) .. "  v"
                    fire(control, option)
                    closeDropdown()
                end)
                connectPopup(optionButton.MouseEnter, function()
                    optionButton.BackgroundTransparency = 0.35
                    optionButton.TextColor3 = Theme.Text
                end)
                connectPopup(optionButton.MouseLeave, function()
                    optionButton.BackgroundTransparency = optionIndex == index and 0.25 or 1
                    optionButton.TextColor3 = optionIndex == index and Theme.Text or Theme.Muted
                end)
            end
        end)
    end

    local function createAction(control, row)
        local button = make("TextButton", {
            Size = UDim2.fromOffset(102, 27), Position = UDim2.new(1, -115, 0.5, -14),
            BackgroundColor3 = Theme.Control, BorderSizePixel = 0, Text = control.ButtonText or "Executar",
            TextColor3 = Theme.Accent, Font = Enum.Font.GothamMedium, TextSize = 10, AutoButtonColor = false,
        }, row)
        round(button, 5)
        stroke(button, Theme.Border, 0.45)
        connectPage(button.MouseButton1Click, function()
            fire(control, true)
            button.Text = "Concluído"
            task.delay(1, function() if button.Parent then button.Text = control.ButtonText or "Executar" end end)
        end)
    end

    local function createControl(sectionFrame, control)
        local height = control.Kind == "Paragraph" and 56 or 42
        local row = make("Frame", {
            Name = control.Id or control.Label, Size = UDim2.new(1, 0, 0, height),
            BackgroundColor3 = Theme.Surface, BackgroundTransparency = 0.17,
            BorderSizePixel = 0, Active = true,
        }, sectionFrame)
        round(row, 5)
        stroke(row, Theme.Border, 0.6)
        local labelWidth = (control.Kind == "Paragraph") and -26 or -185
        text(row, control.Label, {
            Size = UDim2.new(1, labelWidth, 0, control.Description and 18 or height), Position = UDim2.fromOffset(12, control.Description and 6 or 0),
            TextColor3 = Theme.Text, Font = control.Kind == "Paragraph" and Enum.Font.GothamMedium or Enum.Font.Gotham,
            TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
        })
        if control.Description then
            text(row, control.Description, {
                Size = UDim2.new(1, -26, 0, 18), Position = UDim2.fromOffset(12, 27),
                TextColor3 = Theme.Dim, Font = Enum.Font.Gotham, TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
        end
        if control.Kind == "Toggle" then createToggle(sectionFrame, control, row)
        elseif control.Kind == "Slider" then createSlider(sectionFrame, control, row)
        elseif control.Kind == "Dropdown" then createChoice(control, row)
        elseif control.Kind == "Button" then createAction(control, row)
        end
        connectPage(row.MouseEnter, function()
            TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.08 }):Play()
        end)
        connectPage(row.MouseLeave, function()
            TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.17 }):Play()
        end)
        return row
    end

    local function clearPage()
        closeDropdown()
        disconnectAll(pageConnections)
        for _, child in ipairs(page:GetChildren()) do
            if child ~= pageLayout and not child:IsA("UIPadding") then child:Destroy() end
        end
    end

    local function render(category)
        activeCategory = category
        title.Text = category.Label
        titleIcon.Image = Config.Icons[category.Icon] or category.Icon or ""
        clearPage()
        for sectionIndex, section in ipairs(category.Sections or {}) do
            local sectionFrame = make("Frame", {
                Name = section.Title, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1, LayoutOrder = sectionIndex,
            }, page)
            local layout = make("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, sectionFrame)
            local sectionHeader = make("Frame", {
                Name = "SectionHeader", Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 0,
            }, sectionFrame)
            icon(sectionHeader, section.Icon or category.Icon, {
                Size = UDim2.fromOffset(15, 15), Position = UDim2.fromOffset(1, 4),
                ImageColor3 = Theme.Muted,
            })
            text(sectionHeader, section.Title, {
                Size = UDim2.new(1, -25, 1, 0), Position = UDim2.fromOffset(24, 0), TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
            })
            for controlIndex, control in ipairs(section.Controls or {}) do
                local row = createControl(sectionFrame, control)
                row.LayoutOrder = controlIndex
            end
        end
        page.CanvasPosition = Vector2.new(0, 0)
    end

    local function selectCategory(category, button)
        if activeButton then
            activeButton.BackgroundTransparency = 1
            local marker = activeButton:FindFirstChild("ActiveMarker")
            if marker then marker.Visible = false end
            local oldIcon = activeButton:FindFirstChild("CategoryIcon")
            local oldLabel = activeButton:FindFirstChild("CategoryLabel")
            if oldIcon then oldIcon.ImageColor3 = Theme.Muted end
            if oldLabel then oldLabel.TextColor3 = Theme.Muted end
        end
        activeButton, activeCategory = button, category
        button.BackgroundTransparency = 0.72
        button.ActiveMarker.Visible = true
        button.CategoryIcon.ImageColor3 = Theme.Accent
        button.CategoryLabel.TextColor3 = Theme.Text
        render(category)
    end

    local function refreshFavoriteOrder()
        for _, item in pairs(navButtons) do
            item.Button.LayoutOrder = item.Favorite and item.OriginalIndex or (1000 + item.OriginalIndex)
            item.FavoriteButton.ImageColor3 = item.Favorite and Theme.Bookmark or Theme.Dim
            item.FavoriteButton.ImageTransparency = item.Favorite and 0 or 0.12
        end
    end

    for index, category in ipairs(categories) do
        category.Bookmarked = false
        local button = make("TextButton", {
            Name = category.Id, Size = UDim2.new(1, 0, 0, 35), BackgroundColor3 = Theme.Surface,
            BackgroundTransparency = 1, BorderSizePixel = 0,
            Text = "", AutoButtonColor = false, LayoutOrder = index,
        }, nav)
        round(button, 5)
        local marker = make("Frame", {
            Name = "ActiveMarker", Size = UDim2.fromOffset(3, 18), Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Visible = false,
        }, button)
        round(marker, 2)
        icon(button, category.Icon, {
            Name = "CategoryIcon",
            Size = UDim2.fromOffset(15, 15), Position = UDim2.fromOffset(12, 10),
            ImageColor3 = Theme.Muted, ZIndex = 2,
        })
        text(button, category.Label, {
            Name = "CategoryLabel",
            Size = UDim2.new(1, -68, 1, 0), Position = UDim2.fromOffset(36, 0),
            TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2,
        })
        local favorite = make("ImageButton", {
            Name = "Favorite", AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(16, 16), Position = UDim2.new(1, -17, 0.5, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0, Image = Config.Icons.bookmark,
            ImageColor3 = Theme.Dim,
            AutoButtonColor = false, ZIndex = 5,
        }, button)
        navButtons[category.Id] = {
            Button = button, Category = category, FavoriteButton = favorite,
            Favorite = false, OriginalIndex = index,
        }
        connect(button.MouseButton1Click, function() selectCategory(category, button) end)
        connect(button.MouseEnter, function()
            if activeButton ~= button then TweenService:Create(button, TweenInfo.new(0.12), { BackgroundTransparency = 0.88 }):Play() end
        end)
        connect(button.MouseLeave, function()
            if activeButton ~= button then TweenService:Create(button, TweenInfo.new(0.12), { BackgroundTransparency = 1 }):Play() end
        end)
        connect(favorite.MouseButton1Click, function()
            local item = navButtons[category.Id]
            item.Favorite = not item.Favorite
            category.Bookmarked = item.Favorite
            refreshFavoriteOrder()
            favorite.Size = UDim2.fromOffset(13, 13)
            TweenService:Create(favorite, TweenInfo.new(0.14, Enum.EasingStyle.Back), { Size = UDim2.fromOffset(16, 16) }):Play()
        end)
        if category.Id == Config.DefaultCategory then selectCategory(category, button) end
    end
    refreshFavoriteOrder()
    if not activeButton then
        local first = navButtons[categories[1].Id]
        selectCategory(first.Category, first.Button)
    end

    connect(search:GetPropertyChangedSignal("Text"), function()
        local query = lower(search.Text):gsub("^%s+", ""):gsub("%s+$", "")
        for _, item in pairs(navButtons) do
            item.Button.Visible = query == "" or string.find(lower(item.Category.Label), query, 1, true) ~= nil
        end
    end)

    local hidden = false
    local function setVisible(visible)
        if destroyed or not root.Parent then return end
        if not visible then closeDropdown() end
        hidden = not visible
        root.Visible = visible
    end
    connect(minimize.MouseButton1Click, function() setVisible(false) end)
    connect(close.MouseButton1Click, function() setVisible(false) end)
    connect(UserInputService.InputBegan, function(inputObject, processed)
        if not processed and inputObject.KeyCode == Config.ToggleKey then setVisible(hidden) end
    end)

    local dragging, dragStart, startPosition = false, nil, nil
    connect(header.InputBegan, function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            closeDropdown()
            dragging, dragStart, startPosition = true, inputObject.Position, root.Position
        end
    end)
    connect(UserInputService.InputChanged, function(inputObject)
        if dragging and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
            local delta = inputObject.Position - dragStart
            root.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end)
    connect(UserInputService.InputEnded, function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    local function updateScale()
        local camera = Workspace.CurrentCamera
        if not camera then return end
        local viewport = camera.ViewportSize
        local fit = math.min((viewport.X - Config.Window.Margin) / Config.Window.Width, (viewport.Y - Config.Window.Margin) / Config.Window.Height, 1)
        scale.Scale = math.max(fit, Config.Window.MinScale)
    end
    local function bindCamera()
        if cameraViewportConnection then
            pcall(function() cameraViewportConnection:Disconnect() end)
            cameraViewportConnection = nil
        end
        if Workspace.CurrentCamera then
            cameraViewportConnection = Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
        end
        updateScale()
    end
    connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), bindCamera)
    bindCamera()

    local currentThemeName = "Default"
    local wallpaperAssets = {}
    local themeKeys = {
        "Window", "WindowHighlight", "WindowDark", "Sidebar", "Header",
        "Surface", "SurfaceHover", "Control", "Accent", "Bookmark",
        "Text", "Muted", "Dim", "Border", "Success", "Danger",
    }
    local colorProperties = {
        "BackgroundColor3", "TextColor3", "PlaceholderColor3",
        "ImageColor3", "ScrollBarImageColor3", "Color",
    }

    local function copyColors(source)
        local result = {}
        for _, key in ipairs(themeKeys) do result[key] = source[key] end
        return result
    end

    local function colorThemeKey(color, palette)
        if typeof(color) ~= "Color3" then return nil end
        for _, key in ipairs(themeKeys) do
            if palette[key] == color then return key end
        end
        return nil
    end

    local function recolorMenu(oldColors, newColors)
        local objects = { root }
        for _, object in ipairs(root:GetDescendants()) do table.insert(objects, object) end
        for _, object in ipairs(objects) do
            for _, property in ipairs(colorProperties) do
                local ok, current = pcall(function() return object[property] end)
                if ok then
                    local key = colorThemeKey(current, oldColors)
                    if key and newColors[key] then
                        pcall(function() object[property] = newColors[key] end)
                    end
                end
            end
        end
    end

    local function assetBaseUrls()
        if type(options.AssetBaseUrls) == "table" and #options.AssetBaseUrls > 0 then
            return options.AssetBaseUrls
        end
        if type(options.BaseUrl) == "string" and options.BaseUrl ~= "" then
            return { options.BaseUrl }
        end
        return {}
    end

    local function downloadWallpaper(path)
        local lastError = "nenhuma fonte de assets foi configurada"
        local version = tostring(options.AssetVersion or Config.Version or "stable")
        for attempt = 1, 3 do
            for _, configuredBaseUrl in ipairs(assetBaseUrls()) do
                local baseUrl = configuredBaseUrl
                if string.sub(baseUrl, -1) ~= "/" then baseUrl = baseUrl .. "/" end
                local ok, data = pcall(function()
                    return game:HttpGet(baseUrl .. path .. "?v=" .. version, true)
                end)
                if ok and type(data) == "string" and string.sub(data, 1, 8) == "\137PNG\r\n\26\n" then
                    return data
                end
                if ok then
                    lastError = "a resposta não é uma imagem PNG válida"
                else
                    lastError = tostring(data)
                end
            end
            if attempt < 3 then task.wait(0.75 * (2 ^ (attempt - 1))) end
        end
        return nil, lastError
    end

    local function wallpaperAsset(themeName, definition)
        if wallpaperAssets[themeName] then return wallpaperAssets[themeName] end
        local assetLoader = type(getcustomasset) == "function" and getcustomasset
            or (type(getsynasset) == "function" and getsynasset or nil)
        if not assetLoader or type(writefile) ~= "function" then return nil end

        local ok, asset = pcall(function()
            local directory = "HMenuThemes"
            local version = tostring(options.AssetVersion or Config.Version or "stable")
                :gsub("[^%w%-_%.]", "_")
            local localPath = "HMenuTheme-" .. themeName .. "-" .. version .. ".png"
            if type(makefolder) == "function" then
                pcall(function() makefolder(directory) end)
                localPath = directory .. "/" .. themeName .. "-" .. version .. ".png"
            end
            if type(isfile) == "function" and isfile(localPath) then
                local cachedOk, cachedAsset = pcall(assetLoader, localPath)
                if cachedOk and cachedAsset then return cachedAsset end
            end
            local data, downloadError = downloadWallpaper(definition.Wallpaper)
            if not data then error(downloadError, 0) end
            writefile(localPath, data)
            return assetLoader(localPath)
        end)
        if not ok or not asset then
            warn("[HMenu] Wallpaper could not be loaded:", themeName, asset)
            return nil
        end
        wallpaperAssets[themeName] = asset
        return asset
    end

    local function updateWallpaper(themeName, definition)
        wallpaperRequest = wallpaperRequest + 1
        local request = wallpaperRequest
        wallpaper.Visible = false
        wallpaperShade.Visible = false
        if not definition.Wallpaper then
            wallpaper.Image = ""
            wallpaper.ImageTransparency = 1
            wallpaperShade.BackgroundTransparency = 1
            return
        end

        task.spawn(function()
            local asset = wallpaperAsset(themeName, definition)
            if request ~= wallpaperRequest or currentThemeName ~= themeName or not asset then return end
            wallpaper.Image = asset
            wallpaper.ImageTransparency = 1
            wallpaperShade.BackgroundTransparency = 1
            wallpaper.Visible = true
            wallpaperShade.Visible = true
            TweenService:Create(wallpaper, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {
                ImageTransparency = definition.WallpaperTransparency or 0.42,
            }):Play()
            TweenService:Create(wallpaperShade, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {
                BackgroundTransparency = definition.ShadeTransparency or 0.5,
            }):Play()
        end)
    end

    local function applyTheme(themeName)
        local definition = Config.Themes and Config.Themes[themeName]
        if not definition or not definition.Colors or themeName == currentThemeName then return end
        closeDropdown()

        local oldColors = copyColors(Theme)
        local newColors = definition.Colors
        recolorMenu(oldColors, newColors)
        for _, key in ipairs(themeKeys) do
            if newColors[key] then Theme[key] = newColors[key] end
        end
        currentThemeName = themeName
        rootGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.WindowHighlight),
            ColorSequenceKeypoint.new(1, Theme.WindowDark),
        })
        wallpaperShade.BackgroundColor3 = Theme.WindowDark
        updateWallpaper(themeName, definition)

        if activeCategory then render(activeCategory) end
        refreshFavoriteOrder()
    end

    themeSetter = function(themeName)
        applyTheme(tostring(themeName or "Default"))
    end
    _G.__HMENU_SET_THEME = themeSetter

    print("[HMenu] Aberto. Use RightShift para ocultar ou mostrar.")
    return { Gui = gui, State = state, Destroy = cleanupFunction, SetVisible = setVisible }
end

return HMenu
end
-- END HMenu.lua

-- BEGIN categories/Atmosphere.lua
__modules["categories/Atmosphere.lua"] = function()
local Lighting = game:GetService("Lighting")

return {
    Id = "Atmosphere",
    Label = "Atmosphere",
    Icon = "atmosphere",
    Bookmarked = false,
    RuntimeModule = "runtime/Atmosphere.lua",
    Sections = {
        {
            Title = "World Appearance",
            Icon = "cloud",
            Controls = {
                { Kind = "Dropdown", Setting = "Weather", Id = "weather", Label = "Weather", Options = { "Default", "Clear", "Night", "Fog" }, Default = "Default" },
                { Kind = "Slider", Setting = "Brightness", Id = "brightness", Label = "Brightness", Min = 0, Max = 10, Default = Lighting.Brightness, Step = 0.1 },
                { Kind = "Toggle", Setting = "CustomSky", Id = "custom_sky", Label = "Custom Sky", Default = false },
            },
        },
    },
}
end
-- END categories/Atmosphere.lua

-- BEGIN categories/Combat.lua
__modules["categories/Combat.lua"] = function()
return {
    Id = "Combat",
    Label = "Combat",
    Icon = "target",
    Bookmarked = false,
    RuntimeModule = "runtime/Combat.lua",
    Sections = {
        {
            Title = "Murder",
            Icon = "target",
            Controls = {
                { Kind = "Toggle", Setting = "MurderKillAura", Id = "murder_kill_aura", Label = "Kill Aura", Description = "Automatically attacks a valid target inside the aura radius.", Default = false },
                { Kind = "Slider", Setting = "MurderAuraRadius", Id = "murder_aura_radius", Label = "Aura Radius", Min = 4, Max = 25, Default = 12, Step = 1 },
                { Kind = "Slider", Setting = "MurderAttackDelay", Id = "murder_attack_delay", Label = "Attack Delay", Min = 0.05, Max = 1, Default = 0.15, Step = 0.05 },
                { Kind = "Dropdown", Setting = "MurderTargetPriority", Id = "murder_target_priority", Label = "Target Priority", Options = { "Nearest", "Sheriff First" }, Default = "Nearest" },
                { Kind = "Toggle", Setting = "MurderAutoEquipKnife", Id = "murder_auto_equip", Label = "Auto Equip Knife", Description = "Keeps the Knife equipped while you are the Murderer.", Default = false },
                { Kind = "Button", Setting = "MurderEquipKnife", Id = "murder_equip_knife", Label = "Equip Knife", ButtonText = "Equip" },
                { Kind = "Button", Setting = "MurderKillNearest", Id = "murder_kill_nearest", Label = "Kill Nearest", Description = "Blink-stabs the nearest alive target and returns to your position.", ButtonText = "Kill" },
                { Kind = "Button", Setting = "MurderKillSheriff", Id = "murder_kill_sheriff", Label = "Kill Sheriff", Description = "Targets the Sheriff or current Hero carrying the Gun.", ButtonText = "Kill" },
                { Kind = "Button", Setting = "MurderKillAll", Id = "murder_kill_all", Label = "Kill All", Description = "Sequentially attacks every alive non-Murderer target.", ButtonText = "Kill All" },
            },
        },
        {
            Title = "Sheriff",
            Icon = "target",
            Controls = {
                { Kind = "Toggle", Setting = "SheriffPerfectShots", Id = "sheriff_perfect_shots", Label = "Perfect Shots", Description = "Any manual Gun shot also sends a guaranteed shot to the Murderer.", Default = false },
                { Kind = "Button", Setting = "SheriffShootMurderer", Id = "sheriff_shoot_murderer", Label = "Shoot Murderer", Description = "Equips the Gun and fires directly at the current Murderer.", ButtonText = "Shoot" },
                { Kind = "Toggle", Setting = "SheriffAutoShootMurderer", Id = "sheriff_auto_shoot", Label = "Auto Shoot Murderer", Description = "When the Murderer is visible, pulls the Gun from Backpack and fires automatically.", Default = false },
                { Kind = "Slider", Setting = "SheriffShootCooldown", Id = "sheriff_shoot_cooldown", Label = "Auto Shoot Cooldown", Min = 0.4, Max = 2, Default = 1.1, Step = 0.1 },
                { Kind = "Dropdown", Setting = "SheriffTargetPart", Id = "sheriff_target_part", Label = "Target Part", Options = { "HumanoidRootPart", "Head", "UpperTorso" }, Default = "HumanoidRootPart" },
                { Kind = "Slider", Setting = "SheriffPrediction", Id = "sheriff_prediction", Label = "Prediction", Min = 0, Max = 0.35, Default = 0.08, Step = 0.01 },
                { Kind = "Toggle", Setting = "SheriffIgnoreWalls", Id = "sheriff_ignore_walls", Label = "Ignore Walls", Description = "Off by default: Auto Shoot requires direct line of sight.", Default = false },
                { Kind = "Toggle", Setting = "SheriffAutoEquipGun", Id = "sheriff_auto_equip", Label = "Auto Equip Gun", Description = "Automatically equips the Gun when it enters your Backpack.", Default = false },
                { Kind = "Button", Setting = "SheriffEquipGun", Id = "sheriff_equip_gun", Label = "Equip Gun", ButtonText = "Equip" },
                { Kind = "Toggle", Setting = "SheriffAutoGrabGun", Id = "sheriff_auto_grab", Label = "Auto Grab Dropped Gun", Description = "Attempts to collect GunDrop without moving or changing your CFrame.", Default = false },
                { Kind = "Button", Setting = "SheriffGrabGunNow", Id = "sheriff_grab_now", Label = "Grab Dropped Gun Now", Description = "Remote pickup attempt only; your character stays in place.", ButtonText = "Grab" },
            },
        },
        {
            Title = "Utils",
            Icon = "shield",
            Controls = {
                { Kind = "Toggle", Setting = "UtilsAutoEvadeMurderer", Id = "utils_auto_evade", Label = "Auto Evade Murderer", Description = "Moves away when the Murderer enters the danger radius.", Default = false },
                { Kind = "Slider", Setting = "UtilsDangerRadius", Id = "utils_danger_radius", Label = "Danger Radius", Min = 5, Max = 40, Default = 15, Step = 1 },
                { Kind = "Slider", Setting = "UtilsEvadeDistance", Id = "utils_evade_distance", Label = "Evade Distance", Min = 10, Max = 50, Default = 30, Step = 1 },
                { Kind = "Toggle", Setting = "UtilsHitboxExpander", Id = "utils_hitbox", Label = "Hitbox Expander", Description = "Locally expands HumanoidRootPart for the selected combat target.", Default = false },
                { Kind = "Slider", Setting = "UtilsHitboxSize", Id = "utils_hitbox_size", Label = "Hitbox Size", Min = 2, Max = 15, Default = 6, Step = 1 },
                { Kind = "Dropdown", Setting = "UtilsHitboxTarget", Id = "utils_hitbox_target", Label = "Hitbox Target", Options = { "Murderer", "Sheriff", "Everyone" }, Default = "Murderer" },
            },
        },
    },
}
end
-- END categories/Combat.lua

-- BEGIN categories/Credits.lua
__modules["categories/Credits.lua"] = function()
return {
    Id = "Credits", Label = "Credits", Icon = "info", Bookmarked = false,
    Sections = {
        { Title = "About", Icon = "info", Controls = {
            { Kind = "Paragraph", Label = "HMenu v1.0", Description = "Interface modular criada para manutenção simples e expansão por categorias." },
            { Kind = "Paragraph", Label = "Desenvolvimento", Description = "Manoel2k67 / HMenu" },
            { Kind = "Button", Id = "copy_community", Label = "Community", ButtonText = "Copiar link" },
        }},
    },
}
end
-- END categories/Credits.lua

-- BEGIN categories/Emotes.lua
__modules["categories/Emotes.lua"] = function()
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
end
-- END categories/Emotes.lua

-- BEGIN categories/Farm.lua
__modules["categories/Farm.lua"] = function()
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
                { Kind = "Slider", Setting = "FarmWalkSpeed", Id = "farm_walk_speed", Label = "Farm Walk Speed", Min = 16, Max = 100, Default = 16, Step = 2 },
            },
        },
    },
}
end
-- END categories/Farm.lua

-- BEGIN categories/Main.lua
__modules["categories/Main.lua"] = function()
return {
    Id = "Main", Label = "Main", Icon = "home", Bookmarked = false,
    Sections = {
        { Title = "Overview", Icon = "overview", Controls = {
            { Kind = "Paragraph", Label = "HMenu está pronto", Description = "Interface modular carregada com dados de demonstração." },
            { Kind = "Dropdown", Id = "profile", Label = "Perfil ativo", Options = { "Default", "Performance", "Custom" }, Default = "Default" },
            { Kind = "Button", Id = "save_profile", Label = "Salvar preferências", ButtonText = "Salvar" },
        }},
        { Title = "Quick settings", Icon = "settings", Controls = {
            { Kind = "Toggle", Id = "notifications", Label = "Notificações", Default = false },
            { Kind = "Toggle", Id = "auto_save", Label = "Salvar automaticamente", Default = false },
        }},
    },
}
end
-- END categories/Main.lua

-- BEGIN categories/Misc.lua
__modules["categories/Misc.lua"] = function()
return {
    Id = "Misc", Label = "Misc", Icon = "settings", Bookmarked = false,
    RuntimeModule = "runtime/Misc.lua",
    Sections = {
        { Title = "Themes", Icon = "palette", Controls = {
            { Kind = "Dropdown", Setting = "MenuTheme", Id = "menu_theme", Label = "Menu Theme", Description = "Changes the menu palette and background while keeping controls easy to read.", Options = { "Default", "Purple", "Orange" }, Default = "Default", UseList = true },
        }},
        { Title = "Utilities", Icon = "sliders", Controls = {
            { Kind = "Toggle", Setting = "ShowFPS", Id = "show_fps", Label = "Show FPS", Description = "Displays live FPS and network ping.", Default = false },
            { Kind = "Toggle", Setting = "PerformanceMode", Id = "performance_mode", Label = "Performance Mode", Description = "Temporarily reduces local visual effects to improve performance.", Default = false },
        }},
    },
}
end
-- END categories/Misc.lua

-- BEGIN categories/Player.lua
__modules["categories/Player.lua"] = function()
return {
    Id = "Player",
    Label = "Player",
    Icon = "player",
    Bookmarked = false,
    RuntimeModule = "runtime/Player.lua",
    Sections = {
        {
            Title = "Movement",
            Icon = "player",
            Controls = {
                { Kind = "Slider", Setting = "WalkSpeed", Id = "walk_speed", Label = "Walk Speed", Min = 8, Max = 200, Default = 16, Step = 1 },
                { Kind = "Toggle", Setting = "LockWalkSpeed", Id = "lock_walk_speed", Label = "Lock Walk Speed", Description = "Keeps the selected speed if the game changes it.", Default = false },
                { Kind = "Slider", Setting = "JumpPower", Id = "jump_power", Label = "Jump Power", Min = 25, Max = 200, Default = 50, Step = 1 },
                { Kind = "Toggle", Setting = "LockJumpPower", Id = "lock_jump_power", Label = "Lock Jump Power", Description = "Keeps the selected jump power active.", Default = false },
                { Kind = "Toggle", Setting = "InfiniteJump", Id = "infinite_jump", Label = "Infinite Jump", Description = "Allows jumping while already in the air.", Default = false },
            },
        },
        {
            Title = "Flight",
            Icon = "navigation",
            Controls = {
                { Kind = "Toggle", Setting = "Fly", Id = "fly", Label = "Fly", Description = "WASD to move | Space up | LeftControl down", Default = false },
                { Kind = "Slider", Setting = "FlySpeed", Id = "fly_speed", Label = "Fly Speed", Min = 10, Max = 200, Default = 60, Step = 5 },
            },
        },
        {
            Title = "Protection and Collision",
            Icon = "shield",
            Controls = {
                { Kind = "Toggle", Setting = "Noclip", Id = "noclip", Label = "Noclip", Description = "Disables collision on your character while active.", Default = false },
                { Kind = "Toggle", Setting = "AntiFling", Id = "anti_fling", Label = "Anti Fling", Description = "Returns to the last safe position after extreme velocity.", Default = false },
                { Kind = "Toggle", Setting = "AntiVoid", Id = "anti_void", Label = "Anti Void", Description = "Returns to the last grounded position before falling into the void.", Default = false },
            },
        },
        {
            Title = "Utilities",
            Icon = "settings",
            Controls = {
                { Kind = "Toggle", Setting = "AntiAFK", Id = "anti_afk", Label = "Anti AFK", Description = "Prevents the standard idle disconnect.", Default = false },
                { Kind = "Toggle", Setting = "AntiSit", Id = "anti_sit", Label = "Anti Sit", Description = "Immediately leaves seats and forced sitting states.", Default = false },
            },
        },
    },
}
end
-- END categories/Player.lua

-- BEGIN categories/Teleport.lua
__modules["categories/Teleport.lua"] = function()
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
                { Kind = "Dropdown", Setting = "SelectedPlayer", OptionsSource = "Players", UseList = true, Id = "target_player", Label = "Target Player", Default = "Select a player" },
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
            },
        },
    },
}
end
-- END categories/Teleport.lua

-- BEGIN categories/Troll.lua
__modules["categories/Troll.lua"] = function()
return {
    Id = "Troll",
    Label = "Troll",
    Icon = "fire",
    Bookmarked = false,
    RuntimeModule = "runtime/Troll.lua",
    Sections = {
        {
            Title = "Fling",
            Icon = "fire",
            Controls = {
                {
                    Kind = "Toggle",
                    Setting = "TouchFling",
                    Id = "touch_fling",
                    Label = "Fling ao Encostar",
                    Description = "Arremessa para fora do mapa qualquer jogador em quem você encostar.",
                    Default = false,
                },
            },
        },
    },
}
end
-- END categories/Troll.lua

-- BEGIN categories/Visuals.lua
__modules["categories/Visuals.lua"] = function()
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
            Title = "Items ESP",
            Icon = "map",
            Controls = {
                { Kind = "Toggle", Setting = "ShowCoins", Id = "show_coins", Label = "Show Coins", Description = "Highlights coins. X-Ray ESP controls visibility through walls.", Default = false },
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
end
-- END categories/Visuals.lua

-- BEGIN categories/Whitelist.lua
__modules["categories/Whitelist.lua"] = function()
return {
    Id = "Whitelist", Label = "Whitelist", Icon = "shield", Bookmarked = false,
    Sections = {
        { Title = "Access list", Icon = "users", Controls = {
            { Kind = "Toggle", Id = "friends_allowed", Label = "Allow Friends", Default = false },
            { Kind = "Dropdown", Id = "list_policy", Label = "Default Policy", Options = { "Ignore", "Allow", "Block" }, Default = "Ignore" },
            { Kind = "Button", Id = "refresh_list", Label = "Refresh List", ButtonText = "Atualizar" },
        }},
    },
}
end
-- END categories/Whitelist.lua

-- BEGIN runtime/Atmosphere.lua
__modules["runtime/Atmosphere.lua"] = function()
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Atmosphere = {}

local CUSTOM_SKY = {
    SkyboxBk = "rbxassetid://159454299",
    SkyboxDn = "rbxassetid://159454296",
    SkyboxFt = "rbxassetid://159454293",
    SkyboxLf = "rbxassetid://159454286",
    SkyboxRt = "rbxassetid://159454300",
    SkyboxUp = "rbxassetid://159454288",
}

function Atmosphere:Create()
    if type(_G.__HMENU_ATMOSPHERE_CLEANUP) == "function" then
        pcall(_G.__HMENU_ATMOSPHERE_CLEANUP)
    end

    local runtime = {}
    local destroyed = false
    local active = false
    local weatherOverride = false
    local brightnessOverride = false
    local connections = {}
    local atmosphereState = {}
    local skyState = {}
    local generatedSky = nil
    local cleanupFunction

    local originalLighting = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ExposureCompensation = Lighting.ExposureCompensation,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
    }

    local settings = {
        Weather = "Default",
        Brightness = originalLighting.Brightness,
        CustomSky = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function rememberAtmosphere(instance)
        if not instance:IsA("Atmosphere") or atmosphereState[instance] then return end
        atmosphereState[instance] = {
            Density = instance.Density,
            Offset = instance.Offset,
            Color = instance.Color,
            Decay = instance.Decay,
            Glare = instance.Glare,
            Haze = instance.Haze,
        }
    end

    local function rememberSky(instance)
        if not instance:IsA("Sky") or instance == generatedSky or skyState[instance] then return end
        skyState[instance] = {
            SkyboxBk = instance.SkyboxBk,
            SkyboxDn = instance.SkyboxDn,
            SkyboxFt = instance.SkyboxFt,
            SkyboxLf = instance.SkyboxLf,
            SkyboxRt = instance.SkyboxRt,
            SkyboxUp = instance.SkyboxUp,
            CelestialBodiesShown = instance.CelestialBodiesShown,
            StarCount = instance.StarCount,
        }
    end

    local function rememberEffects()
        for _, child in ipairs(Lighting:GetChildren()) do
            rememberAtmosphere(child)
            rememberSky(child)
        end
    end

    local function restoreAtmospheres()
        for instance, values in pairs(atmosphereState) do
            if instance.Parent then
                for property, value in pairs(values) do instance[property] = value end
            end
        end
    end

    local function restoreSkies(removeGenerated)
        for instance, values in pairs(skyState) do
            if instance.Parent then
                for property, value in pairs(values) do instance[property] = value end
            end
        end
        if removeGenerated and generatedSky then
            generatedSky:Destroy()
            generatedSky = nil
        end
    end

    local function restoreWeather()
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.ExposureCompensation = originalLighting.ExposureCompensation
        Lighting.FogStart = originalLighting.FogStart
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.FogColor = originalLighting.FogColor
        restoreAtmospheres()
    end

    local function restoreLighting()
        Lighting.Brightness = originalLighting.Brightness
        restoreWeather()
        restoreSkies(true)
    end

    local function applyCustomSky()
        local foundSky = false
        for instance in pairs(skyState) do
            if instance.Parent then
                foundSky = true
                for property, value in pairs(CUSTOM_SKY) do instance[property] = value end
                instance.CelestialBodiesShown = true
                instance.StarCount = 3000
            end
        end
        if foundSky and generatedSky then
            generatedSky:Destroy()
            generatedSky = nil
        end
        if not foundSky then
            generatedSky = generatedSky or Instance.new("Sky")
            generatedSky.Name = "HMenuCustomSky"
            for property, value in pairs(CUSTOM_SKY) do generatedSky[property] = value end
            generatedSky.CelestialBodiesShown = true
            generatedSky.StarCount = 3000
            generatedSky.Parent = Lighting
        end
    end

    local function applyWeather()
        if settings.Weather == "Clear" then
            Lighting.ClockTime = 14
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000000
            for instance in pairs(atmosphereState) do
                if instance.Parent then
                    instance.Density = 0
                    instance.Haze = 0
                    instance.Glare = 0
                end
            end
        elseif settings.Weather == "Night" then
            Lighting.ClockTime = 0
            Lighting.Ambient = Color3.fromRGB(35, 40, 65)
            Lighting.OutdoorAmbient = Color3.fromRGB(20, 24, 45)
            Lighting.ExposureCompensation = -0.35
        elseif settings.Weather == "Fog" then
            Lighting.FogStart = 0
            Lighting.FogEnd = 120
            Lighting.FogColor = Color3.fromRGB(185, 190, 200)
            for instance in pairs(atmosphereState) do
                if instance.Parent then
                    instance.Density = 0.45
                    instance.Haze = 2
                    instance.Glare = 0
                end
            end
        end
    end

    local function applySettings()
        if destroyed or not active then return end

        rememberEffects()
        if brightnessOverride then Lighting.Brightness = settings.Brightness end
        if weatherOverride then applyWeather() end

        if settings.CustomSky then applyCustomSky() end
    end

    rememberEffects()

    local elapsed = 0
    connect(RunService.Heartbeat, function(deltaTime)
        if not active or destroyed then return end
        elapsed = elapsed + deltaTime
        if elapsed >= 0.2 then
            elapsed = 0
            applySettings()
        end
    end)

    connect(Lighting.ChildAdded, function(instance)
        if instance == generatedSky then return end
        rememberAtmosphere(instance)
        rememberSky(instance)
        if active then task.defer(applySettings) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "Weather" then
            restoreWeather()
            weatherOverride = value ~= "Default"
        elseif name == "Brightness" then
            brightnessOverride = true
        elseif name == "CustomSky" and not value then
            restoreSkies(true)
        end
        active = weatherOverride or brightnessOverride or settings.CustomSky
        applySettings()
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        active = false
        restoreLighting()
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if _G.__HMENU_ATMOSPHERE_CLEANUP == cleanupFunction then
            _G.__HMENU_ATMOSPHERE_CLEANUP = nil
        end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_ATMOSPHERE_CLEANUP = cleanupFunction
    return runtime
end

return Atmosphere
end
-- END runtime/Atmosphere.lua

-- BEGIN runtime/Combat.lua
__modules["runtime/Combat.lua"] = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Combat = {}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function rootPart(player)
    local character = player and player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function humanoidOf(player)
    local character = player and player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function toolIn(player, name)
    if not player then return nil end
    local character = player.Character
    local backpack = player:FindFirstChild("Backpack")
    return (character and character:FindFirstChild(name)) or (backpack and backpack:FindFirstChild(name))
end

local function partFromDrop(drop)
    if not drop then return nil end
    if drop:IsA("BasePart") then return drop end
    if drop:IsA("Model") then
        return drop.PrimaryPart or drop:FindFirstChildWhichIsA("BasePart", true)
    end
    return drop:FindFirstChildWhichIsA("BasePart", true)
end

function Combat:Create(options)
    if type(_G.__HMENU_COMBAT_CLEANUP) == "function" then
        pcall(_G.__HMENU_COMBAT_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local localMouse = localPlayer:GetMouse()
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local destroyed = false
    local cleanupFunction
    local connections = {}
    local roles = {}
    local roleRemote = nil
    local roleBusy = false
    local gunActivationConnection = nil
    local boundGun = nil
    local shootBusy = false
    local killAllBusy = false
    local grabBusy = false
    local lastAutoShot = 0
    local lastPerfectShot = 0
    local lastPerfectRedirect = 0
    local lastGrabAttempt = 0
    local lastEvade = 0
    local lastAuraAttack = 0
    local unsupportedGrabWarned = false
    local hitboxOriginals = {}
    local perfectHookState = nil
    local perfectHookHandler = nil
    local perfectInvokeHookState = nil
    local perfectMouseHookState = nil
    local perfectMouseHookHandler = nil
    local suppressedGunConnections = {}
    local nativeGunSuppressed = false

    local settings = {
        MurderKillAura = false,
        MurderAuraRadius = 12,
        MurderAttackDelay = 0.15,
        MurderTargetPriority = "Nearest",
        MurderAutoEquipKnife = false,
        MurderEquipKnife = false,
        MurderKillNearest = false,
        MurderKillSheriff = false,
        MurderKillAll = false,

        SheriffPerfectShots = false,
        SheriffShootMurderer = false,
        SheriffAutoShootMurderer = false,
        SheriffShootCooldown = 1.1,
        SheriffTargetPart = "HumanoidRootPart",
        SheriffPrediction = 0.08,
        SheriffIgnoreWalls = false,
        SheriffAutoEquipGun = false,
        SheriffEquipGun = false,
        SheriffAutoGrabGun = false,
        SheriffGrabGunNow = false,

        UtilsAutoEvadeMurderer = false,
        UtilsDangerRadius = 15,
        UtilsEvadeDistance = 30,
        UtilsHitboxExpander = false,
        UtilsHitboxSize = 6,
        UtilsHitboxTarget = "Murderer",
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = make("ScreenGui", {
        Name = "HMenuCombatOverlay",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 997,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local toast = make("Frame", {
        Name = "Toast",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, -60),
        Size = UDim2.fromOffset(350, 44),
        BackgroundColor3 = Color3.fromRGB(24, 38, 65),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Visible = false,
    }, overlay)
    make("UICorner", { CornerRadius = UDim.new(0, 8) }, toast)
    make("UIStroke", { Color = Color3.fromRGB(83, 122, 190), Transparency = 0.25, Thickness = 1 }, toast)
    local toastMarker = make("Frame", {
        Size = UDim2.fromOffset(3, 26), Position = UDim2.fromOffset(0, 9),
        BackgroundColor3 = Color3.fromRGB(102, 151, 246), BorderSizePixel = 0,
    }, toast)
    make("UICorner", { CornerRadius = UDim.new(0, 2) }, toastMarker)
    local toastText = make("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.fromOffset(17, 0),
        BackgroundTransparency = 1, Text = "", TextColor3 = Color3.fromRGB(235, 241, 255),
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)
    local toastVersion = 0

    local function notify(message, success)
        if destroyed then return end
        toastVersion = toastVersion + 1
        local version = toastVersion
        toastText.Text = tostring(message)
        toastMarker.BackgroundColor3 = success and Color3.fromRGB(83, 220, 145) or Color3.fromRGB(255, 118, 126)
        toast.Visible = true
        TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, 0, 0, 20),
        }):Play()
        task.delay(2.2, function()
            if destroyed or version ~= toastVersion then return end
            local tween = TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0, -60),
            })
            tween:Play()
            tween.Completed:Wait()
            if not destroyed and version == toastVersion then toast.Visible = false end
        end)
    end

    local function character()
        return localPlayer.Character
    end

    local function localHumanoid()
        return humanoidOf(localPlayer)
    end

    local function localRoot()
        return rootPart(localPlayer)
    end

    local function refreshRoles()
        if destroyed or roleBusy then return end
        roleBusy = true
        if not roleRemote or not roleRemote.Parent then
            local candidate = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
            if candidate and candidate:IsA("RemoteFunction") then roleRemote = candidate end
        end
        if roleRemote then
            local ok, result = pcall(function()
                return roleRemote:InvokeServer()
            end)
            if ok and type(result) == "table" then roles = result end
        end
        roleBusy = false
    end

    local function roleFromTools(player)
        if toolIn(player, "Knife") then return "Murderer" end
        if toolIn(player, "Gun") then return "Sheriff" end
        return "Innocent"
    end

    local function roleOf(player)
        if not player then return "Unknown" end
        local data = roles[player.Name]
        local role = data and data.Role
        if role == "Murderer" or role == "Sheriff" or role == "Hero" or role == "Innocent" then
            return role
        end
        return roleFromTools(player)
    end

    local function isAlive(player)
        if not player or not player.Parent or not player.Character then return false end
        local root = rootPart(player)
        if not root then return false end
        local humanoid = humanoidOf(player)
        if humanoid then return humanoid.Health > 0 end
        local data = roles[player.Name]
        return not (data and (data.Dead or data.Killed))
    end

    local function findMurderer()
        -- Tool ownership is the freshest role signal during round transitions.
        -- Prefer it over cached GetPlayerData so a stale Innocent role cannot make
        -- Perfect Shots silently keep the original mouse target.
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and toolIn(player, "Knife") then
                return player
            end
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and roleOf(player) == "Murderer" then
                return player
            end
        end
        return nil
    end

    local function isGunCarrier(player)
        if not player or not isAlive(player) then return false end
        local role = roleOf(player)
        return role == "Sheriff" or role == "Hero" or toolIn(player, "Gun") ~= nil
    end

    local function findSheriffOrHero()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isGunCarrier(player) then return player end
        end
        return nil
    end

    local function equipNamedTool(name)
        local currentCharacter = character()
        if not currentCharacter then return nil end
        local equipped = currentCharacter:FindFirstChild(name)
        if equipped then return equipped end
        local backpack = localPlayer:FindFirstChild("Backpack")
        local tool = backpack and backpack:FindFirstChild(name)
        if not tool then return nil end
        local humanoid = localHumanoid()
        if humanoid then
            pcall(function() humanoid:EquipTool(tool) end)
        else
            tool.Parent = currentCharacter
        end
        task.wait()
        return currentCharacter:FindFirstChild(name) or tool
    end

    local function equipKnife(showError)
        local knife = equipNamedTool("Knife")
        if not knife and showError then notify("Knife not found. You must be the Murderer.", false) end
        return knife
    end

    local function equipGun(showError)
        local gun = equipNamedTool("Gun")
        if not gun and showError then notify("Gun not found in Character or Backpack.", false) end
        return gun
    end

    local function targetPartFor(player)
        local currentCharacter = player and player.Character
        if not currentCharacter then return nil end
        if settings.SheriffTargetPart == "Head" then
            return currentCharacter:FindFirstChild("Head") or currentCharacter:FindFirstChild("HumanoidRootPart")
        elseif settings.SheriffTargetPart == "UpperTorso" then
            return currentCharacter:FindFirstChild("UpperTorso") or currentCharacter:FindFirstChild("Torso") or currentCharacter:FindFirstChild("HumanoidRootPart")
        end
        return currentCharacter:FindFirstChild("HumanoidRootPart") or currentCharacter:FindFirstChild("Head")
    end

    local function predictedPosition(player)
        local part = targetPartFor(player)
        if not part then return nil end
        local velocity = Vector3.zero
        pcall(function() velocity = part.AssemblyLinearVelocity end)
        return part.Position + velocity * settings.SheriffPrediction
    end

    local function hasLineOfSight(player)
        if settings.SheriffIgnoreWalls then return true end
        local target = targetPartFor(player)
        if not target then return false end
        local camera = Workspace.CurrentCamera
        local origin = camera and camera.CFrame.Position or (localRoot() and localRoot().Position)
        if not origin then return false end
        local direction = target.Position - origin
        if direction.Magnitude < 0.01 then return true end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = character() and { character() } or {}
        params.IgnoreWater = true
        local result = Workspace:Raycast(origin, direction, params)
        return result == nil or (result.Instance and result.Instance:IsDescendantOf(player.Character))
    end

    local function gunRemote(gun)
        if not gun then return nil end
        local knifeLocal = gun:FindFirstChild("KnifeLocal")
        local createBeam = knifeLocal and knifeLocal:FindFirstChild("CreateBeam", true)
        local direct = createBeam and createBeam:FindFirstChild("RemoteFunction", true)
        if direct and direct:IsA("RemoteFunction") then
            return direct
        end
        for _, descendant in ipairs(gun:GetDescendants()) do
            if descendant:IsA("RemoteFunction") and descendant.Name == "RemoteFunction" then
                local node = descendant.Parent
                for _ = 1, 8 do
                    if not node then break end
                    if node.Name == "CreateBeam" then return descendant end
                    node = node.Parent
                end
            end
        end
        return nil
    end

    local function fireGunAt(player, showError)
        if shootBusy or not player or not isAlive(player) then return false end
        shootBusy = true
        local gun = equipGun(showError)
        if not gun then
            shootBusy = false
            return false
        end
        local remote = gunRemote(gun)
        local position = predictedPosition(player)
        if not remote or not position then
            if showError then notify("Gun shot remote or target part was not found.", false) end
            shootBusy = false
            return false
        end
        local ok = pcall(function()
            remote:InvokeServer(1, position, "AH2")
        end)
        shootBusy = false
        if showError then
            notify(ok and "Shot sent directly to Murderer." or "Could not fire the Gun remote.", ok)
        end
        return ok
    end

    local function shootMurderer(showError)
        refreshRoles()
        local murderer = findMurderer()
        if not murderer then
            if showError then notify("Murderer not found yet.", false) end
            return false
        end
        return fireGunAt(murderer, showError)
    end

    local function remoteLooksLikeGunShot(remote)
        if typeof(remote) ~= "Instance" or not remote:IsA("RemoteFunction") then return false end

        -- Prefer comparing against the remote discovered from the Gun the player
        -- actually owns. Some MM2 versions add wrappers between CreateBeam and the
        -- RemoteFunction, which made the old ancestry-only check miss the shot.
        local currentGun = toolIn(localPlayer, "Gun")
        if currentGun and gunRemote(currentGun) == remote then return true end

        local node = remote.Parent
        local hasCreateBeam = false
        for _ = 1, 12 do
            if not node then break end
            if node.Name == "CreateBeam" then
                hasCreateBeam = true
            elseif hasCreateBeam and node:IsA("Tool") and node.Name == "Gun" then
                return true
            end
            node = node.Parent
        end
        return false
    end

    local function ensurePerfectShotHook()
        local existing = rawget(_G, "__HMENU_COMBAT_NAMECALL_HOOK")
        if type(existing) == "table" and existing.Installed then
            perfectHookState = existing
            return existing
        end
        if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" or type(newcclosure) ~= "function" then
            return nil
        end

        local state = { Installed = false, Handler = nil, Busy = false }
        local oldNamecall
        local ok, result = pcall(function()
            oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local handler = state.Handler
                if handler and not state.Busy and method == "InvokeServer" then
                    state.Busy = true
                    local handledOk, handled, packed = pcall(handler, self, ...)
                    state.Busy = false
                    if handledOk and handled and packed then
                        return oldNamecall(self, table.unpack(packed, 1, packed.n))
                    end
                end
                return oldNamecall(self, ...)
            end))
            return oldNamecall
        end)
        if not ok or not result then return nil end

        state.Old = oldNamecall
        state.Installed = true
        _G.__HMENU_COMBAT_NAMECALL_HOOK = state
        perfectHookState = state
        return state
    end

    perfectHookHandler = function(remote, ...)
        if destroyed or not settings.SheriffPerfectShots then
            return false
        end
        local args = table.pack(...)
        local hasMM2Signature = typeof(remote) == "Instance"
            and remote:IsA("RemoteFunction")
            and args[1] == 1
            and args[3] == "AH2"
            and toolIn(localPlayer, "Gun") ~= nil
        if not hasMM2Signature and not remoteLooksLikeGunShot(remote) then return false end

        local murderer = findMurderer()
        local position = murderer and predictedPosition(murderer)
        if not position then return false end

        -- MM2's normal signature stores the hit position in argument 2. Prefer it
        -- when several spatial arguments exist so an origin CFrame is not changed.
        local order = {}
        if args.n >= 2 then table.insert(order, 2) end
        for index = 1, args.n do
            if index ~= 2 then table.insert(order, index) end
        end
        for _, index in ipairs(order) do
            local argumentType = typeof(args[index])
            if argumentType == "Vector3" then
                args[index] = position
                lastPerfectRedirect = tick()
                return true, args
            elseif argumentType == "CFrame" then
                args[index] = CFrame.new(position)
                lastPerfectRedirect = tick()
                return true, args
            end
        end
        return false
    end

    local function enablePerfectShotHook()
        local state = ensurePerfectShotHook()
        if not state then return false end
        state.Handler = perfectHookHandler
        return true
    end

    local function disablePerfectShotHook()
        local state = perfectHookState or rawget(_G, "__HMENU_COMBAT_NAMECALL_HOOK")
        if type(state) == "table" and state.Handler == perfectHookHandler then
            state.Handler = nil
        end
    end

    local function ensurePerfectInvokeHook(remote)
        local existing = rawget(_G, "__HMENU_COMBAT_INVOKE_HOOK")
        if type(existing) == "table" and existing.Installed then
            perfectInvokeHookState = existing
            return existing
        end
        if not remote or not remote:IsA("RemoteFunction") then return nil end

        local hook = type(hookfunction) == "function" and hookfunction
            or (type(hookfunc) == "function" and hookfunc or nil)
        if not hook then return nil end

        local state = { Installed = false, Handler = nil, Busy = false }
        local oldInvoke
        local callback = function(self, ...)
            local handler = state.Handler
            if handler and not state.Busy then
                state.Busy = true
                local handledOk, handled, packed = pcall(handler, self, ...)
                state.Busy = false
                if handledOk and handled and packed then
                    return oldInvoke(self, table.unpack(packed, 1, packed.n))
                end
            end
            return oldInvoke(self, ...)
        end
        if type(newcclosure) == "function" then callback = newcclosure(callback) end

        local ok, result = pcall(function()
            oldInvoke = hook(remote.InvokeServer, callback)
            return oldInvoke
        end)
        if not ok or not result then return nil end

        state.Old = oldInvoke
        state.Installed = true
        _G.__HMENU_COMBAT_INVOKE_HOOK = state
        perfectInvokeHookState = state
        return state
    end

    local function enablePerfectInvokeHook(remote)
        local state = ensurePerfectInvokeHook(remote)
        if not state then return false end
        state.Handler = perfectHookHandler
        return true
    end

    local function disablePerfectInvokeHook()
        local state = perfectInvokeHookState or rawget(_G, "__HMENU_COMBAT_INVOKE_HOOK")
        if type(state) == "table" and state.Handler == perfectHookHandler then
            state.Handler = nil
        end
    end

    local function ensurePerfectMouseHook()
        local existing = rawget(_G, "__HMENU_COMBAT_MOUSE_HOOK")
        if type(existing) == "table" and existing.Installed then
            perfectMouseHookState = existing
            return existing
        end
        if type(hookmetamethod) ~= "function" or type(newcclosure) ~= "function" then
            return nil
        end

        local state = { Installed = false, Handler = nil, Busy = false }
        local oldIndex
        local ok, result = pcall(function()
            oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
                local handler = state.Handler
                if handler and not state.Busy then
                    state.Busy = true
                    local handledOk, handled, value = pcall(handler, self, key)
                    state.Busy = false
                    if handledOk and handled then return value end
                end
                return oldIndex(self, key)
            end))
            return oldIndex
        end)
        if not ok or not result then return nil end

        state.Old = oldIndex
        state.Installed = true
        _G.__HMENU_COMBAT_MOUSE_HOOK = state
        perfectMouseHookState = state
        return state
    end

    perfectMouseHookHandler = function(object, key)
        if destroyed or not settings.SheriffPerfectShots or object ~= localMouse then
            return false
        end
        if key ~= "Hit" and key ~= "Target" and key ~= "UnitRay" then
            return false
        end

        local murderer = findMurderer()
        local part = murderer and targetPartFor(murderer)
        local position = murderer and predictedPosition(murderer)
        if not part or not position then return false end
        lastPerfectRedirect = tick()

        if key == "Target" then return true, part end
        if key == "Hit" then return true, CFrame.new(position) end

        local camera = Workspace.CurrentCamera
        local origin = camera and camera.CFrame.Position or (localRoot() and localRoot().Position)
        if not origin or (position - origin).Magnitude < 0.01 then return false end
        return true, Ray.new(origin, (position - origin).Unit * 1000)
    end

    local function enablePerfectMouseHook()
        local state = ensurePerfectMouseHook()
        if not state then return false end
        state.Handler = perfectMouseHookHandler
        return true
    end

    local function disablePerfectMouseHook()
        local state = perfectMouseHookState or rawget(_G, "__HMENU_COMBAT_MOUSE_HOOK")
        if type(state) == "table" and state.Handler == perfectMouseHookHandler then
            state.Handler = nil
        end
    end

    local function restoreGunConnections()
        for _, connection in ipairs(suppressedGunConnections) do
            pcall(function()
                if type(connection.Enable) == "function" then connection:Enable() end
            end)
        end
        suppressedGunConnections = {}
        nativeGunSuppressed = false
    end

    local function suppressGunConnections(gun)
        if type(getconnections) ~= "function" or not gun then return false end
        local ok, found = pcall(function() return getconnections(gun.Activated) end)
        if not ok or type(found) ~= "table" then return false end

        for _, connection in ipairs(found) do
            local disabled = pcall(function()
                if type(connection.Disable) ~= "function" then error("unsupported connection") end
                connection:Disable()
            end)
            if disabled then table.insert(suppressedGunConnections, connection) end
        end
        return #suppressedGunConnections > 0
    end

    local function disconnectGunActivation()
        if gunActivationConnection then
            gunActivationConnection:Disconnect()
            gunActivationConnection = nil
        end
        restoreGunConnections()
        boundGun = nil
    end

    local function bindGunActivation()
        if not settings.SheriffPerfectShots then
            if gunActivationConnection or #suppressedGunConnections > 0 then disconnectGunActivation() end
            return
        end
        local currentCharacter = character()
        local gun = currentCharacter and currentCharacter:FindFirstChild("Gun")
        if gun == boundGun and gunActivationConnection then return end
        disconnectGunActivation()
        if not gun then return end
        boundGun = gun
        local invokeHooked = enablePerfectInvokeHook(gunRemote(gun))
        local namecallHooked = perfectHookState and perfectHookState.Handler == perfectHookHandler
        local mouseHooked = perfectMouseHookState and perfectMouseHookState.Handler == perfectMouseHookHandler
        if not invokeHooked and not namecallHooked and not mouseHooked then
            nativeGunSuppressed = suppressGunConnections(gun)
        end
        gunActivationConnection = gun.Activated:Connect(function()
            if destroyed or not settings.SheriffPerfectShots then return end
            local now = tick()
            if now - lastPerfectShot < 0.15 then return end
            lastPerfectShot = now

            -- Tool.Activated is also a per-shot safety net. A hook being installed
            -- does not guarantee that a particular game remote was recognized.
            -- Defer until the Gun's own Activated callbacks have had the chance to
            -- invoke the remote, then only send a direct shot if no redirect occurred.
            task.defer(function()
                if destroyed or not settings.SheriffPerfectShots then return end
                if not nativeGunSuppressed and tick() - lastPerfectRedirect < 0.12 then return end
                refreshRoles()
                local murderer = findMurderer()
                if murderer then fireGunAt(murderer, false) end
            end)
        end)
    end

    local function nearestGunDrop()
        -- MM2 normally exposes a single GunDrop. Using FindFirstChild avoids scanning
        -- the entire workspace every Auto Grab tick.
        return Workspace:FindFirstChild("GunDrop", true)
    end

    local function hasGunAnywhere()
        return toolIn(localPlayer, "Gun") ~= nil
    end

    local function grabGunWithoutMoving(showMessage)
        if grabBusy or hasGunAnywhere() then return hasGunAnywhere() end
        local now = tick()
        if now - lastGrabAttempt < 0.18 then return false end
        lastGrabAttempt = now
        grabBusy = true

        local root = localRoot()
        local drop = nearestGunDrop()
        local part = partFromDrop(drop)
        if not root or not part then
            if showMessage then notify("No dropped Gun found.", false) end
            grabBusy = false
            return false
        end

        local attempted = false
        if type(firetouchinterest) == "function" then
            attempted = true
            pcall(function()
                firetouchinterest(root, part, 0)
                task.wait()
                firetouchinterest(root, part, 1)
            end)
        end

        if not hasGunAnywhere() and type(fireproximityprompt) == "function" then
            local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                attempted = true
                pcall(function() fireproximityprompt(prompt) end)
            end
        end

        if not attempted then
            if showMessage or not unsupportedGrabWarned then
                notify("Executor has no firetouchinterest/fireproximityprompt support. No teleport fallback was used.", false)
                unsupportedGrabWarned = true
            end
            grabBusy = false
            return false
        end

        task.wait(0.08)
        local acquired = hasGunAnywhere()
        if showMessage then
            notify(acquired and "Gun pickup triggered without moving your character." or "Pickup was triggered; server may reject remote-distance collection.", acquired)
        end
        grabBusy = false
        return acquired
    end

    local function triggerKnife(knife, targetRoot)
        if not knife or not targetRoot then return false end
        local used = false
        local stab = knife:FindFirstChild("Stab")
        if stab and stab:IsA("RemoteEvent") then
            used = true
            pcall(function()
                stab:FireServer("Down")
                stab:FireServer("Down")
            end)
        end
        pcall(function()
            knife:Activate()
            used = true
        end)
        local handle = knife:FindFirstChild("Handle")
        if handle and type(firetouchinterest) == "function" then
            used = true
            pcall(function()
                firetouchinterest(handle, targetRoot, 0)
                firetouchinterest(handle, targetRoot, 1)
            end)
        end
        return used
    end

    local function attackTarget(player, blink)
        if not player or not isAlive(player) then return false end
        local knife = equipKnife(false)
        local root = localRoot()
        local targetRoot = rootPart(player)
        if not knife or not root or not targetRoot then return false end
        local oldCFrame = root.CFrame
        local moved = false
        if blink and (targetRoot.Position - root.Position).Magnitude > settings.MurderAuraRadius then
            moved = true
            root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 1.6)
            RunService.Heartbeat:Wait()
        end
        local ok = triggerKnife(knife, targetRoot)
        task.wait(0.04)
        if moved and root.Parent then root.CFrame = oldCFrame end
        return ok
    end

    local function validMurderTargets()
        local root = localRoot()
        local list = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and roleOf(player) ~= "Murderer" then
                local targetRoot = rootPart(player)
                if targetRoot then
                    table.insert(list, {
                        Player = player,
                        Distance = root and (targetRoot.Position - root.Position).Magnitude or math.huge,
                        GunCarrier = isGunCarrier(player),
                    })
                end
            end
        end
        table.sort(list, function(a, b)
            if settings.MurderTargetPriority == "Sheriff First" and a.GunCarrier ~= b.GunCarrier then
                return a.GunCarrier
            end
            return a.Distance < b.Distance
        end)
        return list
    end

    local function killNearest()
        refreshRoles()
        if not equipKnife(true) then return end
        local targets = validMurderTargets()
        local target = targets[1] and targets[1].Player
        if not target then
            notify("No alive target found.", false)
            return
        end
        local ok = attackTarget(target, true)
        notify(ok and ("Attacked " .. target.Name .. ".") or "Could not attack target.", ok)
    end

    local function killSheriff()
        refreshRoles()
        if not equipKnife(true) then return end
        local target = findSheriffOrHero()
        if not target then
            notify("Sheriff/Hero with Gun not found.", false)
            return
        end
        local ok = attackTarget(target, true)
        notify(ok and ("Attacked Gun carrier: " .. target.Name) or "Could not attack Sheriff/Hero.", ok)
    end

    local function killAll()
        if killAllBusy then return end
        refreshRoles()
        if not equipKnife(true) then return end
        killAllBusy = true
        task.spawn(function()
            local targets = validMurderTargets()
            if #targets == 0 then
                notify("No alive targets found.", false)
                killAllBusy = false
                return
            end
            local original = localRoot() and localRoot().CFrame
            for _, entry in ipairs(targets) do
                if destroyed then break end
                attackTarget(entry.Player, true)
                task.wait(settings.MurderAttackDelay)
            end
            local root = localRoot()
            if root and original then root.CFrame = original end
            notify("Kill All sequence finished.", true)
            killAllBusy = false
        end)
    end

    local function restoreHitbox(part)
        local original = hitboxOriginals[part]
        if not original then return end
        if part and part.Parent then
            part.Size = original.Size
            part.Transparency = original.Transparency
            part.CanCollide = original.CanCollide
        end
        hitboxOriginals[part] = nil
    end

    local function restoreAllHitboxes()
        local parts = {}
        for part in pairs(hitboxOriginals) do table.insert(parts, part) end
        for _, part in ipairs(parts) do restoreHitbox(part) end
    end

    local function shouldExpandHitbox(player)
        if player == localPlayer or not isAlive(player) then return false end
        if settings.UtilsHitboxTarget == "Everyone" then return true end
        if settings.UtilsHitboxTarget == "Sheriff" then return isGunCarrier(player) end
        return roleOf(player) == "Murderer"
    end

    local function updateHitboxes()
        if not settings.UtilsHitboxExpander then
            restoreAllHitboxes()
            return
        end
        local keep = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if shouldExpandHitbox(player) then
                local part = rootPart(player)
                if part then
                    keep[part] = true
                    if not hitboxOriginals[part] then
                        hitboxOriginals[part] = {
                            Size = part.Size,
                            Transparency = part.Transparency,
                            CanCollide = part.CanCollide,
                        }
                    end
                    part.Size = Vector3.new(settings.UtilsHitboxSize, settings.UtilsHitboxSize, settings.UtilsHitboxSize)
                    part.Transparency = 0.72
                    part.CanCollide = false
                end
            end
        end
        local stale = {}
        for part in pairs(hitboxOriginals) do
            if not keep[part] then table.insert(stale, part) end
        end
        for _, part in ipairs(stale) do restoreHitbox(part) end
    end

    local function autoEvade()
        if not settings.UtilsAutoEvadeMurderer then return end
        local murderer = findMurderer()
        local root = localRoot()
        local murdererRoot = rootPart(murderer)
        if not root or not murdererRoot then return end
        local offset = root.Position - murdererRoot.Position
        local distance = offset.Magnitude
        if distance > settings.UtilsDangerRadius or tick() - lastEvade < 0.55 then return end
        local direction
        if distance < 0.05 then
            direction = Vector3.new(1, 0, 0)
        else
            direction = Vector3.new(offset.X, 0, offset.Z)
            if direction.Magnitude < 0.05 then direction = Vector3.new(1, 0, 0) end
            direction = direction.Unit
        end
        lastEvade = tick()
        root.AssemblyLinearVelocity = Vector3.zero
        root.CFrame = root.CFrame + direction * settings.UtilsEvadeDistance
    end

    local function updateKillAura()
        if not settings.MurderKillAura then return end
        local now = tick()
        if now - lastAuraAttack < settings.MurderAttackDelay then return end
        local knife = toolIn(localPlayer, "Knife")
        if not knife then return end
        if settings.MurderAutoEquipKnife then knife = equipKnife(false) or knife end
        local root = localRoot()
        if not root then return end
        local targets = validMurderTargets()
        for _, entry in ipairs(targets) do
            if entry.Distance <= settings.MurderAuraRadius then
                lastAuraAttack = now
                attackTarget(entry.Player, false)
                break
            end
        end
    end

    local function updateAutoShoot()
        if not settings.SheriffAutoShootMurderer then return end
        local now = tick()
        if now - lastAutoShot < settings.SheriffShootCooldown then return end
        local murderer = findMurderer()
        if not murderer or not hasLineOfSight(murderer) then return end
        local gun = toolIn(localPlayer, "Gun")
        if not gun then
            if settings.SheriffAutoGrabGun then grabGunWithoutMoving(false) end
            return
        end
        lastAutoShot = now
        fireGunAt(murderer, false)
    end

    local function updateAutoEquip()
        if settings.MurderAutoEquipKnife and toolIn(localPlayer, "Knife") then
            equipKnife(false)
        end
        if settings.SheriffAutoEquipGun and toolIn(localPlayer, "Gun") then
            equipGun(false)
        end
    end

    local roleElapsed, mainElapsed, hitboxElapsed, grabElapsed = 0, 0, 0, 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        roleElapsed = roleElapsed + deltaTime
        mainElapsed = mainElapsed + deltaTime
        hitboxElapsed = hitboxElapsed + deltaTime
        grabElapsed = grabElapsed + deltaTime

        local needsRoles = settings.MurderKillAura
            or settings.SheriffPerfectShots
            or settings.SheriffAutoShootMurderer
            or settings.UtilsAutoEvadeMurderer
            or settings.UtilsHitboxExpander

        if needsRoles and roleElapsed >= 0.45 then
            roleElapsed = 0
            task.spawn(refreshRoles)
        end

        if mainElapsed >= 0.08 then
            mainElapsed = 0
            bindGunActivation()
            updateAutoEquip()
            updateKillAura()
            updateAutoShoot()
            autoEvade()
        end

        if settings.UtilsHitboxExpander and hitboxElapsed >= 0.18 then
            hitboxElapsed = 0
            updateHitboxes()
        end

        if settings.SheriffAutoGrabGun and not hasGunAnywhere() and grabElapsed >= 0.35 then
            grabElapsed = 0
            task.spawn(function() grabGunWithoutMoving(false) end)
        end
    end)

    connect(Workspace.DescendantAdded, function(instance)
        if destroyed or not settings.SheriffAutoGrabGun or instance.Name ~= "GunDrop" then return end
        task.delay(0.08, function()
            if destroyed or not settings.SheriffAutoGrabGun then return end
            grabGunWithoutMoving(false)
        end)
    end)

    connect(localPlayer.CharacterAdded, function()
        disconnectGunActivation()
        task.delay(0.5, function()
            if destroyed then return end
            bindGunActivation()
            updateAutoEquip()
        end)
    end)

    connect(Players.PlayerRemoving, function(player)
        local part = rootPart(player)
        if part then restoreHitbox(part) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value

        if name == "MurderEquipKnife" then
            local knife = equipKnife(true)
            notify(knife and "Knife equipped." or "Knife not found.", knife ~= nil)
            settings[name] = false
        elseif name == "MurderKillNearest" then
            killNearest()
            settings[name] = false
        elseif name == "MurderKillSheriff" then
            killSheriff()
            settings[name] = false
        elseif name == "MurderKillAll" then
            killAll()
            settings[name] = false
        elseif name == "SheriffShootMurderer" then
            shootMurderer(true)
            settings[name] = false
        elseif name == "SheriffEquipGun" then
            local gun = equipGun(true)
            notify(gun and "Gun equipped." or "Gun not found.", gun ~= nil)
            settings[name] = false
        elseif name == "SheriffGrabGunNow" then
            task.spawn(function() grabGunWithoutMoving(true) end)
            settings[name] = false
        elseif name == "SheriffPerfectShots" then
            if value then
                refreshRoles()
                local hooked = enablePerfectShotHook()
                local mouseHooked = enablePerfectMouseHook()
                local gun = toolIn(localPlayer, "Gun")
                local invokeHooked = enablePerfectInvokeHook(gunRemote(gun))
                disconnectGunActivation()
                bindGunActivation()
                if not hooked and not mouseHooked and not invokeHooked and type(getconnections) ~= "function" then
                    notify("Perfect Shots has limited support in this executor.", false)
                else
                    local murderer = findMurderer()
                    notify(murderer and ("Perfect Shots ready: " .. murderer.Name) or "Perfect Shots ready; waiting for Murderer.", murderer ~= nil)
                end
            else
                disablePerfectShotHook()
                disablePerfectInvokeHook()
                disablePerfectMouseHook()
                disconnectGunActivation()
            end
        elseif name == "UtilsHitboxExpander" then
            if value then
                refreshRoles()
                updateHitboxes()
            else
                restoreAllHitboxes()
            end
        elseif name == "UtilsHitboxSize" or name == "UtilsHitboxTarget" then
            if settings.UtilsHitboxExpander then
                refreshRoles()
                updateHitboxes()
            end
        elseif name == "SheriffAutoShootMurderer" or name == "MurderKillAura" or name == "UtilsAutoEvadeMurderer" then
            if value then refreshRoles() end
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.MurderKillAura = false
        settings.SheriffPerfectShots = false
        settings.SheriffAutoShootMurderer = false
        settings.SheriffAutoGrabGun = false
        settings.UtilsAutoEvadeMurderer = false
        settings.UtilsHitboxExpander = false
        disablePerfectShotHook()
        disablePerfectInvokeHook()
        disablePerfectMouseHook()
        disconnectGunActivation()
        restoreAllHitboxes()
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_COMBAT_CLEANUP == cleanupFunction then _G.__HMENU_COMBAT_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_COMBAT_CLEANUP = cleanupFunction
    return runtime
end

return Combat
end
-- END runtime/Combat.lua

-- BEGIN runtime/Emotes.lua
__modules["runtime/Emotes.lua"] = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Emotes = {}

function Emotes:Create()
    local runtime = {}
    local destroyed = false
    local loopGeneration = 0

    local settings = {
        SelectedEmote = "Sit",
        LoopEmote = false,
        PlayEmote = false,
    }

    local emoteNames = {
        Sit = "sit",
        Zen = "zen",
        ["Ninja Rest"] = "ninja",
        Dab = "dab",
        Floss = "floss",
        Zombie = "zombie",
        Headless = "headless",
    }

    local function emoteEvent()
        local event = ReplicatedStorage:FindFirstChild("PlayEmote")
            or ReplicatedStorage:FindFirstChild("PlayEmote", true)
        if event and event:IsA("BindableEvent") then
            return event
        end
        return nil
    end

    local function playSelectedEmote()
        local emoteName = emoteNames[settings.SelectedEmote]
        local event = emoteEvent()
        if not event or not emoteName then
            warn("[H Menu] PlayEmote do MM2 não foi encontrado:", settings.SelectedEmote)
            return false
        end

        local success = pcall(function()
            event:Fire(emoteName)
        end)
        if not success then
            warn("[H Menu] Não foi possível reproduzir o emote do MM2:", settings.SelectedEmote)
            return false
        end
        return true
    end

    local function restartLoop()
        loopGeneration = loopGeneration + 1
        local generation = loopGeneration
        if not settings.LoopEmote then
            return
        end

        task.spawn(function()
            while not destroyed and settings.LoopEmote and generation == loopGeneration do
                playSelectedEmote()
                task.wait(2.5)
            end
        end)
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then
            return
        end
        settings[name] = value

        if name == "PlayEmote" then
            playSelectedEmote()
        elseif name == "LoopEmote" then
            restartLoop()
        elseif name == "SelectedEmote" and settings.LoopEmote then
            restartLoop()
        end
    end

    function runtime:Destroy()
        if destroyed then
            return
        end
        destroyed = true
        loopGeneration = loopGeneration + 1
    end

    return runtime
end

return Emotes
end
-- END runtime/Emotes.lua

-- BEGIN runtime/Farm.lua
__modules["runtime/Farm.lua"] = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Farm = {}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function lower(value)
    return string.lower(tostring(value or ""))
end

function Farm:Create(options)
    if type(_G.__HMENU_FARM_CLEANUP) == "function" then pcall(_G.__HMENU_FARM_CLEANUP) end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local destroyed = false
    local cleanupFunction
    local farmGeneration = 0
    local actionGeneration = 0
    local actionBusy = false
    local toastVersion = 0

    local settings = {
        AutoCoins = false,
        ReturnAfterSweep = false,
        AutoEventItems = false,
        EventFilter = "All",
        MovementMode = "Teleport",
        ActionDelay = 0.2,
        SmoothSpeed = 70,
        FarmWalkSpeed = 16,
        NearestCoin = false,
        CollectAllEvents = false,
    }

    local overlay = make("ScreenGui", {
        Name = "HMenuFarmOverlay", ResetOnSpawn = false, IgnoreGuiInset = true,
        DisplayOrder = 997, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end
    local toast = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, -60),
        Size = UDim2.fromOffset(340, 44), BackgroundColor3 = Color3.fromRGB(24, 38, 65),
        BackgroundTransparency = 0.08, BorderSizePixel = 0, Visible = false,
    }, overlay)
    make("UICorner", { CornerRadius = UDim.new(0, 8) }, toast)
    make("UIStroke", { Color = Color3.fromRGB(83, 122, 190), Transparency = 0.25, Thickness = 1 }, toast)
    local marker = make("Frame", {
        Size = UDim2.fromOffset(3, 26), Position = UDim2.fromOffset(0, 9),
        BackgroundColor3 = Color3.fromRGB(102, 151, 246), BorderSizePixel = 0,
    }, toast)
    make("UICorner", { CornerRadius = UDim.new(0, 2) }, marker)
    local toastText = make("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.fromOffset(17, 0),
        BackgroundTransparency = 1, Text = "", TextColor3 = Color3.fromRGB(235, 241, 255),
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)

    local function notify(message, success)
        if destroyed then return end
        toastVersion = toastVersion + 1
        local version = toastVersion
        toastText.Text = message
        marker.BackgroundColor3 = success and Color3.fromRGB(83, 220, 145) or Color3.fromRGB(255, 118, 126)
        toast.Visible = true
        TweenService:Create(toast, TweenInfo.new(0.18), { Position = UDim2.new(0.5, 0, 0, 20) }):Play()
        task.delay(2.2, function()
            if destroyed or version ~= toastVersion then return end
            local tween = TweenService:Create(toast, TweenInfo.new(0.18), { Position = UDim2.new(0.5, 0, 0, -60) })
            tween:Play()
            tween.Completed:Wait()
            if not destroyed and version == toastVersion then toast.Visible = false end
        end)
    end

    local function rootPart()
        local character = localPlayer.Character
        return character and character:FindFirstChild("HumanoidRootPart")
    end

    local function humanoid()
        local character = localPlayer.Character
        return character and character:FindFirstChildOfClass("Humanoid")
    end

    local function ancestorNamed(instance, fragment, levels)
        local current = instance
        for _ = 1, levels or 4 do
            if not current or current == Workspace then break end
            if string.find(lower(current.Name), fragment, 1, true) then return true end
            current = current.Parent
        end
        return false
    end

    local function normalizedCoin(part)
        local name = lower(part.Name)
        if name == "coinvisual" and part.Parent and part.Parent:IsA("BasePart") then
            return part.Parent
        end
        if part:FindFirstChild("CoinVisual") then return part end
        if name == "coin" or name == "coin_server" or name == "currencycoin" then return part end
        if ancestorNamed(part.Parent, "coincontainer", 4) and string.find(name, "coin", 1, true) then return part end
        return nil
    end

    local function eventType(part)
        local current = part
        for _ = 1, 5 do
            if not current or current == Workspace then break end
            local name = lower(current.Name):gsub("[%s_-]", "")
            if string.find(name, "beachball", 1, true) then return "Beach Balls" end
            if string.find(name, "rareegg", 1, true) or string.find(name, "egg", 1, true) then return "Eggs" end
            if string.find(name, "candy", 1, true) or string.find(name, "snowtoken", 1, true)
                or string.find(name, "eventtoken", 1, true) then return "Candy" end
            current = current.Parent
        end
        return nil
    end

    local function getItems(itemType)
        local results, seen = {}, {}
        local localCharacter = localPlayer.Character
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("BasePart") and (not localCharacter or not descendant:IsDescendantOf(localCharacter)) then
                local candidate
                if itemType == "Coins" then
                    candidate = normalizedCoin(descendant)
                else
                    local detectedType = eventType(descendant)
                    if detectedType and (settings.EventFilter == "All" or settings.EventFilter == detectedType) then
                        candidate = descendant
                    end
                end
                if candidate and candidate.Parent and not seen[candidate] then
                    seen[candidate] = true
                    table.insert(results, candidate)
                end
            end
        end
        return results
    end

    local function nearest(items)
        local root = rootPart()
        if not root then return nil end
        local best, bestDistance
        for _, item in ipairs(items) do
            if item.Parent then
                local distance = (item.Position - root.Position).Magnitude
                if not bestDistance or distance < bestDistance then
                    best, bestDistance = item, distance
                end
            end
        end
        return best
    end

    local function touchItem(root, item)
        if not root or not item or not item.Parent then return end
        if type(firetouchinterest) == "function" then
            pcall(function()
                firetouchinterest(root, item, 0)
                firetouchinterest(root, item, 1)
            end)
        end
    end

    local function moveTo(item, shouldContinue)
        local root = rootPart()
        if not root or not item or not item.Parent then return false end
        local targetPosition = item.Position + Vector3.new(0, 0.5, 0)
        if settings.MovementMode == "Teleport" then
            root.AssemblyLinearVelocity = Vector3.zero
            root.CFrame = CFrame.new(targetPosition)
        elseif settings.MovementMode == "Smooth" then
            local startPosition = root.Position
            local duration = math.max((targetPosition - startPosition).Magnitude / math.max(settings.SmoothSpeed, 1), 0.05)
            local started = time()
            while not destroyed and shouldContinue() and root.Parent and item.Parent do
                local alpha = math.clamp((time() - started) / duration, 0, 1)
                root.CFrame = CFrame.new(startPosition:Lerp(targetPosition, alpha))
                if alpha >= 1 then break end
                RunService.Heartbeat:Wait()
            end
        else
            local currentHumanoid = humanoid()
            if not currentHumanoid then return false end
            local originalSpeed = currentHumanoid.WalkSpeed
            currentHumanoid.WalkSpeed = settings.FarmWalkSpeed
            currentHumanoid:MoveTo(targetPosition)
            local started = time()
            while not destroyed and shouldContinue() and root.Parent and item.Parent
                and (root.Position - targetPosition).Magnitude > 3 and time() - started < 10 do
                task.wait(0.1)
            end
            if currentHumanoid.Parent then currentHumanoid.WalkSpeed = originalSpeed end
        end
        if destroyed or not shouldContinue() then return false end
        touchItem(root, item)
        return true
    end

    local function combinedAutoItems()
        local items = {}
        if settings.AutoCoins then
            for _, item in ipairs(getItems("Coins")) do table.insert(items, item) end
        end
        if settings.AutoEventItems then
            for _, item in ipairs(getItems("Events")) do table.insert(items, item) end
        end
        return items
    end

    local function restartAutoFarm()
        farmGeneration = farmGeneration + 1
        local generation = farmGeneration
        if not settings.AutoCoins and not settings.AutoEventItems then return end
        task.spawn(function()
            while not destroyed and generation == farmGeneration
                and (settings.AutoCoins or settings.AutoEventItems) do
                local item = nearest(combinedAutoItems())
                if item then
                    moveTo(item, function()
                        return not destroyed and generation == farmGeneration
                    end)
                    task.wait(settings.ActionDelay)
                else
                    task.wait(0.8)
                end
            end
        end)
    end

    local function runSweep(itemType)
        if actionBusy then
            notify("A collection action is already running.", false)
            return
        end
        if settings.AutoCoins or settings.AutoEventItems then
            notify("Disable auto collection before starting a sweep.", false)
            return
        end
        actionBusy = true
        actionGeneration = actionGeneration + 1
        local generation = actionGeneration
        task.spawn(function()
            local root = rootPart()
            if not root then
                actionBusy = false
                notify("Your character is not ready.", false)
                return
            end
            local saved = root.CFrame
            local items = getItems(itemType)
            if #items == 0 then
                actionBusy = false
                notify(itemType == "Coins" and "No coins found." or "No event items found.", false)
                return
            end
            notify("Collecting " .. tostring(#items) .. " items...", true)
            while not destroyed and generation == actionGeneration and #items > 0 do
                local item = nearest(items)
                if not item then break end
                for index = #items, 1, -1 do
                    if items[index] == item or not items[index].Parent then table.remove(items, index) end
                end
                moveTo(item, function()
                    return not destroyed and generation == actionGeneration
                end)
                task.wait(settings.ActionDelay)
            end
            if not destroyed and generation == actionGeneration and settings.ReturnAfterSweep then
                local currentRoot = rootPart()
                if currentRoot then currentRoot.CFrame = saved end
            end
            actionBusy = false
            if not destroyed and generation == actionGeneration then notify("Collection sweep complete.", true) end
        end)
    end

    local function collectNearestCoin()
        if settings.AutoCoins or settings.AutoEventItems or actionBusy then
            notify("Stop the current collection first.", false)
            return
        end
        local coin = nearest(getItems("Coins"))
        if not coin then
            notify("No coins found.", false)
            return
        end
        actionGeneration = actionGeneration + 1
        local generation = actionGeneration
        task.spawn(function()
            moveTo(coin, function() return not destroyed and generation == actionGeneration end)
            if not destroyed then notify("Nearest coin collected.", true) end
        end)
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "AutoCoins" or name == "AutoEventItems" then
            restartAutoFarm()
        elseif name == "NearestCoin" then
            collectNearestCoin()
        elseif name == "CollectAllEvents" then
            runSweep("Events")
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        farmGeneration = farmGeneration + 1
        actionGeneration = actionGeneration + 1
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_FARM_CLEANUP == cleanupFunction then _G.__HMENU_FARM_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_FARM_CLEANUP = cleanupFunction
    return runtime
end

return Farm
end
-- END runtime/Farm.lua

-- BEGIN runtime/Misc.lua
__modules["runtime/Misc.lua"] = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local Misc = {}

function Misc:Create(options)
    if type(_G.__HMENU_MISC_CLEANUP) == "function" then
        pcall(_G.__HMENU_MISC_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local connections = {}
    local disabledEffects = {}
    local destroyed = false
    local cleanupFunction

    local settings = {
        MenuTheme = "Default",
        ShowFPS = false,
        PerformanceMode = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = Instance.new("ScreenGui")
    overlay.Name = "HMenuMiscOverlay"
    overlay.ResetOnSpawn = false
    overlay.IgnoreGuiInset = true
    overlay.DisplayOrder = 998
    overlay.Parent = parent
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "PerformanceStats"
    statsLabel.Position = UDim2.new(1, -12, 1, -12)
    statsLabel.AnchorPoint = Vector2.new(1, 1)
    statsLabel.Size = UDim2.fromOffset(170, 28)
    statsLabel.BackgroundColor3 = Color3.fromRGB(15, 22, 38)
    statsLabel.BackgroundTransparency = 0.18
    statsLabel.BorderSizePixel = 0
    statsLabel.TextColor3 = Color3.fromRGB(235, 242, 255)
    statsLabel.Font = Enum.Font.Code
    statsLabel.TextSize = 13
    statsLabel.TextXAlignment = Enum.TextXAlignment.Center
    statsLabel.Visible = false
    statsLabel.Parent = overlay

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = statsLabel

    local function setEffectEnabled(effect, enabled)
        if effect:IsA("PostEffect") or effect:IsA("ParticleEmitter")
            or effect:IsA("Trail") or effect:IsA("Beam") then
            if disabledEffects[effect] == nil then
                disabledEffects[effect] = effect.Enabled
            end
            effect.Enabled = enabled
        end
    end

    local function applyPerformanceMode()
        if not settings.PerformanceMode then
            for effect, wasEnabled in pairs(disabledEffects) do
                if effect and effect.Parent then effect.Enabled = wasEnabled end
            end
            disabledEffects = {}
            return
        end

        for _, instance in ipairs(Workspace:GetDescendants()) do
            setEffectEnabled(instance, false)
        end
        for _, instance in ipairs(Lighting:GetChildren()) do
            setEffectEnabled(instance, false)
        end
    end

    local function refreshStats()
        local ping = "--"
        local ok, value = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
        end)
        if ok and value then ping = tostring(value):gsub(" ms", "") .. " ms" end
        return ping
    end

    local elapsed = 0
    local frames = 0
    connect(RunService.RenderStepped, function(deltaTime)
        if destroyed then return end
        frames = frames + 1
        elapsed = elapsed + deltaTime
        if elapsed >= 0.5 then
            local fps = math.floor(frames / elapsed + 0.5)
            statsLabel.Text = string.format("FPS %d  |  Ping %s", fps, refreshStats())
            statsLabel.Visible = settings.ShowFPS
            frames = 0
            elapsed = 0
        end
    end)

    connect(Workspace.DescendantAdded, function(instance)
        if settings.PerformanceMode then setEffectEnabled(instance, false) end
    end)
    connect(Lighting.ChildAdded, function(instance)
        if settings.PerformanceMode then setEffectEnabled(instance, false) end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "MenuTheme" then
            local setTheme = rawget(_G, "__HMENU_SET_THEME")
            if type(setTheme) == "function" then setTheme(value) end
        elseif name == "ShowFPS" then
            statsLabel.Visible = value
        elseif name == "PerformanceMode" then
            applyPerformanceMode()
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        for effect, wasEnabled in pairs(disabledEffects) do
            if effect and effect.Parent then effect.Enabled = wasEnabled end
        end
        for _, connection in ipairs(connections) do
            pcall(function() connection:Disconnect() end)
        end
        connections = {}
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_MISC_CLEANUP == cleanupFunction then _G.__HMENU_MISC_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_MISC_CLEANUP = cleanupFunction
    return runtime
end

return Misc
end
-- END runtime/Misc.lua

-- BEGIN runtime/Player.lua
__modules["runtime/Player.lua"] = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local PlayerRuntime = {}

local function destroy(object)
    if object then pcall(function() object:Destroy() end) end
end

function PlayerRuntime:Create()
    if type(_G.__HMENU_PLAYER_CLEANUP) == "function" then
        pcall(_G.__HMENU_PLAYER_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local connections = {}
    local collisionState = {}
    local humanoidOriginals = {}
    local destroyed = false
    local cleanupFunction
    local antiAfkConnection
    local flyRoot, flyHumanoid, flyVelocity, flyGyro
    local flyPlatformStand, flyAutoRotate
    local lastSafeCFrame
    local statsTouched = { WalkSpeed = false, JumpPower = false }

    local settings = {
        WalkSpeed = 16,
        LockWalkSpeed = false,
        JumpPower = 50,
        LockJumpPower = false,
        InfiniteJump = false,
        Fly = false,
        FlySpeed = 60,
        Noclip = false,
        AntiFling = false,
        AntiVoid = false,
        AntiAFK = false,
        AntiSit = false,
    }

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function character()
        return localPlayer.Character
    end

    local function humanoid()
        local current = character()
        return current and current:FindFirstChildOfClass("Humanoid")
    end

    local function rootPart()
        local current = character()
        return current and current:FindFirstChild("HumanoidRootPart")
    end

    local function rememberHumanoid(currentHumanoid)
        if currentHumanoid and not humanoidOriginals[currentHumanoid] then
            humanoidOriginals[currentHumanoid] = {
                WalkSpeed = currentHumanoid.WalkSpeed,
                JumpPower = currentHumanoid.JumpPower,
                UseJumpPower = currentHumanoid.UseJumpPower,
            }
        end
    end

    local function applyWalkSpeed()
        local currentHumanoid = humanoid()
        if not currentHumanoid then return end
        rememberHumanoid(currentHumanoid)
        currentHumanoid.WalkSpeed = settings.WalkSpeed
    end

    local function applyJumpPower()
        local currentHumanoid = humanoid()
        if not currentHumanoid then return end
        rememberHumanoid(currentHumanoid)
        currentHumanoid.UseJumpPower = true
        currentHumanoid.JumpPower = settings.JumpPower
    end

    local function restoreCollisions()
        for part, canCollide in pairs(collisionState) do
            if part and part.Parent then part.CanCollide = canCollide end
        end
        collisionState = {}
    end

    local function applyNoclip()
        local current = character()
        if not current then return end
        for _, part in ipairs(current:GetDescendants()) do
            if part:IsA("BasePart") then
                if collisionState[part] == nil then collisionState[part] = part.CanCollide end
                part.CanCollide = false
            end
        end
    end

    local function stopFly()
        destroy(flyVelocity)
        destroy(flyGyro)
        flyVelocity, flyGyro = nil, nil
        if flyHumanoid and flyHumanoid.Parent then
            flyHumanoid.PlatformStand = flyPlatformStand == true
            flyHumanoid.AutoRotate = flyAutoRotate ~= false
            flyHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        flyRoot, flyHumanoid = nil, nil
        flyPlatformStand, flyAutoRotate = nil, nil
    end

    local function ensureFly()
        if not settings.Fly then
            stopFly()
            return false
        end
        local root = rootPart()
        local currentHumanoid = humanoid()
        if not root or not currentHumanoid then
            stopFly()
            return false
        end
        if flyRoot == root and flyVelocity and flyVelocity.Parent and flyGyro and flyGyro.Parent then
            return true
        end

        stopFly()
        flyRoot, flyHumanoid = root, currentHumanoid
        flyPlatformStand, flyAutoRotate = currentHumanoid.PlatformStand, currentHumanoid.AutoRotate
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.Name = "HMenuFlyVelocity"
        flyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        flyVelocity.P = 12500
        flyVelocity.Velocity = Vector3.zero
        flyVelocity.Parent = root
        flyGyro = Instance.new("BodyGyro")
        flyGyro.Name = "HMenuFlyGyro"
        flyGyro.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
        flyGyro.P = 20000
        flyGyro.D = 500
        flyGyro.CFrame = root.CFrame
        flyGyro.Parent = root
        currentHumanoid.PlatformStand = true
        currentHumanoid.AutoRotate = false
        return true
    end

    local function flyDirection(camera, currentHumanoid)
        local direction = Vector3.zero
        local keyboardDirection = false
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + camera.CFrame.LookVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - camera.CFrame.LookVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camera.CFrame.RightVector
            keyboardDirection = true
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camera.CFrame.RightVector
            keyboardDirection = true
        end
        if not keyboardDirection and currentHumanoid.MoveDirection.Magnitude > 0 then
            direction = direction + currentHumanoid.MoveDirection
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        return direction.Magnitude > 0 and direction.Unit or Vector3.zero
    end

    local function updateFly()
        if not settings.Fly or not ensureFly() then return end
        local camera = Workspace.CurrentCamera
        if not camera or not flyRoot or not flyHumanoid then return end
        flyHumanoid.PlatformStand = true
        flyHumanoid.AutoRotate = false
        flyVelocity.Velocity = flyDirection(camera, flyHumanoid) * settings.FlySpeed
        local look = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
        if look.Magnitude > 0.001 then
            flyGyro.CFrame = CFrame.lookAt(flyRoot.Position, flyRoot.Position + look.Unit)
        end
    end

    local function captureSafePosition()
        local root = rootPart()
        local currentHumanoid = humanoid()
        if not root or not currentHumanoid then return end
        local voidLevel = Workspace.FallenPartsDestroyHeight
        local grounded = currentHumanoid.FloorMaterial ~= Enum.Material.Air
        local stable = root.AssemblyLinearVelocity.Magnitude < 90 and root.AssemblyAngularVelocity.Magnitude < 35
        if grounded and stable and root.Position.Y > voidLevel + 30 then
            lastSafeCFrame = root.CFrame
        end
    end

    local function recover(messageCondition)
        local root = rootPart()
        if not root or not lastSafeCFrame or not messageCondition then return false end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = lastSafeCFrame
        return true
    end

    local safetyElapsed = 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        if settings.LockWalkSpeed then applyWalkSpeed() end
        if settings.LockJumpPower then applyJumpPower() end

        local currentHumanoid = humanoid()
        if settings.AntiSit and currentHumanoid and currentHumanoid.Sit then
            currentHumanoid.Sit = false
            currentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        safetyElapsed = safetyElapsed + deltaTime
        if safetyElapsed < 0.12 then return end
        safetyElapsed = 0
        if settings.AntiFling or settings.AntiVoid then captureSafePosition() end
        local root = rootPart()
        if not root or settings.Fly then return end
        local ownTrollImpulse = rawget(_G, "__HMENU_TROLL_IMPULSE") ~= nil
        if settings.AntiFling and not ownTrollImpulse then
            local flung = root.AssemblyLinearVelocity.Magnitude > 250 or root.AssemblyAngularVelocity.Magnitude > 100
            recover(flung)
        end
        if settings.AntiVoid then
            recover(root.Position.Y <= Workspace.FallenPartsDestroyHeight + 25)
        end
    end)

    connect(RunService.Stepped, function()
        if settings.Noclip then applyNoclip() end
    end)
    connect(RunService.RenderStepped, updateFly)
    connect(UserInputService.JumpRequest, function()
        if not settings.InfiniteJump then return end
        local currentHumanoid = humanoid()
        if currentHumanoid then currentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    connect(localPlayer.CharacterAdded, function(newCharacter)
        stopFly()
        restoreCollisions()
        lastSafeCFrame = nil
        task.delay(0.5, function()
            if destroyed or newCharacter ~= character() then return end
            if statsTouched.WalkSpeed or settings.LockWalkSpeed then applyWalkSpeed() end
            if statsTouched.JumpPower or settings.LockJumpPower then applyJumpPower() end
            captureSafePosition()
        end)
    end)

    local function setAntiAfk(enabled)
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
        if not enabled then return end
        antiAfkConnection = localPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.zero, Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or CFrame.new())
                task.wait(0.1)
                VirtualUser:Button2Up(Vector2.zero, Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or CFrame.new())
            end)
        end)
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "WalkSpeed" then
            statsTouched.WalkSpeed = true
            applyWalkSpeed()
        elseif name == "JumpPower" then
            statsTouched.JumpPower = true
            applyJumpPower()
        elseif name == "LockWalkSpeed" and value then
            applyWalkSpeed()
        elseif name == "LockJumpPower" and value then
            applyJumpPower()
        elseif name == "Fly" then
            if value then ensureFly() else stopFly() end
        elseif name == "Noclip" and not value then
            restoreCollisions()
        elseif name == "AntiFling" or name == "AntiVoid" then
            if value then captureSafePosition() end
        elseif name == "AntiAFK" then
            setAntiAfk(value)
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.Fly = false
        stopFly()
        restoreCollisions()
        setAntiAfk(false)
        for currentHumanoid, originals in pairs(humanoidOriginals) do
            if currentHumanoid and currentHumanoid.Parent then
                currentHumanoid.WalkSpeed = originals.WalkSpeed
                currentHumanoid.JumpPower = originals.JumpPower
                currentHumanoid.UseJumpPower = originals.UseJumpPower
            end
        end
        for _, connection in ipairs(connections) do pcall(function() connection:Disconnect() end) end
        connections = {}
        if _G.__HMENU_PLAYER_CLEANUP == cleanupFunction then _G.__HMENU_PLAYER_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_PLAYER_CLEANUP = cleanupFunction
    return runtime
end

return PlayerRuntime
end
-- END runtime/Player.lua

-- BEGIN runtime/Teleport.lua
__modules["runtime/Teleport.lua"] = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Teleport = {}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function rootPart(player)
    local character = player and player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function isAlive(player)
    local character = player and player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return rootPart(player) ~= nil and (humanoid == nil or humanoid.Health > 0)
end

function Teleport:Create(options)
    if type(_G.__HMENU_TELEPORT_CLEANUP) == "function" then
        pcall(_G.__HMENU_TELEPORT_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local destroyed = false
    local cleanupFunction
    local toastVersion = 0
    local roles = {}

    local settings = {
        SelectedPlayer = "Select a player",
        ArrivalMode = "Behind",
        ArrivalDistance = 4,
        TeleportMurderer = false,
        TeleportSheriff = false,
        TeleportGun = false,
        TeleportSelected = false,
        TeleportNearest = false,
        TeleportRandom = false,
        SavePosition = false,
        LoadPosition = false,
    }

    local overlay = make("ScreenGui", {
        Name = "HMenuTeleportOverlay",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 997,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local toast = make("Frame", {
        Name = "Toast",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, -60),
        Size = UDim2.fromOffset(330, 44),
        BackgroundColor3 = Color3.fromRGB(24, 38, 65),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Visible = false,
    }, overlay)
    make("UICorner", { CornerRadius = UDim.new(0, 8) }, toast)
    make("UIStroke", { Color = Color3.fromRGB(83, 122, 190), Transparency = 0.25, Thickness = 1 }, toast)
    local toastMarker = make("Frame", {
        Size = UDim2.fromOffset(3, 26), Position = UDim2.fromOffset(0, 9),
        BackgroundColor3 = Color3.fromRGB(102, 151, 246), BorderSizePixel = 0,
    }, toast)
    make("UICorner", { CornerRadius = UDim.new(0, 2) }, toastMarker)
    local toastText = make("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.fromOffset(17, 0),
        BackgroundTransparency = 1, Text = "", TextColor3 = Color3.fromRGB(235, 241, 255),
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)

    local function notify(message, success)
        if destroyed then return end
        toastVersion = toastVersion + 1
        local version = toastVersion
        toastText.Text = message
        toastMarker.BackgroundColor3 = success and Color3.fromRGB(83, 220, 145) or Color3.fromRGB(255, 118, 126)
        toast.Visible = true
        TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, 0, 0, 20),
        }):Play()
        task.delay(2.2, function()
            if destroyed or version ~= toastVersion then return end
            local tween = TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0, -60),
            })
            tween:Play()
            tween.Completed:Wait()
            if version == toastVersion then toast.Visible = false end
        end)
    end

    local function refreshRoles()
        local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
        if remote and remote:IsA("RemoteFunction") then
            local ok, result = pcall(function() return remote:InvokeServer() end)
            if ok and type(result) == "table" then roles = result end
        end
    end

    local function heldTool(player, toolName)
        local character = player and player.Character
        local backpack = player and player:FindFirstChild("Backpack")
        return (character and character:FindFirstChild(toolName)) or (backpack and backpack:FindFirstChild(toolName))
    end

    local function findRole(roleName)
        refreshRoles()
        local hero
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) then
                local data = roles[player.Name]
                local role = data and data.Role
                if role == roleName then return player end
                if roleName == "Sheriff" and role == "Hero" then hero = player end
            end
        end
        if hero then return hero end
        local toolName = roleName == "Murderer" and "Knife" or "Gun"
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) and heldTool(player, toolName) then return player end
        end
        return nil
    end

    local function arrivalCFrame(targetRoot)
        local distance = math.clamp(tonumber(settings.ArrivalDistance) or 4, 2, 12)
        if settings.ArrivalMode == "In Front" then
            return targetRoot.CFrame * CFrame.new(0, 0, -distance)
        elseif settings.ArrivalMode == "Above" then
            return targetRoot.CFrame * CFrame.new(0, distance + 3, 0)
        end
        return targetRoot.CFrame * CFrame.new(0, 0, distance)
    end

    local function teleportTo(cf, message)
        local root = rootPart(localPlayer)
        if not root then
            notify("Your character is not ready.", false)
            return false
        end
        local ok = pcall(function()
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = cf
        end)
        if ok then
            notify(message or "Teleported.", true)
            return true
        end
        notify("Teleport failed.", false)
        return false
    end

    local function teleportToPlayer(player, description)
        local targetRoot = rootPart(player)
        if not player or player == localPlayer or not isAlive(player) or not targetRoot then
            notify("Target player is unavailable.", false)
            return false
        end
        return teleportTo(arrivalCFrame(targetRoot), "Teleported to " .. (description or player.Name) .. ".")
    end

    local function selectedPlayer()
        local name = settings.SelectedPlayer
        if name == "Select a player" or name == "No players available" then return nil end
        return Players:FindFirstChild(name)
    end

    local function nearestPlayer()
        local localRoot = rootPart(localPlayer)
        if not localRoot then return nil end
        local nearest, nearestDistance
        for _, player in ipairs(Players:GetPlayers()) do
            local targetRoot = rootPart(player)
            if player ~= localPlayer and isAlive(player) and targetRoot then
                local distance = (targetRoot.Position - localRoot.Position).Magnitude
                if not nearestDistance or distance < nearestDistance then
                    nearest, nearestDistance = player, distance
                end
            end
        end
        return nearest
    end

    local function randomPlayer()
        local available = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and isAlive(player) then table.insert(available, player) end
        end
        return #available > 0 and available[math.random(1, #available)] or nil
    end

    local function teleportToGun()
        local gun = Workspace:FindFirstChild("GunDrop", true)
        if not gun then
            notify("No dropped gun found.", false)
            return
        end
        local part
        if gun:IsA("BasePart") then
            part = gun
        elseif gun:IsA("Model") then
            part = gun.PrimaryPart or gun:FindFirstChildWhichIsA("BasePart", true)
        else
            part = gun:FindFirstChildWhichIsA("BasePart", true)
        end
        if part then
            teleportTo(part.CFrame * CFrame.new(0, 2.5, 0), "Teleported to dropped gun.")
        else
            notify("Dropped gun has no valid part.", false)
        end
    end

    function runtime:GetOptions(source)
        if source ~= "Players" then return { "None" } end
        local names = { "Select a player" }
        local players = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then table.insert(players, player.Name) end
        end
        table.sort(players, function(a, b) return string.lower(a) < string.lower(b) end)
        for _, name in ipairs(players) do table.insert(names, name) end
        if #names == 1 then return { "No players available" } end
        return names
    end

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "TeleportMurderer" then
            local player = findRole("Murderer")
            if player then teleportToPlayer(player, "Murderer") else notify("Murderer not found yet.", false) end
        elseif name == "TeleportSheriff" then
            local player = findRole("Sheriff")
            if player then teleportToPlayer(player, "Sheriff") else notify("Sheriff or Hero not found.", false) end
        elseif name == "TeleportGun" then
            teleportToGun()
        elseif name == "TeleportSelected" then
            teleportToPlayer(selectedPlayer())
        elseif name == "TeleportNearest" then
            teleportToPlayer(nearestPlayer(), "nearest player")
        elseif name == "TeleportRandom" then
            teleportToPlayer(randomPlayer(), "random player")
        elseif name == "SavePosition" then
            local root = rootPart(localPlayer)
            if root then
                _G.__HMENU_SAVED_CFRAME = root.CFrame
                notify("Current position saved.", true)
            else
                notify("Your character is not ready.", false)
            end
        elseif name == "LoadPosition" then
            if _G.__HMENU_SAVED_CFRAME then
                teleportTo(_G.__HMENU_SAVED_CFRAME, "Returned to saved position.")
            else
                notify("Save a position first.", false)
            end
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        if overlay and overlay.Parent then overlay:Destroy() end
        if _G.__HMENU_TELEPORT_CLEANUP == cleanupFunction then _G.__HMENU_TELEPORT_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_TELEPORT_CLEANUP = cleanupFunction
    return runtime
end

return Teleport
end
-- END runtime/Teleport.lua

-- BEGIN runtime/Troll.lua
__modules["runtime/Troll.lua"] = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local TrollRuntime = {}

function TrollRuntime:Create()
    if type(_G.__HMENU_TROLL_CLEANUP) == "function" then
        pcall(_G.__HMENU_TROLL_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local connections = {}
    local touchConnections = {}
    local targetDebounce = {}
    local destroyed = false
    local cleanupFunction
    local actionToken = 0
    local flinging = false
    local activeRestore
    local impulseMarker = {}

    local settings = {
        TouchFling = false,
    }

    local function connect(bucket, signal, callback)
        local connection = signal:Connect(callback)
        table.insert(bucket, connection)
        return connection
    end

    local function disconnectAll(bucket)
        for index = #bucket, 1, -1 do
            pcall(function() bucket[index]:Disconnect() end)
            table.remove(bucket, index)
        end
    end

    local function livingRoot(character)
        if not character then return nil end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
        if not humanoid or humanoid.Health <= 0 or not root or not root:IsA("BasePart") then
            return nil
        end
        return root, humanoid
    end

    local function playerFromPart(part)
        local ancestor = part
        while ancestor do
            if ancestor:IsA("Model") then
                local player = Players:GetPlayerFromCharacter(ancestor)
                if player then return player end
            end
            ancestor = ancestor.Parent
        end
        return nil
    end

    local function fling(targetPlayer)
        if destroyed or not settings.TouchFling or flinging or not targetPlayer or targetPlayer == localPlayer then return end

        local now = os.clock()
        if (targetDebounce[targetPlayer] or 0) > now then return end
        targetDebounce[targetPlayer] = now + 1

        local targetRoot, targetHumanoid = livingRoot(targetPlayer.Character)
        local localRoot = livingRoot(localPlayer.Character)
        if not targetRoot or not targetHumanoid or not localRoot then return end
        if targetPlayer.Character == localPlayer.Character then return end

        flinging = true
        _G.__HMENU_TROLL_IMPULSE = impulseMarker
        actionToken = actionToken + 1
        local token = actionToken
        local savedCFrame = targetRoot.CFrame
        local savedLinearVelocity = targetRoot.AssemblyLinearVelocity
        local savedAngularVelocity = targetRoot.AssemblyAngularVelocity
        local savedAutoRotate = targetHumanoid.AutoRotate
        local restored = false

        local function restore()
            if restored then return end
            restored = true
            if targetRoot and targetRoot.Parent then
                targetRoot.AssemblyLinearVelocity = savedLinearVelocity
                targetRoot.AssemblyAngularVelocity = savedAngularVelocity
                targetRoot.CFrame = savedCFrame
            end
            if targetHumanoid and targetHumanoid.Parent then
                targetHumanoid.AutoRotate = savedAutoRotate
            end
            if _G.__HMENU_TROLL_IMPULSE == impulseMarker then
                _G.__HMENU_TROLL_IMPULSE = nil
            end
            if activeRestore == restore then activeRestore = nil end
            flinging = false
        end
        activeRestore = restore

        task.spawn(function()
            local ok, err = pcall(function()
                local startedAt = os.clock()
                targetHumanoid.AutoRotate = false

                while not destroyed and settings.TouchFling and token == actionToken
                    and os.clock() - startedAt < 0.28 do
                    local currentTargetRoot = livingRoot(targetPlayer.Character)
                    local currentLocalRoot = livingRoot(localPlayer.Character)
                    if not currentTargetRoot or not currentLocalRoot then break end

                    local horizontal = currentTargetRoot.Position - currentLocalRoot.Position
                    horizontal = Vector3.new(horizontal.X, 0, horizontal.Z)
                    if horizontal.Magnitude < 0.05 then
                        horizontal = Vector3.new(currentLocalRoot.CFrame.LookVector.X, 0,
                            currentLocalRoot.CFrame.LookVector.Z)
                    end
                    local direction = horizontal.Magnitude > 0.05 and horizontal.Unit or Vector3.new(1, 0, 0)

                    currentTargetRoot.AssemblyLinearVelocity = Vector3.new(direction.X * 9000, 12000,
                        direction.Z * 9000)
                    currentTargetRoot.AssemblyAngularVelocity = Vector3.new(0, 100000, 0)
                    RunService.Heartbeat:Wait()
                end
            end)

            restore()
            if not ok then warn("[HMenu] Touch Fling error:", err) end
        end)
    end

    local function onTouched(part)
        if destroyed or not settings.TouchFling or not part or not part.Parent then return end
        if localPlayer.Character and part:IsDescendantOf(localPlayer.Character) then return end
        local targetPlayer = playerFromPart(part)
        if targetPlayer and targetPlayer ~= localPlayer then fling(targetPlayer) end
    end

    local function watchPart(part)
        if part:IsA("BasePart") then
            connect(touchConnections, part.Touched, onTouched)
        end
    end

    local function bindCharacter(character)
        disconnectAll(touchConnections)
        if not settings.TouchFling or not character then return end
        for _, descendant in ipairs(character:GetDescendants()) do
            watchPart(descendant)
        end
        connect(touchConnections, character.DescendantAdded, watchPart)
    end

    connect(connections, localPlayer.CharacterAdded, function(character)
        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        task.defer(function()
            if not destroyed and settings.TouchFling and character == localPlayer.Character then
                bindCharacter(character)
            end
        end)
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value == true
        if name ~= "TouchFling" then return end

        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        if settings.TouchFling then
            bindCharacter(localPlayer.Character)
        else
            disconnectAll(touchConnections)
            targetDebounce = {}
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        settings.TouchFling = false
        actionToken = actionToken + 1
        if activeRestore then activeRestore() end
        disconnectAll(touchConnections)
        disconnectAll(connections)
        targetDebounce = {}
        if _G.__HMENU_TROLL_IMPULSE == impulseMarker then _G.__HMENU_TROLL_IMPULSE = nil end
        if _G.__HMENU_TROLL_CLEANUP == cleanupFunction then _G.__HMENU_TROLL_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_TROLL_CLEANUP = cleanupFunction
    return runtime
end

return TrollRuntime
end
-- END runtime/Troll.lua

-- BEGIN runtime/Visuals.lua
__modules["runtime/Visuals.lua"] = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Visuals = {}

local ROLE_COLORS = {
    Murderer = Color3.fromRGB(255, 66, 77),
    Sheriff = Color3.fromRGB(64, 143, 255),
    Hero = Color3.fromRGB(255, 218, 62),
    Innocent = Color3.fromRGB(67, 220, 124),
    Unknown = Color3.fromRGB(205, 215, 235),
}

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function destroy(object)
    if object then pcall(function() object:Destroy() end) end
end

function Visuals:Create(options)
    if type(_G.__HMENU_VISUAL_CLEANUP) == "function" then
        pcall(_G.__HMENU_VISUAL_CLEANUP)
    end

    local runtime = {}
    local localPlayer = Players.LocalPlayer
    local parent = options and options.Parent or localPlayer:WaitForChild("PlayerGui")
    local connections = {}
    local playerVisuals = {}
    local gunVisuals = {}
    local coinVisuals = {}
    local roles = {}
    local destroyed = false
    local roleBusy = false
    local cleanupFunction

    local settings = {
        EspEnabled = false,
        PlayerNames = false,
        ShowRoles = false,
        ShowDistance = false,
        ShowHealth = false,
        XRay = false,
        FillTransparency = 68,
        DroppedGun = false,
        ShowCoins = false,
        Fov = 70,
        Crosshair = "Off",
        FullBright = false,
        NoFog = false,
    }

    local camera = Workspace.CurrentCamera
    local originalFov = camera and camera.FieldOfView or 70
    local originalLighting = {
        Brightness = Lighting.Brightness,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
    }
    local atmosphereState = {}

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local overlay = make("ScreenGui", {
        Name = "HMenuVisualOverlay",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 996,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)
    if type(protect_gui) == "function" then pcall(protect_gui, overlay) end

    local crosshair = make("Frame", {
        Name = "Crosshair",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        Visible = false,
    }, overlay)
    local dot = make("Frame", {
        Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(4, 4),
        BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0,
    }, crosshair)
    make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
    local crosshairLines = {
        make("Frame", { Size = UDim2.fromOffset(1, 7), Position = UDim2.new(0.5, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(1, 7), Position = UDim2.new(0.5, 0, 1, -7), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(7, 1), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
        make("Frame", { Size = UDim2.fromOffset(7, 1), Position = UDim2.new(1, -7, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 245, 255), BorderSizePixel = 0 }, crosshair),
    }

    local function updateCrosshair()
        crosshair.Visible = settings.Crosshair ~= "Off"
        dot.Visible = settings.Crosshair == "Dot"
        for _, line in ipairs(crosshairLines) do
            line.Visible = settings.Crosshair == "Classic"
        end
    end

    local function roleFromTools(player)
        local function hasTool(container, name)
            return container and container:FindFirstChild(name) ~= nil
        end
        if hasTool(player.Character, "Knife") or hasTool(player:FindFirstChild("Backpack"), "Knife") then
            return "Murderer"
        end
        if hasTool(player.Character, "Gun") or hasTool(player:FindFirstChild("Backpack"), "Gun") then
            return "Sheriff"
        end
        return "Innocent"
    end

    local function getRole(player)
        local data = roles[player.Name]
        local role = data and data.Role
        if role == "Murderer" or role == "Sheriff" or role == "Hero" or role == "Innocent" then
            return role
        end
        return roleFromTools(player)
    end

    local function isAlive(player)
        local data = roles[player.Name]
        if data and (data.Dead or data.Killed) then return false end
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        return humanoid == nil or humanoid.Health > 0
    end

    local function refreshRoles()
        if roleBusy or destroyed or not settings.EspEnabled then return end
        roleBusy = true
        local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
        if remote and remote:IsA("RemoteFunction") then
            local ok, result = pcall(function() return remote:InvokeServer() end)
            if ok and type(result) == "table" then roles = result end
        end
        roleBusy = false
    end

    local function removePlayerVisual(player)
        local entry = playerVisuals[player]
        if not entry then return end
        destroy(entry.Highlight)
        destroy(entry.Billboard)
        playerVisuals[player] = nil
    end

    local function removeAllPlayerVisuals()
        local players = {}
        for player in pairs(playerVisuals) do table.insert(players, player) end
        for _, player in ipairs(players) do removePlayerVisual(player) end
    end

    local function ensurePlayerVisual(player)
        local character = player.Character
        if not character then
            removePlayerVisual(player)
            return nil
        end
        local head = character:FindFirstChild("Head")
        if not head then return nil end

        local entry = playerVisuals[player]
        if entry and entry.Character ~= character then
            removePlayerVisual(player)
            entry = nil
        end
        if entry then return entry end

        local highlight = make("Highlight", {
            Name = "HMenuPlayerHighlight",
            Adornee = character,
            FillTransparency = settings.FillTransparency / 100,
            OutlineTransparency = 0.05,
            DepthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded,
        }, character)
        local billboard = make("BillboardGui", {
            Name = "HMenuPlayerLabel",
            Adornee = head,
            Size = UDim2.fromOffset(220, 38),
            StudsOffset = Vector3.new(0, 3.15, 0),
            AlwaysOnTop = settings.XRay,
            LightInfluence = 0,
            MaxDistance = 1500,
        }, head)
        local label = make("TextLabel", {
            Name = "Label", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            Text = "", TextColor3 = Color3.new(1, 1, 1),
            TextStrokeColor3 = Color3.fromRGB(5, 8, 14), TextStrokeTransparency = 0.25,
            Font = Enum.Font.GothamBold, TextSize = 13,
        }, billboard)
        entry = { Character = character, Highlight = highlight, Billboard = billboard, Label = label }
        playerVisuals[player] = entry
        return entry
    end

    local function updatePlayers()
        if not settings.EspEnabled then return end
        local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Parent and isAlive(player) then
                local entry = ensurePlayerVisual(player)
                if entry then
                    local role = getRole(player)
                    local color = ROLE_COLORS[role] or ROLE_COLORS.Unknown
                    entry.Highlight.Enabled = true
                    entry.Highlight.FillColor = color
                    entry.Highlight.OutlineColor = color
                    entry.Highlight.FillTransparency = settings.FillTransparency / 100
                    entry.Highlight.DepthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                    entry.Billboard.AlwaysOnTop = settings.XRay

                    local parts = {}
                    if settings.PlayerNames then table.insert(parts, player.DisplayName) end
                    if settings.ShowRoles then table.insert(parts, string.upper(role)) end
                    if settings.ShowDistance and localRoot then
                        local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            table.insert(parts, tostring(math.floor((targetRoot.Position - localRoot.Position).Magnitude + 0.5)) .. "m")
                        end
                    end
                    if settings.ShowHealth then
                        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.MaxHealth > 0 then
                            table.insert(parts, tostring(math.floor((humanoid.Health / humanoid.MaxHealth) * 100 + 0.5)) .. "% HP")
                        end
                    end
                    entry.Label.Text = table.concat(parts, "  |  ")
                    entry.Label.TextColor3 = color
                    entry.Billboard.Enabled = #parts > 0
                end
            else
                removePlayerVisual(player)
            end
        end
    end

    local function gunAdornee(instance)
        if instance:IsA("BasePart") or instance:IsA("Model") then return instance end
        local model = instance:FindFirstAncestorOfClass("Model")
        return model or instance
    end

    local function gunLabelPart(instance)
        if instance:IsA("BasePart") then return instance end
        if instance:IsA("Model") then
            return instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
        end
        return instance:FindFirstChildWhichIsA("BasePart", true)
    end

    local function removeGunVisual(instance)
        local entry = gunVisuals[instance]
        if not entry then return end
        destroy(entry.Highlight)
        destroy(entry.Billboard)
        gunVisuals[instance] = nil
    end

    local function removeAllGunVisuals()
        local instances = {}
        for instance in pairs(gunVisuals) do table.insert(instances, instance) end
        for _, instance in ipairs(instances) do removeGunVisual(instance) end
    end

    local function normalizedCoin(part)
        local name = string.lower(part.Name)
        local parent = part.Parent
        if name == "coinvisual" and parent and parent:IsA("BasePart") then
            return parent
        end
        if part:FindFirstChild("CoinVisual") then return part end
        if name == "coin" or name == "coin_server" or name == "currencycoin" then return part end
        local current = parent
        for _ = 1, 4 do
            if not current or current == Workspace then break end
            local currentName = string.lower(current.Name)
            if string.find(currentName, "coincontainer", 1, true) and string.find(name, "coin", 1, true) then
                return part
            end
            current = current.Parent
        end
        return nil
    end

    local function removeAllCoinVisuals()
        for coin, highlight in pairs(coinVisuals) do
            destroy(highlight)
            coinVisuals[coin] = nil
        end
    end

    local function scanCoinVisuals()
        if not settings.ShowCoins then return end
        local found = {}
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                local coin = normalizedCoin(descendant)
                if coin and coin.Parent then
                    found[coin] = true
                    if not coinVisuals[coin] then
                        coinVisuals[coin] = make("Highlight", {
                            Name = "HMenuCoinHighlight",
                            Adornee = coin,
                            FillColor = Color3.fromRGB(255, 205, 45),
                            OutlineColor = Color3.fromRGB(255, 248, 185),
                            FillTransparency = 0.5,
                            OutlineTransparency = 0.05,
                            DepthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop
                                or Enum.HighlightDepthMode.Occluded,
                        }, coin)
                    end
                    coinVisuals[coin].DepthMode = settings.XRay
                        and Enum.HighlightDepthMode.AlwaysOnTop
                        or Enum.HighlightDepthMode.Occluded
                end
            end
        end
        for coin, highlight in pairs(coinVisuals) do
            if not found[coin] or not coin.Parent then
                destroy(highlight)
                coinVisuals[coin] = nil
            end
        end

        local function updateCoinDepthModes()
            local depthMode = settings.XRay and Enum.HighlightDepthMode.AlwaysOnTop
                or Enum.HighlightDepthMode.Occluded
            for _, highlight in pairs(coinVisuals) do
                if highlight and highlight.Parent then
                    highlight.DepthMode = depthMode
                end
            end
        end
    end

    local function addGunVisual(instance)
        if destroyed or not settings.DroppedGun or gunVisuals[instance] or not instance:IsDescendantOf(Workspace) then return end
        local adornee = gunAdornee(instance)
        local part = gunLabelPart(adornee)
        if not adornee or not part then return end
        local color = Color3.fromRGB(255, 205, 48)
        local highlight = make("Highlight", {
            Name = "HMenuGunDropHighlight", Adornee = adornee,
            FillColor = color, OutlineColor = Color3.fromRGB(255, 245, 170),
            FillTransparency = 0.35, OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        }, adornee)
        local billboard = make("BillboardGui", {
            Name = "HMenuGunDropLabel", Adornee = part,
            Size = UDim2.fromOffset(170, 30), StudsOffset = Vector3.new(0, 1.7, 0),
            AlwaysOnTop = true, LightInfluence = 0, MaxDistance = 1800,
        }, part)
        make("TextLabel", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            Text = "DROPPED GUN", TextColor3 = color,
            TextStrokeColor3 = Color3.fromRGB(20, 15, 0), TextStrokeTransparency = 0.2,
            Font = Enum.Font.GothamBold, TextSize = 12,
        }, billboard)
        gunVisuals[instance] = { Highlight = highlight, Billboard = billboard }
    end

    local function scanGunDrops()
        if not settings.DroppedGun then return end
        local found = {}
        for _, instance in ipairs(Workspace:GetDescendants()) do
            if instance.Name == "GunDrop" then
                found[instance] = true
                addGunVisual(instance)
            end
        end
        local stale = {}
        for instance in pairs(gunVisuals) do
            if not found[instance] or not instance:IsDescendantOf(Workspace) then table.insert(stale, instance) end
        end
        for _, instance in ipairs(stale) do removeGunVisual(instance) end
    end

    local function rememberAtmospheres()
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:IsA("Atmosphere") and not atmosphereState[child] then
                atmosphereState[child] = { Density = child.Density, Haze = child.Haze, Glare = child.Glare }
            end
        end
    end

    local function applyFullBright(enabled)
        if enabled then
            Lighting.Brightness = 3
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(185, 185, 185)
            Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
        else
            Lighting.Brightness = originalLighting.Brightness
            Lighting.GlobalShadows = originalLighting.GlobalShadows
            Lighting.Ambient = originalLighting.Ambient
            Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        end
    end

    local function applyNoFog(enabled)
        if enabled then
            rememberAtmospheres()
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000000
            for atmosphere in pairs(atmosphereState) do
                if atmosphere.Parent then
                    atmosphere.Density = 0
                    atmosphere.Haze = 0
                    atmosphere.Glare = 0
                end
            end
        else
            Lighting.FogStart = originalLighting.FogStart
            Lighting.FogEnd = originalLighting.FogEnd
            for atmosphere, values in pairs(atmosphereState) do
                if atmosphere.Parent then
                    atmosphere.Density = values.Density
                    atmosphere.Haze = values.Haze
                    atmosphere.Glare = values.Glare
                end
            end
        end
    end

    local roleElapsed, visualElapsed, gunElapsed, coinElapsed = 0, 0, 0, 0
    connect(RunService.Heartbeat, function(deltaTime)
        if destroyed then return end
        roleElapsed = roleElapsed + deltaTime
        visualElapsed = visualElapsed + deltaTime
        gunElapsed = gunElapsed + deltaTime
        coinElapsed = coinElapsed + deltaTime
        if settings.EspEnabled and roleElapsed >= 0.75 then
            roleElapsed = 0
            task.spawn(refreshRoles)
        end
        if settings.EspEnabled and visualElapsed >= 0.12 then
            visualElapsed = 0
            updatePlayers()
        end
        if settings.DroppedGun and gunElapsed >= 1 then
            gunElapsed = 0
            scanGunDrops()
        end
        if settings.ShowCoins and coinElapsed >= 1 then
            coinElapsed = 0
            scanCoinVisuals()
        end
        if settings.FullBright then applyFullBright(true) end
        if settings.NoFog then applyNoFog(true) end
    end)

    connect(Players.PlayerRemoving, removePlayerVisual)
    connect(Workspace.DescendantAdded, function(instance)
        if settings.DroppedGun and instance.Name == "GunDrop" then
            task.defer(function() addGunVisual(instance) end)
        end
    end)
    connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), function()
        camera = Workspace.CurrentCamera
        if camera then camera.FieldOfView = settings.Fov end
    end)

    function runtime:Set(name, value)
        if destroyed or settings[name] == nil then return end
        settings[name] = value
        if name == "Fov" then
            camera = Workspace.CurrentCamera
            if camera then camera.FieldOfView = value end
        elseif name == "Crosshair" then
            updateCrosshair()
        elseif name == "FullBright" then
            applyFullBright(value)
        elseif name == "NoFog" then
            applyNoFog(value)
        elseif name == "EspEnabled" then
            if value then
                task.spawn(refreshRoles)
                updatePlayers()
            else
                removeAllPlayerVisuals()
            end
        elseif name == "DroppedGun" then
            if value then scanGunDrops() else removeAllGunVisuals() end
        elseif name == "ShowCoins" then
            if value then scanCoinVisuals() else removeAllCoinVisuals() end
        elseif name == "XRay" then
            updateCoinDepthModes()
            if settings.EspEnabled then
                updatePlayers()
            end
        elseif settings.EspEnabled then
            updatePlayers()
        end
    end

    function runtime:Destroy()
        if destroyed then return end
        destroyed = true
        removeAllPlayerVisuals()
        removeAllGunVisuals()
        removeAllCoinVisuals()
        applyFullBright(false)
        applyNoFog(false)
        camera = Workspace.CurrentCamera
        if camera then camera.FieldOfView = originalFov end
        for _, connection in ipairs(connections) do pcall(function() connection:Disconnect() end) end
        connections = {}
        destroy(overlay)
        if _G.__HMENU_VISUAL_CLEANUP == cleanupFunction then _G.__HMENU_VISUAL_CLEANUP = nil end
    end

    cleanupFunction = function() runtime:Destroy() end
    _G.__HMENU_VISUAL_CLEANUP = cleanupFunction
    return runtime
end

return Visuals
end
-- END runtime/Visuals.lua

local Bundle = {
    Version = tostring(rawget(_G, "__HMENU_RELEASE_VERSION") or "unknown"),
    ModuleCount = 24,
}

local function createImporter()
    local cache = {}
    local loaded = {}
    local loading = {}

    return function(path)
        if loaded[path] then return cache[path] end
        local factory = __modules[path]
        if type(factory) ~= "function" then
            error("Modulo nao incluido no bundle: " .. tostring(path), 0)
        end
        if loading[path] then
            error("Dependencia circular ao importar: " .. tostring(path), 0)
        end

        loading[path] = true
        local ok, result = pcall(factory)
        loading[path] = nil
        if not ok then
            error("Falha no modulo " .. tostring(path) .. ": " .. tostring(result), 0)
        end
        if result == nil then
            error("O modulo " .. tostring(path) .. " nao retornou um valor", 0)
        end

        cache[path] = result
        loaded[path] = true
        return result
    end
end

function Bundle:Validate()
    local import = createImporter()
    local schema = import("HMenuSchema.lua")
    local config = import("HMenuConfig.lua")
    schema.ValidateConfig(config)
    local categoryIds = {}
    local controlIds = {}
    local runtimePaths = {}
    for _, path in ipairs(config.CategoryModules) do
        schema.RequireModulePath(path, "Config.CategoryModules[]")
        local category = import(path)
        schema.ValidateCategory(category, path, categoryIds, controlIds)
        if category.RuntimeModule then runtimePaths[category.RuntimeModule] = true end
    end
    if not categoryIds[config.DefaultCategory] then
        error("DefaultCategory nao esta registrada: " .. tostring(config.DefaultCategory), 0)
    end
    local runtimeCount = 0
    for path in pairs(runtimePaths) do
        local runtimeModule = import(path)
        if type(runtimeModule) ~= "table" or type(runtimeModule.Create) ~= "function" then
            error(path .. " deve expor Create", 0)
        end
        runtimeCount = runtimeCount + 1
    end
    local controlCount = 0
    for _ in pairs(controlIds) do controlCount = controlCount + 1 end
    return { Categories = #config.CategoryModules, Controls = controlCount, Runtimes = runtimeCount }
end

function Bundle:Create(options)
    options = options or {}
    local resolvedOptions = {}
    for key, value in pairs(options) do resolvedOptions[key] = value end
    resolvedOptions.Import = createImporter()
    local menu = resolvedOptions.Import("HMenu.lua")
    if type(menu) ~= "table" or type(menu.Create) ~= "function" then
        error("HMenu.lua nao expoe uma funcao Create", 0)
    end
    return menu:Create(resolvedOptions)
end

return Bundle
