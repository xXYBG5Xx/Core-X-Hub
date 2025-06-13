-- CoreXHub Script UI for Roblox
-- Author: Core X Team
-- Github Project Ready Version

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- إنشاء الـ ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoreXHubGui"
screenGui.Parent = game.CoreGui -- لضمان عدم اختفاء الواجهة عند الموت

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- رسالة ترحيب
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -20, 0, 40)
welcomeLabel.Position = UDim2.new(0, 10, 0, 10)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextColor3 = Color3.new(1, 1, 1)
welcomeLabel.Text = "مرحباً بك في Core X Script Hub"
welcomeLabel.Font = Enum.Font.ArialBold
welcomeLabel.TextSize = 24
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.Parent = mainFrame

-- إطار الصور (صورة المستخدم وصورة حسابه مع حد بينهم)
local imagesFrame = Instance.new("Frame")
imagesFrame.Size = UDim2.new(1, -20, 0, 100)
imagesFrame.Position = UDim2.new(0, 10, 0, 60)
imagesFrame.BackgroundTransparency = 1
imagesFrame.Parent = mainFrame

local function createImageLabel(imageId, position)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 90, 0, 90)
    imageLabel.Position = position
    imageLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    imageLabel.BorderSizePixel = 2
    imageLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
    imageLabel.Image = imageId
    imageLabel.ScaleType = Enum.ScaleType.Fit
    imageLabel.Parent = imagesFrame
    return imageLabel
end

local userAvatarImageId = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"
local userImage = createImageLabel(userAvatarImageId, UDim2.new(0, 0, 0, 0))
local robloxImage = createImageLabel(userAvatarImageId, UDim2.new(0, 110, 0, 0))

-- حد (Divider) بين الصورتين
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0, 2, 1, 0)
divider.Position = UDim2.new(0, 100, 0, 0)
divider.BackgroundColor3 = Color3.new(1, 1, 1)
divider.BackgroundTransparency = 0.7
divider.Parent = imagesFrame

-- قسم Player Info
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Size = UDim2.new(1, -20, 0, 110)
playerInfoFrame.Position = UDim2.new(0, 10, 0, 170)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerInfoFrame.BorderSizePixel = 0
playerInfoFrame.Parent = mainFrame

-- صورة اللاعب بجانب مربع الكتابة
local playerImage = Instance.new("ImageLabel")
playerImage.Size = UDim2.new(0, 60, 0, 60)
playerImage.Position = UDim2.new(0, 10, 0, 10)
playerImage.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
playerImage.BorderSizePixel = 1
playerImage.BorderColor3 = Color3.fromRGB(255, 255, 255)
playerImage.Image = ""
playerImage.ScaleType = Enum.ScaleType.Fit
playerImage.Parent = playerInfoFrame

-- مربع نص لاختيار اللاعب (يدعم الكتابة وحفظ أول حروف للاسم)
local playerTextBox = Instance.new("TextBox")
playerTextBox.Size = UDim2.new(1, -90, 0, 60)
playerTextBox.Position = UDim2.new(0, 80, 0, 10)
playerTextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
playerTextBox.TextColor3 = Color3.new(1, 1, 1)
playerTextBox.Font = Enum.Font.Arial
playerTextBox.TextSize = 22
playerTextBox.PlaceholderText = "أكتب اسم اللاعب هنا"
playerTextBox.ClearTextOnFocus = false
playerTextBox.Parent = playerInfoFrame

-- أزرار الأوامر أسفل مربع النص
local buttonNames = {"طرده", "نقله لك", "تنقله لك", "VIEW"}
local buttons = {}

for i, name in ipairs(buttonNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 30)
    btn.Position = UDim2.new(0, 10 + (i - 1) * 90, 0, 80)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.ArialBold
    btn.TextSize = 18
    btn.Text = name
    btn.Parent = playerInfoFrame
    buttons[name] = btn
end

-- وظيفة للبحث عن لاعب بناءً على بداية الاسم (case insensitive)
local function findPlayerByPartialName(partial)
    if partial == "" then return nil end
    partial = partial:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():sub(1, #partial) == partial then
            return plr
        end
    end
    return nil
end

-- تحديث صورة اللاعب حسب الاسم المكتوب
local function updatePlayerImage()
    local plr = findPlayerByPartialName(playerTextBox.Text)
    if plr then
        playerImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=420&h=420"
    else
        playerImage.Image = ""
    end
end

playerTextBox:GetPropertyChangedSignal("Text"):Connect(updatePlayerImage)

-- أفعال الأزرار
buttons["طرده"].MouseButton1Click:Connect(function()
    local plr = findPlayerByPartialName(playerTextBox.Text)
    if plr then
        -- تنفيذ أمر الطرد (يحتاج صلاحيات خاصة)
        local success, err = pcall(function()
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/kick " .. plr.Name, "All")
        end)
        if not success then
            warn("فشل تنفيذ أمر الطرد: " .. tostring(err))
        end
    end
end)

buttons["نقله لك"].MouseButton1Click:Connect(function()
    local plr = findPlayerByPartialName(playerTextBox.Text)
    if plr and plr.Character and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, 3)
    end
end)

buttons["تنقله لك"].MouseButton1Click:Connect(function()
    local plr = findPlayerByPartialName(playerTextBox.Text)
    if plr and plr.Character and LocalPlayer.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, 3)
    end
end)

buttons["VIEW"].MouseButton1Click:Connect(function()
    local plr = findPlayerByPartialName(playerTextBox.Text)
    if plr then
        -- هنا تضع كود التنقل للسيرفر الخاص باللاعب (بحسب API موجودة لديك)
        print("طلب عرض اللاعب:", plr.Name)
        -- مثال:
        -- TeleportService:TeleportToPlaceInstance(placeId, plr.GameId, LocalPlayer)
    end
end)
