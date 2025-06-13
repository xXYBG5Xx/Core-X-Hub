-- Core X Hub مع زر إخفاء وإطار ملون عشوائي
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ألوان عشوائية للإطار (الحواف)
local borderColors = {
	Color3.fromRGB(170, 0, 255),
	Color3.fromRGB(0, 170, 255),
	Color3.fromRGB(0, 255, 170),
	Color3.fromRGB(255, 85, 0),
	Color3.fromRGB(255, 0, 127),
	Color3.fromRGB(0, 255, 255)
}
local randomBorderColor = borderColors[math.random(1, #borderColors)]

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoreXHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- خلفية ثابتة
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
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

-- قائمة جانبية
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 130, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local categories = {
	"Home | القائمة الرئيسية",
	"Game | التخريب",
	"Character | اللاعب",
	"Target | استهداف",
	"Anims | انميشنات",
	"Misc | أخرى",
	"Credits | الحقوق"
}

for i, text in ipairs(categories) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 25)
	button.Position = UDim2.new(0, 0, 0, (i - 1) * 26)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.SourceSans
	button.TextSize = 16
	button.Parent = sidebar
end

-- صورة اللاعب
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size150x150
local content, isReady = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)

local playerImage = Instance.new("ImageLabel")
playerImage.Size = UDim2.new(0, 100, 0, 100)
playerImage.Position = UDim2.new(0, 140, 0, 40)
playerImage.BackgroundTransparency = 0.2
playerImage.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
playerImage.Image = content
playerImage.Parent = mainFrame

-- نص ترحيبي
local homeText = Instance.new("TextLabel")
homeText.Position = UDim2.new(0, 250, 0, 40)
homeText.Size = UDim2.new(0, 180, 0, 200)
homeText.BackgroundTransparency = 1
homeText.TextColor3 = Color3.new(1, 1, 1)
homeText.Font = Enum.Font.SourceSans
homeText.TextSize = 18
homeText.TextXAlignment = Enum.TextXAlignment.Left
homeText.TextYAlignment = Enum.TextYAlignment.Top
homeText.TextWrapped = true
homeText.Text = [[
@]] .. player.Name .. [[

صباح النور

اضغط [B] لإخفاء الواجهة
Free User : حالة الاشتراك

للاشتراك تفضل دسكورد Core X

جميع الحقوق محفوظة لسيرفر Core X
المطورين غير مسؤولين عن سوء الاستخدام

نتمنى ان يعجبك السكربت.
]]
homeText.Parent = mainFrame

-- زر إظهار/إخفاء
local visible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.B then
		visible = not visible
		mainFrame.Visible = visible
	end
end)
