local PlaceId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local Repo = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/refs/heads/main/"

local SupportedGames = {
    [79546208627805] = "Games/99Nights.lua",
    [109983668079237] = "Games/StealABrainrot.lua",
    [121864768012064] = "Games/FishIt.lua",
    [127742093697776] = "Games/PlantsVsBrainrots.lua"
}

local UniversalScript = "Unsupported%20Game.lua"

local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
        Icon = "rbxassetid://11697668826"
    })
end

local function LoadScript(ScriptPath)
    local Url = Repo .. ScriptPath
    
    local Success, Content = pcall(function()
        return game:HttpGet(Url)
    end)

    if not Success then
        Notify("Connection Error", "Failed to fetch script.")
        return
    end

    local Func, LoadErr = loadstring(Content)
    
    if not Func then
        Notify("Syntax Error", "Script loaded but failed to compile.")
        return
    end

    task.spawn(Func)
end

Notify("TiRex Hub", "Checking Game ID: " .. tostring(PlaceId))

if SupportedGames[PlaceId] then
    Notify("TiRex Hub", "Game Detected! Loading Module...")
    LoadScript(SupportedGames[PlaceId])
else
    Notify("TiRex Hub", "Loading Universal Fallback... (Unsupported game)")
    LoadScript(UniversalScript)
end
