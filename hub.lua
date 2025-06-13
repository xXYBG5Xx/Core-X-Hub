local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ألوان الحواف
local borderColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 255)
}
local randomBorderColor = borderColors[math.random(1, #borderColors)]

-- شاشة الواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoreXHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 4
mainFrame.BorderColor3 = randomBorderColor
mainFrame.Parent = screenGui

-- العنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Core X Hub: The Mercy Script | كور إكس هب"
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Parent = mainFrame

-- القائمة الجانبية
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

createSideButton("Home | الرئيسية", 10)
createSideButton("Settings | الإعدادات", 55)
createSideButton("About | حول", 100)

-- محتوى الترحيب
local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, -140, 1, -40)
welcomeText.Position = UDim2.new(0, 140, 0, 35)
welcomeText.BackgroundTransparency = 1
welcomeText.TextWrapped = true
welcomeText.TextYAlignment = Enum.TextYAlignment.Top
welcomeText.TextXAlignment = Enum.TextXAlignment.Left
welcomeText.Font = Enum.Font.SourceSans
welcomeText.TextSize = 18
welcomeText.TextColor3 = Color3.new(1, 1, 1)
welcomeText.Text = [[
Welcome to Core X Hub: The Mercy Script 🌟
مرحباً بك في كور إكس هب: سكربت ميرسي

⚙️ Features | المميزات:
- Powerful tools | أدوات قوية
- Easy to use | سهل الاستخدام
- Custom sections | أقسام مخصصة

👑 Developed by: Core X Team
]]
welcomeText.Parent = mainFrame

-- زر فتح/إغلاق دائري في يسار منتصف الشاشة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.AnchorPoint = Vector2.new(0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "×"
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleButton.TextSize = 28
toggleButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = toggleButton

local guiVisible = true
toggleButton.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	mainFrame.Visible = guiVisible
	toggleButton.Text = guiVisible and "×" or "☰"
end)
