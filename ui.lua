local UI = {}

-- خدمات روبلوكس الأساسية
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function UI.CreateMain()
    -- تلوين عشوائي للـ Stroke وحرف X عند الحقن
    local randomColor = Color3.fromRGB(math.random(50, 255), math.random(50, 255), math.random(50, 255))
    local robloxBgColor = Color3.fromRGB(36, 37, 38)
    local robloxButtonColor = Color3.fromRGB(57, 59, 61)

    -- الشاشة الرئيسية
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CoreX_Gui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- حماية السكربت من الظهور في التسجيل (إذا كان المحقن يدعمها)
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    -- الفريم الرئيسي (تجاوبي مع الشاشات)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = robloxBgColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = randomColor
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- ميزة سحب الفريم (Draggable)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)

    -- التوب بار (Top Bar)
    local TopBar = Instance.new("TextButton")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0.12, 0)
    TopBar.BackgroundColor3 = robloxBgColor
    TopBar.BorderSizePixel = 0
    TopBar.Text = ""
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar

    -- اسم السكربت (نص مقسم لتلوين الـ X)
    local TitleFrame = Instance.new("Frame")
    TitleFrame.Size = UDim2.new(0.6, 0, 1, 0)
    TitleFrame.BackgroundTransparency = 1
    TitleFrame.Parent = TopBar

    local TitleLayout = Instance.new("UIListLayout")
    TitleLayout.FillDirection = Enum.FillDirection.Horizontal
    TitleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TitleLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TitleLayout.Parent = TitleFrame

    local Title1 = Instance.new("TextLabel")
    Title1.Text = " فعاليات رسم العرب | Core-"
    Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title1.TextSize = 16
    Title1.Font = Enum.Font.SourceSansBold
    Title1.Size = UDim2.new(0, 160, 1, 0)
    Title1.BackgroundTransparency = 1
    Title1.Parent = TitleFrame

    local TitleX = Instance.new("TextLabel")
    TitleX.Text = "X"
    TitleX.TextColor3 = randomColor
    TitleX.TextSize = 16
    TitleX.Font = Enum.Font.SourceSansBold
    TitleX.Size = UDim2.new(0, 15, 1, 0)
    TitleX.BackgroundTransparency = 1
    TitleX.Parent = TitleFrame

    -- زر إغلاق السكربت (X) في التوب بار
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Size = UDim2.new(0.08, 0, 0.8, 0)
    CloseBtn.Position = UDim2.new(0.9, 0, 0.1, 0)
    CloseBtn.BackgroundColor3 = robloxButtonColor
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Parent = TopBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

    -- البوتوم بار (Bottom Bar)
    local BottomBar = Instance.new("Frame")
    BottomBar.Name = "BottomBar"
    BottomBar.Size = UDim2.new(1, 0, 0.08, 0)
    BottomBar.Position = UDim2.new(0, 0, 0.92, 0)
    BottomBar.BackgroundColor3 = robloxBgColor
    BottomBar.BorderSizePixel = 0
    BottomBar.Parent = MainFrame

    local BottomCorner = Instance.new("UICorner")
    BottomCorner.CornerRadius = UDim.new(0, 8)
    BottomCorner.Parent = BottomBar

    local Credits = Instance.new("TextLabel")
    Credits.Size = UDim2.new(1, 0, 1, 0)
    Credits.Text = "@xXYBG5Xx "
    Credits.TextColor3 = randomColor
    Credits.TextSize = 12
    Credits.Font = Enum.Font.SourceSansItalic
    Credits.BackgroundTransparency = 1
    Credits.Parent = BottomBar

    -- القائمة الجانبية للأقسام (Sidebar)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0.25, 0, 0.8, 0)
    Sidebar.Position = UDim2.new(0, 0, 0.12, 0)
    Sidebar.BackgroundColor3 = robloxBgColor
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.Parent = Sidebar

    local sections = {"Info", "Cheat", "Spam", "Fun", "Skin"}
    for _, secName in ipairs(sections) do
        local SecBtn = Instance.new("TextButton")
        SecBtn.Name = secName.."Btn"
        SecBtn.Size = UDim2.new(0.9, 0, 0, 35)
        SecBtn.BackgroundColor3 = robloxButtonColor
        SecBtn.Text = "      " .. secName -- مسافة مكان الأيقونة اليدوية
        SecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SecBtn.Font = Enum.Font.SourceSansBold
        SecBtn.TextSize = 14
        SecBtn.Parent = Sidebar
        Instance.new("UICorner", SecBtn).CornerRadius = UDim.new(0, 6)

        -- أيقونة يدوية (تستطيع استبدال المعرف لاحقاً)
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Size = UDim2.new(0, 20, 0, 20)
        Icon.Position = UDim2.new(0, 5, 0.2, 0)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxassetid://0" -- ضع معرف الصورة هنا
        Icon.Parent = SecBtn
    end

    -- زر القفل والفتح العائم (Floating Toggle Button)
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "CoreX_Toggle"
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
    ToggleBtn.BackgroundColor3 = robloxBgColor
    ToggleBtn.Image = "rbxassetid://0" -- ضع معرف صورتك هنا للقفل والفتح
    ToggleBtn.Visible = false
    ToggleBtn.Parent = ScreenGui
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 25)
    local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
    ToggleStroke.Color = randomColor
    ToggleStroke.Thickness = 2

    -- سحب الزر العائم
    local tDragging, tStartPos, tDragStart
    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tDragging = true
            tDragStart = input.Position
            tStartPos = ToggleBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if tDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - tDragStart
            ToggleBtn.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then tDragging = false end
    end)

    -- آلية فتح وإخفاء الفريم عبر التوب بار والزر العائم
    local isOpen = true
    local function toggleUI()
        isOpen = not isOpen
        MainFrame.Visible = isOpen
        ToggleBtn.Visible = not isOpen
    end
    TopBar.MouseButton1Click:Connect(toggleUI)
    ToggleBtn.MouseButton1Click:Connect(toggleUI)

    -- فريم تأكيد قفل السكربت النهائي
    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Name = "ConfirmFrame"
    ConfirmFrame.Size = UDim2.new(0.6, 0, 0.4, 0)
    ConfirmFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
    ConfirmFrame.BackgroundColor3 = robloxBgColor
    ConfirmFrame.Visible = false
    ConfirmFrame.ZIndex = 10
    ConfirmFrame.Parent = MainFrame
    Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", ConfirmFrame).Color = Color3.fromRGB(255, 0, 0)

    local ConfirmText = Instance.new("TextLabel")
    ConfirmText.Size = UDim2.new(1, 0, 0.5, 0)
    ConfirmText.Text = "هل أنت متأكد أنك تريد قفل السكربت؟"
    ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmText.Font = Enum.Font.SourceSansBold
    ConfirmText.TextSize = 16
    ConfirmText.BackgroundTransparency = 1
    ConfirmText.Parent = ConfirmFrame

    local YesBtn = Instance.new("TextButton")
    YesBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
    YesBtn.Position = UDim2.new(0.08, 0, 0.6, 0)
    YesBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    YesBtn.Text = "تأكيد"
    YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    YesBtn.Parent = ConfirmFrame
    Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 4)

    local NoBtn = Instance.new("TextButton")
    NoBtn.Size = UDim2.new(0.4, 0, 0.3, 0)
    NoBtn.Position = UDim2.new(0.52, 0, 0.6, 0)
    NoBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    NoBtn.Text = "إلغاء"
    NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoBtn.Parent = ConfirmFrame
    Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 4)

    CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
    NoBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
    YesBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    return ScreenGui
end

-- دالة الإشعارات الجانبية (Notify)
function UI.Notify(title, msg, duration)
    local NotificationGui = game:GetService("CoreGui"):FindFirstChild("CoreX_NotifyGui") or Instance.new("ScreenGui")
    NotificationGui.Name = "CoreX_NotifyGui"
    NotificationGui.Parent = game:GetService("CoreGui")

    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 220, 0, 60)
    NotifFrame.Position = UDim2.new(1, -240, 0.85, 0)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(36, 37, 38)
    NotifFrame.Parent = NotificationGui
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", NotifFrame)
    stroke.Color = Color3.fromRGB(0, 255, 100)

    local Txt = Instance.new("TextLabel")
    Txt.Size = UDim2.new(1, -10, 1, -10)
    Txt.Position = UDim2.new(0, 5, 0, 5)
    Txt.Text = title .. "\n" .. msg
    Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    Txt.TextSize = 14
    Txt.Font = Enum.Font.SourceSansBold
    Txt.BackgroundTransparency = 1
    Txt.Parent = NotifFrame

    task.wait(duration or 3)
    NotifFrame:Destroy()
end

return UI
