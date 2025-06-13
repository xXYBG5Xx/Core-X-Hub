local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
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

-- الصوت
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://12222216" -- صوت بسيط (تقدر تغيّره)
clickSound.Volume = 0.5
clickSound.Name = "ClickSound"
clickSound.Parent = playerGui

-- GUI
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

-- محتوى الصفحات
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -140, 1, -40)
contentFrame.Position = UDim2.new(0, 140, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- محتويات كل صفحة
local pages = {}

pages["Home"] = [[
Welcome to Core X Hub: The Mercy Script 🌟
مرحباً بك في كور إكس هب: سكربت ميرسي

⚙️ Features | المميزات:
- Powerful tools | أدوات قوية
- Easy to use | سهل الاستخدام
- Custom sections | أقسام مخصصة

👑 Developed by: Core X Team
]]

pages["Settings"] = [[
⚙️ Settings | الإعدادات

- Coming soon... | قريباً
]]

pages["About"] = [[
📄 About | حول

- Core X Hub is a free Lua script interface.
- Created for Roblox lovers 💙

كور إكس هب هو سكربت مجاني لمحبي روبلوكس.
]]

-- نص الصفحة المعروضة
local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, 0, 1, 0)
contentLabel.BackgroundTransparency = 1
contentLabel.TextWrapped = true
contentLabel.TextYAlignment = Enum.TextYAlignment.Top
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.Font = Enum.Font.SourceSans
contentLabel.TextSize = 18
contentLabel.TextColor3 = Color3.new(1, 1, 1)
contentLabel.Text = pages["Home"]
contentLabel.Parent = contentFrame

-- زرار القائمة
local function createSideButton(name, yPosition)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, yPosition)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.BorderSizePixel = 0
	btn.Text = name
	btn.Font = Enum.Font.SourceSans
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextSize = 18
	btn.Parent = sideMenu

	local function animatePage()
		clickSound:Play()
		local tweenOut = TweenService:Create(contentLabel, TweenInfo.new(0.25), {TextTransparency = 1})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		contentLabel.Text = pages[name:match("^([^|]+)"):gsub("%s+", "")] or "No content"
		local tweenIn = TweenService:Create(contentLabel, TweenInfo.new(0.25), {TextTransparency = 0})
		tweenIn:Play()
	end

	btn.MouseButton1Click:Connect(animatePage)

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

-- زر إخفاء/إظهار
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
	clickSound:Play()
	guiVisible = not guiVisible
	mainFrame.Visible = guiVisible
	toggleButton.Text = guiVisible and "×" or "☰"
end)
