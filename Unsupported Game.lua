-- Storage for original metatable functions to allow for cleanup and secure execution
local old_index_safe
local old_namecall_safe


local function Secure()
    local success, err = pcall(function()
        local mt = getrawmetatable(game)
        
        local old_index = mt.__index
        local old_namecall = mt.__namecall
        old_index_safe = old_index
        old_namecall_safe = old_namecall
        
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
    if not success then warn("Failed to apply security hooks:", err) end
end
task.spawn(Secure)

local TiRex = loadstring(game:HttpGet("https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/refs/heads/main/Library.lua"))()

local Hub = TiRex:Window("TiRex Hub")
local Home = Hub:Tab("🏠 | Home", "")
local Move = Hub:Tab("⚡ | Movement", "")
local Vis = Hub:Tab("🖼️ | Visuals", "")
local Sett = Hub:Tab("⚙️ | Settings", "")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local CharSpeedListener

local function FullCleanup()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    if old_index_safe then mt.__index = old_index_safe end
    if old_namecall_safe then mt.__namecall = old_namecall_safe end
    setreadonly(mt, true)

    if CharSpeedListener then
        CharSpeedListener:Disconnect()
        CharSpeedListener = nil
    end

    pcall(function() RunService:UnbindFromRenderStep("TiRex_Fly") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Speed") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Jump") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Noclip") end)
    pcall(function() RunService:UnbindFromRenderStep("TiRex_Fullbright") end)
    
    getgenv().SpeedEnabled = false
    getgenv().JumpEnabled = false
    getgenv().FlyEnabled = false
    getgenv().Noclip = false
    getgenv().InfJump = false
    
    local Char = LocalPlayer.Character
    if Char then
        -- FIX: Use FindFirstChildOfClass for robust Humanoid retrieval
        local Hum = Char:FindFirstChildOfClass("Humanoid") 
        if Hum then
            Hum.PlatformStand = false
            Hum.WalkSpeed = 16
            Hum.JumpPower = 50
        end
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if HRP then
            HRP.Velocity = Vector3.zero
            -- FIX: Reset AssemblyLinearVelocity as well for a full stop
            HRP.AssemblyLinearVelocity = Vector3.zero 
        end
        -- FIX: Ensure CanCollide is reset for all parts if noclip was active
        for _, v in pairs(Char:GetDescendants()) do 
            if v:IsA("BasePart") then v.CanCollide = true end
        end
        if Char:FindFirstChild("TiRexHighlight") then
            Char.TiRexHighlight:Destroy()
        end
    end
    
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("TiRexHighlight") then
            v.Character.TiRexHighlight:Destroy()
        end
    end
    
    Lighting.Brightness = 1
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 1000
    Lighting.ClockTime = 12
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
end

-- FIX: Added handler for WalkSpeed on CharacterAdded events
local function setupSpeedHandler()
    CharSpeedListener = LocalPlayer.CharacterAdded:Connect(function(newChar)
        local Hum = newChar:WaitForChild("Humanoid", 5)
        if Hum then
            if getgenv().SpeedEnabled then
                Hum.WalkSpeed = SpeedVal
            else
                Hum.WalkSpeed = 16
            end
        end
    end)
end
task.spawn(setupSpeedHandler)

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
        -- FIX: Using task.delay for better scheduling outside of RunService
        task.delay(1) 
    end
end)

Home:Button("Destroy GUI", function()
    FullCleanup() 
    
    local Target = TiRex.ActiveInstance
    if not Target then Target = game:GetService("CoreGui"):FindFirstChild("TiRex_Refined") end
    if not Target and gethui then Target = gethui():FindFirstChild("TiRex_Refined") end
    if Target then
        local Main = Target:FindFirstChild("Main")
        if Main then
            local t = TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)})
            t:Play()
            t.Completed:Wait()
        end
        Target:Destroy()
    end
end)

local SpeedVal = 16
local SpeedToggle = Move:Toggle("Speed Hack", false, function(s)
    getgenv().SpeedEnabled = s
    if s then
        local Char = LocalPlayer.Character
        -- FIX: Check if Char exists before finding Humanoid
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid") 
        if Hum then
            Hum.WalkSpeed = SpeedVal
        end

        RunService:BindToRenderStep("TiRex_Speed", 100, function()
            local Char = LocalPlayer.Character
            local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                Hum.WalkSpeed = SpeedVal
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Speed")
        local Char = LocalPlayer.Character
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        if Hum then Hum.WalkSpeed = 16 end
    end
    getgenv().TiRex_SpeedToggle = s
end)

local SpeedSlider = Move:Slider("Speed Amount", 16, 100, 16, function(v) 
    SpeedVal = v 
    getgenv().TiRex_SpeedVal = v
end)

local JumpVal = 50
local JumpToggle = Move:Toggle("JumpPower", false, function(s)
    getgenv().JumpEnabled = s
    if s then
        RunService:BindToRenderStep("TiRex_Jump", 100, function()
            local Char = LocalPlayer.Character
            local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
            if Hum then
                Hum.JumpPower = JumpVal
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Jump")
        local Char = LocalPlayer.Character
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        if Hum then Hum.JumpPower = 50 end
    end
    getgenv().TiRex_JumpToggle = s
end)

local JumpSlider = Move:Slider("Jump Amount", 50, 500, 50, function(v) 
    JumpVal = v 
    getgenv().TiRex_JumpVal = v
end)

local NoclipToggle = Move:Toggle("Noclip", false, function(s)
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
        -- FIX: Ensure noclip parts are reset when turning off the toggle
        if LocalPlayer.Character then
             for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
    end
    getgenv().TiRex_NoclipToggle = s
end)

local InfJumpToggle = Move:Toggle("Infinite Jump", false, function(s) getgenv().InfJump = s end)
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if Hum and Hum.Health > 0 then
            -- FIX: Use Enum for clarity/robustness instead of string
            Hum:ChangeState(Enum.HumanoidStateType.Jumping) 
        end
    end
end)
getgenv().TiRex_InfJumpToggle = false

local FlySpeed = 16
local FlyToggle = Move:Toggle("Fly (Universal 3D)", false, function(s)
    getgenv().FlyEnabled = s
    if s then
        RunService:BindToRenderStep("TiRex_Fly", 100, function(Delta)
            local Char = LocalPlayer.Character
            local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
            local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
            
            if Char and HRP and Hum then
                
                Hum.PlatformStand = true
                HRP.Velocity = Vector3.zero
                -- FIX: Explicitly reset AssemblyLinearVelocity
                HRP.AssemblyLinearVelocity = Vector3.zero 
                
                local Cam = workspace.CurrentCamera
                HRP.CFrame = CFrame.new(HRP.Position, HRP.Position + Cam.CFrame.LookVector)
                
                local Look = Cam.CFrame.LookVector
                local Right = Cam.CFrame.RightVector
                local MoveDir = Hum.MoveDirection
                
                if MoveDir.Magnitude > 0 then
                    local FlatLook = (Look * Vector3.new(1,0,1)).Unit
                    local FlatRight = (Right * Vector3.new(1,0,1)).Unit
                    
                    local ForwardDot = MoveDir:Dot(FlatLook)
                    local RightDot = MoveDir:Dot(FlatRight)
                    
                    local FinalVelocity = (Look * ForwardDot) + (Right * RightDot)
                    
                    if math.abs(ForwardDot) > 0.1 or math.abs(RightDot) > 0.1 then
                        HRP.CFrame = HRP.CFrame + (FinalVelocity * FlySpeed * Delta * 5)
                    end
                end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    HRP.CFrame = HRP.CFrame + (Vector3.new(0,1,0) * FlySpeed * Delta * 2)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    HRP.CFrame = HRP.CFrame - (Vector3.new(0,1,0) * FlySpeed * Delta * 2)
                end
            end
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Fly")
        local Char = LocalPlayer.Character
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        if Hum then
            Hum.PlatformStand = false
        end
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        if HRP then
            HRP.Velocity = Vector3.zero
            HRP.AssemblyLinearVelocity = Vector3.zero
        end
    end
    getgenv().TiRex_FlyToggle = s
end)

local FlySlider = Move:Slider("Fly Speed", 16, 100, 16, function(v) 
    FlySpeed = v 
    getgenv().TiRex_FlySpeed = v
end)

local FullbrightToggle = Vis:Toggle("Fullbright", false, function(s)
    if s then
        RunService:BindToRenderStep("TiRex_Fullbright", 100, function()
            
            Lighting.Brightness = 2
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end)
    else
        RunService:UnbindFromRenderStep("TiRex_Fullbright")
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 1000
        Lighting.ClockTime = 12
        Lighting.OutdoorAmbient = Color3.new(0,0,0)
    end
    getgenv().TiRex_FullbrightToggle = s
end)

local ESP_Color = Color3.new(1, 1, 1)
local ESP_Enabled = false

local function AddESP(plr)
    if plr == LocalPlayer then return end
    local char = plr.Character
    if not char then return end
    
    local existingH = char:FindFirstChild("TiRexHighlight")
    if existingH then
        existingH:Destroy()
    end
    
    local H = Instance.new("Highlight")
    H.Name = "TiRexHighlight"
    H.FillTransparency = 0.55
    H.OutlineColor = ESP_Color
    H.FillColor = ESP_Color
    -- FIX: Use the 'char' variable which is guaranteed to exist
    H.Parent = char 
end

local ESPToggle = Vis:Toggle("Player ESP", false, function(s)
    ESP_Enabled = s
    if s then
        for _, v in pairs(Players:GetPlayers()) do AddESP(v) end
        
        local PlayerConnection = Players.PlayerAdded:Connect(function(plr)
            local CharConnection
            CharConnection = plr.CharacterAdded:Connect(function()
                if ESP_Enabled then 
                    -- FIX: Use task.spawn/task.wait to prevent CharacterAdded deadlock/race condition
                    task.spawn(function() task.wait(0.5) AddESP(plr) end) 
                end
            end)
            plr.AncestryChanged:Connect(function(_, parent)
                if not parent and CharConnection then CharConnection:Disconnect() end
            end)
        end)
        getgenv().TiRex_PlayerESPConnection = PlayerConnection
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("TiRexHighlight") then
                v.Character.TiRexHighlight:Destroy()
            end
        end
        if getgenv().TiRex_PlayerESPConnection then 
            getgenv().TiRex_PlayerESPConnection:Disconnect() 
            getgenv().TiRex_PlayerESPConnection = nil
        end
    end
    getgenv().TiRex_ESPToggle = s
end)

local ESPColorPicker = Vis:ColorPicker("ESP Color", Color3.new(1, 1, 1), function(c)
    ESP_Color = c
    if ESP_Enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("TiRexHighlight") then
                v.Character.TiRexHighlight.OutlineColor = c
                v.Character.TiRexHighlight.FillColor = c
            end
        end
    end
    getgenv().TiRex_ESPColor = {R=c.R, G=c.G, B=c.B}
end)
getgenv().TiRex_ESPColor = {R=1, G=1, B=1}

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
            warn("No available servers found. Retrying...")
            task.wait(2)
            Hop()
        end
    end
    Hop()
end)

local ConfigList = {}
local SelectedConfig = ""
local ConfigName = ""
local Flags = {
    SpeedToggle = "TiRex_SpeedToggle",
    SpeedVal = "TiRex_SpeedVal",
    JumpToggle = "TiRex_JumpToggle",
    JumpVal = "TiRex_JumpVal",
    NoclipToggle = "TiRex_NoclipToggle",
    InfJumpToggle = "TiRex_InfJumpToggle",
    FlyToggle = "TiRex_FlyToggle",
    FlySpeed = "TiRex_FlySpeed",
    FullbrightToggle = "TiRex_FullbrightToggle",
    ESPToggle = "TiRex_ESPToggle",
    ESPColor = "TiRex_ESPColor"
}

if not isfolder("TiRex") then makefolder("TiRex") end
if not isfolder("TiRex/Configs") then makefolder("TiRex/Configs") end

local function RefreshConfigs()
    ConfigList = {}
    if listfiles then
        for _, v in pairs(listfiles("TiRex/Configs")) do
            local name = v:match("([^/]+)$"):gsub(".json", "")
            table.insert(ConfigList, name)
        end
    end
end
RefreshConfigs()

local Drop = Sett:Dropdown("Select Config", ConfigList, function(v) SelectedConfig = v end)
Sett:TextBox("Config Name...", "Name", function(v) ConfigName = v end)

Sett:Button("Create Config", function()
    if ConfigName ~= "" then
        local DataToSave = {}
        for key, globalName in pairs(Flags) do
            DataToSave[key] = getgenv()[globalName]
        end
        
        writefile("TiRex/Configs/" .. ConfigName .. ".json", HttpService:JSONEncode(DataToSave))
        
        RefreshConfigs()
        Drop.Refresh(ConfigList)
        print("Config '" .. ConfigName .. "' saved successfully.")
    else
        warn("Config name cannot be empty!")
    end
end)

Sett:Button("Load Config", function()
    if SelectedConfig ~= "" and isfile("TiRex/Configs/" .. SelectedConfig .. ".json") then
        local success, Data = pcall(function()
            return HttpService:JSONDecode(readfile("TiRex/Configs/" .. SelectedConfig .. ".json"))
        end)
        
        if success and Data then
            FullCleanup() 
            
            SpeedSlider:SetValue(Data.SpeedVal or 16)
            SpeedToggle:Set(Data.SpeedToggle or false)
            
            JumpSlider:SetValue(Data.JumpVal or 50)
            JumpToggle:Set(Data.JumpToggle or false)
            
            NoclipToggle:Set(Data.NoclipToggle or false)
            InfJumpToggle:Set(Data.InfJumpToggle or false)
            
            FlySlider:SetValue(Data.FlySpeed or 16)
            FlyToggle:Set(Data.FlyToggle or false)
            
            if Data.ESPColor then
                local c = Color3.new(Data.ESPColor.R, Data.ESPColor.G, Data.ESPColor.B)
                ESPColorPicker:SetValue(c)
            end
            ESPToggle:Set(Data.ESPToggle or false)
            
            print("Config '" .. SelectedConfig .. "' loaded successfully.")
        else
            warn("Failed to decode config file: ", Data)
        end
    else
        warn("No config selected or file not found!")
    end
end)

Drop.Refresh(ConfigList)
