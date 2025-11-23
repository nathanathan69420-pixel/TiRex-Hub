local PlaceId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local SupportedGames = {
    [79546208627805] = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/Games/99Nights.lua",
    [109983668079237] = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/Games/StealABrainrot.lua",
    [121864768012064] = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/Games/FishIt.lua",
    [127742093697776] = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/Games/PlantsVsBrainrots.lua"
}

local UniversalScript = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/refs/heads/main/Unsupported%20Game"

local function Notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
        Icon = "rbxassetid://11697668826"
    })
end

Notify("TiRex Hub", "Checking Game ID: " .. tostring(PlaceId))

if SupportedGames[PlaceId] then
    Notify("TiRex Hub", "Supported Game Detected! Loading Module...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(SupportedGames[PlaceId]))()
    end)
    if not success then
        Notify("Error", "Failed to load module: " .. tostring(err))
    end
else
    Notify("TiRex Hub", "Game Not Supported. Loading Universal...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(UniversalScript))()
    end)
    if not success then
        Notify("Error", "Failed to load Universal: " .. tostring(err))
    end
end
