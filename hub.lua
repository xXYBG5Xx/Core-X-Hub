local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- مكتبة UI خارجية
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/edJT9EGX"))()
local Window = Library:CreateWindow("VR7 TEAM: The Mercy Script")

-- 🔻 زر فتح/إغلاق جانبي بالزر M
UserInputService.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.M and not gp then
		Library:ToggleUI()
	end
end)

-- 🔊 صوت واجهة
local function playSound()
	local sound = Instance.new("Sound", player:WaitForChild("PlayerGui"))
	sound.SoundId = "rbxassetid://9118823100"
	sound.Volume = 1
	sound:Play()
	game:GetService("Debris"):AddItem(sound, 2)
end

-- ✅ Home | الرئيسية
local HomeTab = Window:CreateTab("🏠 Home")
HomeTab:CreateLabel("مرحباً " .. player.DisplayName .. " (@" .. player.Name .. ")")
HomeTab:CreateLabel("اضغط [M] لفتح/إغلاق الواجهة")

-- صورة اللاعب
local thumbnailUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
HomeTab:CreateLabel("صورة اللاعب:")
HomeTab:CreateLabel(thumbnailUrl)

-- صوت ترحيبي
HomeTab:CreateButton("تشغيل صوت ترحيبي", function()
	playSound()
end)

-- إشعار بسيط
HomeTab:CreateButton("عرض إشعار", function()
	StarterGui:SetCore("SendNotification", {
		Title = "VR7 Script",
		Text = "أهلاً بك في الهب الاحترافي!",
		Duration = 5
	})
end)

HomeTab:CreateParagraph("جميع الحقوق محفوظة لفريق VR7\nنحن غير مسؤولين عن سوء الاستخدام.\nاستمتع بالواجهة الجديدة 👑")

-- باقي التبويبات (مؤقتاً بدون تفاصيلها)
Window:CreateTab("🎮 Game")
Window:CreateTab("👤 Character")
Window:CreateTab("🎯 Target")
Window:CreateTab("🎞️ Anims")
Window:CreateTab("🧪 Misc")
Window:CreateTab("📜 Credits")

-- مظهر تبويبات ديناميكي
for _, tab in pairs(Window.Tabs) do
	if tab.TabButton then
		local button = tab.TabButton
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button.MouseEnter:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end)
		button.MouseLeave:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		end)
	end
end
