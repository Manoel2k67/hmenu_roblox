local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Config = loadstring(readfile("HMenuConfig.lua"))()

local HMenu = {}
local connections = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

local function corner(instance, radius)
    local object = Instance.new("UICorner")
    object.CornerRadius = UDim.new(0, radius)
    object.Parent = instance
    return object
end

local function label(parent, text, size, position, color, font, textSize)
    local object = Instance.new("TextLabel")
    object.Size = size
    object.Position = position
    object.BackgroundTransparency = 1
    object.Text = text
    object.TextColor3 = color
    object.Font = font
    object.TextSize = textSize
    object.TextXAlignment = Enum.TextXAlignment.Left
    object.Parent = parent
    return object
end

local function padding(instance, value)
    local object = Instance.new("UIPadding")
    object.PaddingLeft = UDim.new(0, value)
    object.PaddingRight = UDim.new(0, value)
    object.Parent = instance
end

local function clearCards(container)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

function HMenu:Destroy()
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
    connections = {}

    local existing = PlayerGui:FindFirstChild(Config.GuiName)
    if existing then
        existing:Destroy()
    end
end

function HMenu:CreateCard(container, data)
    local title, description, value, colorName = data[1], data[2], data[3], data[4]
    local theme = Config.Theme

    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 82)
    card.BackgroundColor3 = theme.Surface
    card.BorderSizePixel = 0
    card.Parent = container
    corner(card, 10)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 1, -20)
    accent.Position = UDim2.new(0, 0, 0, 10)
    accent.BackgroundColor3 = Config.StatusColors[colorName] or theme.Accent
    accent.BorderSizePixel = 0
    accent.Parent = card
    corner(accent, 2)

    label(card, title, UDim2.new(1, -145, 0, 23), UDim2.new(0, 20, 0, 15),
        theme.Text, Enum.Font.GothamBold, 14)
    label(card, description, UDim2.new(1, -145, 0, 20), UDim2.new(0, 20, 0, 42),
        theme.MutedText, Enum.Font.Gotham, 11)

    local status = label(card, value, UDim2.new(0, 105, 0, 24), UDim2.new(1, -120, 0, 28),
        Config.StatusColors[colorName] or theme.Accent, Enum.Font.GothamBold, 12)
    status.TextXAlignment = Enum.TextXAlignment.Right
end

function HMenu:RenderPage(page, titleObject, subtitleObject, cardContainer)
    titleObject.Text = page.Label
    subtitleObject.Text = page.Subtitle
    clearCards(cardContainer)

    for _, cardData in ipairs(page.Cards) do
        self:CreateCard(cardContainer, cardData)
    end
end

function HMenu:CreateCategoryButton(parent, page, onSelected)
    local theme = Config.Theme
    local button = Instance.new("TextButton")
    button.Name = page.Id .. "Button"
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = theme.Sidebar
    button.BorderSizePixel = 0
    button.Text = page.Label
    button.TextColor3 = Color3.fromRGB(148, 151, 163)
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 12
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.Parent = parent
    padding(button, 12)
    corner(button, 8)

    connect(button.MouseButton1Click, function()
        onSelected(button, page)
    end)
    return button
end

function HMenu:Create()
    self:Destroy()
    local theme = Config.Theme

    local gui = Instance.new("ScreenGui")
    gui.Name = Config.GuiName
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = PlayerGui

    local root = Instance.new("Frame")
    root.Name = "Window"
    root.Size = UDim2.new(0, 720, 0, 440)
    root.Position = UDim2.new(0.5, -360, 0.5, -220)
    root.BackgroundColor3 = theme.Background
    root.BorderSizePixel = 0
    root.Parent = gui
    corner(root, 14)

    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Thickness = 1
    stroke.Parent = root

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 190, 1, 0)
    sidebar.BackgroundColor3 = theme.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Parent = root
    corner(sidebar, 14)

    local sidebarMask = Instance.new("Frame")
    sidebarMask.Size = UDim2.new(0, 14, 1, 0)
    sidebarMask.Position = UDim2.new(1, -14, 0, 0)
    sidebarMask.BackgroundColor3 = theme.Sidebar
    sidebarMask.BorderSizePixel = 0
    sidebarMask.Parent = sidebar

    label(sidebar, "H MENU", UDim2.new(1, -36, 0, 28), UDim2.new(0, 20, 0, 22),
        theme.Accent, Enum.Font.GothamBold, 20)
    label(sidebar, "CONTROL PANEL", UDim2.new(1, -36, 0, 18), UDim2.new(0, 20, 0, 49),
        Color3.fromRGB(120, 123, 135), Enum.Font.Gotham, 10)

    local categoryList = Instance.new("Frame")
    categoryList.Name = "Categories"
    categoryList.Size = UDim2.new(1, -24, 1, -115)
    categoryList.Position = UDim2.new(0, 12, 0, 92)
    categoryList.BackgroundTransparency = 1
    categoryList.Parent = sidebar

    local categoryLayout = Instance.new("UIListLayout")
    categoryLayout.Padding = UDim.new(0, 6)
    categoryLayout.Parent = categoryList

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -215, 1, -30)
    content.Position = UDim2.new(0, 205, 0, 15)
    content.BackgroundTransparency = 1
    content.Parent = root

    local titleObject = label(content, "Dashboard", UDim2.new(1, -70, 0, 30), UDim2.new(0, 0, 0, 5),
        theme.Text, Enum.Font.GothamBold, 23)
    local subtitleObject = label(content, "", UDim2.new(1, -20, 0, 20), UDim2.new(0, 0, 0, 37),
        theme.MutedText, Enum.Font.Gotham, 12)

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "Close"
    closeButton.Size = UDim2.new(0, 34, 0, 34)
    closeButton.Position = UDim2.new(1, -34, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(39, 23, 29)
    closeButton.Text = "X"
    closeButton.TextColor3 = theme.AccentSoft
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = content
    corner(closeButton, 9)

    local cardContainer = Instance.new("Frame")
    cardContainer.Name = "Cards"
    cardContainer.Size = UDim2.new(1, 0, 1, -82)
    cardContainer.Position = UDim2.new(0, 0, 0, 82)
    cardContainer.BackgroundTransparency = 1
    cardContainer.Parent = content

    local cardLayout = Instance.new("UIListLayout")
    cardLayout.Padding = UDim.new(0, 10)
    cardLayout.Parent = cardContainer

    local activeButton
    local function select(button, page)
        if activeButton then
            activeButton.BackgroundColor3 = theme.Sidebar
            activeButton.TextColor3 = Color3.fromRGB(148, 151, 163)
        end
        activeButton = button
        button.BackgroundColor3 = theme.SurfaceActive
        button.TextColor3 = theme.AccentSoft
        self:RenderPage(page, titleObject, subtitleObject, cardContainer)
    end

    for _, page in ipairs(Config.Categories) do
        local button = self:CreateCategoryButton(categoryList, page, select)
        if not activeButton then
            select(button, page)
        end
    end

    connect(closeButton.MouseButton1Click, function()
        root.Visible = false
    end)

    connect(UserInputService.InputBegan, function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Config.ToggleKey then
            root.Visible = not root.Visible
        end
    end)

    return gui
end

return HMenu
