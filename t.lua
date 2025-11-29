local Library={}

local repo="https://raw.githubusercontent.com/nathanathan69420-pixel/TiRex-Hub/main/"

local function notify(text,time)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="TiRex Hub",Text=text,Duration=time or 3})
end

Library.Notify=notify

function Library:LoadScript(name)
    loadstring(game:HttpGet(repo..name..".lua"))()
end

function Library:CreateWindow(title)
    local screen=Instance.new("ScreenGui",game.CoreGui)
    local frame=Instance.new("Frame",screen)
    frame.Size=UDim2.new(0,400,0,500)
    frame.Position=UDim2.new(0.5,-200,0.5,-250)
    frame.BackgroundColor3=Color3.fromRGB(15,15,15)
    frame.BorderSizePixel=0
    
    local top=Instance.new("Frame",frame)
    top.Size=UDim2.new(1,0,0,30)
    top.BackgroundColor3=Color3.fromRGB(255,0,255)
    top.BorderSizePixel=0
    
    local titlelabel=Instance.new("TextLabel",top)
    titlelabel.Text=title or "TiRex Hub"
    titlelabel.TextColor3=Color3.new(1,1,1)
    titlelabel.BackgroundTransparency=1
    titlelabel.Font=Enum.Font.GothamBold
    titlelabel.TextSize=16
    titlelabel.Size=UDim2.new(1,0,1,0)
    
    local dragging
    top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
    top.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
            local delta=i.Position-Vector2.new(frame.Position.X.Offset,frame.Position.Y.Offset)
            frame.Position=UDim2.new(0,delta.X,0,delta.Y)
        end
    end)
    
    local list=Instance.new("ScrollingFrame",frame)
    list.Size=UDim2.new(1,-10,1,-40)
    list.Position=UDim2.new(0,5,0,35)
    list.BackgroundTransparency=1
    list.ScrollBarThickness=4
    
    local layout=Instance.new("UIListLayout",list)
    layout.Padding=UDim.new(0,5)
    layout.SortOrder=Enum.SortOrder.LayoutOrder
    
    local count=0
    
    function Library:AddButton(text,callback)
        count=count+1
        local btn=Instance.new("TextButton",list)
        btn.Size=UDim2.new(1,-10,0,35)
        btn.BackgroundColor3=Color3.fromRGB(255,0,255)
        btn.TextColor3=Color3.new(1,1,1)
        btn.Font=Enum.Font.GothamBold
        btn.Text=text
        btn.AutoButtonColor=false
        btn.LayoutOrder=count
        
        btn.MouseButton1Click:Connect(callback)
        
        btn.MouseEnter:Connect(function() btn.BackgroundColor3=Color3.fromRGB(200,0,200) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3=Color3.fromRGB(255,0,255) end)
    end
    
    function Library:AddExitButton()
        count=count+1
        local exitbtn=Instance.new("TextButton",list)
        exitbtn.Size=UDim2.new(1,-10,0,35)
        exitbtn.BackgroundColor3=Color3.fromRGB(255,0,0)
        exitbtn.TextColor3=Color3.new(1,1,1)
        exitbtn.Font=Enum.Font.GothamBold
        exitbtn.Text="Exit TiRex Hub"
        exitbtn.AutoButtonColor=false
        exitbtn.LayoutOrder=count

        exitbtn.MouseEnter:Connect(function() exitbtn.BackgroundColor3=Color3.fromRGB(200,0,0) end)
        exitbtn.MouseLeave:Connect(function() exitbtn.BackgroundColor3=Color3.fromRGB(255,0,0) end)
        
        exitbtn.MouseButton1Click:Connect(function()
            notify("Hub closed. Re-exec to reopen.",4)
            screen:Destroy()
        end)
    end
    
    Library:AddExitButton() -- auto adds exit button at the bottom every time
    
    return Library
end

notify("TiRex Library Loaded",1.5)
return Library
