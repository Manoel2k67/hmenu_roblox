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
