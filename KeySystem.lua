-- HMenu bootstrap. Public entry point:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/KeySystem.lua", true))()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local BUNDLE_PATH = "dist/HMenu.bundle.lua"
local REPOSITORIES = {
    "https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/",
    "https://cdn.jsdelivr.net/gh/Manoel2k67/hmenu_roblox@main/",
}
local CACHE_BUST = tostring(os.time())
local function downloadReleaseVersion()
    for _, repository in ipairs(REPOSITORIES) do
        local ok, response = pcall(function()
            return game:HttpGet(repository .. "VERSION?cacheBust=" .. CACHE_BUST, true)
        end)
        if ok and type(response) == "string" then
            local version = response:match("^%s*(%d+%.%d+%.%d+)%s*$")
            if version then return version end
        end
    end
    error("não foi possível baixar VERSION do HMenu", 0)
end
local RELEASE_VERSION = downloadReleaseVersion()
_G.__HMENU_RELEASE_VERSION = RELEASE_VERSION
local MAX_DOWNLOAD_ATTEMPTS = 4
local RETRY_BASE_DELAY = 0.75
local GUI_NAME = "HMenuKeySystem"
local LICENSE_API_URL = "https://m2kscripts-backend.onrender.com/api/licenses/validate"
local PRODUCT_SLUG = "script-murder-mistery-2"
local LICENSE_API_CONFIGURED = LICENSE_API_URL:match("^https://") ~= nil
local GET_KEY_URL = nil -- Configure an HTTPS community/key URL before production.
local HAS_KEY_URL = type(GET_KEY_URL) == "string" and string.match(GET_KEY_URL, "^https://") ~= nil

if type(_G.__HMENU_KEY_CLEANUP) == "function" then
    pcall(_G.__HMENU_KEY_CLEANUP)
end
if type(_G.__HMENU_CLEANUP) == "function" then
    pcall(_G.__HMENU_CLEANUP)
end

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
    BackgroundTransparency = 1, Text = "HMenu  |  Access v" .. RELEASE_VERSION,
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
    BorderSizePixel = 0, ClearTextOnFocus = false,     PlaceholderText = "Cole a chave recebida no site...",
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
    TextSize = 11, AutoButtonColor = false, Visible = HAS_KEY_URL,
}, window)
local status = new("TextLabel", {
    Size = HAS_KEY_URL and UDim2.new(1, -190, 0, 25) or UDim2.new(1, -44, 0, 25),
    Position = HAS_KEY_URL and UDim2.new(0, 169, 0, 239) or UDim2.fromOffset(22, 239),
    BackgroundTransparency = 1, Text = "A chave será validada online",
    TextColor3 = Color3.fromRGB(128, 145, 178), Font = Enum.Font.Gotham,
    TextSize = 10, TextXAlignment = HAS_KEY_URL and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center,
}, window)

local busy = false
local function validKey(value)
    value = value:match("^%s*(.-)%s*$")
    return value ~= "" and #value >= 20
end

local function getHttpRequest()
    if type(syn) == "table" and type(syn.request) == "function" then return syn.request end
    if type(request) == "function" then return request end
    if type(http_request) == "function" then return http_request end
    if type(http) == "table" and type(http.request) == "function" then return http.request end
    return nil
end

local function validateLicense(key)
    if not LICENSE_API_CONFIGURED then
        return false, "configure a URL pública da API"
    end

    local requestFunction = getHttpRequest()
    if not requestFunction then
        return false, "executor sem suporte a requisições HTTPS POST"
    end

    local body = HttpService:JSONEncode({
        key = key:match("^%s*(.-)%s*$"),
        productSlug = PRODUCT_SLUG,
        deviceId = "roblox-user-" .. tostring(Players.LocalPlayer.UserId),
    })
    local ok, response = pcall(requestFunction, {
        Url = LICENSE_API_URL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = body,
    })
    if not ok or type(response) ~= "table" then
        return false, "não foi possível conectar à API"
    end

    local statusCode = tonumber(response.StatusCode or response.Status)
    if statusCode and (statusCode < 200 or statusCode >= 300) then
        return false, "API recusou a validação (" .. tostring(statusCode) .. ")"
    end

    local responseBody = response.Body or response.body
    local decodedOk, result = pcall(HttpService.JSONDecode, HttpService, responseBody or "")
    if not decodedOk or type(result) ~= "table" then
        return false, "resposta inválida da API"
    end
    if result.valid ~= true then
        local reasons = {
            invalid_request = "dados inválidos",
            invalid_key = "chave inválida",
            disabled = "licença desativada",
            expired = "licença expirada",
            device_mismatch = "chave vinculada a outro usuário",
        }
        return false, reasons[result.reason] or "chave não autorizada"
    end
    return true
end

local function payloadError(source)
    if type(source) ~= "string" or #source == 0 then
        return "resposta vazia"
    end

    if string.sub(source, 1, 3) == "\239\187\191" then
        source = string.sub(source, 4)
    end

    local prefix = string.lower(string.sub(source, 1, 512))
    local firstCharacter = string.match(source, "^%s*(.)")
    if firstCharacter == "<" or string.find(prefix, "<!doctype", 1, true)
        or string.find(prefix, "<html", 1, true) then
        return "servidor retornou HTML em vez de Lua"
    end
    if string.find(prefix, "backend.max_conn", 1, true) then
        return "servidor temporariamente sobrecarregado"
    end
    return nil, source
end

local function downloadBundle(onAttempt)
    if type(loadstring) ~= "function" then
        error("este executor não disponibiliza loadstring", 0)
    end

    local lastError = "falha de rede desconhecida"
    for attempt = 1, MAX_DOWNLOAD_ATTEMPTS do
        for _, repository in ipairs(REPOSITORIES) do
            if onAttempt then onAttempt(attempt) end
            local url = repository .. BUNDLE_PATH
                .. "?v=" .. RELEASE_VERSION .. "&cacheBust=" .. CACHE_BUST
            local requestOk, response = pcall(function()
                return game:HttpGet(url, true)
            end)

            if requestOk then
                local responseError, source = payloadError(response)
                if not responseError then
                    local chunk, compileError = loadstring(source, "@HMenu/" .. BUNDLE_PATH)
                    if chunk then
                        local bundleOk, bundle = pcall(chunk)
                        if bundleOk and type(bundle) == "table"
                            and bundle.Version == RELEASE_VERSION
                            and type(bundle.Create) == "function" then
                            return function() return bundle end, repository
                        end
                        lastError = "bundle desatualizado ou inválido"
                    else
                        lastError = "bundle inválido: " .. tostring(compileError)
                    end
                else
                    lastError = responseError
                end
            else
                lastError = tostring(response)
            end
        end

        if attempt < MAX_DOWNLOAD_ATTEMPTS then
            task.wait(RETRY_BASE_DELAY * (2 ^ (attempt - 1)))
        end
    end

    error("não foi possível baixar o HMenu após " .. tostring(MAX_DOWNLOAD_ATTEMPTS)
        .. " tentativas: " .. lastError, 0)
end

local function setStatus(message, color)
    if status and status.Parent then
        status.Text, status.TextColor3 = message, color
    end
end

local connections = {}
local destroyed = false
local cleanupFunction
local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

local function cleanup()
    if destroyed then return end
    destroyed = true
    for _, connection in ipairs(connections) do
        pcall(function() connection:Disconnect() end)
    end
    connections = {}
    if gui and gui.Parent then gui:Destroy() end
    if _G.__HMENU_KEY_CLEANUP == cleanupFunction then
        _G.__HMENU_KEY_CLEANUP = nil
    end
end
cleanupFunction = cleanup
_G.__HMENU_KEY_CLEANUP = cleanupFunction

local function openMenu()
    if busy or destroyed then return end
    if not validKey(input.Text) then
        setStatus("Digite uma chave", Color3.fromRGB(255, 177, 98))
        return
    end
    busy = true
    submit.Text = "Carregando..."
    setStatus("Validando licença...", Color3.fromRGB(105, 221, 160))
    local licenseOk, licenseError = validateLicense(input.Text)
    if not licenseOk then
        submit.Text, busy = "Validar e abrir", false
        setStatus(licenseError, Color3.fromRGB(255, 177, 98))
        return
    end
    setStatus("Licença aprovada. Preparando download...", Color3.fromRGB(105, 221, 160))
    local cleanupBeforeAttempt = rawget(_G, "__HMENU_CLEANUP")
    local ok, result = pcall(function()
        local chunk = downloadBundle(function()
            setStatus("Baixando menu...", Color3.fromRGB(130, 168, 242))
        end)
        local bundle = chunk()
        assert(type(bundle) == "table" and type(bundle.Create) == "function",
            "o bundle baixado não expõe uma função Create")
        setStatus("Inicializando menu...", Color3.fromRGB(105, 221, 160))
        return bundle:Create({
            Parent = guiParent,
            AssetBaseUrls = REPOSITORIES,
            AssetVersion = RELEASE_VERSION,
        })
    end)
    if not ok then
        local partialCleanup = rawget(_G, "__HMENU_CLEANUP")
        if type(partialCleanup) == "function" and partialCleanup ~= cleanupBeforeAttempt then
            pcall(partialCleanup)
        end
        warn("[HMenu] Não foi possível abrir o menu:", result)
        submit.Text, busy = "Tentar novamente", false
        setStatus("Falha ao carregar. Tente novamente.", Color3.fromRGB(255, 113, 122))
        return
    end
    cleanup()
end

connect(submit.MouseButton1Click, openMenu)
connect(input.FocusLost, function(enterPressed) if enterPressed then openMenu() end end)
connect(close.MouseButton1Click, cleanup)
connect(getKey.MouseButton1Click, function()
    if not HAS_KEY_URL then return end
    if type(setclipboard) == "function" then
        setclipboard(GET_KEY_URL)
        setStatus("Link copiado", Color3.fromRGB(105, 221, 160))
    else
        setStatus(GET_KEY_URL, Color3.fromRGB(130, 168, 242))
    end
end)
connect(submit.MouseEnter, function()
    TweenService:Create(submit, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(108, 153, 239) }):Play()
end)
connect(submit.MouseLeave, function()
    TweenService:Create(submit, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(90, 137, 231) }):Play()
end)
connect(UserInputService.InputBegan, function(key, processed)
    if not processed and key.KeyCode == Enum.KeyCode.Escape then cleanup() end
end)
task.defer(function()
    if not destroyed and input.Parent then input:CaptureFocus() end
end)
print("[HMenu] KeySystem v" .. RELEASE_VERSION .. " pronto (validação online ativa)")
