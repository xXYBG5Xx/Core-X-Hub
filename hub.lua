local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إعدادات السكربت
local Settings = {
    HubName = "Core X Hub",
    Version = "2.5",
    ButtonPosition = UDim2.new(0, 20, 0.5, 0) -- الموضع الافتراضي للزر
}

-- إنشاء الواجهة الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = Settings.HubName
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- الإطار الرئيسي (مع حواف مدورة)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false -- مخفي بشكل افتراضي
mainFrame.Parent = screenGui

-- حواف مدورة للإطار الرئيسي
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- زر التبديل المدور القابل للتحريك
local dragButton = Instance.new("TextButton")
dragButton.Size = UDim2.new(0, 40, 0, 40)
dragButton.Position = Settings.ButtonPosition
dragButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- أزرق جميل
dragButton.Text = "☰"
dragButton.Font = Enum.Font.GothamBold
dragButton.TextColor3 = Color3.new(1, 1, 1)
dragButton.TextSize = 20
dragButton.ZIndex = 2
dragButton.Parent = screenGui

-- جعل الزر مدوراً بالكامل
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = dragButton

-- ظل للزر
local buttonShadow = Instance.new("ImageLabel")
buttonShadow.Name = "Shadow"
buttonShadow.Image = "rbxassetid://1316045217"
buttonShadow.ImageColor3 = Color3.new(0, 0, 0)
buttonShadow.ImageTransparency = 0.8
buttonShadow.ScaleType = Enum.ScaleType.Slice
buttonShadow.SliceCenter = Rect.new(10, 10, 118, 118)
buttonShadow.Size = UDim2.new(1, 10, 1, 10)
buttonShadow.Position = UDim2.new(0, -5, 0, -5)
buttonShadow.BackgroundTransparency = 1
buttonShadow.Parent = dragButton

-- متغيرات لتحريك الزر
local dragging = false
local dragStartPos
local buttonStartPos

-- بدء السحب
dragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        buttonStartPos = dragButton.Position
        
        -- تأثير عند السحب
        game:GetService("TweenService"):Create(dragButton, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(0, 150, 255),
            Size = UDim2.new(0, 36, 0, 36)
        }):Play()
    end
end)

-- أثناء السحب
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
        dragButton.Position = UDim2.new(
            buttonStartPos.X.Scale, 
            buttonStartPos.X.Offset + delta.X,
            buttonStartPos.Y.Scale,
            buttonStartPos.Y.Offset + delta.Y
        )
    end
end)

-- إنهاء السحب
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        Settings.ButtonPosition = dragButton.Position
        
        -- إعادة تأثير الزر
        game:GetService("TweenService"):Create(dragButton, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 215),
            Size = UDim2.new(0, 40, 0, 40)
        }):Play()
    end
end)

-- تبديل عرض/إخفاء الواجهة
local guiVisible = false
dragButton.MouseButton1Click:Connect(function()
    if not dragging then
        guiVisible = not guiVisible
        dragButton.Text = guiVisible and "×" or "☰"
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
        if guiVisible then
            mainFrame.Visible = true
            game:GetService("TweenService"):Create(mainFrame, tweenInfo, {
                Size = UDim2.new(0, 450, 0, 300),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
        else
            game:GetService("TweenService"):Create(mainFrame, tweenInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
        end
    end
end)

-- تأثيرات عند التفاعل مع الزر
dragButton.MouseEnter:Connect(function()
    if not dragging then
        game:GetService("TweenService"):Create(dragButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 150, 255),
            Size = UDim2.new(0, 44, 0, 44)
        }):Play()
    end
end)

dragButton.MouseLeave:Connect(function()
    if not dragging then
        game:GetService("TweenService"):Create(dragButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 215),
            Size = UDim2.new(0, 40, 0, 40)
        }):Play()
    end
end)

-- إضافة محتوى الواجهة (مثال)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = Settings.HubName .. " v" .. Settings.Version
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Parent = mainFrame

-- تبويبات القائمة
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 100, 1, -40)
sideMenu.Position = UDim2.new(0, 0, 0, 40)
sideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = mainFrame

-- محتوى الصفحات
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -110, 1, -50)
contentFrame.Position = UDim2.new(0, 110, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- إشعار عند التحميل
StarterGui:SetCore("SendNotification", {
    Title = Settings.HubName,
    Text = "تم تحميل السكربت بنجاح!",
    Duration = 3,
    Icon = "rbxassetid://7733658504"
})
