-- Core X Styled Redz Interface (Basic UI)
-- by Zeus | Only GUI Structure - No Functional Buttons

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CoreXHub"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 400)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 16)

-- Left Sidebar
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 0

local sidebarCorner = Instance.new("UICorner", sidebar)
sidebarCorner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Core X Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

-- Section Buttons
local sections = {
    "Home", "Settings", "Game", "Character", "Target", "Other", "Misc"
}

for i, name in ipairs(sections) do
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = UDim2.new(0, 10, 0, 50 + ((i - 1) * 40))
    button.Text = name
    button.Name = name.."Button"
    button.TextColor3 = Color3.fromRGB(240, 240, 240)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner", button)
    btnCorner.CornerRadius = UDim.new(0, 8)
end

-- Main Content Placeholder
local content = Instance.new("Frame", mainFrame)
content.Name = "ContentArea"
content.Size = UDim2.new(1, -150, 1, -20)
content.Position = UDim2.new(0, 150, 0, 10)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
content.BorderSizePixel = 0

local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0, 12)

-- End of Script (No functionality, just design)
