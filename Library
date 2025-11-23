local TiRex = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Settings = {
    Name = "TiRex Hub",
    Accent = Color3.fromRGB(160, 60, 255),
    Background = Color3.fromRGB(10, 10, 12),
    Header = Color3.fromRGB(15, 15, 18),
    Sidebar = Color3.fromRGB(14, 14, 17),
    Element = Color3.fromRGB(20, 20, 24),
    Text = Color3.fromRGB(240, 240, 240),
    TextDark = Color3.fromRGB(140, 140, 150)
}

local function Tween(obj, props, time, style, dir)
    TweenService:Create(obj, TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

function TiRex:Window(name)
    -- Cleanup
    local function Clear(parent)
        for _, v in pairs(parent:GetChildren()) do
            if v.Name == "TiRex_Refined" then v:Destroy() end
        end
    end
    Clear(CoreGui)
    if gethui then Clear(gethui()) end

    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local Shadow = Instance.new("ImageLabel")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local MenuBtn = Instance.new("TextButton")
    local CloseBtn = Instance.new("TextButton")
    local Sidebar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local TabHolder = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local Container = Instance.new("Frame")
    local MenuIcon = Instance.new("Frame")
    local MenuList = Instance.new("UIListLayout")
    
    -- Mini Toggle
    local MiniToggle = Instance.new("TextButton")
    local MiniCorner = Instance.new("UICorner")
    local MiniStroke = Instance.new("UIStroke")

    -- Parenting
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end

    ScreenGui.Name = "TiRex_Refined"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Properties
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Settings.Background
    Main.BackgroundTransparency = 0.1
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true
    
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main

    MainStroke.Parent = Main
    MainStroke.Color = Color3.fromRGB(40, 40, 50)
    MainStroke.Thickness = 1
    MainStroke.Transparency = 0.6

    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- Header Construction
    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = Settings.Header
    Header.BackgroundTransparency = 0.05
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.ZIndex = 2
    
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    local HeaderFill = Instance.new("Frame")
    HeaderFill.Parent = Header
    HeaderFill.BackgroundColor3 = Settings.Header
    HeaderFill.BackgroundTransparency = 0.05
    HeaderFill.BorderSizePixel = 0
    HeaderFill.Position = UDim2.new(0, 0, 1, -10)
    HeaderFill.Size = UDim2.new(1, 0, 0, 10)
    HeaderFill.ZIndex = 2

    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 50, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = name
    Title.TextColor3 = Settings.Text
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 3

    MenuBtn.Parent = Header
    MenuBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MenuBtn.BackgroundTransparency = 1
    MenuBtn.Position = UDim2.new(0, 12, 0.5, -12)
    MenuBtn.Size = UDim2.new(0, 24, 0, 24)
    MenuBtn.Text = ""
    MenuBtn.ZIndex = 3

    MenuIcon.Parent = MenuBtn
    MenuIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MenuIcon.BackgroundTransparency = 1
    MenuIcon.Size = UDim2.new(1, 0, 1, 0)
    MenuIcon.Rotation = 90 
    
    MenuList.Parent = MenuIcon
    MenuList.SortOrder = Enum.SortOrder.LayoutOrder
    MenuList.Padding = UDim.new(0, 4)
    MenuList.VerticalAlignment = Enum.VerticalAlignment.Center
    
    for i = 1, 3 do
        local dot = Instance.new("Frame")
        dot.Parent = MenuIcon
        dot.BackgroundColor3 = Settings.TextDark
        dot.Size = UDim2.new(1, 0, 0, 3)
        dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    end

    CloseBtn.Parent = Header
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -34, 0.5, -12)
    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Settings.TextDark
    CloseBtn.TextSize = 14
    CloseBtn.ZIndex = 3
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        wait(0.3)
        Main.Visible = false
    end)

    -- Sidebar Construction
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Settings.Sidebar
    Sidebar.BackgroundTransparency = 0.05
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.Size = UDim2.new(0, 160, 1, -45)
    Sidebar.ZIndex = 2
    Sidebar.BorderSizePixel = 0
    SidebarCorner.CornerRadius = UDim.new(0, 12)
    SidebarCorner.Parent = Sidebar

    local SidebarTopFill = Instance.new("Frame")
    SidebarTopFill.Parent = Sidebar
    SidebarTopFill.BackgroundColor3 = Settings.Sidebar
    SidebarTopFill.BackgroundTransparency = 0.05
    SidebarTopFill.BorderSizePixel = 0
    SidebarTopFill.Size = UDim2.new(1, 0, 0, 10)
    SidebarTopFill.ZIndex = 2
    
    local SidebarRightFill = Instance.new("Frame")
    SidebarRightFill.Parent = Sidebar
    SidebarRightFill.BackgroundColor3 = Settings.Sidebar
    SidebarRightFill.BackgroundTransparency = 0.05
    SidebarRightFill.BorderSizePixel = 0
    SidebarRightFill.Position = UDim2.new(1, -10, 0, 0)
    SidebarRightFill.Size = UDim2.new(0, 10, 1, 0)
    SidebarRightFill.ZIndex = 2

    TabHolder.Parent = Sidebar
    TabHolder.BackgroundTransparency = 1
    TabHolder.Position = UDim2.new(0, 10, 0, 10)
    TabHolder.Size = UDim2.new(1, -20, 1, -20)
    TabHolder.ScrollBarThickness = 0
    TabHolder.ZIndex = 3

    TabList.Parent = TabHolder
    TabList.Padding = UDim.new(0, 5)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 170, 0, 55)
    Container.Size = UDim2.new(1, -180, 1, -65)
    Container.ZIndex = 1

    -- Mini Toggle
    MiniToggle.Parent = ScreenGui
    MiniToggle.BackgroundColor3 = Settings.Header
    MiniToggle.BackgroundTransparency = 0.1
    MiniToggle.Position = UDim2.new(0.5, -25, 0.05, 0)
    MiniToggle.Size = UDim2.new(0, 50, 0, 50)
    MiniToggle.AutoButtonColor = false
    MiniToggle.Text = "T"
    MiniToggle.Font = Enum.Font.GothamBold
    MiniToggle.TextSize = 32
    MiniToggle.TextColor3 = Settings.Accent
    MiniToggle.ZIndex = 10
    MiniCorner.CornerRadius = UDim.new(0, 10)
    MiniCorner.Parent = MiniToggle
    MiniStroke.Parent = MiniToggle
    MiniStroke.Color = Settings.Accent
    MiniStroke.Thickness = 2

    -- Drag Logic
    local function MakeDraggable(object, dragObject)
        local Dragging, DragInput, DragStart, StartPosition
        local IsDragging = false

        dragObject.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position
                IsDragging = false
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then Dragging = false end
                end)
            end
        end)

        dragObject.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                DragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == DragInput and Dragging then
                local Delta = input.Position - DragStart
                if Delta.Magnitude > 2 then IsDragging = true end
                object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
            end
        end)
        return function() return IsDragging end
    end

    MakeDraggable(Main, Header)
    local CheckMiniDrag = MakeDraggable(MiniToggle, MiniToggle)

    MiniToggle.MouseButton1Click:Connect(function()
        if not CheckMiniDrag() then
            if Main.Visible then
                Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                wait(0.3)
                Main.Visible = false
            else
                Main.Visible = true
                Tween(Main, {Size = UDim2.new(0, 550, 0, 350)}, 0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
            end
        end
    end)

    Tween(Main, {Size = UDim2.new(0, 550, 0, 350)}, 0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

    local SidebarOpen = true
    MenuBtn.MouseButton1Click:Connect(function()
        SidebarOpen = not SidebarOpen
        if SidebarOpen then
            Tween(MenuIcon, {Rotation = 90}, 0.3)
            Tween(Sidebar, {Size = UDim2.new(0, 160, 1, -45)}, 0.4)
            Tween(Container, {Position = UDim2.new(0, 170, 0, 55), Size = UDim2.new(1, -180, 1, -65)}, 0.4)
            for _, v in pairs(MenuIcon:GetChildren()) do
                if v:IsA("Frame") then Tween(v, {BackgroundColor3 = Settings.TextDark}, 0.2) end
            end
        else
            Tween(MenuIcon, {Rotation = 0}, 0.3)
            Tween(Sidebar, {Size = UDim2.new(0, 0, 1, -45)}, 0.4)
            Tween(Container, {Position = UDim2.new(0, 10, 0, 55), Size = UDim2.new(1, -20, 1, -65)}, 0.4)
            for _, v in pairs(MenuIcon:GetChildren()) do
                if v:IsA("Frame") then Tween(v, {BackgroundColor3 = Settings.Accent}, 0.2) end
            end
        end
    end)

    local Window = {}
    local FirstTab = true

    function Window:Tab(text, icon)
        local TabBtn = Instance.new("TextButton")
        local TabTitle = Instance.new("TextLabel")
        local TabCorner = Instance.new("UICorner")
        local TabPage = Instance.new("ScrollingFrame")
        local PageList = Instance.new("UIListLayout")
        local PagePad = Instance.new("UIPadding")

        TabBtn.Parent = TabHolder
        TabBtn.BackgroundColor3 = Settings.Sidebar
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 32)
        TabBtn.AutoButtonColor = false
        TabBtn.Text = ""
        TabBtn.ZIndex = 3
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn

        TabTitle.Parent = TabBtn
        TabTitle.BackgroundTransparency = 1
        TabTitle.Position = UDim2.new(0, 10, 0, 0)
        TabTitle.Size = UDim2.new(1, -10, 1, 0)
        TabTitle.Font = Enum.Font.GothamMedium
        TabTitle.Text = text
        TabTitle.TextColor3 = Settings.TextDark
        TabTitle.TextSize = 14
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle.ZIndex = 3

        TabPage.Parent = Container
        TabPage.BackgroundTransparency = 1
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Settings.Accent
        TabPage.Visible = false
        PageList.Parent = TabPage
        PageList.Padding = UDim.new(0, 8)
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PagePad.Parent = TabPage
        PagePad.PaddingTop = UDim.new(0, 5)
        PagePad.PaddingBottom = UDim.new(0, 5)

        local function Update()
            if TabPage.Visible then
                Tween(TabTitle, {TextColor3 = Settings.Accent}, 0.2)
                Tween(TabBtn, {BackgroundTransparency = 0.9}, 0.2)
            else
                Tween(TabTitle, {TextColor3 = Settings.TextDark}, 0.2)
                Tween(TabBtn, {BackgroundTransparency = 1}, 0.2)
            end
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(TabHolder:GetChildren()) do
                if v:IsA("TextButton") then
                    Tween(v.TextLabel, {TextColor3 = Settings.TextDark}, 0.2)
                    Tween(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            TabPage.Visible = true
            Update()
        end)

        if FirstTab then
            FirstTab = false
            TabPage.Visible = true
            Update()
        end

        local Elements = {}

        function Elements:Button(text, cb)
            local Btn = Instance.new("TextButton")
            local BtnCorner = Instance.new("UICorner")
            local BtnStroke = Instance.new("UIStroke")
            
            Btn.Parent = TabPage
            Btn.BackgroundColor3 = Settings.Element
            Btn.BackgroundTransparency = 0.2
            Btn.Size = UDim2.new(1, -5, 0, 42)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamMedium
            Btn.Text = text
            Btn.TextColor3 = Settings.Text
            Btn.TextSize = 14
            
            BtnCorner.CornerRadius = UDim.new(0, 8)
            BtnCorner.Parent = Btn
            BtnStroke.Parent = Btn
            BtnStroke.Color = Color3.fromRGB(40, 40, 50)
            BtnStroke.Thickness = 1
            BtnStroke.Transparency = 0.5

            Btn.MouseEnter:Connect(function()
                Tween(Btn, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}, 0.2)
                Tween(BtnStroke, {Color = Settings.Accent}, 0.2)
            end)
            Btn.MouseLeave:Connect(function()
                Tween(Btn, {BackgroundColor3 = Settings.Element}, 0.2)
                Tween(BtnStroke, {Color = Color3.fromRGB(40, 40, 50)}, 0.2)
            end)
            Btn.MouseButton1Click:Connect(function()
                Tween(Btn, {TextSize = 12}, 0.1)
                wait(0.1)
                Tween(Btn, {TextSize = 14}, 0.1)
                pcall(cb)
            end)
        end

        function Elements:Toggle(text, default, cb)
            local Toggled = default or false
            local TogBtn = Instance.new("TextButton")
            local TogCorner = Instance.new("UICorner")
            local TogStroke = Instance.new("UIStroke")
            local TogTitle = Instance.new("TextLabel")
            local Switch = Instance.new("Frame")
            local SwitchCorner = Instance.new("UICorner")
            local Dot = Instance.new("Frame")
            local DotCorner = Instance.new("UICorner")

            TogBtn.Parent = TabPage
            TogBtn.BackgroundColor3 = Settings.Element
            TogBtn.BackgroundTransparency = 0.2
            TogBtn.Size = UDim2.new(1, -5, 0, 42)
            TogBtn.AutoButtonColor = false
            TogBtn.Text = ""
            
            TogCorner.CornerRadius = UDim.new(0, 8)
            TogCorner.Parent = TogBtn
            TogStroke.Parent = TogBtn
            TogStroke.Color = Color3.fromRGB(40, 40, 50)
            TogStroke.Thickness = 1
            TogStroke.Transparency = 0.5
            
            TogTitle.Parent = TogBtn
            TogTitle.BackgroundTransparency = 1
            TogTitle.Position = UDim2.new(0, 15, 0, 0)
            TogTitle.Size = UDim2.new(1, -65, 1, 0)
            TogTitle.Font = Enum.Font.GothamMedium
            TogTitle.Text = text
            TogTitle.TextColor3 = Settings.Text
            TogTitle.TextSize = 14
            TogTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            Switch.Parent = TogBtn
            Switch.BackgroundColor3 = Toggled and Settings.Accent or Color3.fromRGB(40, 40, 45)
            Switch.Position = UDim2.new(1, -50, 0.5, -10)
            Switch.Size = UDim2.new(0, 36, 0, 20)
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = Switch
            
            Dot.Parent = Switch
            Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dot.Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Dot.Size = UDim2.new(0, 16, 0, 16)
            DotCorner.CornerRadius = UDim.new(1, 0)
            DotCorner.Parent = Dot

            local function Update()
                local targetColor = Toggled and Settings.Accent or Color3.fromRGB(40, 40, 45)
                local targetPos = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                Tween(Switch, {BackgroundColor3 = targetColor}, 0.2)
                Tween(Dot, {Position = targetPos}, 0.2)
            end

            TogBtn.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                Update()
                pcall(cb, Toggled)
            end)
            
            if default then Update() end
            return {
                Set = function(val)
                    Toggled = val
                    Update()
                    pcall(cb, val)
                end
            }
        end

        function Elements:Slider(text, min, max, default, cb)
            local Value = default or min
            local Dragging = false
            
            local SlideBtn = Instance.new("TextButton")
            local SlideCorner = Instance.new("UICorner")
            local SlideStroke = Instance.new("UIStroke")
            local SlideTitle = Instance.new("TextLabel")
            local SlideVal = Instance.new("TextLabel")
            local BarBg = Instance.new("Frame")
            local BarFill = Instance.new("Frame")
            
            SlideBtn.Parent = TabPage
            SlideBtn.BackgroundColor3 = Settings.Element
            SlideBtn.BackgroundTransparency = 0.2
            SlideBtn.Size = UDim2.new(1, -5, 0, 50)
            SlideBtn.AutoButtonColor = false
            SlideBtn.Text = ""
            
            SlideCorner.CornerRadius = UDim.new(0, 8)
            SlideCorner.Parent = SlideBtn
            SlideStroke.Parent = SlideBtn
            SlideStroke.Color = Color3.fromRGB(40, 40, 50)
            SlideStroke.Thickness = 1
            SlideStroke.Transparency = 0.5
            
            SlideTitle.Parent = SlideBtn
            SlideTitle.BackgroundTransparency = 1
            SlideTitle.Position = UDim2.new(0, 15, 0, 5)
            SlideTitle.Size = UDim2.new(1, -30, 0, 20)
            SlideTitle.Font = Enum.Font.GothamMedium
            SlideTitle.Text = text
            SlideTitle.TextColor3 = Settings.Text
            SlideTitle.TextSize = 14
            SlideTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SlideVal.Parent = SlideBtn
            SlideVal.BackgroundTransparency = 1
            SlideVal.Position = UDim2.new(0, 15, 0, 5)
            SlideVal.Size = UDim2.new(1, -30, 0, 20)
            SlideVal.Font = Enum.Font.GothamMedium
            SlideVal.Text = tostring(Value)
            SlideVal.TextColor3 = Settings.TextDark
            SlideVal.TextSize = 14
            SlideVal.TextXAlignment = Enum.TextXAlignment.Right
            
            BarBg.Parent = SlideBtn
            BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            BarBg.Position = UDim2.new(0, 15, 0, 32)
            BarBg.Size = UDim2.new(1, -30, 0, 6)
            Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)
            
            BarFill.Parent = BarBg
            BarFill.BackgroundColor3 = Settings.Accent
            BarFill.Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
            BarFill.BorderSizePixel = 0
            Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)
            
            local function Update(input)
                local SizeX = BarBg.AbsoluteSize.X
                local PosX = BarBg.AbsolutePosition.X
                local Percent = math.clamp((input.Position.X - PosX) / SizeX, 0, 1)
                Value = math.floor(min + ((max - min) * Percent))
                Tween(BarFill, {Size = UDim2.new(Percent, 0, 1, 0)}, 0.1)
                SlideVal.Text = tostring(Value)
                pcall(cb, Value)
            end
            
            SlideBtn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    Update(input)
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then Dragging = false end
                    end)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    Update(input)
                end
            end)
            
            return {
                Set = function(val)
                    Value = val
                    local Percent = (Value - min) / (max - min)
                    Tween(BarFill, {Size = UDim2.new(Percent, 0, 1, 0)}, 0.1)
                    SlideVal.Text = tostring(Value)
                    pcall(cb, Value)
                end
            }
        end

        function Elements:Label(text)
            local Lab = Instance.new("TextLabel")
            local LabCorner = Instance.new("UICorner")
            Lab.Parent = TabPage
            Lab.BackgroundColor3 = Settings.Element
            Lab.BackgroundTransparency = 0.4
            Lab.Size = UDim2.new(1, -5, 0, 0)
            Lab.Font = Enum.Font.GothamMedium
            Lab.Text = text
            Lab.TextColor3 = Settings.Text
            Lab.TextSize = 14
            Lab.TextWrapped = true
            Lab.TextXAlignment = Enum.TextXAlignment.Left
            Lab.AutomaticSize = Enum.AutomaticSize.Y
            LabCorner.CornerRadius = UDim.new(0, 8)
            LabCorner.Parent = Lab
            local Pad = Instance.new("UIPadding")
            Pad.Parent = Lab
            Pad.PaddingLeft = UDim.new(0, 10)
            Pad.PaddingTop = UDim.new(0, 10)
            Pad.PaddingBottom = UDim.new(0, 10)
            return Lab
        end

        function Elements:TextBox(text, placeholder, cb)
            local BoxFrame = Instance.new("Frame")
            local BoxInput = Instance.new("TextBox")
            BoxFrame.Parent = TabPage
            BoxFrame.BackgroundColor3 = Settings.Element
            BoxFrame.BackgroundTransparency = 0.2
            BoxFrame.Size = UDim2.new(1, -5, 0, 50)
            Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 8)
            
            local Title = Instance.new("TextLabel", BoxFrame)
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 15, 0, 5)
            Title.Size = UDim2.new(1, -30, 0, 20)
            Title.Font = Enum.Font.GothamMedium
            Title.Text = text
            Title.TextColor3 = Settings.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            BoxInput.Parent = BoxFrame
            BoxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            BoxInput.Position = UDim2.new(0, 15, 0, 28)
            BoxInput.Size = UDim2.new(1, -30, 0, 18)
            BoxInput.Font = Enum.Font.Gotham
            BoxInput.PlaceholderText = placeholder or "..."
            BoxInput.Text = ""
            BoxInput.TextColor3 = Settings.Text
            BoxInput.TextSize = 13
            Instance.new("UICorner", BoxInput).CornerRadius = UDim.new(0, 4)
            
            BoxInput.FocusLost:Connect(function() pcall(cb, BoxInput.Text) end)
        end

        function Elements:Dropdown(text, list, cb)
            local DropOpen = false
            local DropFrame = Instance.new("Frame")
            local DropBtn = Instance.new("TextButton")
            local DropScroll = Instance.new("ScrollingFrame")
            local DropSelected = Instance.new("TextLabel", DropBtn)
            
            DropFrame.Parent = TabPage
            DropFrame.BackgroundColor3 = Settings.Element
            DropFrame.BackgroundTransparency = 0.2
            DropFrame.Size = UDim2.new(1, -5, 0, 42)
            DropFrame.ClipsDescendants = true
            Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 8)
            
            DropBtn.Parent = DropFrame
            DropBtn.BackgroundTransparency = 1
            DropBtn.Size = UDim2.new(1, 0, 0, 42)
            DropBtn.Text = ""
            
            local Title = Instance.new("TextLabel", DropBtn)
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 15, 0, 0)
            Title.Size = UDim2.new(1, -30, 1, 0)
            Title.Font = Enum.Font.GothamMedium
            Title.Text = text
            Title.TextColor3 = Settings.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            DropSelected.BackgroundTransparency = 1
            DropSelected.Position = UDim2.new(1, -150, 0, 0)
            DropSelected.Size = UDim2.new(0, 115, 1, 0)
            DropSelected.Font = Enum.Font.Gotham
            DropSelected.Text = "..."
            DropSelected.TextColor3 = Settings.Accent
            DropSelected.TextSize = 13
            DropSelected.TextXAlignment = Enum.TextXAlignment.Right
            
            DropScroll.Parent = DropFrame
            DropScroll.BackgroundTransparency = 1
            DropScroll.Position = UDim2.new(0, 0, 0, 45)
            DropScroll.Size = UDim2.new(1, 0, 1, -45)
            local List = Instance.new("UIListLayout", DropScroll)
            List.SortOrder = Enum.SortOrder.LayoutOrder
            List.Padding = UDim.new(0, 5)
            
            local function Refresh(newlist)
                for _, v in pairs(DropScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                for _, v in pairs(newlist) do
                    local Item = Instance.new("TextButton", DropScroll)
                    Item.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                    Item.Size = UDim2.new(1, -20, 0, 30)
                    Item.Font = Enum.Font.Gotham
                    Item.Text = v
                    Item.TextColor3 = Settings.TextDark
                    Item.TextSize = 13
                    Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 6)
                    Item.MouseButton1Click:Connect(function()
                        DropSelected.Text = v
                        pcall(cb, v)
                        DropOpen = false
                        Tween(DropFrame, {Size = UDim2.new(1, -5, 0, 42)}, 0.2)
                    end)
                end
                DropScroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 10)
            end
            
            Refresh(list)
            
            DropBtn.MouseButton1Click:Connect(function()
                DropOpen = not DropOpen
                if DropOpen then
                    Tween(DropFrame, {Size = UDim2.new(1, -5, 0, 150)}, 0.2)
                else
                    Tween(DropFrame, {Size = UDim2.new(1, -5, 0, 42)}, 0.2)
                end
            end)
            
            return {Refresh = Refresh}
        end

        return Elements
    end
    return Window
end

return TiRex
