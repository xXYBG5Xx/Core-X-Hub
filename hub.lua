local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إعدادات السكربت الأساسية
local Settings = {
    HubName = "Core X Hub",
    Version = "2.0",
    GitHubRepo = "YOUR_GITHUB_USERNAME/CoreXHub", -- استبدل بمعلومات مستودعك
    DebugMode = false
}

-- أصوات محسنة
local Sounds = {
    Click = {Id = "rbxassetid://9118823105", Volume = 0.5},
    Success = {Id = "rbxassetid://6026984224", Volume = 0.7},
    Error = {Id = "rbxassetid://5419098674", Volume = 0.7},
    Notification = {Id = "rbxassetid://4590666636", Volume = 0.5}
}

local function CreateSound(soundData, parent)
    local sound = Instance.new("Sound")
    sound.SoundId = soundData.Id
    sound.Volume = soundData.Volume
    sound.Parent = parent
    return sound
end

-- إنشاء واجهة المستخدم الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = Settings.HubName
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- إطار رئيسي مع تأثيرات
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- تأثير ظل
local uiGradient = Instance.new("UIGradient")
uiGradient.Rotation = 90
uiGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0.5)
})
uiGradient.Parent = mainFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

-- شريط العنوان
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.BackgroundTransparency = 1
title.Text = Settings.HubName .. " v" .. Settings.Version
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 20
closeButton.Parent = titleBar

-- القائمة الجانبية
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 120, 1, -30)
sideMenu.Position = UDim2.new(0, 0, 0, 30)
sideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = mainFrame

-- محتوى الصفحات
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -130, 1, -40)
contentFrame.Position = UDim2.new(0, 130, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local tabButtons = {}
local currentTab = "Home"

-- نظام الصفحات المطور
local Tabs = {
    Home = {
        Create = function(parent)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 1, 0)
            container.BackgroundTransparency = 1
            container.Parent = parent
            
            local welcomeLabel = Instance.new("TextLabel")
            welcomeLabel.Size = UDim2.new(1, -20, 0, 60)
            welcomeLabel.Position = UDim2.new(0, 10, 0, 10)
            welcomeLabel.BackgroundTransparency = 1
            welcomeLabel.Text = "مرحبًا بك في " .. Settings.HubName
            welcomeLabel.Font = Enum.Font.GothamBold
            welcomeLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
            welcomeLabel.TextSize = 18
            welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
            welcomeLabel.Parent = container
            
            -- يمكن إضافة عناصر واجهة مستخدم إضافية هنا
        end
    },
    Scripts = {
        Create = function(parent)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 1, 0)
            container.BackgroundTransparency = 1
            container.Parent = parent
            
            -- قائمة السكربتات ستضاف هنا ديناميكيًا
            local loadingText = Instance.new("TextLabel")
            loadingText.Size = UDim2.new(1, 0, 1, 0)
            loadingText.BackgroundTransparency = 1
            loadingText.Text = "جاري تحميل السكربتات..."
            loadingText.Font = Enum.Font.Gotham
            loadingText.TextColor3 = Color3.new(1, 1, 1)
            loadingText.TextSize = 16
            loadingText.Parent = container
            
            -- سوف يتم ملء هذه القائمة من GitHub
        end
    },
    Settings = {
        Create = function(parent)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 1, 0)
            container.BackgroundTransparency = 1
            container.Parent = parent
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -20, 0, 30)
            title.Position = UDim2.new(0, 10, 0, 10)
            title.BackgroundTransparency = 1
            title.Text = "الإعدادات"
            title.Font = Enum.Font.GothamBold
            title.TextColor3 = Color3.new(1, 1, 1)
            title.TextSize = 18
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = container
            
            -- إضافة عناصر الإعدادات هنا
        end
    }
}

-- إنشاء أزرار التبويب
local function CreateTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.Parent = sideMenu
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {
            BackgroundColor3 = currentTab == name and Color3.fromRGB(0, 90, 150) or Color3.fromRGB(30, 30, 30)
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        if currentTab ~= name then
            currentTab = name
            -- تحديث الواجهة حسب التبويب المحدد
        end
    end)
    
    tabButtons[name] = btn
end

-- إنشاء تبويبات الواجهة
CreateTabButton("Home", 10)
CreateTabButton("Scripts", 50)
CreateTabButton("Settings", 90)

-- نظام التحميل من GitHub
local function LoadScriptFromGitHub(scriptPath)
    local success, result = pcall(function()
        local url = "https://raw.githubusercontent.com/" .. Settings.GitHubRepo .. "/main/" .. scriptPath
        if Settings.DebugMode then
            print("محاولة تحميل السكربت من:", url)
        end
        local response = game:HttpGet(url, true)
        return response
    end)
    
    if success then
        return result
    else
        warn("فشل تحميل السكربت:", result)
        return nil
    end
end

-- نظام الإشعارات المحسن
local function ShowNotification(title, text, notificationType)
    local icon = "rbxassetid://7733658504" -- أيقونة افتراضية
    if notificationType == "error" then
        icon = "rbxassetid://7733660490"
    elseif notificationType == "warning" then
        icon = "rbxassetid://7733686865"
    end
    
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
        Icon = icon
    })
end

-- إخفاء/إظهار الواجهة
closeButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.2)
    screenGui:Destroy()
end)

-- التحقق من التحديثات
local function CheckForUpdates()
    local versionFile = LoadScriptFromGitHub("version.txt")
    if versionFile and versionFile ~= Settings.Version then
        ShowNotification("تحديث متاح", "الإصدار "..versionFile.." متاح الآن!", "info")
        -- يمكن إضافة منطق التحديث التلقائي هنا
    end
end

-- تهيئة الواجهة
Tabs.Home.Create(contentFrame)
CheckForUpdates()
