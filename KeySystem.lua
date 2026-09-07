-- Key System simples - apenas para estudo / seus jogos
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ====================== CONFIG ======================
local KEY_VALIDA_QUALQUER = true          -- true = qualquer chave passa (por enquanto)
local DISCORD_LINK = "https://discord.gg/seulink"  -- coloque o seu
local SCRIPT_URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" -- exemplo, troque depois
-- ====================================================

-- Remove UI antiga se existir
if playerGui:FindFirstChild("SimpleKeySystem") then
    playerGui.SimpleKeySystem:Destroy()
end
if CoreGui:FindFirstChild("SimpleKeySystem") then
    CoreGui.SimpleKeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- Fundo escuro
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.45
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 380, 0, 260)
Main.Position = UDim2.new(0.5, -190, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 70, 70)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Main

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -20, 0, 25)
SubTitle.Position = UDim2.new(0, 10, 0, 50)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Insira sua chave para continuar"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = Main

-- Caixa de texto
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -40, 0, 40)
TextBox.Position = UDim2.new(0, 20, 0, 95)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TextBox.Text = ""
TextBox.PlaceholderText = "Cole sua chave aqui..."
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.ClearTextOnFocus = false
TextBox.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = TextBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(60, 60, 70)
BoxStroke.Thickness = 1
BoxStroke.Parent = TextBox

-- Botão Submit
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -40, 0, 42)
SubmitBtn.Position = UDim2.new(0, 20, 0, 150)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
SubmitBtn.Text = "Inserir Chave"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 15
SubmitBtn.Parent = Main

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

-- Botão Get Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(1, -40, 0, 32)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 205)
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.Text = "Pegue sua chave aqui"
GetKeyBtn.TextColor3 = Color3.fromRGB(100, 160, 255)
GetKeyBtn.Font = Enum.Font.Gotham
GetKeyBtn.TextSize = 13
GetKeyBtn.Parent = Main

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 1, -28)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = Main

-- Função de validação (por enquanto qualquer chave passa)
local function validarChave(chave)
    if KEY_VALIDA_QUALQUER then
        return true
    end
    
    -- Depois você troca por algo assim:
    -- local response = game:HttpGet("https://seusite.com/api/check?key=" .. chave)
    -- return response == "valid"
    
    return false
end

-- Carregar o script principal
local function carregarScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)
    
    if not success then
        warn("[Key System] Erro ao carregar script:", err)
        StatusLabel.Text = "Erro ao carregar o script"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end

-- Eventos
SubmitBtn.MouseButton1Click:Connect(function()
    local chave = TextBox.Text:gsub("%s+", "") -- remove espaços
    
    if chave == "" then
        StatusLabel.Text = "Digite uma chave"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
        return
    end
    
    StatusLabel.Text = "Verificando..."
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    task.wait(0.4)
    
    if validarChave(chave) then
        StatusLabel.Text = "Chave válida! Carregando..."
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        
        task.wait(0.6)
        ScreenGui:Destroy()
        carregarScript()
    else
        StatusLabel.Text = "Chave inválida"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        StatusLabel.Text = "Link copiado! Cole no navegador"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    else
        StatusLabel.Text = "Abra: " .. DISCORD_LINK
    end
end)

-- Fechar com ESC (opcional)
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.Escape then
        ScreenGui:Destroy()
    end
end)

print("[Key System] Carregado - qualquer chave funciona por enquanto")