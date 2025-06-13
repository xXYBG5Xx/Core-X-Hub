local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ألوان الحواف
local borderColors = {
    Color3.fromRGB(255, 0, 0),   -- أحمر
    Color3.fromRGB(0, 255, 0),   -- أخضر
    Color3.fromRGB(0, 0, 255),   -- أزرق
    Color3.fromRGB(255, 255, 0), -- أصفر
    Color3.fromRGB(0, 255, 255)  -- سماوي
}
local randomBorderColor = borderColors[math.random(1, #borderColors)]

-- إنشاء ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoreXHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 4
mainFrame.BorderColor3 = randomBorderColor
mainFrame.Parent = screenGui

-- عنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Core X Hub: The Mercy Script"
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Parent = mainFrame

-- قائمة جانبية احترافية
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 130, 1, -30)
sideMenu.Position = UDim2.new(0, 0, 0, 30)
sideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = mainFrame

local function createSideButton(text, yPosition)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, yPosition)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 18
    btn.Parent = sideMenu

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

createSideButton("الرئيسية", 10)
createSideButton("الإعدادات", 55)
createSideButton("حول", 100)

-- زر إغلاق وفتح الواجهة (دائري) فوق في منتصف اليسار
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20) -- 10 بكسل من اليسار، ووسط الشاشة -20 لرفع للنص وسط الزر
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "×"
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleButton.TextSize = 30
toggleButton.AnchorPoint = Vector2.new(0, 0)

-- إضافة UICorner عشان يكون دائري
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0) -- دائري 100%
corner.Parent = toggleButton

toggleButton.Parent = screenGui

local guiVisible = true
toggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    mainFrame.Visible = guiVisible
    if guiVisible then
        toggleButton.Text = "×"
    else
        toggleButton.Text = "☰"
    end
end)
