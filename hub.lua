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
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 4
mainFrame.BorderColor3 = randomBorderColor
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
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

-- زر إغلاق وفتح الواجهة في الركن الأسفل الأيسر
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 35, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 1, -45) -- 10 بكسل من اليسار، و 45 بكسل من الأسفل
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "×"
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleButton.TextSize = 28
toggleButton.AnchorPoint = Vector2.new(0, 0)
toggleButton.Parent = screenGui -- مهم: الزر خارج الإطار الرئيسي ليظل ظاهر دائمًا

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
