local function Secure()
    local success, err = pcall(function()
        local mt = getrawmetatable(game)
        local old_index = mt.__index
        local old_namecall = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "Kick" or method == "kick" then return nil end
            if method == "FireServer" or method == "InvokeServer" then
                for _, arg in pairs(args) do
                    if type(arg) == "string" then
                        local lower = arg:lower()
                        if lower:find("ban") or lower:find("kick") or lower:find("detect") or lower:find("flag") then return nil end
                    end
                end
            end
            return old_namecall(self, ...)
        end)
        
        mt.__index = newcclosure(function(self, k)
            if not checkcaller() then
                if k == "WalkSpeed" then return 16 end
                if k == "JumpPower" then return 50 end
            end
            return old_index(self, k)
        end)
        
        setreadonly(mt, true)
        game:GetService("ScriptContext").Error:Connect(function() end)
    end)
end
task.spawn(Secure)

local TiRex = loadstring(game:HttpGet("https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/Library.lua"))()

local Hub = TiRex:Window("TiRex Hub")
local Home = Hub:Tab("🏠 | Home", "")
local Move = Hub:Tab("⚡ | Movement", "")
local Sett = Hub:Tab("⚙️ | Settings", "")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local function FullCleanup()
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Fly") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Speed") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Jump") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Noclip") end)
    
    getgenv().SpeedEnabled = false
    getgenv().JumpEnabled = false
    getgenv().FlyEnabled = false
    getgenv().Noclip = false
    getgenv().InfJump = false
    
    local Char = LocalPlayer.Character
    if Char then
        if Char:FindFirstChild("Humanoid") then
            Char.Humanoid.PlatformStand = false
            Char.Humanoid.WalkSpeed = 16
            Char.Humanoid.JumpPower = 50
        end
        if Char:FindFirstChild("HumanoidRootPart") then
            Char.HumanoidRootPart.Velocity = Vector3.zero
        end
        for _, v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end

local StatsFile = "TiRex_Stats.json"
local RunCount = 1
if isfile and readfile and writefile then
    if isfile(StatsFile) then
        local s, d = pcall(function() return HttpService:JSONDecode(readfile(StatsFile)) end)
        if s and d and d.Runs then RunCount = d.Runs + 1 end
    end
    writefile(StatsFile, HttpService:JSONEncode({Runs = RunCount}))
end

local WelcomeLabel = Home:Label("Stats...")
task.spawn(function()
    while true do
        WelcomeLabel.Text = string.format(
            "Welcome, @%s!\nRuns: %d\nTime: %s",
            LocalPlayer.Name, RunCount, os.date("%I:%M %p %m/%d/%Y")
        )
        task.wait(1)
    end
end)

Home:Button("Destroy GUI", function()
    FullCleanup()
    if TiRex.ActiveInstance then
        local main = TiRex.ActiveInstance:FindFirstChild("Main")
        if main then
            game:GetService("TweenService"):Create(main, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0)}):Play()
            task.wait(0.5)
        end
        TiRex.ActiveInstance:Destroy()
    end
end)

local SpeedVal = 16
Move:Toggle("Speed Hack", false, function(s)
    getgenv().SpeedEnabled = s
    if s then
        RunService:BindToRenderStep("TiRex_Speed", 100, function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = SpeedVal
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Speed")
        if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
    end
end)

Move:Slider("Speed Amount", 16, 100, 16, function(v) SpeedVal = v end)

local JumpVal = 50
Move:Toggle("JumpPower", false, function(s)
    getgenv().JumpEnabled = s
    if s then
        RunService:BindToRenderStep("TiRex_Jump", 100, function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = JumpVal
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Jump")
        if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = 50 end
    end
end)

Move:Slider("Jump Amount", 50, 500, 50, function(v) JumpVal = v end)

Move:Toggle("Noclip", false, function(s)
    getgenv().Noclip = s
    if s then
        RunService:BindToRenderStep("TiRex_Noclip", 100, function()
            if LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                end
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Noclip")
    end
end)

Move:Toggle("Infinite Jump", false, function(s) getgenv().InfJump = s end)
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

local FlySpeed = 16
Move:Toggle("Fly (Universal 3D)", false, function(s)
    getgenv().FlyEnabled = s
    if s then
        RunService:BindToRenderStep("TiRex_Fly", 100, function(Delta)
            local Char = LocalPlayer.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
                local HRP = Char.HumanoidRootPart
                local Hum = Char.Humanoid
                local Cam = workspace.CurrentCamera
                
                Hum.PlatformStand = true
                HRP.Velocity = Vector3.zero
                HRP.AssemblyLinearVelocity = Vector3.zero
                
                local Look = Cam.CFrame.LookVector
                local Right = Cam.CFrame.RightVector
                local MoveDir = Hum.MoveDirection
                
                HRP.CFrame = CFrame.new(HRP.Position, HRP.Position + Look)
                
                if MoveDir.Magnitude > 0 then
                    local FlatLook = (Look * Vector3.new(1,0,1)).Unit
                    local FlatRight = (Right * Vector3.new(1,0,1)).Unit
                    
                    local ForwardDot = MoveDir:Dot(FlatLook)
                    local RightDot = MoveDir:Dot(FlatRight)
                    
                    local FinalVelocity = (Look * ForwardDot) + (Right * RightDot)
                    HRP.CFrame = HRP.CFrame + (FinalVelocity * FlySpeed * Delta * 5)
                end
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Fly")
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
        end
    end
end)

Move:Slider("Fly Speed", 16, 100, 16, function(v) FlySpeed = v end)

Sett:Button("Rejoin Server", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

Sett:Button("Server Hop", function()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local function Hop()
        local site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"))
        for i, v in pairs(site.data) do
            if v.playing ~= v.maxPlayers and v.id ~= game.JobId then
                table.insert(AllIDs, v.id)
            end
        end
        if #AllIDs > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceID, AllIDs[math.random(1, #AllIDs)], LocalPlayer)
        else
            Hop()
        end
    end
    Hop()
end)

local ConfigList = {}
local SelectedConfig = ""
local ConfigName = ""
local Flags = {} 

if not isfolder("TiRex") then makefolder("TiRex") end
if not isfolder("TiRex/Configs") then makefolder("TiRex/Configs") end

local function RefreshConfigs()
    ConfigList = {}
    if listfiles then
        for _, v in pairs(listfiles("TiRex/Configs")) do
            table.insert(ConfigList, v:match("([^/]+)$"):gsub(".json", ""))
        end
    end
end
RefreshConfigs()

local Drop = Sett:Dropdown("Select Config", ConfigList, function(v) SelectedConfig = v end)
Sett:TextBox("Config Name...", "Name", function(v) ConfigName = v end)

Sett:Button("Create Config", function()
    if ConfigName ~= "" then
        writefile("TiRex/Configs/" .. ConfigName .. ".json", HttpService:JSONEncode(Flags))
        RefreshConfigs()
        Drop.Refresh(ConfigList)
    end
end)

Sett:Button("Load Config", function()
    if SelectedConfig ~= "" and isfile("TiRex/Configs/" .. SelectedConfig .. ".json") then
        local Data = HttpService:JSONDecode(readfile("TiRex/Configs/" .. SelectedConfig .. ".json"))
    end
end)
