-- إنشاء الـ GUI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZeusHubUI"
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- عنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "Zeus Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = MainFrame

-- زر إغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.BackgroundTransparency = 1
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Parent = Title

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- إطار للأقسام (Tabs Buttons)
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabsFrame.Parent = MainFrame

-- إطار عرض السكربتات
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -90)
ContentFrame.Position = UDim2.new(0, 10, 0, 90)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.Parent = MainFrame
ContentFrame.ClipsDescendants = true

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- بيانات الأقسام + السكربتات (اضف السكربتات في الجدول هنا)
local tabs = {
	["Section 1"] = {
		["Script A"] = "https://raw.githubusercontent.com/USERNAME/RepoName/main/scripts/scriptA.lua",
		["Script B"] = "https://raw.githubusercontent.com/USERNAME/RepoName/main/scripts/scriptB.lua",
	},
	["Section 2"] = {
		["Script C"] = "https://raw.githubusercontent.com/USERNAME/RepoName/main/scripts/scriptC.lua",
	},
	["Section 3"] = {},
	["Section 4"] = {},
	["Section 5"] = {},
}

-- دالة لإنشاء زر لكل سكربت
local function createScriptButton(name, url)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 18
	btn.Text = name
	btn.Parent = ContentFrame
	btn.MouseButton1Click:Connect(function()
		pcall(function()
			loadstring(game:HttpGet(url))()
		end)
	end)
	return btn
end

-- مسح السكربتات من العرض
local function clearScripts()
	for _, child in pairs(ContentFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
end

-- إنشاء أزرار التبويبات (Tabs)
local selectedTab = nil

local function selectTab(tabName)
	selectedTab = tabName
	clearScripts()
	for scriptName, url in pairs(tabs[tabName]) do
		createScriptButton(scriptName, url)
	end
	-- تفعيل زر التاب المحدد بلون مختلف
	for _, btn in pairs(TabsFrame:GetChildren()) do
		if btn:IsA("TextButton") then
			btn.BackgroundColor3 = (btn.Name == tabName) and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(40, 40, 40)
		end
	end
end

for tabName, _ in pairs(tabs) do
	local tabBtn = Instance.new("TextButton")
	tabBtn.Name = tabName
	tabBtn.Size = UDim2.new(0, 80, 1, 0)
	tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabBtn.Font = Enum.Font.GothamBold
	tabBtn.TextSize = 16
	tabBtn.Text = tabName
	tabBtn.Parent = TabsFrame

	tabBtn.MouseButton1Click:Connect(function()
		selectTab(tabName)
	end)
end

-- نبدأ بأول تاب مفتوح
selectTab(next(tabs))
