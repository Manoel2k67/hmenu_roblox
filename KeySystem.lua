-- HMenu bootstrap. Public entry point:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/KeySystem.lua"))()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local REPOSITORY = "https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/"
local GUI_NAME = "HMenuKeySystem"
local ACCEPT_ANY_NON_EMPTY_KEY = true -- Temporary mock validation.
local VALID_KEYS = { "HMENU-DEMO" }
local GET_KEY_URL = "https://discord.gg/seulink"

local function resolveGuiParent()
    if type(gethui) == "function" then
        local ok, result = pcall(gethui)
        if ok and result then return result end
    end
    local ok = pcall(function() return CoreGui.Name end)
    return ok and CoreGui or Players.LocalPlayer:WaitForChild("PlayerGui")
end

local guiParent = resolveGuiParent()
local oldGui = guiParent:FindFirstChild(GUI_NAME)
if oldGui then oldGui:Destroy() end

local function new(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do object[key] = value end
    object.Parent = parent
    return object
end

local function round(parent, radius)
    return new("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function stroke(parent, color, transparency)
    return new("UIStroke", { Color = color, Thickness = 1, Transparency = transparency or 0 }, parent)
end

local gui = new("ScreenGui", {
    Name = GUI_NAME, ResetOnSpawn = false, IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999,
}, guiParent)
if type(protect_gui) == "function" then pcall(protect_gui, gui) end

local overlay = new("Frame", {
    Name = "Overlay", Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(4, 7, 14), BackgroundTransparency = 0.32,
    BorderSizePixel = 0,
}, gui)

local window = new("Frame", {
    Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(410, 276),
    BackgroundColor3 = Color3.fromRGB(24, 35, 60), BackgroundTransparency = 0.08,
    BorderSizePixel = 0, ClipsDescendants = true,
}, overlay)
round(window, 12)
stroke(window, Color3.fromRGB(84, 118, 180), 0.35)
new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 48, 82)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 25, 45)),
    }), Rotation = 120,
}, window)

new("TextLabel", {
    Size = UDim2.new(1, -62, 0, 28), Position = UDim2.fromOffset(22, 17),
    BackgroundTransparency = 1, Text = "HMenu  |  Access",
    TextColor3 = Color3.fromRGB(239, 244, 255), Font = Enum.Font.GothamMedium,
    TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left,
}, window)
local close = new("TextButton", {
    Size = UDim2.fromOffset(30, 30), Position = UDim2.new(1, -42, 0, 12),
    BackgroundTransparency = 1, Text = "X", TextColor3 = Color3.fromRGB(182, 194, 220),
    Font = Enum.Font.Gotham, TextSize = 14, AutoButtonColor = false,
}, window)
new("Frame", {
    Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromOffset(0, 55),
    BackgroundColor3 = Color3.fromRGB(92, 121, 177), BackgroundTransparency = 0.72,
    BorderSizePixel = 0,
}, window)
new("TextLabel", {
    Size = UDim2.new(1, -44, 0, 28), Position = UDim2.fromOffset(22, 73),
    BackgroundTransparency = 1, Text = "Bem-vindo", TextColor3 = Color3.fromRGB(245, 248, 255),
    Font = Enum.Font.GothamBold, TextSize = 21, TextXAlignment = Enum.TextXAlignment.Left,
}, window)
new("TextLabel", {
    Size = UDim2.new(1, -44, 0, 20), Position = UDim2.fromOffset(22, 103),
    BackgroundTransparency = 1, Text = "Insira uma chave para abrir o painel.",
    TextColor3 = Color3.fromRGB(159, 175, 207), Font = Enum.Font.Gotham,
    TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
}, window)

local input = new("TextBox", {
    Size = UDim2.new(1, -44, 0, 42), Position = UDim2.fromOffset(22, 136),
    BackgroundColor3 = Color3.fromRGB(19, 31, 55), BackgroundTransparency = 0.12,
    BorderSizePixel = 0, ClearTextOnFocus = false, PlaceholderText = "Digite qualquer chave...",
    PlaceholderColor3 = Color3.fromRGB(115, 133, 170), Text = "",
    TextColor3 = Color3.fromRGB(235, 241, 255), Font = Enum.Font.Gotham,
    TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
}, window)
round(input, 7)
stroke(input, Color3.fromRGB(83, 112, 169), 0.48)
new("UIPadding", { PaddingLeft = UDim.new(0, 13), PaddingRight = UDim.new(0, 13) }, input)

local submit = new("TextButton", {
    Size = UDim2.new(1, -44, 0, 40), Position = UDim2.fromOffset(22, 190),
    BackgroundColor3 = Color3.fromRGB(90, 137, 231), BorderSizePixel = 0,
    Text = "Validar e abrir", TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold, TextSize = 13, AutoButtonColor = false,
}, window)
round(submit, 7)
local getKey = new("TextButton", {
    Size = UDim2.fromOffset(150, 25), Position = UDim2.fromOffset(17, 239),
    BackgroundTransparency = 1, Text = "Obter chave / comunidade",
    TextColor3 = Color3.fromRGB(130, 168, 242), Font = Enum.Font.Gotham,
    TextSize = 11, AutoButtonColor = false,
}, window)
local status = new("TextLabel", {
    Size = UDim2.new(1, -190, 0, 25), Position = UDim2.new(0, 169, 0, 239),
    BackgroundTransparency = 1, Text = "Qualquer chave funciona no modo demo",
    TextColor3 = Color3.fromRGB(128, 145, 178), Font = Enum.Font.Gotham,
    TextSize = 10, TextXAlignment = Enum.TextXAlignment.Right,
}, window)

local busy = false
local function validKey(value)
    value = value:match("^%s*(.-)%s*$")
    if value == "" then return false end
    if ACCEPT_ANY_NON_EMPTY_KEY then return true end
    for _, allowed in ipairs(VALID_KEYS) do
        if value == allowed then return true end
    end
    return false
end

local function import(path)
    local source = game:HttpGet(REPOSITORY .. path, true)
    local chunk, compileError = loadstring(source, "@HMenu/" .. path)
    assert(chunk, compileError)
    return chunk()
end

local function setStatus(message, color)
    status.Text, status.TextColor3 = message, color
end

local function openMenu()
    if busy then return end
    if not validKey(input.Text) then
        setStatus("Digite uma chave", Color3.fromRGB(255, 177, 98))
        return
    end
    busy = true
    submit.Text = "Carregando..."
    setStatus("Chave válida", Color3.fromRGB(105, 221, 160))
    local ok, result = pcall(function()
        local menu = import("HMenu.lua")
        return menu:Create({ BaseUrl = REPOSITORY, Import = import, Parent = guiParent })
    end)
    if not ok then
        warn("[HMenu] Não foi possível abrir o menu:", result)
        submit.Text, busy = "Tentar novamente", false
        setStatus("Erro ao carregar; veja o console", Color3.fromRGB(255, 113, 122))
        return
    end
    gui:Destroy()
end

submit.MouseButton1Click:Connect(openMenu)
input.FocusLost:Connect(function(enterPressed) if enterPressed then openMenu() end end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)
getKey.MouseButton1Click:Connect(function()
    if type(setclipboard) == "function" then
        setclipboard(GET_KEY_URL)
        setStatus("Link copiado", Color3.fromRGB(105, 221, 160))
    else
        setStatus(GET_KEY_URL, Color3.fromRGB(130, 168, 242))
    end
end)
submit.MouseEnter:Connect(function()
    TweenService:Create(submit, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(108, 153, 239) }):Play()
end)
submit.MouseLeave:Connect(function()
    TweenService:Create(submit, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(90, 137, 231) }):Play()
end)
UserInputService.InputBegan:Connect(function(key, processed)
    if not processed and key.KeyCode == Enum.KeyCode.Escape and gui.Parent then gui:Destroy() end
end)
task.defer(function() input:CaptureFocus() end)
print("[HMenu] KeySystem pronto (validação demo ativa)")
