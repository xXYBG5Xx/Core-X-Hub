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

-- Main GUI
local CoreGui = Instance.new("ScreenGui", playerGui)
CoreGui.Name = "CoreXHub"
CoreGui.ResetOnSpawn = false

-- زر الإخفاء/الإظهار
local toggleKey = Enum.KeyCode.B
local visible = true
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == toggleKey then
		visible = not visible
		CoreGui.Enabled = visible
	end
end)

-- خلفية
local MainFrame = Instance.new("Frame", CoreGui)
MainFrame.Size = UDim2.new(0, 650, 0, 330)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.05

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- القائمة الجانبية
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 4)

-- Tabs
local tabs = {
	"Home | القائمة الرئيسية",
	"Game | التخريب",
	"Character | اللاعب",
	"Target | استهداف",
	"Anims | انميشنات",
	"Misc | أخرى",
	"Credits | الحقوق"
}

for i, text in ipairs(tabs) do
	local tab = Instance.new("TextButton", SideBar)
	tab.Size = UDim2.new(1, -10, 0, 30)
	tab.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 10)
	tab.Text = text
	tab.Font = Enum.Font.GothamSemibold
	tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tab.TextSize = 14
	tab.AutoButtonColor = false
	tab.MouseButton1Click:Connect(function()
		clickSound:Play()
	end)
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 4)
end

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

-- بيانات
local Info = Instance.new("TextLabel", HomeFrame)
Info.Text = "@"..player.DisplayName.."\nاضغط [B] لاخفاء الواجهة\nFree User : حالة الاشتراك\nللاشتراك تفضل دسكورد Core X"
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
Box.BackgroundTransparency = 0.4
Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Box.TextWrapped = true
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

-- إشعار ترحيبي
StarterGui:SetCore("SendNotification", {
	Title = "Core X Hub",
	Text = "تم تشغيل Core X Hub بنجاح!",
	Duration = 5
})
notifySound:Play()
