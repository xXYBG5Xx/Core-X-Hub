-- Core X Hub - إصدار احترافي
-- بواسطة Zeus 

-- الخدمات
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- أصوات
local clickSound = Instance.new("Sound", SoundService)
clickSound.SoundId = "rbxassetid://9118823107"

local notifySound = Instance.new("Sound", SoundService)
notifySound.SoundId = "rbxassetid://6026984224"

-- شاشة GUI
local CoreGui = Instance.new("ScreenGui")
CoreGui.Name = "CoreXHub"
CoreGui.ResetOnSpawn = false
CoreGui.Parent = playerGui

-- تأثير Blur خلف الواجهة (في الإضاءة فقط)
if not game.Lighting:FindFirstChild("CoreXHubBlur") then
    local blur = Instance.new("BlurEffect")
    blur.Size = 12
    blur.Name = "CoreXHubBlur"
    blur.Parent = game.Lighting
end

-- زر البرقر (☰)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.AutoButtonColor = true
ToggleButton.ZIndex = 10
ToggleButton.Parent = CoreGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 330)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.05
MainFrame.Parent = CoreGui
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
MainFrame.ClipsDescendants = true

-- Animation عند الفتح
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
    Size = UDim2.new(0, 650, 0, 330)
}):Play()

-- قائمة التبويبات الجانبية
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 8)

-- تبويبات
local tabs = {
	"Home",
	"Game",
	"Character",
	"Target",
	"Anims",
	"Misc",
	"Credits"
}

local buttons = {}

for i, text in ipairs(tabs) do
	local tab = Instance.new("TextButton", SideBar)
	tab.Size = UDim2.new(1, -20, 0, 32)
	tab.Position = UDim2.new(0, 10, 0, (i - 1) * 40 + 10)
	tab.Text = text
	tab.Font = Enum.Font.GothamSemibold
	tab.TextColor3 = Color3.fromRGB(180, 180, 180) -- لون نص افتراضي رمادي فاتح
	tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tab.TextSize = 14
	tab.AutoButtonColor = false
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)

	tab.MouseButton1Click:Connect(function()
		clickSound:Play()

		-- إعادة اللون الأساسي لكل الأزرار
		for _, other in pairs(buttons) do
			other.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			other.TextColor3 = Color3.fromRGB(180, 180, 180)
		end

		-- تمييز الزر المحدد
		tab.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
		tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	buttons[i] = tab
end

-- تعيين التبويب الأول كافتراضي محدد
buttons[1].BackgroundColor3 = Color3.fromRGB(70, 130, 180)
buttons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- الصفحة الرئيسية
local HomeFrame = Instance.new("Frame", MainFrame)
HomeFrame.Position = UDim2.new(0, 160, 0, 0)
HomeFrame.Size = UDim2.new(1, -160, 1, 0)
HomeFrame.BackgroundTransparency = 1

-- صورة اللاعب
local thumb = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
local Avatar = Instance.new("ImageLabel", HomeFrame)
Avatar.Size = UDim2.new(0, 100, 0, 100)
Avatar.Position = UDim2.new(0, 10, 0, 10)
Avatar.Image = thumb
Avatar.BackgroundTransparency = 1

-- معلومات اللاعب
local Info = Instance.new("TextLabel", HomeFrame)
Info.Text = "@"..player.DisplayName.."\nاضغط [☰] لاخفاء/إظهار الواجهة\nFree User : حالة الاشتراك\nللاشتراك تفضل دسكورد Core X"
Info.Position = UDim2.new(0, 120, 0, 10)
Info.Size = UDim2.new(1, -130, 0, 100)
Info.Font = Enum.Font.Gotham
Info.TextSize = 16
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.BackgroundTransparency = 1
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top

-- مربع الحقوق
local Box = Instance.new("TextLabel", HomeFrame)
Box.Size = UDim2.new(1, -20, 0, 90)
Box.Position = UDim2.new(0, 10, 0, 120)
Box.Text = [[جميع الحقوق محفوظة لسيرفر Core X
المطورين غير مسؤولين عن سوء الاستخدام.
نتمنى ان يعجبك السكربت.]]
Box.Font = Enum.Font.Gotham
Box.TextSize = 16
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.BackgroundTransparency = 0.3
Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Box.TextWrapped = true
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

-- إشعار ترحيبي
StarterGui:SetCore("SendNotification", {
	Title = "Core X Hub",
	Text = "تم تشغيل Core X Hub بنجاح!",
	Duration = 5
})
notifySound:Play()

-- التحكم بزر البرقر
local opened = true
ToggleButton.MouseButton1Click:Connect(function()
	clickSound:Play()
	opened = not opened
	TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
		Size = opened and UDim2.new(0, 650, 0, 330) or UDim2.new(0, 0, 0, 0)
	}):Play()
end)
