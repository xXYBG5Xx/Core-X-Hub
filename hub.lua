-- Modern Core X Hub - Stylish Rounded Script Hub
-- Designed for GitHub

local CoreXHub = {}

-- Color palette
local colors = {
    background = Color3.fromRGB(28, 28, 30),
    secondary = Color3.fromRGB(44, 44, 46),
    accent = Color3.fromHSV(math.random(), 0.8, 0.9),
    text = Color3.fromRGB(242, 242, 247),
    button = Color3.fromRGB(72, 72, 74)
}

-- Animation service
local ts = game:GetService("TweenService")

-- Modern easing styles
local easeOut = Enum.EasingStyle.Quint
local easeInOut = Enum.EasingStyle.Quad

-- Notification system with modern design
function CoreXHub:Notify(title, message, success)
    local sound = Instance.new("Sound")
    sound.SoundId = success and "rbxassetid://4590662766" or "rbxassetid://4590662766"
    sound.Parent = game:GetService("SoundService")
    sound:Play()

    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0.3, 0, 0, 60)
    notif.Position = UDim2.new(0.5, 0, 0.05, 0)
    notif.AnchorPoint = Vector2.new(0.5, 0)
    notif.BackgroundColor3 = success and Color3.fromRGB(48, 219, 91) or Color3.fromRGB(255, 69, 58)
    notif.BorderSizePixel = 0
    notif.ZIndex = 100
    notif.Parent = self.MainFrame

    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0, 12)

    local shadow = Instance.new("ImageLabel", notif)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 14, 1, 14)
    shadow.Position = UDim2.new(0, -7, 0, -7)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = 99

    local titleLabel = Instance.new("TextLabel", notif)
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local messageLabel = Instance.new("TextLabel", notif)
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
    messageLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.new(1, 1, 1)
    messageLabel.TextScaled = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Animate in
    notif.Position = UDim2.new(0.5, 0, 0, -70)
    ts:Create(notif, TweenInfo.new(0.3, easeOut), {Position = UDim2.new(0.5, 0, 0.05, 0)}):Play()

    -- Animate out after delay
    task.delay(3, function()
        ts:Create(notif, TweenInfo.new(0.3, easeOut), {Position = UDim2.new(0.5, 0, 0, -70)}):Play()
        task.delay(0.3, function() notif:Destroy() end)
    end)
end

-- Create modern GUI
function CoreXHub:Create()
    -- Create main screen GUI
    local player = game:GetService("Players").LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "ModernCoreXHub"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Create separate burger button
    local burgerBtn = Instance.new("TextButton")
    burgerBtn.Name = "BurgerButton"
    burgerBtn.Size = UDim2.new(0, 50, 0, 50)
    burgerBtn.Position = UDim2.new(0.02, 0, 0.5, 0)
    burgerBtn.AnchorPoint = Vector2.new(0, 0.5)
    burgerBtn.BackgroundColor3 = colors.button
    burgerBtn.Text = "≡"
    burgerBtn.TextColor3 = colors.text
    burgerBtn.TextSize = 24
    burgerBtn.Font = Enum.Font.GothamBold
    burgerBtn.AutoButtonColor = false
    burgerBtn.Parent = gui

    -- Burger button styling
    local burgerCorner = Instance.new("UICorner", burgerBtn)
    burgerCorner.CornerRadius = UDim.new(0, 12)
    
    local burgerShadow = Instance.new("ImageLabel", burgerBtn)
    burgerShadow.Name = "Shadow"
    burgerShadow.Size = UDim2.new(1, 10, 1, 10)
    burgerShadow.Position = UDim2.new(0, -5, 0, -5)
    burgerShadow.BackgroundTransparency = 1
    burgerShadow.Image = "rbxassetid://1316045217"
    burgerShadow.ImageColor3 = Color3.new(0, 0, 0)
    burgerShadow.ImageTransparency = 0.7
    burgerShadow.ScaleType = Enum.ScaleType.Slice
    burgerShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    burgerShadow.ZIndex = -1

    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = colors.background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = gui

    -- Modern rounded corners
    local mainCorner = Instance.new("UICorner", mainFrame)
    mainCorner.CornerRadius = UDim.new(0, 16)

    -- Subtle border
    local border = Instance.new("Frame", mainFrame)
    border.Name = "Border"
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = colors.accent
    border.BorderSizePixel = 0
    border.ZIndex = -1

    local borderCorner = Instance.new("UICorner", border)
    borderCorner.CornerRadius = UDim.new(0, 16)

    -- Modern shadow
    local shadow = Instance.new("ImageLabel", mainFrame)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 14, 1, 14)
    shadow.Position = UDim2.new(0, -7, 0, -7)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = -2

    -- Title bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0.1, 0)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = colors.secondary
    titleBar.BorderSizePixel = 0

    -- Title text with modern font
    local titleText = Instance.new("TextLabel", titleBar)
    titleText.Name = "Title"
    titleText.Size = UDim2.new(0.8, 0, 1, 0)
    titleText.Position = UDim2.new(0.1, 0, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "CORE X HUB"
    titleText.TextColor3 = colors.text
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left

    local subtitleText = Instance.new("TextLabel", titleBar)
    subtitleText.Name = "Subtitle"
    subtitleText.Size = UDim2.new(0.8, 0, 0.4, 0)
    subtitleText.Position = UDim2.new(0.1, 0, 0.6, 0)
    subtitleText.BackgroundTransparency = 1
    subtitleText.Text = "The best script for any map"
    subtitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleText.TextSize = 14
    subtitleText.Font = Enum.Font.Gotham
    subtitleText.TextXAlignment = Enum.TextXAlignment.Left

    -- Sidebar (initially hidden)
    local sidebar = Instance.new("Frame", mainFrame)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0.25, 0, 0.9, 0)
    sidebar.Position = UDim2.new(-0.25, 0, 0.1, 0)
    sidebar.BackgroundColor3 = colors.secondary
    sidebar.BorderSizePixel = 0
    sidebar.ClipsDescendants = true

    -- Content area
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 0.9, 0)
    contentFrame.Position = UDim2.new(0, 0, 0.1, 0)
    contentFrame.BackgroundColor3 = colors.background
    contentFrame.BorderSizePixel = 0

    -- Category buttons
    local categories = {
        {Name = "Home", Text = "🏠 الرئيسية", Icon = "rbxassetid://3926305904"},
        {Name = "Settings", Text = "⚙️ الإعدادات", Icon = "rbxassetid://3926307971"},
        {Name = "Game", Text = "🎮 اللعبة", Icon = "rbxassetid://3926307971"},
        {Name = "Character", Text = "👤 اللاعب", Icon = "rbxassetid://3926305904"},
        {Name = "Target", Text = "🎯 استهداف", Icon = "rbxassetid://3926307971"},
        {Name = "Other", Text = "📦 أخرى", Icon = "rbxassetid://3926305904"},
        {Name = "Misc", Text = "© الحقوق", Icon = "rbxassetid://3926307971"}
    }

    local categoryButtons = {}
    local scrollingFrames = {}

    for i, category in ipairs(categories) do
        -- Modern category button
        local button = Instance.new("TextButton", sidebar)
        button.Name = category.Name
        button.Size = UDim2.new(1, -10, 0.12, 0)
        button.Position = UDim2.new(0, 5, 0.12 * (i-1), 5)
        button.BackgroundColor3 = colors.button
        button.BorderSizePixel = 0
        button.Text = "  "..category.Text
        button.TextColor3 = colors.text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.AutoButtonColor = false

        local buttonCorner = Instance.new("UICorner", button)
        buttonCorner.CornerRadius = UDim.new(0, 8)

        -- Icon (optional - using text icons for now)
        -- local icon = Instance.new("ImageLabel", button)
        -- icon.Size = UDim2.new(0, 20, 0, 20)
        -- icon.Position = UDim2.new(0, 5, 0.5, -10)
        -- icon.Image = category.Icon
        -- icon.BackgroundTransparency = 1

        -- Scrolling frame for content
        local scrollFrame = Instance.new("ScrollingFrame", contentFrame)
        scrollFrame.Name = category.Name
        scrollFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollFrame.Position = UDim2.new(0, 0, 0, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.ScrollBarImageColor3 = colors.accent
        scrollFrame.ScrollBarThickness = 4
        scrollFrame.Visible = i == 1

        local scrollLayout = Instance.new("UIListLayout", scrollFrame)
        scrollLayout.Padding = UDim.new(0, 10)
        scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder

        -- Store references
        categoryButtons[category.Name] = button
        scrollingFrames[category.Name] = scrollFrame

        -- Button interactions
        button.MouseEnter:Connect(function()
            if not scrollFrame.Visible then
                ts:Create(button, TweenInfo.new(0.2, easeOut), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
            end
        end)

        button.MouseLeave:Connect(function()
            if not scrollFrame.Visible then
                ts:Create(button, TweenInfo.new(0.2, easeOut), {BackgroundColor3 = colors.button}):Play()
            end
        end)

        button.MouseButton1Click:Connect(function()
            -- Hide all frames
            for _, frame in pairs(scrollingFrames) do
                frame.Visible = false
            end
            
            -- Show selected frame
            scrollFrame.Visible = true
            
            -- Reset all buttons
            for _, btn in pairs(categoryButtons) do
                ts:Create(btn, TweenInfo.new(0.2, easeOut), {
                    BackgroundColor3 = colors.button,
                    TextColor3 = colors.text
                }):Play()
            end
            
            -- Highlight selected button
            ts:Create(button, TweenInfo.new(0.2, easeOut), {
                BackgroundColor3 = colors.accent,
                TextColor3 = Color3.new(1, 1, 1)
            }):Play()
        end)
    end

    -- Highlight first button
    ts:Create(categoryButtons["Home"], TweenInfo.new(0.2, easeOut), {
        BackgroundColor3 = colors.accent,
        TextColor3 = Color3.new(1, 1, 1)
    }):Play()

    -- Burger button functionality
    local sidebarVisible = false

    local function toggleSidebar()
        sidebarVisible = not sidebarVisible
        
        if sidebarVisible then
            -- Show sidebar
            ts:Create(sidebar, TweenInfo.new(0.3, easeOut), {Position = UDim2.new(0, 0, 0.1, 0)}):Play()
            ts:Create(contentFrame, TweenInfo.new(0.3, easeOut), {
                Size = UDim2.new(0.75, 0, 0.9, 0),
                Position = UDim2.new(0.25, 0, 0.1, 0)
            }):Play()
        else
            -- Hide sidebar
            ts:Create(sidebar, TweenInfo.new(0.3, easeOut), {Position = UDim2.new(-0.25, 0, 0.1, 0)}):Play()
            ts:Create(contentFrame, TweenInfo.new(0.3, easeOut), {
                Size = UDim2.new(1, 0, 0.9, 0),
                Position = UDim2.new(0, 0, 0.1, 0)
            }):Play()
        end
    end

    burgerBtn.MouseButton1Click:Connect(toggleSidebar)

    -- Burger button animations
    burgerBtn.MouseEnter:Connect(function()
        ts:Create(burgerBtn, TweenInfo.new(0.2, easeOut), {
            BackgroundColor3 = Color3.fromRGB(90, 90, 90),
            Rotation = 10
        }):Play()
    end)

    burgerBtn.MouseLeave:Connect(function()
        ts:Create(burgerBtn, TweenInfo.new(0.2, easeOut), {
            BackgroundColor3 = colors.button,
            Rotation = 0
        }):Play()
    end)

    -- Make GUI draggable
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        burgerBtn.Position = UDim2.new(0.02, 0, startPos.Y.Scale, startPos.Y.Offset + delta.Y + (mainFrame.Size.Y.Offset / 2))
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Initial animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    burgerBtn.Position = UDim2.new(0.02, 0, 0.5, -25)

    ts:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.35, 0, 0.6, 0)
    }):Play()

    ts:Create(burgerBtn, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.1), {
        Position = UDim2.new(0.02, 0, 0.5, 0)
    }):Play()

    -- Add sample content
    local homeContent = Instance.new("TextLabel", scrollingFrames["Home"])
    homeContent.Name = "Welcome"
    homeContent.Size = UDim2.new(1, -20, 0, 150)
    homeContent.Position = UDim2.new(0, 10, 0, 10)
    homeContent.BackgroundTransparency = 1
    homeContent.Text = "مرحبًا بك في Core X Hub!\n\nاختر قسمًا من القائمة الجانبية لبدء الاستخدام"
    homeContent.TextColor3 = colors.text
    homeContent.TextSize = 20
    homeContent.Font = Enum.Font.GothamSemibold
    homeContent.TextWrapped = true

    -- Store references
    self.MainFrame = mainFrame
    self.GUI = gui
    self.BurgerButton = burgerBtn

    -- Show welcome notification
    self:Notify("تم التحميل بنجاح", "Core X Hub جاهز للاستخدام!", true)
end

-- Initialize
CoreXHub:Create()

return CoreXHub
