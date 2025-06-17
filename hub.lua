-- Core X Hub - Rounded Script Hub GUI
-- By GitHub User (for GitHub repository)

local CoreXHub = {}

-- Random color generator for borders
local function getRandomColor()
    return Color3.fromHSV(math.random(), 0.7, 1)
end

-- Animation function
local function tween(obj, props, duration, style, direction)
    game:GetService("TweenService"):Create(
        obj,
        TweenInfo.new(duration, style, direction),
        props
    ):Play()
end

-- Notification system
function CoreXHub:Notify(title, text, success)
    local notificationSound = Instance.new("Sound")
    notificationSound.SoundId = success and "rbxassetid://4590662766" or "rbxassetid://4590662766"
    notificationSound.Parent = game:GetService("SoundService")
    notificationSound:Play()
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0.3, 0, 0.1, 0)
    notification.Position = UDim2.new(0.7, 0, 0.05, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.BackgroundColor3 = success and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    notification.BorderSizePixel = 0
    notification.ZIndex = 100
    
    local corner = Instance.new("UICorner", notification)
    corner.CornerRadius = UDim.new(0.2, 0)
    
    local shadow = Instance.new("ImageLabel", notification)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = 99
    
    local titleLabel = Instance.new("TextLabel", notification)
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.9, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local textLabel = Instance.new("TextLabel", notification)
    textLabel.Name = "Text"
    textLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    notification.Parent = self.MainFrame
    tween(notification, {Position = UDim2.new(0.7, 0, 0.1, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    wait(3)
    
    tween(notification, {Position = UDim2.new(0.7, 0, 0.05, -50)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    wait(0.3)
    notification:Destroy()
end

-- Create main GUI
function CoreXHub:Create()
    -- Generate random border color
    local borderColor = getRandomColor()
    
    -- Create main screen GUI
    local player = game:GetService("Players").LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "CoreXHub"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = player:WaitForChild("PlayerGui")
    
    -- Main frame
    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    
    -- Rounded corners for main frame
    local mainCorner = Instance.new("UICorner", mainFrame)
    mainCorner.CornerRadius = UDim.new(0.05, 0)
    
    -- Border effect
    local border = Instance.new("Frame", mainFrame)
    border.Name = "Border"
    border.Size = UDim2.new(1, 6, 1, 6)
    border.Position = UDim2.new(0, -3, 0, -3)
    border.BackgroundColor3 = borderColor
    border.BorderSizePixel = 0
    border.ZIndex = -1
    
    local borderCorner = Instance.new("UICorner", border)
    borderCorner.CornerRadius = UDim.new(0.05, 0)
    
    -- Drop shadow
    local shadow = Instance.new("ImageLabel", mainFrame)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = -2
    
    -- Title bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0.1, 0)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.BorderSizePixel = 0
    
    local titleBarCorner = Instance.new("UICorner", titleBar)
    titleBarCorner.CornerRadius = UDim.new(0, 0)
    
    -- Title text
    local titleText = Instance.new("TextLabel", titleBar)
    titleText.Name = "Title"
    titleText.Size = UDim2.new(0.8, 0, 1, 0)
    titleText.Position = UDim2.new(0.1, 0, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "Core X Hub : The Best Script For AnyMap"
    titleText.TextColor3 = Color3.new(1, 1, 1)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.GothamBold
    
    -- Burger button
    local burgerButton = Instance.new("TextButton", titleBar)
    burgerButton.Name = "BurgerButton"
    burgerButton.Size = UDim2.new(0.1, 0, 1, 0)
    burgerButton.Position = UDim2.new(0, 0, 0, 0)
    burgerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    burgerButton.BorderSizePixel = 0
    burgerButton.Text = "≡"
    burgerButton.TextColor3 = Color3.new(1, 1, 1)
    burgerButton.TextScaled = true
    burgerButton.Font = Enum.Font.GothamBold
    
    local burgerCorner = Instance.new("UICorner", burgerButton)
    burgerCorner.CornerRadius = UDim.new(0.2, 0)
    
    -- Sidebar
    local sidebar = Instance.new("Frame", mainFrame)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0.25, 0, 0.9, 0)
    sidebar.Position = UDim2.new(0, 0, 0.1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    sidebar.BorderSizePixel = 0
    
    local sidebarCorner = Instance.new("UICorner", sidebar)
    sidebarCorner.CornerRadius = UDim.new(0, 0)
    
    -- Content frame
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(0.75, 0, 0.9, 0)
    contentFrame.Position = UDim2.new(0.25, 0, 0.1, 0)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    contentFrame.BorderSizePixel = 0
    
    local contentCorner = Instance.new("UICorner", contentFrame)
    contentCorner.CornerRadius = UDim.new(0, 0)
    
    -- Category buttons
    local categories = {
        {Name = "Home", Text = "🏠 Home - الواجهة الرئيسية"},
        {Name = "Settings", Text = "⚙️ Settings - الاعدادات"},
        {Name = "Game", Text = "🎮 Game - اللعبة"},
        {Name = "Character", Text = "👤 Character - اللاعب"},
        {Name = "Target", Text = "🎯 Target - استهداف"},
        {Name = "Other", Text = "📦 Other - اخرى"},
        {Name = "Misc", Text = "© Misc - الحقوق"}
    }
    
    local categoryButtons = {}
    local scrollingFrames = {}
    
    for i, category in ipairs(categories) do
        -- Create button
        local button = Instance.new("TextButton", sidebar)
        button.Name = category.Name
        button.Size = UDim2.new(1, -10, 0.12, 0)
        button.Position = UDim2.new(0, 5, 0.12 * (i-1), 5)
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        button.BorderSizePixel = 0
        button.Text = category.Text
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextScaled = true
        button.Font = Enum.Font.Gotham
        button.TextWrapped = true
        
        local buttonCorner = Instance.new("UICorner", button)
        buttonCorner.CornerRadius = UDim.new(0.1, 0)
        
        -- Create scrolling frame for content
        local scrollFrame = Instance.new("ScrollingFrame", contentFrame)
        scrollFrame.Name = category.Name
        scrollFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollFrame.Position = UDim2.new(0, 0, 0, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 5
        scrollFrame.Visible = i == 1 -- Only show first tab initially
        
        local scrollLayout = Instance.new("UIListLayout", scrollFrame)
        scrollLayout.Padding = UDim.new(0, 5)
        scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        -- Store references
        categoryButtons[category.Name] = button
        scrollingFrames[category.Name] = scrollFrame
        
        -- Button click event
        button.MouseButton1Click:Connect(function()
            -- Hide all scrolling frames
            for _, frame in pairs(scrollingFrames) do
                frame.Visible = false
            end
            
            -- Show selected frame
            scrollFrame.Visible = true
            
            -- Reset all button colors
            for _, btn in pairs(categoryButtons) do
                tween(btn, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            end
            
            -- Highlight selected button
            tween(button, {BackgroundColor3 = borderColor}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        end)
        
        -- Hover effects
        button.MouseEnter:Connect(function()
            if not scrollFrame.Visible then
                tween(button, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            end
        end)
        
        button.MouseLeave:Connect(function()
            if not scrollFrame.Visible then
                tween(button, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            end
        end)
    end
    
    -- Highlight first button
    tween(categoryButtons["Home"], {BackgroundColor3 = borderColor}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Burger button functionality (toggle sidebar)
    local sidebarVisible = true
    burgerButton.MouseButton1Click:Connect(function()
        sidebarVisible = not sidebarVisible
        
        if sidebarVisible then
            tween(sidebar, {Size = UDim2.new(0.25, 0, 0.9, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            tween(contentFrame, {Size = UDim2.new(0.75, 0, 0.9, 0), Position = UDim2.new(0.25, 0, 0.1, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        else
            tween(sidebar, {Size = UDim2.new(0, 0, 0.9, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            tween(contentFrame, {Size = UDim2.new(1, 0, 0.9, 0), Position = UDim2.new(0, 0, 0.1, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        end
    end)
    
    -- Make GUI draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Burger button animation
    burgerButton.MouseEnter:Connect(function()
        tween(burgerButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    end)
    
    burgerButton.MouseLeave:Connect(function()
        tween(burgerButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    end)
    
    -- Initial animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    tween(mainFrame, {Size = UDim2.new(0.35, 0, 0.6, 0)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    -- Store references
    self.MainFrame = mainFrame
    self.GUI = gui
    self.CategoryButtons = categoryButtons
    self.ScrollingFrames = scrollingFrames
    
    -- Add sample content to Home tab
    local homeLabel = Instance.new("TextLabel", scrollingFrames["Home"])
    homeLabel.Name = "WelcomeLabel"
    homeLabel.Size = UDim2.new(1, -20, 0, 100)
    homeLabel.Position = UDim2.new(0, 10, 0, 10)
    homeLabel.BackgroundTransparency = 1
    homeLabel.Text = "Welcome to Core X Hub!\nThe best script for any map!"
    homeLabel.TextColor3 = Color3.new(1, 1, 1)
    homeLabel.TextScaled = true
    homeLabel.Font = Enum.Font.GothamBold
    homeLabel.TextWrapped = true
    
    -- Add sample content to Settings tab
    local setting1 = Instance.new("TextLabel", scrollingFrames["Settings"])
    setting1.Name = "Setting1"
    setting1.Size = UDim2.new(1, -20, 0, 40)
    setting1.Position = UDim2.new(0, 10, 0, 10)
    setting1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    setting1.BorderSizePixel = 0
    setting1.Text = "Theme Color"
    setting1.TextColor3 = Color3.new(1, 1, 1)
    setting1.TextScaled = true
    setting1.Font = Enum.Font.Gotham
    
    local setting1Corner = Instance.new("UICorner", setting1)
    setting1Corner.CornerRadius = UDim.new(0.1, 0)
    
    -- Add sample content to other tabs...
    
    -- Show success notification
    self:Notify("Success", "Core X Hub loaded successfully!", true)
end

-- Initialize
CoreXHub:Create()

return CoreXHub
