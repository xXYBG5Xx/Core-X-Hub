local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- RemoteEvents للطلبات للسيرفر (راح أشرح لك لاحقاً كيف تضيفها)
local KickPlayerEvent = ReplicatedStorage:FindFirstChild("KickPlayerEvent")
local TeleportToPlayerEvent = ReplicatedStorage:FindFirstChild("TeleportToPlayerEvent")
local ViewPlayerServerEvent = ReplicatedStorage:FindFirstChild("ViewPlayerServerEvent")

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
mainFrame.Size = UDim2.new(0, 480, 0, 350)
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
sideMenu.Size = UDim2.new(0, 140, 1, -30)
sideMenu.Position = UDim2.new(0, 0, 0, 30)
sideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = mainFrame

-- محتوى الصفحات
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -150, 1, -40)
contentFrame.Position = UDim2.new(0, 150, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- محتوى الصفحة (متحرك للنص)
local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, 0, 1, 0)
contentLabel.BackgroundTransparency = 1
contentLabel.TextWrapped = true
contentLabel.TextYAlignment = Enum.TextYAlignment.Top
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.Font = Enum.Font.SourceSans
contentLabel.TextSize = 18
contentLabel.TextColor3 = Color3.new(1, 1, 1)
contentLabel.Parent = contentFrame

-- وظيفة جلب صورة المستخدم (ImageLabel)
local function getPlayerThumbnail(userId)
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size48x48
	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	return content
end

-- صفحة Home: صورة المستخدم + رسالة الترحيب
local function createHomeContent()
	-- نمسح المحتوى القديم
	contentFrame:ClearAllChildren()

	local playerImage = Instance.new("ImageLabel")
	playerImage.Size = UDim2.new(0, 80, 0, 80)
	playerImage.Position = UDim2.new(0, 0, 0, 10)
	playerImage.BackgroundTransparency = 1
	playerImage.Image = getPlayerThumbnail(player.UserId)
	playerImage.Parent = contentFrame

	local welcomeLabel = Instance.new("TextLabel")
	welcomeLabel.Size = UDim2.new(1, -90, 0, 80)
	welcomeLabel.Position = UDim2.new(0, 90, 0, 10)
	welcomeLabel.BackgroundTransparency = 1
	welcomeLabel.Font = Enum.Font.SourceSansBold
	welcomeLabel.TextColor3 = Color3.new(1, 1, 1)
	welcomeLabel.TextSize = 20
	welcomeLabel.TextWrapped = true
	welcomeLabel.Text = "Welcome to Core X Hub!\n\n🌟 Powerful features\n👑 Made by Core X Team"
	welcomeLabel.Parent = contentFrame
end

-- صفحة Settings (مثال)
local function createSettingsContent()
	contentLabel.Text = "⚙️ Settings\n\n- Customize your experience."
end

-- صفحة About (مثال)
local function createAboutContent()
	contentLabel.Text = "📄 About\n\nThis hub is created for Roblox users.\n- Developer: Core X Team"
end

-- صفحة Player Info مع البحث والعمليات
local function createPlayerInfoContent()
	-- نمسح المحتوى القديم
	contentFrame:ClearAllChildren()

	-- صندوق البحث
	local searchBox = Instance.new("TextBox")
	searchBox.Size = UDim2.new(0, 220, 0, 35)
	searchBox.Position = UDim2.new(0, 0, 0, 10)
	searchBox.PlaceholderText = "Enter player name..."
	searchBox.ClearTextOnFocus = false
	searchBox.Font = Enum.Font.SourceSans
	searchBox.TextSize = 18
	searchBox.TextColor3 = Color3.new(1, 1, 1)
	searchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	searchBox.Parent = contentFrame

	-- صورة اللاعب المحدد (جانب صندوق البحث)
	local playerImage = Instance.new("ImageLabel")
	playerImage.Size = UDim2.new(0, 48, 0, 48)
	playerImage.Position = UDim2.new(0, 230, 0, 10)
	playerImage.BackgroundTransparency = 1
	playerImage.Image = ""
	playerImage.Parent = contentFrame

	-- اسم اللاعب الحالي المحدد
	local selectedPlayer = nil

	-- دالة تحديث صورة اللاعب بناء على الاسم
	local function updateSelectedPlayer(name)
		if name == "" then
			selectedPlayer = nil
			playerImage.Image = ""
			return
		end

		-- نبحث اللاعب بأول تطابق مع بداية الاسم (case-insensitive)
		local lowerName = name:lower()
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Name:lower():sub(1, #lowerName) == lowerName then
				selectedPlayer = plr
				playerImage.Image = getPlayerThumbnail(plr.UserId)
				return
			end
		end
		-- لم يتم العثور على لاعب
		selectedPlayer = nil
		playerImage.Image = ""
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		updateSelectedPlayer(searchBox.Text)
	end)

	-- أزرار العمليات
	local buttonNames = {"Kick", "Teleport To", "Bring To Me", "View Server"}
	local buttons = {}

	for i, name in ipairs(buttonNames) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 120, 0, 35)
		btn.Position = UDim2.new(0, (i-1)*125, 0, 60)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.BorderSizePixel = 0
		btn.Text = name
		btn.Font = Enum.Font.SourceSans
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.TextSize = 18
		btn.Parent = contentFrame

		btn.MouseEnter:Connect(function()
			btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		end)
		btn.MouseLeave:Connect(function()
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end)

		btn.MouseButton1Click:Connect(function()
			clickSound:Play()
			if not selectedPlayer then
				failSound:Play()
				StarterGui:SetCore("SendNotification", {
					Title = "Core X Hub",
					Text = "Please select a valid player first.",
					Duration = 3,
					Icon = "rbxassetid://7733660490",
				})
				return
			end

			if name == "Kick" then
				if KickPlayerEvent then
					KickPlayerEvent:FireServer(selectedPlayer)
				end
			elseif name == "Teleport To" then
				if TeleportToPlayerEvent then
					TeleportToPlayerEvent:FireServer(selectedPlayer)
				end
			elseif name == "Bring To Me" then
				if TeleportToPlayerEvent then
					-- تبسيط، نستخدم نفس الحدث مع علم مختلف ممكن تعدله بالسيرفر
					TeleportToPlayerEvent:FireServer(player, selectedPlayer)
				end
			elseif name == "View Server" then
				if ViewPlayerServerEvent then
					ViewPlayerServerEvent:FireServer(selectedPlayer)
				end
			end
		end)

		buttons[name] = btn
	end
end

-- الصفحات
local pages = {
	Home = createHomeContent,
	Settings = createSettingsContent,
	About = createAboutContent,
	["Player Info"] = createPlayerInfoContent,
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
		-- عرض الصفحة
		local pageFunc = pages[name]
		if pageFunc then
			pageFunc()
		else
			contentLabel.Text = "No content"
		end
	end)
end

-- أزرار القائمة الجانبية
createSideButton("Home", 10)
createSideButton("Player Info", 55)
createSideButton("Settings", 100)
createSideButton("About", 145)

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

-- إشعار صوتي مرئي عند جلب السكربت (تجربة)
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

-- افتح صفحة Home بشكل تلقائي
createHomeContent()
