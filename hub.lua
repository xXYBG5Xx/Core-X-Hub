-- Core X Hub UI Script - Refactored & Structured for GitHub
-- Author: Zeus
-- Place this LocalScript inside StarterGui

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// Utility
local function create(className, properties)
    local obj = Instance.new(className)
    for prop, value in pairs(properties) do obj[prop] = value end
    return obj
end

local function randomColor()
    return Color3.fromHSV(math.random(), 0.6 + math.random() * 0.4, 0.9)
end

--// Constants
local SECTION_NAMES = {
    {Key = "Home", DisplayName = "الواجهة الرئيسية"},
    {Key = "Settings", DisplayName = "الاعدادات"},
    {Key = "Game", DisplayName = "اللعبة"},
    {Key = "Character", DisplayName = "اللاعب"},
    {Key = "Target", DisplayName = "استهداف"},
    {Key = "Other", DisplayName = "اخرى"},
    {Key = "Misc", DisplayName = "الحقوق"},
}

local successSoundId = "rbxassetid://357694440"
local failSoundId = "rbxassetid://12222005"

--// GUI Creation
local screenGui = create("ScreenGui", {Name = "CoreXHubGui", ResetOnSpawn = false, Parent = playerGui})
local borderColor = randomColor()

-- Main Frame
local mainFrame = create("Frame", {
    Name = "MainFrame",
    Parent = screenGui,
    BackgroundColor3 = Color3.fromRGB(24, 24, 33),
    BorderColor3 = borderColor,
    BorderSizePixel = 4,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 850, 0, 580),
    ClipsDescendants = true,
})
create("UICorner", {CornerRadius = UDim.new(0, 32), Parent = mainFrame})
create("UIStroke", {Thickness = 5, Color = borderColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = mainFrame})

-- Top Bar with Burger & Title
local topBar = create("Frame", {Parent = mainFrame, BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 20), Size = UDim2.new(1, -48, 0, 48)})
local burgerBtn = create("TextButton", {
    Parent = topBar, Size = UDim2.new(0, 48, 0, 48), BackgroundColor3 = Color3.fromRGB(139, 92, 246), Text = "",
    AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 2
})
create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = burgerBtn})
create("TextLabel", {
    Parent = burgerBtn, BackgroundTransparency = 1, Text = "\u{2630}", Font = Enum.Font.SourceSansBold,
    TextColor3 = Color3.new(1, 1, 1), TextScaled = true, Size = UDim2.new(1, 0, 1, 0)
})
create("TextLabel", {
    Parent = topBar, BackgroundTransparency = 1, Position = UDim2.new(0, 60, 0, 0), Size = UDim2.new(1, -60, 1, 0),
    Font = Enum.Font.ArialBold, Text = "Core X hub : the best script for anymap", TextColor3 = Color3.fromRGB(237, 242, 247),
    TextXAlignment = Enum.TextXAlignment.Left, TextScaled = true
})

-- Sidebar
local sidebar = create("Frame", {
    Parent = mainFrame, BackgroundColor3 = Color3.fromRGB(42, 39, 82), BorderSizePixel = 0,
    Size = UDim2.new(0, 220, 1, -72), Position = UDim2.new(1, -220, 0, 72)
})
create("UICorner", {CornerRadius = UDim.new(0, 32), Parent = sidebar})

local sectionScroll = create("ScrollingFrame", {
    Parent = sidebar, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 6, VerticalScrollBarInset = Enum.ScrollBarInset.Always
})
local sectionLayout = create("UIListLayout", {Parent = sectionScroll, FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, 6)})
sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    sectionScroll.CanvasSize = UDim2.new(0, 0, 0, sectionLayout.AbsoluteContentSize.Y + 12)
end)

-- Main Content Area
local mainContent = create("Frame", {
    Parent = mainFrame, BackgroundColor3 = Color3.fromRGB(28, 28, 40), Position = UDim2.new(0, 12, 0, 72),
    Size = UDim2.new(1, -240, 1, -84), ClipsDescendants = true
})
create("UICorner", {CornerRadius = UDim.new(0, 24), Parent = mainContent})
local mainContentLabel = create("TextLabel", {
    Parent = mainContent, BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(209, 209, 236),
    Font = Enum.Font.Gotham, TextSize = 30, Size = UDim2.new(1, -48, 1, -48), Position = UDim2.new(0, 24, 0, 24),
    TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, TextXAlignment = Enum.TextXAlignment.Left,
    Text = "اختر قسم من اليسار لعرض المحتوى", RichText = true
})
create("UIStroke", {Parent = mainContentLabel, Color = Color3.fromRGB(115, 96, 190), Thickness = 1.5, Transparency = 0.4})

-- Section Buttons
local sectionButtons = {}
local selectedSection
local function setSelectedSection(key)
    if selectedSection and sectionButtons[selectedSection] then
        TweenService:Create(sectionButtons[selectedSection], TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(42, 39, 82)}):Play()
    end
    selectedSection = key
    local btn = sectionButtons[key]
    if btn then
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(139, 92, 246)}):Play()
    end
    for _, section in ipairs(SECTION_NAMES) do
        if section.Key == key then
            mainContentLabel.Text = string.format("<b>%s</b>\n%s", section.Key, section.DisplayName)
            break
        end
    end
end

for _, section in ipairs(SECTION_NAMES) do
    local btn = create("TextButton", {
        Parent = sectionScroll, BackgroundColor3 = Color3.fromRGB(42, 39, 82), BorderSizePixel = 0,
        TextColor3 = Color3.fromRGB(237, 242, 247), Font = Enum.Font.GothamBold, TextSize = 18,
        Text = section.Key .. " - " .. section.DisplayName, Size = UDim2.new(1, -24, 0, 48),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = btn})
    btn.MouseEnter:Connect(function()
        if selectedSection ~= section.Key then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(94, 75, 185)}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if selectedSection ~= section.Key then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 39, 82)}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function() setSelectedSection(section.Key) end)
    sectionButtons[section.Key] = btn
end

-- Initial Selection
setSelectedSection("Home")

-- Return for Module/Reference
return screenGui
