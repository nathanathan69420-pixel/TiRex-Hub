local Library={}

local repo="https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/"
local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local notify=function(txt,tm) game:GetService("StarterGui"):SetCore("SendNotification",{Title="TiRex Hub",Text=txt,Duration=tm or 3}) end

Library.Notify=notify

function Library:LoadScript(name) loadstring(game:HttpGet(repo..name..".lua"))() end

function Library:CreateWindow(title)
    local screen=Instance.new("ScreenGui",game.CoreGui)
    screen.DisplayOrder=999999
    
    local main=Instance.new("Frame",screen)
    main.Size=UDim2.new(0,420,0,540)
    main.Position=UDim2.new(0.5,-210,0.5,-270)
    main.BackgroundColor3=Color3.fromRGB(10,10,15)
    main.BorderSizePixel=0
    main.ClipsDescendants=true
    
    local stroke=Instance.new("UIStroke",main)
    stroke.Color=Color3.fromRGB(255,0,255)
    stroke.Thickness=3
    stroke.Transparency=0.4
    
    local glow=Instance.new("ImageLabel",main)
    glow.Size=UDim2.new(1,40,1,40)
    glow.Position=UDim2.new(0,-20,0,-20)
    glow.BackgroundTransparency=1
    glow.Image="rbxassetid://431637172"
    glow.ImageColor3=Color3.fromRGB(255,0,255)
    glow.ImageTransparency=0.7
    glow.ScaleType=Enum.ScaleType.Slice
    glow.SliceCenter=Rect.new(20,20,480,480)
    
    local top=Instance.new("Frame",main)
    top.Size=UDim2.new(1,0,0,40)
    top.BackgroundColor3=Color3.fromRGB(255,0,255)
    top.BorderSizePixel=0
    
    local gradient=Instance.new("UIGradient",top)
    gradient.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))}
    gradient.Rotation=90
    
    local titlelbl=Instance.new("TextLabel",top)
    titlelbl.Text=title or "TiRex Hub"
    titlelbl.Font=Enum.Font.GothamBlack
    titlelbl.TextSize=18
    titlelbl.TextColor3=Color3.new(1,1,1)
    titlelbl.BackgroundTransparency=1
    titlelbl.Size=UDim2.new(1,-80,1,0)
    titlelbl.Position=UDim2.new(0,10,0,0)
    
    local close=Instance.new("TextButton",top)
    close.Size=UDim2.new(0,35,0,35)
    close.Position=UDim2.new(1,-40,0,2.5)
    close.BackgroundTransparency=1
    close.Text="X"
    close.TextColor3=Color3.new(1,1,1)
    close.Font=Enum.Font.GothamBlack
    close.TextSize=20
    close.MouseButton1Click:Connect(function() TweenService:Create(main,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{Position=UDim2.new(0.5,-210,-1,0)}):Play() wait(0.5) screen:Destroy() end)
    
    local dragging=false
    top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
    top.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    UIS.InputChanged:Connect(function(i)if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then local delta=i.Position-main.AbsolutePosition main.Position=UDim2.new(0,delta.X,0,delta.Y) end end)
    
    local container=Instance.new("ScrollingFrame",main)
    container.Size=UDim2.new(1,-20,1,-55)
    container.Position=UDim2.new(0,10,0,45)
    container.BackgroundTransparency=1
    container.ScrollBarThickness=3
    container.ScrollBarImageColor3=Color3.fromRGB(255,0,255)
    
    local layout=Instance.new("UIListLayout",container)
    layout.Padding=UDim.new(0,8)
    layout.SortOrder=Enum.SortOrder.LayoutOrder
    
    local count=0
    function Library:AddButton(text,callback)
        count+=1
        local btn=Instance.new("TextButton",container)
        btn.Size=UDim2.new(1,-10,0,45)
        btn.BackgroundColor3=Color3.fromRGB(30,30,40)
        btn.BorderSizePixel=0
        btn.Text=text
        btn.TextColor3=Color3.new(1,1,1)
        btn.Font=Enum.Font.GothamBold
        btn.TextSize=16
        btn.AutoButtonColor=false
        btn.LayoutOrder=count
        
        local btnstroke=Instance.new("UIStroke",btn)
        btnstroke.Color=Color3.fromRGB(255,0,255)
        btnstroke.Thickness=2
        btnstroke.Transparency=0.8
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(255,0,255)}):Play()
            TweenService:Create(btnstroke,TweenInfo.new(0.2),{Transparency=0}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(30,30,40)}):Play()
            TweenService:Create(btnstroke,TweenInfo.new(0.2),{Transparency=0.8}):Play()
        end)
        
        btn.MouseButton1Click:Connect(callback)
    end
    
    -- Auto spawn with sexy entrance
    main.Position=UDim2.new(0.5,-210,-1,0)
    TweenService:Create(main,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-210,0.5,-270)}):Play()
    
    notify("TiRex Hub — Future just arrived.",3)
    return Library
end

return Library