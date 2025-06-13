local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إعدادات السكربت الأساسية
local Settings = {
    HubName = "Core X Hub",
    Version = "2.2",
    GitHubRepo = "YOUR_GITHUB_USERNAME/CoreXHub",
    DebugMode = false
}

-- ألوان حواف عشوائية
local borderColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(128, 0, 128)
}
local randomBorderColor = borderColors[math.random(1, #borderColors)]

-- إنشاء واجهة المستخدم الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = Settings.HubName
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- إطار رئيسي مع حواف ملونة عشوائية
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 4
mainFrame.BorderColor3 = randomBorderColor
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

-- شريط العنوان
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.BackgroundTransparency = 1
title.Text = Settings.HubName .. " v" .. Settings.Version
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- زر التبديل المنفصل المدور (الجديد)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, 40, 0, -15) -- وضع منفصل خارج الإطار
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.Text = "×"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextSize = 18
toggleButton.Parent = screenGui

-- جعل الزر مدور بالكامل
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0) -- دائري كامل
buttonCorner.Parent = toggleButton

-- تأثيرات الزر عند التفاعل
toggleButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(toggleButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

toggleButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(toggleButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

toggleButton.MouseButton1Down:Connect(function()
    game:GetService("TweenService"):Create(toggleButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(80, 80, 80),
        Size = UDim2.new(0, 28, 0, 28)
    }):Play()
end)

toggleButton.MouseButton1Up:Connect(function()
    game:GetService("TweenService"):Create(toggleButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Size = UDim2.new(0, 30, 0, 30)
    }):Play()
end)

-- القائمة الجانبية
local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 120, 1, -30)
sideMenu.Position = UDim2.new(0, 0, 0, 30)
sideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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

-- نظام الصفحات
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
            
            local descLabel = Instance.new("TextLabel")
            descLabel.Size = UDim2.new(1, -20, 0, 100)
            descLabel.Position = UDim2.new(0, 10, 0, 80)
            descLabel.BackgroundTransparency = 1
            descLabel.Text = "🌟 مركز سكربتات متكامل\n\n👑 صنع بكل فخر بواسطة Core X Team"
            descLabel.Font = Enum.Font.Gotham
            descLabel.TextColor3 = Color3.new(1, 1, 1)
            descLabel.TextSize = 16
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextYAlignment = Enum.TextYAlignment.Top
            descLabel.Parent = container
        end
    },
    Scripts = {
        Create = function(parent)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 1, 0)
            container.BackgroundTransparency = 1
            container.Parent = parent
            
            local loadingText = Instance.new("TextLabel")
            loadingText.Size = UDim2.new(1, 0, 1, 0)
            loadingText.BackgroundTransparency = 1
            loadingText.Text = "جاري تحميل السكربتات..."
            loadingText.Font = Enum.Font.Gotham
            loadingText.TextColor3 = Color3.new(1, 1, 1)
            loadingText.TextSize = 16
            loadingText.Parent = container
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
        end
    }
}

-- إنشاء أزرار التبويب مع تغيير اللون عند التحديد
local function CreateTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = name == "Home" and Color3.fromRGB(0, 90, 150) or Color3.fromRGB(40, 40, 40)
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
        if currentTab ~= name then
            game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if currentTab ~= name then
            game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            }):Play()
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        if currentTab ~= name then
            -- تغيير لون الزر المحدد
            game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(0, 90, 150)
            }):Play()
            
            -- إعادة ألوان الأزرار الأخرى
            for tabName, tabBtn in pairs(tabButtons) do
                if tabName ~= name then
                    game:GetService("TweenService"):Create(tabBtn, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    }):Play()
                end
            end
            
            currentTab = name
            -- مسح المحتوى الحالي
            for _, child in ipairs(contentFrame:GetChildren()) do
                child:Destroy()
            end
            -- إنشاء المحتوى الجديد
            Tabs[name].Create(contentFrame)
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

-- نظام الإشعارات
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
local isVisible = true
toggleButton.MouseButton1Click:Connect(function()
    if isVisible then
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        toggleButton.Text = "☰"
    else
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 500, 0, 350)
        }):Play()
        toggleButton.Text = "×"
    end
    isVisible = not isVisible
end)

-- التحقق من التحديثات
local function CheckForUpdates()
    local versionFile = LoadScriptFromGitHub("version.txt")
    if versionFile and versionFile ~= Settings.Version then
        ShowNotification("تحديث متاح", "الإصدار "..versionFile.." متاح الآن!", "info")
    end
end

-- تهيئة الواجهة
Tabs.Home.Create(contentFrame)
CheckForUpdates()
ShowNotification(Settings.HubName, "تم تحميل الواجهة بنجاح!", "success")
