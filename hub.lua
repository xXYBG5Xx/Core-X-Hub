-- Roblox Core X Hub UI Script
-- Place this script as a LocalScript under StarterGui to auto-run for each player and create the UI.
-- The UI is fully created via Lua code here.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Utility function for creating UI elements with properties
local function create(className, properties)
    local obj = Instance.new(className)
    for prop, value in pairs(properties) do
        obj[prop] = value
    end
    return obj
end

-- Random color generator used for border color and notifications
local function randomColor()
    return Color3.fromHSV(math.random(), 0.6 + math.random()*0.4, 0.9)
end

-- Constants
local SECTION_NAMES = {
    {Key = "Home", DisplayName = "الواجهة الرئيسية"},
    {Key = "Settings", DisplayName = "الاعدادات"},
    {Key = "Game", DisplayName = "اللعبة"},
    {Key = "Character", DisplayName = "اللاعب"},
    {Key = "Target", DisplayName = "استهداف"},
    {Key = "Other", DisplayName = "اخرى"},
    {Key = "Misc", DisplayName = "الحقوق"},
}

-- Sounds URLs -- Using free Roblox sounds for success and failure indicators
local successSoundId = "rbxassetid://357694440" -- Pop sound
local failSoundId = "rbxassetid://12222005"    -- Error beep

-- Create ScreenGui
local screenGui = create("ScreenGui", {
    Name = "CoreXHubGui",
    ResetOnSpawn = false,
    Parent = playerGui,
})

-- Main rounded frame (container)
local mainFrame = create("Frame", {
    Name = "MainFrame",
    Parent = screenGui,
    BackgroundColor3 = Color3.fromRGB(24, 24, 33),
    BorderSizePixel = 4,
    BorderColor3 = randomColor(), -- Random border color on each run
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 850, 0, 580),
    ClipsDescendants = true,
})
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderMode = Enum.BorderMode.Outline
mainFrame:SetAttribute("BorderColor", mainFrame.BorderColor3)

-- UICorner for rounded edges of mainFrame
local mainUICorner = create("UICorner", {
    CornerRadius = UDim.new(0, 32),
    Parent = mainFrame,
})

-- Shadow effect (optional) with UIStroke
local mainUIStroke = create("UIStroke", {
    Thickness = 5,
    Color = mainFrame.BorderColor3,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = mainFrame,
})

-- Top bar contains burger button and title text
local topBar = create("Frame", {
    Name = "TopBar",
    Parent = mainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 24, 0, 20),
    Size = UDim2.new(1, -48, 0, 48),
    ClipsDescendants = false,
})

-- Burger Button (round)
local burgerBtn = create("TextButton", {
    Name = "BurgerButton",
    Parent = topBar,
    BackgroundColor3 = Color3.fromRGB(139, 92, 246),
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 48, 0, 48),
    Text = "",
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 2,
})
local burgerUICorner = create("UICorner", {
    CornerRadius = UDim.new(1, 0),
    Parent = burgerBtn,
})

-- Icon inside burger button (Using text with Unicode hamburger icon for demo)
local burgerIcon = create("TextLabel", {
    Name = "BurgerIcon",
    Parent = burgerBtn,
    BackgroundTransparency = 1,
    Text = "\u{2630}", -- hamburger Unicode
    Font = Enum.Font.SourceSansBold,
    TextColor3 = Color3.new(1,1,1),
    TextScaled = true,
    Size = UDim2.new(1,0,1,0),
    Position = UDim2.new(0,0,0,0),
    ZIndex = 3,
})

-- Title text next to burger button (to the left)
local titleText = create("TextLabel", {
    Name = "TitleText",
    Parent = topBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 60, 0, 0),
    Size = UDim2.new(1, -60, 1, 0),
    Font = Enum.Font.ArialBold,
    Text = "Core X hub : the best script for anymap",
    TextColor3 = Color3.fromRGB(237, 242, 247),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextScaled = true,
    RichText = true,
    ZIndex = 2,
})

-- Left sidebar container for sections
local sidebar = create("Frame", {
    Name = "Sidebar",
    Parent = mainFrame,
    BackgroundColor3 = Color3.fromRGB(42, 39, 82),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 220, 1, -72),
    Position = UDim2.new(1, -220, 0, 72),
    ClipsDescendants = false,
})

-- UICorner sidebar rounded edges on right side
local sidebarCorner = create("UICorner", {
    CornerRadius = UDim.new(0, 32),
    Parent = sidebar,
})

-- Scrolling frame for sections
local sectionScroll = create("ScrollingFrame", {
    Name = "SectionScroll",
    Parent = sidebar,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 0), -- will be updated dynamically
    ScrollBarThickness = 6,
    VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    ClipsDescendants = true,
})

-- UIListLayout for vertical arrangement
local sectionLayout = create("UIListLayout", {
    Parent = sectionScroll,
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6),
})

-- Functional: Updates CanvasSize on layout change
sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    sectionScroll.CanvasSize = UDim2.new(0, 0, 0, sectionLayout.AbsoluteContentSize.Y + 12)
end)

-- Creating section buttons dynamically
local sectionButtons = {}
local selectedSection = nil
local function setSelectedSection(key)
    if selectedSection then
        -- Reset previous button appearance
        local prevBtn = sectionButtons[selectedSection]
        if prevBtn then
            TweenService:Create(prevBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(42, 39, 82)}):Play()
            prevBtn.TextColor3 = Color3.fromRGB(237, 242, 247)
        end
    end

    selectedSection = key
    local btn = sectionButtons[key]
    if btn then
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(139, 92, 246)}):Play()
        btn.TextColor3 = Color3.new(1, 1, 1)
    end

    -- update main content text
    if mainContentLabel then
        for _, section in pairs(SECTION_NAMES) do
            if section.Key == key then
                mainContentLabel.Text = string.format("<b>%s</b>\n%s", section.Key, section.DisplayName)
                break
            end
        end
    end
end

for index, section in ipairs(SECTION_NAMES) do
    local btn = create("TextButton", {
        Name = "SectionBtn_" .. section.Key,
        Parent = sectionScroll,
        BackgroundColor3 = Color3.fromRGB(42, 39, 82),
        BorderSizePixel = 0,
        TextColor3 = Color3.fromRGB(237, 242, 247),
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Text = section.Key .. " - " .. section.DisplayName,
        Size = UDim2.new(1, -24, 0, 48),
        Position = UDim2.new(0, 12, 0, 0),
        AutoButtonColor = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local corner = create("UICorner", {
        CornerRadius = UDim.new(0, 16),
        Parent = btn,
    })

    -- Animations on hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(94, 75, 185)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if selectedSection ~= section.Key then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 39, 82)}):Play()
        end
    end)

    btn.Activated:Connect(function()
        setSelectedSection(section.Key)
    end)

    sectionButtons[section.Key] = btn
end

-- Main content area (right side)
local mainContent = create("Frame", {
    Name = "MainContent",
    Parent = mainFrame,
    BackgroundColor3 = Color3.fromRGB(28, 28, 40),
    Position = UDim2.new(0, 12, 0, 72),
    Size = UDim2.new(1, -240, 1, -84),
    ClipsDescendants = true,
})
local mainContentCorner = create("UICorner", {
    CornerRadius = UDim.new(0, 24),
    Parent = mainContent,
})
local mainContentLabel = create("TextLabel", {
    Name = "ContentLabel",
    Parent = mainContent,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(209, 209, 236),
    Font = Enum.Font.Gotham,
    TextSize = 30,
    Size = UDim2.new(1, -48, 1, -48),
    Position = UDim2.new(0, 24, 0, 24),
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "اختر قسم من اليسار لعرض المحتوى",
    RichText = true,
})
local mainContentTextStroke = create("UIStroke", {
    Parent = mainContentLabel,
    Color = Color3.fromRGB(115, 96, 190),
    Thickness = 1.5,
    Transparency = 0.4,
})

-- Notification frame (initially hidden)
local notificationFrame = create("Frame", {
    Name = "NotificationFrame",
    Parent = screenGui,
    BackgroundColor3 = Color3.new(0,0,0),
    BackgroundTransparency = 0.75,
    Size = UDim2.new(0, 350, 0, 60),
    Position = UDim2.new(0.5, -175, 0, 40),
    Visible = false,
    ZIndex = 40,
})
local notifUICorner = create("UICorner", {
    Parent = notificationFrame,
    CornerRadius = UDim.new(0, 12),
})
local notifText = create("TextLabel", {
    Parent = notificationFrame,
    Text = "",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    Font = Enum.Font.GothamSemibold,
    TextSize = 20,
    TextColor3 = Color3.new(1,1,1),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    RichText = true,
})

-- Load sounds
local successSound = create("Sound", {
    Parent = screenGui,
    SoundId = successSoundId,
    Volume = 0.6,
})
local failSound = create("Sound", {
    Parent = screenGui,
    SoundId = failSoundId,
    Volume = 0.6,
})

-- Notification function with sound
local function notify(message, success)
    notifText.Text = message
    if success then
        notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 167, 69) -- green bg
        successSound:Play()
    else
        notificationFrame.BackgroundColor3 = Color3.fromRGB(215, 58, 73) -- red bg
        failSound:Play()
    end
    notificationFrame.Visible = true
    notificationFrame.Position = UDim2.new(0.5, -175, 0, 40)
    notificationFrame.BackgroundTransparency = 0.75
    local tweenIn = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, -175, 0, 60)})
    local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {BackgroundTransparency = 0.75, Position = UDim2.new(0.5, -175, 0, 40)})

    tweenIn:Play()
    tweenIn.Completed:Wait()
    wait(2)
    tweenOut:Play()
    tweenOut.Completed:Wait()
    notificationFrame.Visible = false
end

-- For demo: simulate script execution when clicking a section
for key, btn in pairs(sectionButtons) do
    btn.MouseButton2Click:Connect(function()
        notify("تم تنفيذ السكربت بنجاح في قسم " .. key, true)
    end)
    btn.MouseButton1Click:Connect(function()
        -- For demo simulate success on even indexed sections, fail on odd.
        local idx
        for i,s in ipairs(SECTION_NAMES) do
            if s.Key == key then idx = i break end
        end
        if idx then
            if idx % 2 == 1 then
                notify("فشل تنفيذ السكربت في قسم ".. key, false)
            else
                notify("تم تنفيذ السكربت بنجاح في قسم " .. key, true)
            end
        end
    end)
end

-- Animations for burger button on click (scale bounce)
local function animateButton(button)
    local tweenUp = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size=button.Size + UDim2.new(0, 8, 0, 8)})
    local tweenDown = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {Size=button.Size})
    tweenUp:Play()
    tweenUp.Completed:Wait()
    tweenDown:Play()
end

burgerBtn.MouseButton1Click:Connect(function()
    animateButton(burgerBtn)
    notify("تم الضغط على زر البرجر", true)
end)

-- Dragging logic for mainFrame & burgerBtn separately
local function makeDraggable(guiObject)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeDraggable(mainFrame)
makeDraggable(burgerBtn)

-- Animate main frame border color change every 7 seconds to random
local function animateBorderColor()
    while true do
        local newColor = randomColor()
        local tween = TweenService:Create(mainFrame, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BorderColor3 = newColor})
        tween:Play()
        tween.Completed:Wait()
        wait(7)
    end
end

coroutine.wrap(animateBorderColor)()

-- Initialize selected section to Home
setSelectedSection("Home")

return screenGui
