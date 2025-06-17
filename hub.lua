-- Core X Hub - واجهة احترافية
-- By Zeus

-- الخدمات
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- الحواف العشوائية
local colors = {
	Color3.fromRGB(255, 99, 99),
	Color3.fromRGB(99, 255, 99),
	Color3.fromRGB(99, 99, 255),
	Color3.fromRGB(255, 255, 99),
	Color3.fromRGB(255, 99, 255),
	Color3.fromRGB(99, 255, 255),
}
local edgeColor = colors[math.random(1, #colors)]

-- إنشاء الشاشة
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "CoreXHub"
ScreenGui.ResetOnSpawn = false

-- زر البرغر
local Burger = Instance.new("TextButton", ScreenGui)
Burger.Size = UDim2.new(0, 40, 0, 40)
Burger.Position = UDim2.new(0, -50, 0.5, -20)
Burger.AnchorPoint = Vector2.new(0, 0.5)
Burger.BackgroundColor3 = edgeColor
Burger.Text = "≡"
Burger.TextColor3 = Color3.new(1,1,1)
Burger.Font = Enum.Font.GothamBlack
Burger.TextSize = 24
Burger.BorderSizePixel = 0
Burger.AutoButtonColor = false
Burger.BackgroundTransparency = 0.1
Burger.ZIndex = 10
Burger.ClipsDescendants = true
Burger.Name = "Burger"

-- تحريك الزر
local dragging, dragInput, dragStart, startPos
Burger.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Burger.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Burger.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- الإطار الرئيسي
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderColor3 = edgeColor
Main.BorderSizePixel = 3
Main.Visible = false
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Name = "Main"
Main.BackgroundTransparency = 0.1

-- العنوان
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Core X hub : the best script for anymap"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = edgeColor
Title.TextScaled = true

-- القائمة الجانبية
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40)
Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(30,30,30)
Side.BorderSizePixel = 0

-- أقسام
local Tabs = {"Home", "Settings", "Game", "Character", "Target", "Other", "Misc"}
local Sections = {}
local SelectedTab = nil

for i, name in ipairs(Tabs) do
	local Button = Instance.new("TextButton", Side)
	Button.Size = UDim2.new(1, -10, 0, 40)
	Button.Position = UDim2.new(0, 5, 0, (i - 1) * 45)
	Button.Text = name
	Button.Name = name
	Button.Font = Enum.Font.GothamSemibold
	Button.TextColor3 = Color3.new(1,1,1)
	Button.TextSize = 18
	Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Button.BorderSizePixel = 0
	Button.AutoButtonColor = false

	Button.MouseEnter:Connect(function()
		if SelectedTab ~= name then
			TweenService:Create(Button, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
		end
	end)
	Button.MouseLeave:Connect(function()
		if SelectedTab ~= name then
			TweenService:Create(Button, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
		end
	end)

	local Section = Instance.new("ScrollingFrame", Main)
	Section.Name = name.."Section"
	Section.Size = UDim2.new(1, -160, 1, -50)
	Section.Position = UDim2.new(0, 160, 0, 45)
	Section.CanvasSize = UDim2.new(0,0,5,0)
	Section.ScrollBarThickness = 5
	Section.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Section.Visible = false
	Sections[name] = Section

	Button.MouseButton1Click:Connect(function()
		if SelectedTab then
			local last = Side:FindFirstChild(SelectedTab)
			if last then
				TweenService:Create(last, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
				Sections[SelectedTab].Visible = false
			end
		end
		SelectedTab = name
		TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = edgeColor}):Play()
		Section.Visible = true
	end)

	if i == 1 then
		Button:MouseButton1Click()
	end
end

-- أنيميشن فتح
local function ToggleUI()
	local visible = not Main.Visible
	Main.Visible = true
	local tween = TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Size = visible and UDim2.new(0, 650, 0, 400) or UDim2.new(0, 0, 0, 0),
		Transparency = visible and 0.1 or 1
	})
	tween:Play()
	wait(visible and 0.4 or 0.2)
	Main.Visible = visible
end
Burger.MouseButton1Click:Connect(ToggleUI)

-- إشعار نجاح
local function ShowNotification(success)
	local msg = Instance.new("TextLabel", ScreenGui)
	msg.Size = UDim2.new(0, 300, 0, 50)
	msg.Position = UDim2.new(0.5, -150, 0, -60)
	msg.BackgroundColor3 = success and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
	msg.Text = success and "✅ Loaded Core X Hub!" or "❌ Failed to load!"
	msg.TextColor3 = Color3.new(1,1,1)
	msg.Font = Enum.Font.GothamBold
	msg.TextSize = 20
	msg.BorderSizePixel = 0
	msg.AnchorPoint = Vector2.new(0.5,0)
	
	local sound = Instance.new("Sound", msg)
	sound.SoundId = success and "rbxassetid://6026984224" or "rbxassetid://6026984225"
	sound.Volume = 2
	sound:Play()

	TweenService:Create(msg, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()
	wait(2.5)
	TweenService:Create(msg, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, -60)}):Play()
	wait(0.6)
	msg:Destroy()
end

ShowNotification(true)
