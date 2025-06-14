-- Core X Hub - إصدار واجهة فقط
-- بواسطة Zeus

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة الواجهة القديمة لو كانت موجودة
if playerGui:FindFirstChild("CoreXHub") then
	playerGui:FindFirstChild("CoreXHub"):Destroy()
end

-- ألوان الحواف العشوائية
local borderColors = {
	Color3.fromRGB(255, 85, 85),
	Color3.fromRGB(85, 255, 127),
	Color3.fromRGB(85, 170, 255),
	Color3.fromRGB(255, 170, 0),
	Color3.fromRGB(170, 85, 255),
	Color3.fromRGB(0, 255, 255)
}
local randomColor = borderColors[math.random(1, #borderColors)]

-- واجهة رئيسية
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "CoreXHub"
ScreenGui.ResetOnSpawn = false

-- زر البرغر
local BurgerButton = Instance.new("TextButton")
BurgerButton.Name = "BurgerButton"
BurgerButton.Parent = ScreenGui
BurgerButton.AnchorPoint = Vector2.new(0.5, 0.5)
BurgerButton.Position = UDim2.new(0, 30, 0.5, 0)
BurgerButton.Size = UDim2.new(0, 40, 0, 40)
BurgerButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BurgerButton.Text = "≡"
BurgerButton.TextSize = 20
BurgerButton.TextColor3 = Color3.new(1, 1, 1)
BurgerButton.AutoButtonColor = true
BurgerButton.BorderSizePixel = 0
BurgerButton.ClipsDescendants = true
BurgerButton.BackgroundTransparency = 0.1
BurgerButton.ZIndex = 2
BurgerButton.Font = Enum.Font.GothamBold
BurgerButton.BorderMode = Enum.BorderMode.Outline
BurgerButton.BorderColor3 = randomColor
BurgerButton.UICorner = Instance.new("UICorner", BurgerButton)
BurgerButton.UICorner.CornerRadius = UDim.new(1, 0)

-- نافذة الواجهة
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- الحواف
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 16)

-- إطار الحواف المتغيرة اللون
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = randomColor
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- العنوان
local Title = Instance.new("TextLabel", MainFrame)
Title.Name = "Title"
Title.Text = "Core X Hub"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 10)
Title.Size = UDim2.new(1, -40, 0, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- الأقسام الجانبية
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.Size = UDim2.new(0, 130, 1, -60)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.BorderSizePixel = 0

local sideCorner = Instance.new("UICorner", Sidebar)
sideCorner.CornerRadius = UDim.new(0, 10)

-- أسماء الأقسام
local sections = {
	"Home", "Setting", "Game", "Player", "Target", "Misc", "Credits"
}

for i, name in ipairs(sections) do
	local btn = Instance.new("TextButton", Sidebar)
	btn.Name = name .. "Btn"
	btn.Text = name
	btn.Size = UDim2.new(1, -10, 0, 32)
	btn.Position = UDim2.new(0, 5, 0, (i - 1) * 36)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.AutoButtonColor = true
	btn.BorderSizePixel = 0

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = randomColor}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
	end)
end

-- زر إظهار/إخفاء القائمة
local isOpen = true
BurgerButton.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	MainFrame.Visible = isOpen
end)

-- تأثير إشعار عند التشغيل
StarterGui:SetCore("SendNotification", {
	Title = "Core X Hub",
	Text = "تم تشغيل الواجهة بنجاح",
	Duration = 3
})

-- صوت بسيط
local sound = Instance.new("Sound", playerGui)
sound.SoundId = "rbxassetid://9118823102" -- صوت نقر بسيط
sound.Volume = 1

BurgerButton.MouseButton1Click:Connect(function()
	sound:Play()
end)
