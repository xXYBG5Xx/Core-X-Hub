-- سكربت رئيسي Script Hub للهاك دلتا روبلوكس

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- إزالة واجهة قديمة إذا موجودة
local existingGui = PlayerGui:FindFirstChild("ScriptHubGUI")
if existingGui then existingGui:Destroy() end

-- إنشاء ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubGUI"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 420)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- العنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Delta Roblox Hack Script Hub"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = mainFrame

-- التابات
local tabs = {"Home", "Character"}
local tabButtons = {}
local pages = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 40)
    btn.Position = UDim2.new(0, (i-1)*120, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = tabName
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Parent = mainFrame
    tabButtons[tabName] = btn

    local pageFrame = Instance.new("Frame")
    pageFrame.Size = UDim2.new(1, 0, 1, -90)
    pageFrame.Position = UDim2.new(0, 0, 0, 90)
    pageFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    pageFrame.Visible = false
    pageFrame.Parent = mainFrame
    pages[tabName] = pageFrame

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do
            p.Visible = false
        end
        pages[tabName].Visible = true
    end)
end

-- إظهار الصفحة الرئيسية Home عند البداية
pages["Home"].Visible = true

-- محتوى Home
local homeText = Instance.new("TextLabel")
homeText.Size = UDim2.new(1, -40, 1, -40)
homeText.Position = UDim2.new(0, 20, 0, 20)
homeText.BackgroundTransparency = 1
homeText.TextColor3 = Color3.new(1, 1, 1)
homeText.TextWrapped = true
homeText.TextYAlignment = Enum.TextYAlignment.Top
homeText.Font = Enum.Font.SourceSans
homeText.TextSize = 18
homeText.Text = [[
مرحباً بك في Delta Roblox Hack Script Hub!

في هذا السكربت هاب يمكنك التحكم باللاعبين داخل اللعبة:
- طردهم
- نقلهم لك أو التنقل إليهم
- الدخول إلى نفس السيرفر معهم
- مشاهدة صورتهم ومعلوماتهم

الرجاء استخدام الأدوات بمسؤولية.
]]
homeText.Parent = pages["Home"]

-- =================
-- قسم Character
-- =================
local charPage = pages["Character"]

local inputLabel = Instance.new("TextLabel")
inputLabel.Size = UDim2.new(0, 150, 0, 30)
inputLabel.Position = UDim2.new(0, 20, 0, 15)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "اسم اللاعب:"
inputLabel.TextColor3 = Color3.new(1,1,1)
inputLabel.Font = Enum.Font.SourceSans
inputLabel.TextSize = 18
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = charPage

local playerNameBox = Instance.new("TextBox")
playerNameBox.Size = UDim2.new(0, 250, 0, 30)
playerNameBox.Position = UDim2.new(0, 20, 0, 50)
playerNameBox.PlaceholderText = "ادخل اسم اللاعب"
playerNameBox.ClearTextOnFocus = false
playerNameBox.Font = Enum.Font.SourceSans
playerNameBox.TextSize = 18
playerNameBox.Parent = charPage

local searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(0, 100, 0, 30)
searchBtn.Position = UDim2.new(0, 280, 0, 50)
searchBtn.Text = "بحث"
searchBtn.Font = Enum.Font.SourceSans
searchBtn.TextSize = 18
searchBtn.Parent = charPage

local playerImage = Instance.new("ImageLabel")
playerImage.Size = UDim2.new(0, 100, 0, 100)
playerImage.Position = UDim2.new(0, 20, 0, 100)
playerImage.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerImage.Parent = charPage
playerImage.Visible = false
playerImage.BorderSizePixel = 1
playerImage.BorderColor3 = Color3.new(1, 1, 1)

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0, 360, 0, 100)
infoLabel.Position = UDim2.new(0, 140, 0, 100)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextWrapped = true
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextSize = 16
infoLabel.Text = ""
infoLabel.Parent = charPage

-- أزرار التحكم باللاعب
local buttonNames = {
    "ادخل السيرفر معه",
    "انتقل إليه",
    "انقله لك",
    "اطرده من السيرفر",
    "مشاهدة معلوماته"
}
local buttons = {}
for i, name in ipairs(buttonNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.Position = UDim2.new(0, 140, 0, 210 + (i-1)*45)
    btn.Text = name
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = charPage
    btn.Visible = false
    buttons[i] = btn
end

local foundPlayer = nil

-- دالة إيجاد اللاعب
local function findPlayer(name)
    name = name:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower() == name then
            return p
        end
    end
    return nil
end

-- عند الضغط على بحث
searchBtn.MouseButton1Click:Connect(function()
    local name = playerNameBox.Text
    if name == "" then return end

    local p = findPlayer(name)
    if p then
        foundPlayer = p
        playerImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p.UserId .. "&width=100&height=100&format=png"
        playerImage.Visible = true
        infoLabel.Text = "اسم اللاعب: "..p.Name.."\nUserId: "..p.UserId.."\nحالة الاتصال: متصل\n" -- ممكن تضيف معلومات أخرى حسب دلتا

        for _, btn in pairs(buttons) do
            btn.Visible = true
        end
    else
        foundPlayer = nil
        playerImage.Visible = false
        infoLabel.Text = "لم يتم العثور على اللاعب"
        for _, btn in pairs(buttons) do
            btn.Visible = false
        end
    end
end)

-- دالة تنفيذ أمر هاك (عدل حسب طريقة دلتا)
local function executeCommand(command)
    print("تنفيذ الأمر: "..command)
    -- هنا تضيف كود ارسال الأمر الى دلتا API أو البروتوكول اللي تستخدمه
end

-- ربط الأزرار بالأوامر
buttons[1].MouseButton1Click:Connect(function()
    if foundPlayer then
        executeCommand("joinserver "..foundPlayer.Name)
    end
end)

buttons[2].MouseButton1Click:Connect(function()
    if foundPlayer then
        executeCommand("tp "..foundPlayer.Name)
    end
end)

buttons[3].MouseButton1Click:Connect(function()
    if foundPlayer then
        executeCommand("bring "..foundPlayer.Name)
    end
end)

buttons[4].MouseButton1Click:Connect(function()
    if foundPlayer then
        executeCommand("kick "..foundPlayer.Name)
    end
end)

buttons[5].MouseButton1Click:Connect(function()
    if foundPlayer then
        executeCommand("view "..foundPlayer.Name)
    end
end)
