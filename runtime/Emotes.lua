local Players = game:GetService("Players")

local Emotes = {}

function Emotes:Create()
    local runtime = {}
    local player = Players.LocalPlayer
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
        Dab = "dab",
        Floss = "floss",
        Zombie = "zombie",
        Headless = "headless",
    }

    local function humanoid()
        local character = player.Character
        return character and character:FindFirstChildOfClass("Humanoid")
    end

    local function playSelectedEmote()
        local currentHumanoid = humanoid()
        local emoteName = emoteNames[settings.SelectedEmote]
        if not currentHumanoid or not emoteName then
            return false
        end

        local success, played = pcall(function()
            return currentHumanoid:PlayEmote(emoteName)
        end)
        if not success or played == false then
            warn("[H Menu] Emote não disponível neste jogo:", settings.SelectedEmote)
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
