-- Core X Hub - واجهة احترافية مدمجة
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local borderColors = {
	Color3.fromRGB(255, 70, 70),
	Color3.fromRGB(70, 255, 135),
	Color3.fromRGB(80, 160, 255),
	Color3.fromRGB(255, 200, 60),
	Color3.fromRGB(170, 80, 255)
}
local borderColor = borderColors[math.random(1, #borderColors)]

if playerGui:FindFirstChild("CoreXHub") then
	playerGui.CoreXHub:Destroy()
end

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "CoreXHub"
gui.ResetOnSpawn = false

local burger = Instance.new("TextButton", gui)
burger.Size = UDim2.new(0, 40, 0, 40)
burger.Position = UDim2.new(0, 10, 0.5, -20)
burger.Text = "☰"
burger.TextSize = 26
burger.Font = Enum.Font.GothamBlack
burger.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
burger.TextColor3 = Color3.new(1, 1, 1)
burger.ZIndex = 3

Instance.new("UICorner", burger).CornerRadius = UDim.new(0, 8)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 550, 0, 330)
main.Position = UDim2.new(0.5, -275, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderColor3 = borderColor
main.BorderSizePixel = 3
main.Visible = true
main.Active = true
main.Draggable = true
main.ZIndex = 2
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(0, 120, 1, 0)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local tabLayout = Instance.new("UIListLayout", tabFrame)
tabLayout.FillDirection = Enum.FillDirection.Vertical
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)

local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1, -120, 1, 0)
content.Position = UDim2.new(0, 120, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local clickSound = Instance.new("Sound", gui)
clickSound.SoundId = "rbxassetid://9118823102"
clickSound.Volume = 1

local successSound = Instance.new("Sound", gui)
successSound.SoundId = "rbxassetid://9118825008"
successSound.Volume = 1

local function showNotification(text, success)
	local notif = Instance.new("TextLabel", gui)
	notif.Size = UDim2.new(0, 300, 0, 40)
	notif.Position = UDim2.new(0.5, -150, 0.1, 0)
	notif.BackgroundColor3 = success and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(200, 60, 60)
	notif.Text = text
	notif.TextColor3 = Color3.new(1,1,1)
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 16
	notif.AnchorPoint = Vector2.new(0.5, 0)
	notif.BackgroundTransparency = 0
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
	TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
	wait(2)
	TweenService:Create(notif, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	wait(0.6)
	notif:Destroy()
end

-- الأقسام ومحتواها
local sections = {
	Home = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "مرحباً بك في Core X Hub"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.GothamBold
		lbl.TextSize = 24
	end,

	Game = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "وظائف التخريب هنا"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end,

	Character = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "معلومات وتحكمات اللاعب"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end,

	Target = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "استهداف لاعبين"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end,

	Anims = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "قائمة الانميشنات"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end,

	Misc = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "أدوات متنوعة"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end,

	Credits = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "جميع الحقوق محفوظة لـ Core X"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 18
	end,

	Setting = function(frame)
		local lbl = Instance.new("TextLabel", frame)
		lbl.Text = "إعدادات السكربت"
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.TextColor3 = Color3.new(1,1,1)
		lbl.BackgroundTransparency = 1
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 20
	end
}

-- إنشاء تبويب
local function createTab(name, label)
	local btn = Instance.new("TextButton", tabFrame)
	btn.Size = UDim2.new(1, -8, 0, 32)
	btn.Text = label .. " | " .. name
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		for _, t in pairs(tabFrame:GetChildren()) do
			if t:IsA("TextButton") then
				t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			end
		end
		btn.BackgroundColor3 = borderColor
		content:ClearAllChildren()
		clickSound:Play()
		local suc = pcall(function()
			sections[name](content)
		end)
		showNotification("تم فتح قسم " .. name, suc)
		if suc then successSound:Play() end
	end)
end

-- التبويبات
local tabs = {
	{"Home", "الرئيسية"},
	{"Game", "التخريب"},
	{"Character", "اللاعب"},
	{"Target", "استهداف"},
	{"Anims", "انميشنات"},
	{"Misc", "أخرى"},
	{"Credits", "الحقوق"},
	{"Setting", "الإعدادات"}
}

for _, tab in ipairs(tabs) do
	createTab(tab[1], tab[2])
end

burger.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	clickSound:Play()
end)

sections["Home"](content)
