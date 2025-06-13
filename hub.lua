local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إعدادات السكربت
local Settings = {
    HubName = "Core X Hub",
    Version = "3.1",
    ButtonPosition = UDim2.new(0, 20, 0.5, -20),
    HubSize = UDim2.new(0, 450, 0, 300),
    HubPosition = UDim2.new(0.5, 0, 0.5, 0)
}

-- ألوان الواجهة
local Colors = {
    Main = Color3.fromRGB(20, 20, 20),
    Button = Color3.fromRGB(0, 120, 215),
    ButtonHover = Color3.fromRGB(0, 150, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TabSelected = Color3.fromRGB(0, 90, 150),
    TabNormal = Color3.fromRGB(40, 40, 40)
}

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = Settings.HubName
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = Settings.HubSize
mainFrame.Position = Settings.HubPosition
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Colors.Main
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = Settings.ButtonPosition
toggleButton.BackgroundColor3 = Colors.Button
toggleButton.Text = "×"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextColor3 = Colors.Text
toggleButton.TextSize = 20
toggleButton.Parent = screenGui

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = toggleButton

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.BackgroundTransparency = 1
title.Text = Settings.HubName
title.Font = Enum.Font.GothamBold
title.TextColor3 = Colors.Text
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local sideMenu = Instance.new("Frame")
sideMenu.Size = UDim2.new(0, 120, 1, -30)
sideMenu.Position = UDim2.new(0, 0, 0, 30)
sideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sideMenu.BorderSizePixel = 0
sideMenu.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -130, 1, -40)
contentFrame.Position = UDim2.new(0, 130, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local pages = {
    Home = {
        Title = "الرئيسية",
        Content = "مرحبًا بك في Core X Hub!\n\nاختر قسمًا من القائمة الجانبية"
    },
    Scripts = {
        Title = "السكربتات",
        Content = "قائمة السكربتات ستظهر هنا"
    },
    Settings = {
        Title = "الإعدادات",
        Content = "خيارات الإعدادات ستظهر هنا"
    }
}

local currentTab = "Home"
local tabButtons = {}

local function createTabButtons()
    local yPos = 10
    for name, page in pairs(pages) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Position = UDim2.new(0, 5, 0, yPos)
        btn.BackgroundColor3 = name == currentTab and Colors.TabSelected or Colors.TabNormal
        btn.BorderSizePixel = 0
        btn.Text = page.Title
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = Colors.Text
        btn.TextSize = 14
        btn.Parent = sideMenu
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            if name ~= currentTab then
                TweenService:Create(btn, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                }):Play()
            end
        end)
        
        btn.MouseLeave:Connect(function()
            if name ~= currentTab then
                TweenService:Create(btn, TweenInfo.new(0.1), {
                    BackgroundColor3 = Colors.TabNormal
                }):Play()
            end
        end)
        
        btn.MouseButton1Click:Connect(function()
            if name ~= currentTab then
                currentTab = name
                for tabName, tabBtn in pairs(tabButtons) do
                    tabBtn.BackgroundColor3 = tabName == name and Colors.TabSelected or Colors.TabNormal
                end
                updateContent()
            end
        end)
        
        tabButtons[name] = btn
        yPos = yPos + 45
    end
end

local function updateContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -20, 1, -20)
    contentLabel.Position = UDim2.new(0, 10, 0, 10)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = pages[currentTab].Content
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextColor3 = Colors.Text
    contentLabel.TextSize = 16
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.Parent = contentFrame
end

local function toggleUI()
    if mainFrame.Visible then
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = Settings.HubPosition
        })
        tween:Play()
        tween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
        toggleButton.Text = "☰"
    else
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0) -- إعداد الحجم صفر قبل التوسع
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = Settings.HubSize,
            Position = Settings.HubPosition
        })
        tween:Play()
        toggleButton.Text = "×"
    end
end

toggleButton.MouseButton1Click:Connect(toggleUI)

toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.ButtonHover,
        Size = UDim2.new(0, 44, 0, 44)
    }):Play()
end)

toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Colors.Button,
        Size = UDim2.new(0, 40, 0, 40)
    }):Play()
end)

createTabButtons()
updateContent()

StarterGui:SetCore("SendNotification", {
    Title = Settings.HubName,
    Text = "تم تحميل الواجهة بنجاح!",
    Duration = 3,
    Icon = "rbxassetid://7733658504"
})
