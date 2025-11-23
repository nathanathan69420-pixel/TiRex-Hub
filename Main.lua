local PlaceId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

--// CONFIGURATION WITH REFS/HEADS //--
local Repo = "https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/refs/heads/main/"

--// FILE MAPPING (Spaces are automatically handled below) //--
local SupportedGames = {
    [79546208627805] = "Games/99Nights.lua",
    [109983668079237] = "Games/StealABrainrot.lua",
    [121864768012064] = "Games/FishIt.lua",
    [127742093697776] = "Games/PlantsVsBrainrots.lua"
}

local UniversalScript = "Unsupported Game.lua" -- Name exactly as it is on GitHub

--// NOTIFICATION SYSTEM //--
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
        Icon = "rbxassetid://11697668826"
    })
end

--// LOADER LOGIC //--
local function LoadScript(ScriptName)
    -- Auto-encode spaces to %20 for raw links
    local EncodedName = ScriptName:gsub(" ", "%%20")
    local TargetUrl = Repo .. EncodedName
    
    print("------------------------------------------------")
    print("[TiRex] FETCHING:", TargetUrl)
    
    local Success, Content = pcall(function()
        return game:HttpGet(TargetUrl)
    end)

    if not Success then
        warn("[TiRex] HTTP ERROR:", Content)
        Notify("Connection Error", "Failed to fetch script.\nSee Console (F9).")
        return
    end

    -- Check if we got a 404 page (which is HTML, not Lua)
    if Content:find("404: Not Found") or Content:find("DOCTYPE html") then
        warn("[TiRex] 404 ERROR: The file path is incorrect.")
        warn("[TiRex] URL used:", TargetUrl)
        Notify("404 Error", "File not found on GitHub.\nCheck URL in Console.")
        return
    end

    local Func, SyntaxErr = loadstring(Content)
    
    if not Func then
        warn("------------------------------------------------")
        warn("[TiRex] SYNTAX ERROR IN SCRIPT:", ScriptName)
        warn(SyntaxErr)
        warn("------------------------------------------------")
        Notify("Syntax Error", "Script has coding errors.\nCheck Console (F9).")
        return
    end

    task.spawn(Func)
end

--// EXECUTION //--
Notify("TiRex Hub", "Checking Game ID: " .. tostring(PlaceId))

if SupportedGames[PlaceId] then
    Notify("TiRex Hub", "Game Detected! Loading Module...")
    LoadScript(SupportedGames[PlaceId])
else
    Notify("TiRex Hub", "Loading Universal Fallback... (Unsupported game)")
    LoadScript(UniversalScript)
end
