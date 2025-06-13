local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- الأصوات (نفس السابق)
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

-- ألوان حواف عشوائية (نفس السابق)
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

-- وظائف مساعدة لجلب الصور من روبلوكس
local function getPlayerThumbnail(userId)
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420

	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	return content
end

-- الصفحة الرئيسية "Home" مع صور المستخدم و الروبكس
local function createHomePage()
	-- حذف محتويات contentFrame
	contentFrame:ClearAllChildren()

	local welcomeLabel = Instance.new("TextLabel")
	welcomeLabel.Size = UDim2.new(1, 0, 0, 30)
	welcomeLabel.Position = UDim2.new(0, 0, 0, 0)
	welcomeLabel.BackgroundTransparency = 1
	welcomeLabel.Font = Enum.Font.SourceSansBold
	welcomeLabel.TextColor3 = Color3.new(1,1,1)
	welcomeLabel.TextSize = 22
	welcomeLabel.Text = "Welcome to Core X Hub!"
	welcomeLabel.Parent = contentFrame

	-- اسم اللاعب
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0, 25)
	nameLabel.Position = UDim2.new(0, 0, 0, 40)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.SourceSans
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.TextSize = 18
	nameLabel.Text = "Player: "..player.Name
	nameLabel.Parent = contentFrame

	-- صورة اللاعب (الوجه)
	local playerImg = Instance.new("ImageLabel")
	playerImg.Size = UDim2.new(0, 100, 0, 100)
	playerImg.Position = UDim2.new(0, 10, 0, 70)
	playerImg.BackgroundTransparency = 1
	playerImg.Image = getPlayerThumbnail(player.UserId)
	playerImg.Parent = contentFrame

	-- صورة الروبوت الخاص باللاعب (مثلاً شخصية Roblox)
	-- نستخدم نفس الصورة هنا للسهولة، ممكن تستبدل بمصدر آخر
	local avatarImg = Instance.new("ImageLabel")
	avatarImg.Size = UDim2.new(0, 100, 0, 100)
	avatarImg.Position = UDim2.new(0, 130, 0, 70)
	avatarImg.BackgroundTransparency = 1
	avatarImg.Image = getPlayerThumbnail(player.UserId) -- لو تحب تغيرها في المستقبل
	avatarImg.Parent = contentFrame

	local avatarLabel = Instance.new("TextLabel")
	avatarLabel.Size = UDim2.new(0, 100, 0, 20)
	avatarLabel.Position = UDim2.new(0, 130, 0, 175)
	avatarLabel.BackgroundTransparency = 1
	avatarLabel.Font = Enum.Font.SourceSans
	avatarLabel.TextColor3 = Color3.new(1,1,1)
	avatarLabel.TextSize = 16
	avatarLabel.Text = "Your Avatar"
	avatarLabel.TextXAlignment = Enum.TextXAlignment.Center
	avatarLabel.Parent = contentFrame
end

-- الصفحة الخاصة بعرض معلومات لاعب معين مع إدخال اسم والزر
local function createPlayerInfoPage()
	contentFrame:ClearAllChildren()

	local inputLabel = Instance.new("TextLabel")
	inputLabel.Size = UDim2.new(1, 0, 0, 25)
	inputLabel.Position = UDim2.new(0, 0, 0, 0)
	inputLabel.BackgroundTransparency = 1
	inputLabel.Font = Enum.Font.SourceSansBold
	inputLabel.TextColor3 = Color3.new(1,1,1)
	inputLabel.TextSize = 20
	inputLabel.Text = "Enter Player Username:"
	inputLabel.Parent = contentFrame

	local inputBox = Instance.new("TextBox")
	inputBox.Size = UDim2.new(0, 250, 0, 30)
	inputBox.Position = UDim2.new(0, 0, 0, 30)
	inputBox.ClearTextOnFocus = false
	inputBox.Font = Enum.Font.SourceSans
	inputBox.TextSize = 18
	inputBox.PlaceholderText = "Player Username"
	inputBox.Text = ""
	inputBox.Parent = contentFrame

	local playerImage = Instance.new("ImageLabel")
	playerImage.Size = UDim2.new(0, 150, 0, 150)
	playerImage.Position = UDim2.new(0, 0, 0, 70)
	playerImage.BackgroundTransparency = 1
	playerImage.Image = ""
	playerImage.Parent = contentFrame

	-- أزرار الإجراءات تحت الصورة
	local buttonNames = {"Kick", "Teleport To You", "Teleport To Player", "View Server"}
	local buttons = {}

	for i, btnName in ipairs(buttonNames) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 150, 0, 35)
		btn.Position = UDim2.new(0, 160, 0, 70 + (i - 1) * 45)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.BorderSizePixel = 0
		btn.Text = btnName
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

		buttons[btnName] = btn
	end

	local targetPlayer = nil

	local function updatePlayerInfo(username)
		local foundPlayer = Players:FindFirstChild(username)
		if foundPlayer then
			targetPlayer = foundPlayer
			playerImage.Image = getPlayerThumbnail(foundPlayer.UserId)
			inputBox.TextColor3 = Color3.new(1,1,1)
			successSound:Play()
		else
			-- نحاول جلب الـ UserId عبر API إذا ما وجدناه في السيرفر
			local success, result = pcall(function()
				return Players:GetUserIdFromNameAsync(username)
			end)
			if success and result then
				targetPlayer = nil
				playerImage.Image = getPlayerThumbnail(result)
				inputBox.TextColor3 = Color3.new(1,1,1)
				successSound:Play()
			else
				playerImage.Image = ""
				inputBox.TextColor3 = Color3.fromRGB(255, 100, 100)
				failSound:Play()
				targetPlayer = nil
			end
		end
	end

	-- حدث تغيير النص في مربع الإدخال
	inputBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local username = inputBox.Text:match("^%s*(.-)%s*$") -- Trim spaces
			if username and #username > 0 then
				updatePlayerInfo(username)
			end
		end
	end)

	-- أزرار الإجراءات مع تحكم بدائي (تحتاج RemoteEvents للخادم)
	buttons["Kick"].MouseButton1Click:Connect(function()
		if targetPlayer and targetPlayer:IsDescendantOf(Players) then
			clickSound:Play()
			-- مثال: تنفيذ طرد عن طريق RemoteEvent (يجب إضافته في الخادم)
			game.ReplicatedStorage:FindFirstChild("KickPlayerEvent"):FireServer(targetPlayer)
		else
			failSound:Play()
		end
	end)

	buttons["Teleport To You"].MouseButton1Click:Connect(function()
		if targetPlayer and targetPlayer:IsDescendantOf(Players) then
			clickSound:Play()
			game.ReplicatedStorage:FindFirstChild("TeleportToYouEvent"):FireServer(targetPlayer)
		else
			failSound:Play()
		end
	end)

	buttons["Teleport To Player"].MouseButton1Click:Connect(function()
		if targetPlayer and targetPlayer:IsDescendantOf(Players) then
			clickSound:Play()
			game.ReplicatedStorage:FindFirstChild("TeleportToPlayerEvent"):FireServer(targetPlayer)
		else
			failSound:Play()
		end
	end)

	buttons["View Server"].MouseButton1Click:Connect(function()
		if targetPlayer then
			clickSound:Play()
			-- هذه عملية معقدة تحتاج تواصل مع سيرفرات أخرى عبر API خارجي أو TeleportService
			-- لذلك هنا مجرد رسالة تنبيه مؤقتة
			StarterGui:SetCore("SendNotification", {
				Title = "Core X Hub";
				Text = "View Server is a complex feature, needs backend support.";
				Duration = 5;
			})
		else
			failSound:Play()
		end
	end)
end

-- تعريف الصفحات
local pages = {
	["Home"] = createHomePage,
	["Player Info"] = createPlayerInfoPage,
	["Settings"] = function()
		contentFrame:ClearAllChildren()
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.TextWrapped = true
		label.TextYAlignment = Enum.TextYAlignment.Top
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Font = Enum.Font.SourceSans
		label.TextSize = 18
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Text = "⚙️ Settings\n\n- Customize your experience."
		label.Parent = contentFrame
	end,
	["About"] = function()
		contentFrame:ClearAllChildren()
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.TextWrapped = true
		label.TextYAlignment = Enum.TextYAlignment.Top
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Font = Enum.Font.SourceSans
		label.TextSize = 18
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Text = "📄 About\n\nThis hub is created for Roblox users.\n- Developer: Core X Team"
		label.Parent = contentFrame
	end
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
		if pages[name] then
			pages[name]()
		else
			contentFrame:ClearAllChildren()
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.TextWrapped = true
			label.TextYAlignment = Enum.TextYAlignment.Top
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Font = Enum.Font.SourceSans
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.Text = "No content"
			label.Parent = contentFrame
		end
	end)
end

createSideButton("Home", 10)
createSideButton("Player Info", 55)
createSideButton("Settings", 100)
createSideButton("About", 145)

-- زر الإخفاء والإظهار (نفس السابق)
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

-- إشعار صوتي مرئي عند جلب السكربت (نفس السابق)
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

-- تجربة تحميل السكربت (نفس السابق)
local success, err = pcall(function()
	loadstring("print('Script Loaded from Server!')")()
end)

if success then
	showNotification("Core X Hub", "Script Loaded Successfully!", true)
else
	showNotification("Core X Hub", "Failed to load script.", false)
end

-- استدعاء الصفحة الافتراضية عند التشغيل
createHomePage()
