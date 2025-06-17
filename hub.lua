-- Core X Hub - إصدار GitHub
-- By Zeus

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إعداد الألوان العشوائية
local BorderColors = {
	Color3.fromRGB(255, 99, 99),
	Color3.fromRGB(99, 255, 142),
	Color3.fromRGB(99, 196, 255),
	Color3.fromRGB(197, 99, 255),
	Color3.fromRGB(255, 207, 99),
	Color3.fromRGB(255, 99, 204)
}
local borderColor = BorderColors[math.random(1, #BorderColors)]

-- صوت إشعار
local function playSound(success)
	local sound = Instance.new("Sound", workspace)
	sound.SoundId = success and "rbxassetid://12222242" or "rbxassetid://138212440" -- أصوات عشوائية
	sound:Play()
	game:GetService("Debris"):AddItem(sound, 3)
end

-- إشعار
local function notify(text, success)
	StarterGui:SetCore("SendNotification", {
		Title = success and "✅ Success" or "❌ Failed",
		Text = text,
		Duration = 4
	})
	playSound(success)
end

-- GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CoreXHub"
screenGui.ResetOnSpawn = false

-- إطار الواجهة
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderColor3 = borderColor
mainFrame.BorderSizePixel = 4
mainFrame.BackgroundTransparency = 0.1
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ZIndex = 2
mainFrame.Name = "MainFrame"
mainFrame.AutomaticSize = Enum.AutomaticSize.None
mainFrame:TweenSize(UDim2.new(0, 500, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)

-- زاوية مدورة
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 20)

-- عنوان
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -10, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Core X hub : the best script for anymap"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.TextScaled = true

-- زر برغر
local burger = Instance.new("TextButton", screenGui)
burger.Size = UDim2.new(0, 40, 0, 40)
burger.Position = UDim2.new(0, 10, 0.5, -20)
burger.BackgroundColor3 = borderColor
burger.Text = "≡"
burger.TextScaled = true
burger.TextColor3 = Color3.new(1,1,1)
burger.AutoButtonColor = false
burger.ZIndex = 3
burger.Draggable = true

local burgerCorner = Instance.new("UICorner", burger)
burgerCorner.CornerRadius = UDim.new(1, 0)

-- أقسام
local tabs = {"Home", "Settings", "Game", "Character", "Target", "Other", "Misc"}
local tabButtons = {}
local selectedTab

-- قائمة جانبية
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 120, 1, -50)
sideBar.Position = UDim2.new(0, 0, 0, 45)
sideBar.BackgroundTransparency = 1

-- المحتوى
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -130, 1, -60)
contentFrame.Position = UDim2.new(0, 130, 0, 50)
contentFrame.BackgroundTransparency = 1

-- تبويبات مع ScrollingFrame
local function createTab(name)
	local button = Instance.new("TextButton", sideBar)
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = UDim2.new(0, 5, 0, (#tabButtons) * 35)
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1,1,1)
	button.Font = Enum.Font.Gotham
	button.TextScaled = true
	button.AutoButtonColor = false

	local btnCorner = Instance.new("UICorner", button)
	btnCorner.CornerRadius = UDim.new(0, 8)

	local frame = Instance.new("ScrollingFrame", contentFrame)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.Visible = false
	frame.CanvasSize = UDim2.new(0, 0, 3, 0)
	frame.ScrollBarThickness = 4
	frame.BackgroundTransparency = 0.1
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local frCorner = Instance.new("UICorner", frame)
	frCorner.CornerRadius = UDim.new(0, 10)

	button.MouseButton1Click:Connect(function()
		if selectedTab then
			selectedTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		end
		for _, v in pairs(contentFrame:GetChildren()) do
			if v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end
		button.BackgroundColor3 = borderColor
		frame.Visible = true
		selectedTab = button
	end)

	table.insert(tabButtons, button)
	return frame
end

-- إنشاء كل التبويبات
for _, name in ipairs(tabs) do
	createTab(name)
end

-- أول قسم يظهر
tabButtons[1].MouseButton1Click:Fire()

-- إظهار/إخفاء
local open = true
burger.MouseButton1Click:Connect(function()
	open = not open
	mainFrame:TweenPosition(open and UDim2.new(0.5, -250, 0.5, -175) or UDim2.new(0.5, -250, 2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
end)

-- تشغيل الإشعار
notify("Core X Hub Loaded Successfully!", true)
