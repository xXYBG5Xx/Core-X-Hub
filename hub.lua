-- Core X Hub - واجهة احترافية
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ألوان الحواف المتغيرة
local borderColors = {
	Color3.fromRGB(255, 70, 70),
	Color3.fromRGB(70, 255, 135),
	Color3.fromRGB(80, 160, 255),
	Color3.fromRGB(255, 200, 60),
	Color3.fromRGB(170, 80, 255)
}
local borderColor = borderColors[math.random(1, #borderColors)]

-- إزالة النسخة القديمة
if playerGui:FindFirstChild("CoreXHub") then
	playerGui.CoreXHub:Destroy()
end

-- الواجهة الرئيسية
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CoreXHub"
screenGui.ResetOnSpawn = false

-- زر البرغر - في المنتصف يسار
local burger = Instance.new("TextButton", screenGui)
burger.Size = UDim2.new(0, 40, 0, 40)
burger.Position = UDim2.new(0, 10, 0.5, -20)
burger.Text = "☰"
burger.TextSize = 26
burger.Font = Enum.Font.GothamBlack
burger.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
burger.TextColor3 = Color3.new(1, 1, 1)
burger.ZIndex = 3

local burgerCorner = Instance.new("UICorner", burger)
burgerCorner.CornerRadius = UDim.new(0, 8)

-- الإطار الرئيسي في منتصف الشاشة
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 550, 0, 330)
main.Position = UDim2.new(0.5, -275, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderColor3 = borderColor
main.BorderSizePixel = 3
main.Visible = true
main.Active = true
main.Draggable = true
main.ZIndex = 2

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

-- قائمة التبويبات
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(0, 120, 1, 0)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local tabLayout = Instance.new("UIListLayout", tabFrame)
tabLayout.FillDirection = Enum.FillDirection.Vertical
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)

-- المحتوى
local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1, -120, 1, 0)
content.Position = UDim2.new(0, 120, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0, 8)

-- صوت الضغط
local clickSound = Instance.new("Sound", screenGui)
clickSound.SoundId = "rbxassetid://9118823102"
clickSound.Volume = 1

-- صوت نجاح التحميل
local successSound = Instance.new("Sound", screenGui)
successSound.SoundId = "rbxassetid://9118825008"
successSound.Volume = 1

-- إشعار
local function showNotification(text, success)
	local notif = Instance.new("TextLabel", screenGui)
	notif.Size = UDim2.new(0, 300, 0, 40)
	notif.Position = UDim2.new(0.5, -150, 0.1, 0)
	notif.BackgroundColor3 = success and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(200, 60, 60)
	notif.Text = text
	notif.TextColor3 = Color3.new(1,1,1)
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 16
	notif.AnchorPoint = Vector2.new(0.5, 0)
	notif.BackgroundTransparency = 0

	local uiCorner = Instance.new("UICorner", notif)
	uiCorner.CornerRadius = UDim.new(0, 8)

	TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
	wait(2)
	TweenService:Create(notif, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	wait(0.6)
	notif:Destroy()
end

-- تحميل القسم
local function loadSection(name)
	content:ClearAllChildren()
	clickSound:Play()
	local suc, err = pcall(function()
		loadfile("Sections/" .. name .. ".lua")()
	end)

	if suc then
		showNotification("✅ تم تحميل " .. name, true)
		successSound:Play()
	else
		warn(err)
		showNotification("❌ فشل تحميل " .. name, false)
	end
end

-- إنشاء زر تبويب
local function createTab(name, label)
	local btn = Instance.new("TextButton", tabFrame)
	btn.Size = UDim2.new(1, -8, 0, 32)
	btn.Text = label .. " | " .. name
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.BorderSizePixel = 0

	local bCorner = Instance.new("UICorner", btn)
	bCorner.CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		for _, t in pairs(tabFrame:GetChildren()) do
			if t:IsA("TextButton") then
				t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			end
		end
		btn.BackgroundColor3 = borderColor
		loadSection(name)
	end)
end

-- الأقسام
local tabs = {
	{"Home", "الرئيسية"},
	{"Game", "التخريب"},
	{"Character", "اللاعب"},
	{"Target", "استهداف"},
	{"Anims", "انميشنات"},
	{"Misc", "أخرى"},
	{"Credits", "الحقوق"}
}

-- إنشاء التبويبات
for _, v in ipairs(tabs) do
	createTab(v[1], v[2])
end

-- زر الإظهار والإخفاء
burger.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	clickSound:Play()
end)

-- تحميل القسم الأول تلقائياً
loadSection("Home")
