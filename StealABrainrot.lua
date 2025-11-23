
local TiRex = loadstring(game:HttpGet("https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/refs/heads/main/Library.lua"))()
local Hub = TiRex:Window("TiRex | Steal a Brainrot")

local Home = Hub:Tab("🏠 | Home", "")
local Main = Hub:Tab("👁️ | Main", "")
local PlayerTab = Hub:Tab("👤 | Player", "")
local Visuals = Hub:Tab("🎨 | Visuals", "")
local Settings = Hub:Tab("⚙️ | Settings", "")

local StatsFile = "TiRex_Stats.json"
local RunCount = 1
local HttpService = game:GetService("HttpService")

if isfile and readfile and writefile then
    if isfile(StatsFile) then
        local success, data = pcall(function() 
            return HttpService:JSONDecode(readfile(StatsFile)) 
        end)
        if success and data and data.Runs then
            RunCount = data.Runs + 1
        end
    end
    writefile(StatsFile, HttpService:JSONEncode({Runs = RunCount}))
end

local WelcomeLabel = Home:Label("Loading Stats...")
local LocalPlayer = game.Players.LocalPlayer

task.spawn(function()
    while true do
        local TimeString = os.date("%I:%M %p %m/%d/%Y")
        WelcomeLabel.Text = string.format("Welcome to TiRex Hub, @%s!\n\nYou have ran TiRex Hub %d times.\n\nThe time is: %s", LocalPlayer.Name, RunCount, TimeString)
        task.wait(1)
    end
end)

Home:Button("Destroy GUI", function()
    local gui = game:GetService("CoreGui"):FindFirstChild("TiRex_Refined") or (gethui and gethui():FindFirstChild("TiRex_Refined"))
    if gui then
        local main = gui:FindFirstChild("Main")
        if main then
            game:GetService("TweenService"):Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
            task.wait(0.5)
        end
        gui:Destroy()
    end
end)

local AutoSteal = false
Main:Toggle("Auto Steal (Proximity)", false, function(state)
    AutoSteal = state
    spawn(function()
        while AutoSteal do
            task.wait()
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        fireproximityprompt(v)
                    end
                end
            end)
        end
    end)
end)

PlayerTab:Slider("WalkSpeed", 16, 300, 16, function(value)
    pcall(function()
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)
end)

PlayerTab:Slider("JumpPower", 50, 300, 50, function(value)
    pcall(function()
        LocalPlayer.Character.Humanoid.JumpPower = value
    end)
end)

PlayerTab:Button("Teleport Safe Zone", function()
    pcall(function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
    end)
end)

local ESPEnabled = false
Visuals:Toggle("Player ESP", false, function(state)
    ESPEnabled = state
    if not state then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("TiRexESP") then
                v.Character.Head.TiRexESP:Destroy()
            end
        end
    else
        spawn(function()
            while ESPEnabled do
                task.wait(1)
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                        if not v.Character.Head:FindFirstChild("TiRexESP") then
                            local bg = Instance.new("BillboardGui")
                            bg.Name = "TiRexESP"
                            bg.Adornee = v.Character.Head
                            bg.Parent = v.Character.Head
                            bg.Size = UDim2.new(0, 100, 0, 50)
                            bg.StudsOffset = Vector3.new(0, 2, 0)
                            bg.AlwaysOnTop = true
                            
                            local text = Instance.new("TextLabel")
                            text.Parent = bg
                            text.BackgroundTransparency = 1
                            text.Size = UDim2.new(1, 0, 1, 0)
                            text.Text = v.Name
                            text.TextColor3 = Color3.fromRGB(157, 0, 255)
                            text.TextStrokeTransparency = 0
                            text.TextSize = 14
                            text.Font = Enum.Font.GothamBold
                        end
                    end
                end
            end
        end)
    end
end)

Settings:Button("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

Settings:Label("Status: Active")
