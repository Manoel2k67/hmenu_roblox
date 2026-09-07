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
