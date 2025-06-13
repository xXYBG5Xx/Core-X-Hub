local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- أصوات
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9118823105"
clickSound.Volume = 1
clickSound.Parent = playerGui

local successSound = Instance.new("Sound")
successSound.SoundId = "rbxassetid://6026984224"
successSound.Volume = 1
successSound.Parent = playerGui

local failSound = Instance.new("Sound")
failSound.SoundId = "rbxassetid://5419098674"
failSound.Volume = 1
failSound.Parent = playerGui

-- ألوان حواف عشوائية
local borderColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 255)
}
local randomBorderColor = borderColors[math.random(1, #borderColors)]

-- GUI الرئيسي
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
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- العنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Core X Hub"
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

-- محتوى الصفحة
local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, 0, 1, 0)
contentLabel.BackgroundTransparency = 1
contentLabel.TextWrapped = true
contentLabel.TextYAlignment = Enum.TextYAlignment.Top
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.Font = Enum.Font.SourceSans
contentLabel.TextSize = 18
contentLabel.TextColor3 = Color3.new(1, 1, 1)
contentLabel.Text = "Welcome to Core X Hub!\n\n🌟 Powerful features\n👑 Made by Core X Team"
contentLabel.Parent = contentFrame

-- الصفحات
local pages = {
	["Home"] = "Welcome to Core X Hub!\n\n🌟 Powerful features\n👑 Made by Core X Team",
	["Settings"] = "⚙️ Settings\n\n- Customize your experience.",
	["About"] = "📄 About\n\nThis hub is created for Roblox users.\n- Developer: Core X Team"
}

-- إنشاء أزرار جانبية
local function createSideButton(name, yPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.BorderSizePixel = 0
	btn.Text = name
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

	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		local tweenOut = TweenService:Create(contentLabel, TweenInfo.new(0.2), {TextTransparency = 1})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		contentLabel.Text = pages[name] or "No content"
		local tweenIn = TweenService:Create(contentLabel, TweenInfo.new(0.2), {TextTransparency = 0})
		tweenIn:Play()
	end)
end

createSideButton("Home", 10)
createSideButton("Settings", 55)
createSideButton("About", 100)

-- زر الإخفاء والإظهار
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

-- إشعار صوتي مرئي عند جلب السكربت
local function showNotification(title, text, success)
	StarterGui:SetCore("SendNotification", {
		Title = title;
		Text = text;
		Duration = 4;
		Icon = success and "rbxassetid://7733658504" or "rbxassetid://7733660490";
	})
	if success then
		successSound:Play()
	else
		failSound:Play()
	end
end

-- تجربة تحميل السكربت
local success, err = pcall(function()
	loadstring("print('Script Loaded from Server!')")()
end)

if success then
	showNotification("Core X Hub", "Script Loaded Successfully!", true)
else
	showNotification("Core X Hub", "Failed to load script.", false)
end
