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
    local Config = options.Import("HMenuConfig.lua")
    local Theme = Config.Theme
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
    for _, path in ipairs(Config.CategoryModules) do
        local ok, category = pcall(options.Import, path)
        if ok and type(category) == "table" then
            table.insert(categories, category)
        else
            warn("[HMenu] Categoria ignorada:", path, category)
        end
    end
    assert(#categories > 0, "No HMenu categories were loaded")

    if type(_G.__HMENU_CLEANUP) == "function" then pcall(_G.__HMENU_CLEANUP) end
    local connections = {}
    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local previous = Parent:FindFirstChild(Config.GuiName)
    if previous then previous:Destroy() end
    local gui = make("ScreenGui", {
        Name = Config.GuiName, ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 998,
    }, Parent)
    if type(protect_gui) == "function" then pcall(protect_gui, gui) end

    local runtimes = {}
    for _, category in ipairs(categories) do
        if category.RuntimeModule then
            local ok, runtimeModule = pcall(options.Import, category.RuntimeModule)
            if ok and type(runtimeModule) == "table" and type(runtimeModule.Create) == "function" then
                local runtimeOk, runtime = pcall(function()
                    return runtimeModule:Create({ Parent = Parent })
                end)
                if runtimeOk and runtime then
                    table.insert(runtimes, runtime)
                    for _, section in ipairs(category.Sections or {}) do
                        for _, control in ipairs(section.Controls or {}) do
                            if control.OptionsSource and type(runtime.GetOptions) == "function" then
                                local optionsSource = control.OptionsSource
                                control.Options = function()
                                    return runtime:GetOptions(optionsSource)
                                end
                            end
                            if control.Setting then
                                local previousCallback = control.Callback
                                control.Callback = function(value, state)
                                    runtime:Set(control.Setting, value)
                                    if type(previousCallback) == "function" then
                                        previousCallback(value, state)
                                    end
                                end
                            end
                        end
                    end
                else
                    warn("[HMenu] Runtime não iniciado:", category.RuntimeModule, runtime)
                end
            else
                warn("[HMenu] Runtime não carregado:", category.RuntimeModule, runtimeModule)
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
    make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 58, 96)),
            ColorSequenceKeypoint.new(1, Theme.WindowDark),
        }), Rotation = 135,
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
        BackgroundTransparency = 0.22, BorderSizePixel = 0, Active = true,
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
        BackgroundColor3 = Theme.Sidebar, BackgroundTransparency = 0.24, BorderSizePixel = 0,
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
        BackgroundTransparency = 1, BorderSizePixel = 0,
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

    local function fire(control, value)
        state[control.Id or control.Label] = value
        if type(control.Callback) == "function" then
            local ok, err = pcall(control.Callback, value, state)
            if not ok then warn("[HMenu] Callback error:", err) end
        end
    end

    local function createToggle(parent, control, row)
        local saved = state[control.Id or control.Label]
        local enabled = saved == true
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
        connect(hit.MouseButton1Click, function()
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
        connect(hit.InputBegan, function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(inputObject.Position.X)
            end
        end)
        connect(UserInputService.InputChanged, function(inputObject)
            if dragging and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
                update(inputObject.Position.X)
            end
        end)
        connect(UserInputService.InputEnded, function(inputObject)
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
        connect(button.MouseButton1Click, function()
            local current = choices[index]
            choices = readChoices()
            index = table.find(choices, current) or 0
            index = index % #choices + 1
            button.Text = tostring(choices[index]) .. "  v"
            fire(control, choices[index])
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
        connect(button.MouseButton1Click, function()
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
        connect(row.MouseEnter, function()
            TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.08 }):Play()
        end)
        connect(row.MouseLeave, function()
            TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.17 }):Play()
        end)
        return row
    end

    local function clearPage()
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

    local cameraConnection
    local function updateScale()
        local camera = Workspace.CurrentCamera
        if not camera then return end
        local viewport = camera.ViewportSize
        local fit = math.min((viewport.X - Config.Window.Margin) / Config.Window.Width, (viewport.Y - Config.Window.Margin) / Config.Window.Height, 1)
        scale.Scale = math.max(fit, Config.Window.MinScale)
    end
    if Workspace.CurrentCamera then cameraConnection = connect(Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), updateScale) end
    updateScale()

    local function cleanup()
        for _, runtime in ipairs(runtimes) do
            if type(runtime.Destroy) == "function" then pcall(function() runtime:Destroy() end) end
        end
        runtimes = {}
        for _, connection in ipairs(connections) do pcall(function() connection:Disconnect() end) end
        connections = {}
        if gui and gui.Parent then gui:Destroy() end
        if _G.__HMENU_CLEANUP == cleanup then _G.__HMENU_CLEANUP = nil end
    end
    _G.__HMENU_CLEANUP = cleanup

    print("[HMenu] Aberto. Use RightShift para ocultar ou mostrar.")
    return { Gui = gui, State = state, Destroy = cleanup, SetVisible = setVisible }
end

return HMenu
