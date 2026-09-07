local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local KEY_VALIDATES_ANY = true
local DISCORD_LINK = "https://discord.gg/seulink"
local SCRIPT_URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"
local LOAD_MAIN_SCRIPT = false
local H_MENU_FILE = "HMenu.lua"

local function destroyExistingGui()
    for _, parent in ipairs({playerGui, CoreGui}) do
        local existing = parent:FindFirstChild("SimpleKeySystem")
        if existing then
            existing:Destroy()
        end
    end
end

destroyExistingGui()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleKeySystem"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.45
background.BorderSizePixel = 0
background.Parent = screenGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 380, 0, 260)
main.Position = UDim2.new(0.5, -190, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 50, 50)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = main

local function createLabel(text, size, position, color, font, textSize)
    local object = Instance.new("TextLabel")
    object.Size = size
    object.Position = position
    object.BackgroundTransparency = 1
    object.Text = text
    object.TextColor3 = color
    object.Font = font
    object.TextSize = textSize
    object.Parent = main
    return object
end

createLabel("KEY SYSTEM", UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 15),
    Color3.fromRGB(255, 70, 70), Enum.Font.GothamBold, 18)
createLabel("Insira sua chave para continuar", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, 50),
    Color3.fromRGB(200, 200, 200), Enum.Font.Gotham, 14)

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -40, 0, 40)
textBox.Position = UDim2.new(0, 20, 0, 95)
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
textBox.Text = ""
textBox.PlaceholderText = "Cole sua chave aqui..."
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.ClearTextOnFocus = false
textBox.Parent = main

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 8)
textBoxCorner.Parent = textBox

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(1, -40, 0, 42)
submitButton.Position = UDim2.new(0, 20, 0, 150)
submitButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
submitButton.Text = "Inserir Chave"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 15
submitButton.Parent = main

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitButton

local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(1, -40, 0, 32)
getKeyButton.Position = UDim2.new(0, 20, 0, 205)
getKeyButton.BackgroundTransparency = 1
getKeyButton.Text = "Pegue sua chave aqui"
getKeyButton.TextColor3 = Color3.fromRGB(100, 160, 255)
getKeyButton.Font = Enum.Font.Gotham
getKeyButton.TextSize = 13
getKeyButton.Parent = main

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 1, -28)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Parent = main

local function validateKey(key)
    if KEY_VALIDATES_ANY then
        return true
    end
    return false
end

local function loadHMenu()
    local success, result = pcall(function()
        return loadstring(readfile(H_MENU_FILE))()
    end)
    if not success then
        warn("[H Menu] Falha ao carregar HMenu.lua:", result)
        statusLabel.Text = "Erro ao carregar o H Menu"
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end
    result:Create()
end

local function loadMainScript()
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)
    if not success then
        warn("[Key System] Erro ao carregar script:", errorMessage)
        statusLabel.Text = "Erro ao carregar o script"
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end

submitButton.MouseButton1Click:Connect(function()
    local key = textBox.Text:gsub("%s+", "")
    if key == "" then
        statusLabel.Text = "Digite uma chave"
        statusLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
        return
    end

    statusLabel.Text = "Verificando..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    task.wait(0.4)

    if validateKey(key) then
        statusLabel.Text = "Chave válida! Carregando..."
        statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        task.wait(0.6)
        screenGui:Destroy()
        loadHMenu()
        if LOAD_MAIN_SCRIPT then
            loadMainScript()
        end
    else
        statusLabel.Text = "Chave inválida"
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

getKeyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        statusLabel.Text = "Link copiado! Cole no navegador"
        statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    else
        statusLabel.Text = "Abra: " .. DISCORD_LINK
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        screenGui:Destroy()
    end
end)

print("[Key System] Carregado - qualquer chave funciona por enquanto")
