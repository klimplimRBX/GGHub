-- =====================================

--[[ GGHub is an open source script :D
       So have fun getting some functions 
       from here and using then on your own script
]]--


-- ============= GGHub v0.9 ===============

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

-- ===================================================
--              LOADING SCREEN
-- ===================================================

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "GGHub_Loading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.Parent = PlayerGui

for _, v in ipairs(Lighting:GetChildren()) do
	if v:IsA("BlurEffect") then v:Destroy() end
end

local blur = Instance.new("BlurEffect")
blur.Name = "__GGHUB_LOADING_BLUR__"
blur.Size = 20
blur.Parent = Lighting

task.spawn(function()
	while true do
		RunService.Heartbeat:Wait()
		if not loadingGui or not loadingGui.Parent then
			for _, v in ipairs(Lighting:GetChildren()) do
				if v:IsA("BlurEffect") then v:Destroy() end
			end
			break
		end
	end
end)

Lighting.DescendantAdded:Connect(function(obj)
	if obj:IsA("BlurEffect") and obj.Name ~= "__GGHUB_LOADING_BLUR__" then
		obj:Destroy()
	end
end)

local frame = Instance.new("Frame", loadingGui)
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local title = Instance.new("TextLabel", frame)
title.Text = "GGHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 56
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 24, 0, 24)
title.Size = UDim2.new(1, -48, 0, 60)
title.TextXAlignment = Enum.TextXAlignment.Left

local sub = Instance.new("TextLabel", frame)
sub.Text = "Made by KlimplimRBX"
sub.Font = Enum.Font.Gotham
sub.TextSize = 16
sub.TextColor3 = Color3.fromRGB(180, 180, 180)
sub.BackgroundTransparency = 1
sub.Position = UDim2.new(0, 26, 0, 88)
sub.Size = UDim2.new(1, -52, 0, 20)
sub.TextXAlignment = Enum.TextXAlignment.Left

local loadingText = Instance.new("TextLabel", frame)
loadingText.Text = "Loading script..."
loadingText.Font = Enum.Font.Gotham
loadingText.TextSize = 22
loadingText.TextColor3 = Color3.fromRGB(220, 220, 220)
loadingText.BackgroundTransparency = 1
loadingText.Position = UDim2.new(0, 26, 1, -54)
loadingText.Size = UDim2.new(1, -52, 0, 30)
loadingText.TextXAlignment = Enum.TextXAlignment.Left

local grid = Instance.new("Frame", frame)
grid.Size = UDim2.new(0, 96, 0, 96)
grid.Position = UDim2.new(1, -126, 1, -126)
grid.BackgroundTransparency = 1
local squares = {}

local layout = {
	[1] = Vector2.new(0, 0), [2] = Vector2.new(32, 0), [3] = Vector2.new(64, 0),
	[8] = Vector2.new(0, 32), [4] = Vector2.new(64, 32),
	[7] = Vector2.new(0, 64), [6] = Vector2.new(32, 64), [5] = Vector2.new(64, 64),
}

for index, pos in pairs(layout) do
	local sq = Instance.new("Frame", grid)
	sq.Size = UDim2.new(0, 26, 0, 26)
	sq.Position = UDim2.new(0, pos.X, 0, pos.Y)
	sq.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	sq.BorderSizePixel = 0
	Instance.new("UICorner", sq).CornerRadius = UDim.new(0, 5)
	squares[index] = sq
end

task.spawn(function()
	local order = {1, 2, 3, 4, 5, 6, 7, 8}
	local step = 1
	while loadingGui and loadingGui.Parent do
		for _, sq in pairs(squares) do
			if sq then sq.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
		end
		local current = order[step]
		if squares[current] then
			squares[current].BackgroundColor3 = Color3.fromRGB(240, 240, 240)
		end
		step = (step % #order) + 1
		task.wait(0.5)
	end
end)

_G.HideGGHubLoading = function()
	if not loadingGui or not loadingGui.Parent then return end
	TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	for _, v in ipairs(frame:GetDescendants()) do
		if v:IsA("TextLabel") then
			TweenService:Create(v, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		elseif v:IsA("Frame") then
			TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		end
	end
	task.delay(0.45, function()
		if loadingGui then loadingGui:Destroy() end
	end)
end

task.wait(0.5)

-- ===================================================
--           SECURITY CHECK (PlaceId and executor)
-- ===================================================

local _ex = string.lower(identifyexecutor() or "")
local _tg = "\115\111\108\97\114\97"

if string.find(_ex, _tg) then
    local _k = "K".."i".."c".."k"
    local p = game:GetService("Players").LocalPlayer
    
    p[_k](p, "\n[GGHub Security & Compatability Check]\nYour executor (Solara) is NOT supported.\nPlease use a supported executor like Bunni, wave or Xeno, or others")
end

local TARGET_PLACE_ID = 131623223084840

if game.PlaceId ~= TARGET_PLACE_ID then
	local checkGui = Instance.new("ScreenGui")
	checkGui.Name = "GGHub_Security"
	checkGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	if loadingGui then
		loadingGui:Destroy()
		loadingGui = nil
	end

	local alertFrame = Instance.new("Frame")
	alertFrame.Size = UDim2.new(0, 400, 0, 100)
	alertFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
	alertFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	alertFrame.BorderSizePixel = 0
	alertFrame.Parent = checkGui

	Instance.new("UICorner", alertFrame)
	local stroke = Instance.new("UIStroke", alertFrame)
	stroke.Color = Color3.fromRGB(255, 50, 50)
	stroke.Thickness = 2

	local msg = Instance.new("TextLabel")
	msg.Size = UDim2.new(1, 0, 1, 0)
	msg.BackgroundTransparency = 1
	msg.Text = "Game not compatible with GGHub!"
	msg.TextColor3 = Color3.fromRGB(255, 255, 255)
	msg.Font = Enum.Font.GothamBold
	msg.TextSize = 20
	msg.Parent = alertFrame

	task.delay(5, function()
		local tw1 = TweenService:Create(alertFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
		local tw2 = TweenService:Create(msg, TweenInfo.new(0.5), {TextTransparency = 1})
		local tw3 = TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1})
		tw1:Play(); tw2:Play(); tw3:Play()
		tw1.Completed:Connect(function() checkGui:Destroy() end)
	end)
end

-- ===================================================
--        GAME VARIABLES & MODULE LOADING
-- ===================================================

local COIN_NAME = "GoldBar" -- Devs forgot to change from GoldBars to ArcadeCoins💔🥀
local notificationList = {}

local performSingleDash = false
local cooldownActive = false
local farming = false
local autoSpinEnabled = false
local spinning = false
local removingBases = false

local SpinRF = nil

task.spawn(function()
    SpinRF = ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("Net", 5):WaitForChild("RF/WheelSpin.Roll", 5)
end)

-- ===================================================
--            COLORS & GUI SETUP
-- ===================================================

local Colors = {
	Background = Color3.fromRGB(20, 20, 20),
	Sidebar = Color3.fromRGB(15, 15, 15),
	ItemBG = Color3.fromRGB(35, 35, 35),
	TextMain = Color3.fromRGB(255, 255, 255),
	TextSub = Color3.fromRGB(180, 180, 180),
	ToggleOn = Color3.fromRGB(0, 85, 165),
	ToggleOff = Color3.fromRGB(80, 80, 80),
	Button = Color3.fromRGB(50, 50, 50),
	ButtonHover = Color3.fromRGB(70, 70, 70)
}

if PlayerGui:FindFirstChild("GGHub_v08") then
	PlayerGui.GGHub_v08:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "GGHub_v08"
gui.Parent = PlayerGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ===================================================
--            DRAG FUNCTION
-- ===================================================

local function makeDraggable(object)
	local dragging, dragInput, dragStart, startPos
	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- ===================================================
--          NOTIFICATION SYSTEM
-- ===================================================

local function showNotification(text)
	local notif = Instance.new("Frame")
	notif.Name = "Notification"
	notif.Size = UDim2.new(0, 250, 0, 50)
	notif.AnchorPoint = Vector2.new(1, 1)
	notif.Position = UDim2.new(1, -20, 1, -20 - (#notificationList * 55))
	notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	notif.BorderSizePixel = 0
	notif.Parent = gui
	notif.ZIndex = 10
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)

	local label = Instance.new("TextLabel")
	label.Name = "Message"
	label.Size = UDim2.new(1, -20, 1, -10)
	label.Position = UDim2.new(0, 10, 0, 5)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Text = text
	label.Parent = notif
	label.ZIndex = 20

	table.insert(notificationList, notif)
	TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = notif.Position - UDim2.new(0,0,0,20)}):Play()

	task.delay(3, function()
		if not notif or not notif.Parent then return end
		local fadeFrame = TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = notif.Position - UDim2.new(0,0,0,20)})
		local fadeText = TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
		fadeFrame:Play(); fadeText:Play()
		fadeFrame.Completed:Connect(function()
			if notif then notif:Destroy() end
			local index = table.find(notificationList, notif)
			if index then table.remove(notificationList, index) end
			for i, n in ipairs(notificationList) do
				n:TweenPosition(UDim2.new(1, -20, 1, -20 - ((i-1) * 55)), "Out", "Quad", 0.3, true)
			end
		end)
	end)
end

-- ===================================================
--         MINI BUTTON & MAIN WINDOW
-- ===================================================

local MiniGG = Instance.new("TextButton")
MiniGG.Name = "MiniGG"
MiniGG.Size = UDim2.new(0, 55, 0, 55)
MiniGG.Position = UDim2.new(0.05, 0, 0.2, 0)
MiniGG.Text = "GG"
MiniGG.TextScaled = true; MiniGG.Font = Enum.Font.SourceSansBold
MiniGG.TextColor3 = Color3.new(1,1,1)
MiniGG.BackgroundColor3 = Color3.new(0,0,0)
MiniGG.Visible = false
MiniGG.Parent = gui
Instance.new("UICorner", MiniGG).CornerRadius = UDim.new(0, 10)
local kStroke = Instance.new("UIStroke"); kStroke.Color = Color3.fromRGB(60, 60, 60); kStroke.Thickness = 2; kStroke.Parent = MiniGG
makeDraggable(MiniGG)

local MainFrame = Instance.new("CanvasGroup")
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -180)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = gui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke"); mStroke.Color = Color3.fromRGB(60, 60, 60); mStroke.Parent = MainFrame
makeDraggable(MainFrame)

-- ===================================================
--              HEADER BAR
-- ===================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50); Header.BackgroundTransparency = 1; Header.Parent = MainFrame

local AppTitle = Instance.new("TextLabel")
AppTitle.Text = "GGHub v0.8"
AppTitle.Size = UDim2.new(0, 200, 0, 20)
AppTitle.Position = UDim2.new(0, 15, 0, 12)
AppTitle.Font = Enum.Font.GothamBold; AppTitle.TextSize = 18; AppTitle.TextColor3 = Colors.TextMain
AppTitle.TextXAlignment = Enum.TextXAlignment.Left; AppTitle.BackgroundTransparency = 1; AppTitle.Parent = Header

local AppSignature = Instance.new("TextLabel")
AppSignature.Text = "Made by KlimplimRBX - The last update before the biggest yet"
AppSignature.Size = UDim2.new(0, 300, 0, 15)
AppSignature.Position = UDim2.new(0, 15, 0, 32)
AppSignature.Font = Enum.Font.Gotham; AppSignature.TextSize = 11; AppSignature.TextColor3 = Colors.TextSub
AppSignature.TextXAlignment = Enum.TextXAlignment.Left; AppSignature.BackgroundTransparency = 1; AppSignature.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"; CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 9)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45,45,45); CloseBtn.TextColor3 = Colors.TextMain; CloseBtn.TextSize = 24
CloseBtn.Parent = Header; Instance.new("UICorner", CloseBtn)

local MinBtn = Instance.new("TextButton")
MinBtn.Text = "-"; MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -80, 0, 9)
MinBtn.BackgroundColor3 = Color3.fromRGB(45,45,45); MinBtn.TextColor3 = Colors.TextMain; MinBtn.TextSize = 20
MinBtn.Parent = Header; Instance.new("UICorner", MinBtn)

-- ===================================================
--         PAGE SYSTEM & SIDEBAR
-- ===================================================

local BodyFrame = Instance.new("Frame")
BodyFrame.Size = UDim2.new(1, 0, 1, -55)
BodyFrame.Position = UDim2.new(0, 0, 0, 55)
BodyFrame.BackgroundTransparency = 1; BodyFrame.Parent = MainFrame

local Pages = {}
local SidebarButtons = {}

local function createPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, -85, 1, -20)
	page.Position = UDim2.new(0, 75, 0, 10)
	page.BackgroundTransparency = 1; page.BorderSizePixel = 0; page.ScrollBarThickness = 3
	page.Visible = false; page.Parent = BodyFrame
	Instance.new("UIListLayout", page).Padding = UDim.new(0, 10)
	Pages[name] = page
	return page
end

local function showPage(name)
	for n, p in pairs(Pages) do p.Visible = (n == name) end
	for n, b in pairs(SidebarButtons) do
		b.BackgroundTransparency = (n == name) and 0.9 or 1
		b.TextColor3 = (n == name) and Colors.TextMain or Color3.fromRGB(100,100,100)
	end
end

local homePage = createPage("Home")
local scriptPage = createPage("Scripts")
local mapPage = createPage("Map")
local settingsPage = createPage("Settings")

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 65, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar; Sidebar.BorderSizePixel = 0; Sidebar.Parent = BodyFrame

local function addSideIcon(text, yPos, target)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(0, 50, 0, 50); btn.Position = UDim2.new(0.5, -25, 0, yPos)
	btn.BackgroundTransparency = 1; btn.TextSize = 28; btn.Parent = Sidebar
	btn.TextColor3 = Color3.fromRGB(100,100,100)
	Instance.new("UICorner", btn)
	SidebarButtons[target] = btn
	btn.MouseButton1Click:Connect(function() showPage(target) end)
end

addSideIcon("🏠", 10, "Home")
addSideIcon("⚡", 70, "Scripts")
addSideIcon("🗺️", 130, "Map")
addSideIcon("⚙️", 190, "Settings")

-- ===================================================
--       UI COMPONENT CREATORS
-- ===================================================

local function createToggle(parent, titleText, desc, callback)
	local ToggleFrame = Instance.new("Frame")
	ToggleFrame.Size = UDim2.new(1, -10, 0, 65); ToggleFrame.BackgroundColor3 = Colors.ItemBG; ToggleFrame.Parent = parent
	Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0,12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = titleText
	TTitle.Size = UDim2.new(1, -75, 0, 25); TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1; TTitle.TextColor3 = Colors.TextMain; TTitle.Font = Enum.Font.GothamBold; TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left; TTitle.Parent = ToggleFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = desc; TDesc.Size = UDim2.new(1, -75, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1; TDesc.TextColor3 = Colors.TextSub; TDesc.Font = Enum.Font.Gotham; TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left; TDesc.Parent = ToggleFrame

	local SwitchBase = Instance.new("TextButton")
	SwitchBase.Text = ""; SwitchBase.Size = UDim2.new(0, 50, 0, 28)
	SwitchBase.Position = UDim2.new(1, -65, 0.5, -14)
	SwitchBase.BackgroundColor3 = Colors.ToggleOff; SwitchBase.Parent = ToggleFrame
	Instance.new("UICorner", SwitchBase).CornerRadius = UDim.new(1,0)

	local Knob = Instance.new("Frame")
	Knob.Size = UDim2.new(0, 22, 0, 22); Knob.Position = UDim2.new(0, 3, 0.5, -11)
	Knob.BackgroundColor3 = Color3.new(1,1,1)
	Knob.Parent = SwitchBase; Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

	local toggled = false
	SwitchBase.MouseButton1Click:Connect(function()
		toggled = not toggled
		TweenService:Create(SwitchBase, TweenInfo.new(0.15), {BackgroundColor3 = toggled and Colors.ToggleOn or Colors.ToggleOff}):Play()
		TweenService:Create(Knob, TweenInfo.new(0.15), {Position = toggled and UDim2.new(0, 25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)}):Play()
		task.spawn(function() pcall(callback, toggled) end)
	end)
end

local function createButton(parent, titleText, desc, callback)
	local BtnFrame = Instance.new("TextButton")
	BtnFrame.Size = UDim2.new(1, -10, 0, 60)
	BtnFrame.BackgroundColor3 = Colors.ItemBG; BtnFrame.Parent = parent
	BtnFrame.Text = ""; BtnFrame.AutoButtonColor = false
	Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0,12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = titleText
	TTitle.Size = UDim2.new(1, -20, 0, 25); TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1; TTitle.TextColor3 = Colors.TextMain; TTitle.Font = Enum.Font.GothamBold; TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left; TTitle.Parent = BtnFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = desc; TDesc.Size = UDim2.new(1, -20, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1; TDesc.TextColor3 = Colors.TextSub; TDesc.Font = Enum.Font.Gotham; TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left; TDesc.Parent = BtnFrame

	BtnFrame.MouseEnter:Connect(function() TweenService:Create(BtnFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ButtonHover}):Play() end)
	BtnFrame.MouseLeave:Connect(function() TweenService:Create(BtnFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemBG}):Play() end)

	BtnFrame.MouseButton1Click:Connect(function()
		local clickTween = TweenService:Create(BtnFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 58)})
		clickTween:Play()
		clickTween.Completed:Connect(function()
			TweenService:Create(BtnFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 60)}):Play()
		end)
		task.spawn(callback)
	end)
end

local function createDropdown(parent, titleText, options, callback)
	local isOpened = false
	local baseHeight = 60
	local optionHeight = 35
	local totalHeight = baseHeight + (#options * optionHeight) + 10

	local DropFrame = Instance.new("Frame")
	DropFrame.Size = UDim2.new(1, -10, 0, baseHeight)
	DropFrame.BackgroundColor3 = Colors.ItemBG
	DropFrame.Parent = parent
	DropFrame.ClipsDescendants = true
	Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 12)

	local DTitle = Instance.new("TextLabel")
	DTitle.Text = titleText
	DTitle.Size = UDim2.new(1, -50, 0, 25)
	DTitle.Position = UDim2.new(0, 15, 0, 17.5)
	DTitle.BackgroundTransparency = 1
	DTitle.TextColor3 = Colors.TextMain
	DTitle.Font = Enum.Font.GothamBold; DTitle.TextSize = 16
	DTitle.TextXAlignment = Enum.TextXAlignment.Left; DTitle.Parent = DropFrame

	local Arrow = Instance.new("TextLabel")
	Arrow.Text = "↓"
	Arrow.Size = UDim2.new(0, 30, 0, 30)
	Arrow.Position = UDim2.new(1, -40, 0, 15)
	Arrow.BackgroundTransparency = 1
	Arrow.TextColor3 = Colors.TextSub; Arrow.TextSize = 14; Arrow.Font = Enum.Font.Gotham
	Arrow.Parent = DropFrame

	local ExpandBtn = Instance.new("TextButton")
	ExpandBtn.Size = UDim2.new(1, 0, 0, baseHeight)
	ExpandBtn.BackgroundTransparency = 1; ExpandBtn.Text = ""
	ExpandBtn.Parent = DropFrame

	local ListContainer = Instance.new("Frame")
	ListContainer.Size = UDim2.new(1, -20, 0, #options * optionHeight)
	ListContainer.Position = UDim2.new(0, 10, 0, baseHeight)
	ListContainer.BackgroundTransparency = 1; ListContainer.Parent = DropFrame
	Instance.new("UIListLayout", ListContainer).Padding = UDim.new(0, 5)

	for _, optName in ipairs(options) do
		local OptBtn = Instance.new("TextButton")
		OptBtn.Size = UDim2.new(1, 0, 0, 30)
		OptBtn.BackgroundColor3 = Colors.Button
		OptBtn.Text = optName
		OptBtn.TextColor3 = Colors.TextSub; OptBtn.Font = Enum.Font.Gotham; OptBtn.TextSize = 14
		OptBtn.Parent = ListContainer
		Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

		OptBtn.MouseButton1Click:Connect(function()
			DTitle.Text = titleText .. ": " .. optName
			callback(optName)
			isOpened = false
			TweenService:Create(DropFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, baseHeight)}):Play()
			TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
		end)
	end

	ExpandBtn.MouseButton1Click:Connect(function()
		isOpened = not isOpened
		TweenService:Create(DropFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, isOpened and totalHeight or baseHeight)}):Play()
		TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = isOpened and 180 or 0}):Play()
	end)
end

-- ===================================================
--           SHADER FUNCTIONS
-- ===================================================

local bloom, colorCorrection, sunRays, blurEffect, skyEffect

local function resetShaders()
	for _, effect in ipairs(Lighting:GetChildren()) do
		if effect:IsA("PostEffect") or effect.ClassName:find("Effect") or effect:IsA("Sky") then
			effect:Destroy()
		end
	end
	bloom = Instance.new("BloomEffect", Lighting)
	colorCorrection = Instance.new("ColorCorrectionEffect", Lighting)
	sunRays = Instance.new("SunRaysEffect", Lighting)
	blurEffect = Instance.new("BlurEffect", Lighting)
	skyEffect = Instance.new("Sky", Lighting)
	skyEffect.Name = "Sky"
end

local function applyDefaultShader()
	resetShaders()
	Lighting.Brightness = 2; Lighting.Ambient = Color3.fromRGB(0, 0, 0)
	Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
	Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0); Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	Lighting.ExposureCompensation = 0; Lighting.ClockTime = 14; Lighting.GeographicLatitude = 41.733
	Lighting.TimeOfDay = "14:00:00"
	bloom.Enabled = false; colorCorrection.Enabled = false; sunRays.Enabled = false; blurEffect.Enabled = false
	skyEffect.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
	skyEffect.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
	skyEffect.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
	skyEffect.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
	skyEffect.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
	skyEffect.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
end

local function applyDaytime()
	resetShaders()
	Lighting.Brightness = 3.93; Lighting.Ambient = Color3.fromRGB(0, 0, 0)
	Lighting.OutdoorAmbient = Color3.fromRGB(145, 128, 95)
	Lighting.ColorShift_Top = Color3.fromRGB(255, 236, 176); Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	Lighting.ExposureCompensation = 0; Lighting.ClockTime = 14.5; Lighting.GeographicLatitude = 143
	bloom.Enabled = true; bloom.Intensity = 1.25; bloom.Size = 110; bloom.Threshold = 2.15
	colorCorrection.Enabled = true; colorCorrection.Brightness = 0.03; colorCorrection.Contrast = 0.19; colorCorrection.Saturation = 0.12
	sunRays.Enabled = false; blurEffect.Enabled = false
	skyEffect.SkyboxBk = "rbxassetid://6444884337"; skyEffect.SkyboxDn = "rbxassetid://6444884785"
	skyEffect.SkyboxFt = "rbxassetid://6444884337"; skyEffect.SkyboxLf = "rbxassetid://6444884337"
	skyEffect.SkyboxRt = "rbxassetid://6444884337"; skyEffect.SkyboxUp = "rbxassetid://6412503613"
end

local function applySunset()
	resetShaders()
	Lighting.Brightness = 3.8; Lighting.Ambient = Color3.fromRGB(172, 172, 172)
	Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
	Lighting.ColorShift_Top = Color3.fromRGB(255, 174, 43); Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	Lighting.ExposureCompensation = -0.24; Lighting.ClockTime = 7.1; Lighting.GeographicLatitude = 72
	bloom.Enabled = true; bloom.Intensity = 1; bloom.Size = 56; bloom.Threshold = 1.82
	colorCorrection.Enabled = true; colorCorrection.Brightness = 0; colorCorrection.Contrast = 0.1; colorCorrection.Saturation = -0.2
	sunRays.Enabled = true; sunRays.Intensity = 0.18; blurEffect.Enabled = false
	skyEffect.SkyboxBk = "rbxassetid://1009082031"; skyEffect.SkyboxDn = "rbxassetid://1009082487"
	skyEffect.SkyboxFt = "rbxassetid://1009082252"; skyEffect.SkyboxLf = "rbxassetid://1009082137"
	skyEffect.SkyboxRt = "rbxassetid://1009081946"; skyEffect.SkyboxUp = "rbxassetid://1009082428"
end

local function applyNight()
	resetShaders()
	Lighting.Brightness = 2; Lighting.Ambient = Color3.fromRGB(0, 0, 0)
	Lighting.OutdoorAmbient = Color3.fromRGB(145, 128, 95)
	Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0); Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	Lighting.ExposureCompensation = 0; Lighting.ClockTime = 3; Lighting.GeographicLatitude = 41.733
	bloom.Enabled = true; bloom.Intensity = 1; bloom.Size = 90; bloom.Threshold = 2
	colorCorrection.Enabled = true; colorCorrection.Brightness = 0.04; colorCorrection.Contrast = 0.19; colorCorrection.Saturation = 0.12
	sunRays.Enabled = true; sunRays.Intensity = 0.18
	blurEffect.Enabled = true; blurEffect.Size = 0
	skyEffect.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
	skyEffect.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
	skyEffect.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
	skyEffect.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
	skyEffect.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
	skyEffect.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
end

local function applyCloudy()
	resetShaders()
	Lighting.Brightness = 5.63; Lighting.Ambient = Color3.fromRGB(0, 0, 0)
	Lighting.OutdoorAmbient = Color3.fromRGB(89, 68, 47)
	Lighting.ColorShift_Top = Color3.fromRGB(207, 114, 0); Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	Lighting.ExposureCompensation = 0.63; Lighting.ClockTime = 17.63; Lighting.GeographicLatitude = 21.589
	bloom.Enabled = true; bloom.Intensity = 1; bloom.Size = 90; bloom.Threshold = 2
	colorCorrection.Enabled = true; colorCorrection.Brightness = 0.04; colorCorrection.Contrast = 0.15; colorCorrection.Saturation = 0.2
	sunRays.Enabled = true; sunRays.Intensity = 0.004
	blurEffect.Enabled = true; blurEffect.Size = 0
	skyEffect.SkyboxBk = "rbxassetid://2177969403"; skyEffect.SkyboxDn = "rbxassetid://2177972406"
	skyEffect.SkyboxFt = "rbxassetid://2177970251"; skyEffect.SkyboxLf = "rbxassetid://2177969836"
	skyEffect.SkyboxRt = "rbxassetid://2177968823"; skyEffect.SkyboxUp = "rbxassetid://2177971305"
end

local function applyShore()
	resetShaders()
	Lighting.Brightness = 1.92; Lighting.Ambient = Color3.fromRGB(109, 117, 135)
	Lighting.OutdoorAmbient = Color3.fromRGB(36, 47, 58)
	Lighting.ColorShift_Top = Color3.fromRGB(226, 75, 0); Lighting.ColorShift_Bottom = Color3.fromRGB(248, 165, 159)
	Lighting.ExposureCompensation = -0.2; Lighting.ClockTime = 17.6; Lighting.GeographicLatitude = 0
	bloom.Enabled = true; bloom.Intensity = 1; bloom.Size = 50; bloom.Threshold = 2.29
	colorCorrection.Enabled = true; colorCorrection.Brightness = 0; colorCorrection.Contrast = 0.2; colorCorrection.Saturation = 0
	sunRays.Enabled = true; sunRays.Intensity = 0.024
	blurEffect.Enabled = false; blurEffect.Size = 4
	skyEffect.SkyboxBk = "rbxassetid://88585370973398"; skyEffect.SkyboxDn = "rbxassetid://128014535205529"
	skyEffect.SkyboxFt = "rbxassetid://85323615042244"; skyEffect.SkyboxLf = "rbxassetid://77415797450913"
	skyEffect.SkyboxRt = "rbxassetid://127566931602371"; skyEffect.SkyboxUp = "rbxassetid://102320981098060"
end

-- ===================================================
--       PLATFORM DETECTION (Shader Reqs)
-- ===================================================

local function getPlatformReqs()
	local platform = UserInputService:GetPlatform()
	if GuiService:IsTenFootInterface() then
		return [[==== MINIMUM REQUIREMENTS FOR SHADER ====
Console (PlayStation/Xbox) and Portable Consoles (Nintendo Switch 1 & 2)
PlayStation 4 / Xbox One | Nintendo Switch 1
Graphics Quality: 7 or higher, more is better
ANYTHING LESS POWERFUL CAN CAUSE STABILITY ISSUES OR MAKE THE EXPERIENCE LAGGY!]]
	elseif platform == Enum.Platform.IOS or platform == Enum.Platform.OSX then
		return [[==== MINIMUM REQUIREMENTS FOR SHADER ====
iPhones (iOS), iPad OS, and iMacs
IPhone 11 with A13 Bionic | IPad Pro 2018 or IPad Mini 6 | MacBook Air M1
Graphics Quality: 7 or higher, more is better
ANYTHING LESS POWERFUL CAN CAUSE STABILITY ISSUES OR MAKE THE EXPERIENCE LAGGY!]]
	elseif platform == Enum.Platform.Android then
		return [[==== MINIMUM REQUIREMENTS FOR SHADER ====
Android
Snapdragon 778G / Dimensity 7025 / Exynos 1380
Graphics Quality: 7 or higher | RAM: 6GB | Vulkan 1.3
ANYTHING LESS POWERFUL CAN CAUSE STABILITY ISSUES OR MAKE THE EXPERIENCE LAGGY!]]
	else
		return [[==== MINIMUM REQUIREMENTS FOR SHADER ====
PC (Notebook/Desktop)
I7-3770K / Ryzen 3 3200G | GTX 680 TI / RX 550
8GB DDR3 (Preferably DDR4 or DDR5) | DirectX 12
Graphics Quality: 7 or higher, more is better
ANYTHING LESS POWERFUL CAN CAUSE STABILITY ISSUES OR MAKE THE EXPERIENCE LAGGY!]]
	end
end

local TeleportService = game:GetService("TeleportService")
local function rejoinGame()
    local queue_on_teleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    
    if queue_on_teleport then
        queue_on_teleport(_G.ScriptLoadstring)
    end

    local data = loadData()
    local rejoinMode = data.rejoinMode or "different"
    local jobId = data.jobId
    
    if rejoinMode == "same" and jobId then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game:GetService("Players").LocalPlayer)
    else
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
end

-- ===================================================
--     AUTO SPIN LOGIC
-- ===================================================

local function requestSpin()
	if not SpinRF then return end
	task.spawn(function()
		pcall(function()
			SpinRF:InvokeServer()
		end)
	end)
end

local function spinOnce()
	requestSpin()
end

task.spawn(function()
	while true do
		if autoSpinEnabled then
			spinOnce()
			task.wait(0.4)
		else
			task.wait(0.5)
		end
	end
end)

-- ===================================================
--         🏠 HOME PAGE CONTENT
-- ===================================================

createButton(homePage, "Activate Shield", "Makes you survive tsunamis and death waves 1 or 2 times", function()
	local player = game.Players.LocalPlayer
	local SAFE_HP = 1e6

	local function makeImmortal(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.BreakJointsOnDeath = false
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		humanoid.MaxHealth = SAFE_HP
		humanoid.Health = SAFE_HP
		humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health <= 1 then
				humanoid.Health = SAFE_HP
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end)
		humanoid.Died:Connect(function()
			humanoid.Health = SAFE_HP
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end)
	end

	if player.Character then makeImmortal(player.Character) end
	player.CharacterAdded:Connect(makeImmortal)
	showNotification("Shield Activated!")
end)

createButton(homePage, "Instant Actions", "Makes so you don't need to hold to use things, useful for getting brainrots", function()
	local function makeInstant(prompt)
		if prompt:IsA("ProximityPrompt") then
			prompt.HoldDuration = 0
		end
	end
	for _, prompt in ipairs(game:GetDescendants()) do
		makeInstant(prompt)
	end
	game.DescendantAdded:Connect(makeInstant)
	showNotification("Instant Prompts Enabled!")
end)

createButton(homePage, "Delete VIP Walls", "Who needs to pay to survive some tsunamis when you have this?", function()
	for _, part in ipairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and (part.Name == "VIP" or part.Name == "VIP_PLUS") then
			part:Destroy()
		end
	end
	showNotification("VIP Walls Destroyed!")
end)

createToggle(homePage, "Remove All Bases", "Resets you, saves your base and removes the other ones for a huge FPS boost", function(state)
	removingBases = state
	if state then
		showNotification("Resetting character...")

		task.spawn(function()
			local player = game.Players.LocalPlayer
			if player.Character then
				local hum = player.Character:FindFirstChild("Humanoid")
				if hum then
					hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
					hum.Health = 0
				end
			end

			player.CharacterAdded:Wait()
			task.wait(0.5)

			local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			local folder = workspace:FindFirstChild("Bases")
			local savedBase = nil

			if hrp and folder then
				local closestDist = math.huge
				for _, base in ipairs(folder:GetChildren()) do
					if base:IsA("Model") or base:IsA("BasePart") then
						local pos = base:IsA("Model") and base:GetPivot().Position or base.Position
						local dist = (hrp.Position - pos).Magnitude
						if dist < closestDist then
							closestDist = dist
							savedBase = base
						end
					end
				end
			end

			if savedBase then
				showNotification("Saved: " .. savedBase.Name)
			else
				showNotification("No base found to save!")
				removingBases = false
				return
			end

			local function clearOtherBases()
				if not folder or not folder.Parent then return end
				for _, base in ipairs(folder:GetChildren()) do
					if base ~= savedBase and base.Parent then
						base:Destroy()
					end
				end
			end

			clearOtherBases()

			while removingBases do
				clearOtherBases()
				task.wait(2)
			end
		end)
	else
		showNotification("Base Removal Stopped")
	end
end)

local reqLabel = Instance.new("TextLabel")
reqLabel.Text = getPlatformReqs()
reqLabel.Size = UDim2.new(1, -20, 0, 100)
reqLabel.BackgroundTransparency = 1
reqLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
reqLabel.Font = Enum.Font.GothamBold
reqLabel.TextSize = 10
reqLabel.TextWrapped = true
reqLabel.TextXAlignment = Enum.TextXAlignment.Left
reqLabel.Parent = homePage

createDropdown(homePage, "Select Shader", {"Default", "Daytime", "Sunset", "Night", "Cloudy", "Shore"}, function(selected)
	if selected == "Default" then applyDefaultShader()
	elseif selected == "Daytime" then applyDaytime()
	elseif selected == "Sunset" then applySunset()
	elseif selected == "Night" then applyNight()
	elseif selected == "Cloudy" then applyCloudy()
	elseif selected == "Shore" then applyShore()
	end
	showNotification("Shader: " .. selected)
end)

-- ===================================================
--       ⚡ SCRIPTS PAGE CONTENT
-- ===================================================

local AutoCollectTicketsEnabled = false
local AutoCollectConsoleCoinsEnabled = false

createToggle(scriptPage, "Auto Farm Tickets", "Prioritizes ArcadeEventTickets", function(state)
    AutoCollectTicketsEnabled = state
    if state then 
        enableGodMode() 
    else 
        if not AutoCollectConsoleCoinsEnabled then 
            disableGodMode() 
        end 
    end
end)

createToggle(scriptPage, "Auto Farm Console Coins", "Collects ArcadeEventConsoles", function(state)
    AutoCollectConsoleCoinsEnabled = state
    if state then 
        enableGodMode() 
    else 
        if not AutoCollectTicketsEnabled then 
            disableGodMode() 
        end 
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        
        local character = LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        
        if root then
            if AutoCollectTicketsEnabled then
                local ticketFolder = Workspace:FindFirstChild("ArcadeEventTickets")
                if ticketFolder then
                    local items = ticketFolder:GetDescendants()
                    for i = 1, #items do
                        if not AutoCollectTicketsEnabled then break end
                        local item = items[i]
                        if item:IsA("BasePart") then
                            character = LocalPlayer.Character
                            root = character and character:FindFirstChild("HumanoidRootPart")
                            if not root then break end
                            
                            root.CFrame = item.CFrame
                            if firetouchinterest then
                                firetouchinterest(root, item, 0)
                                task.wait()
                                firetouchinterest(root, item, 1)
                            end
                            local prompt = item:FindFirstChildWhichIsA("ProximityPrompt") or item.Parent:FindFirstChildWhichIsA("ProximityPrompt")
                            if prompt and fireproximityprompt then
                                fireproximityprompt(prompt)
                            end
                            task.wait(0.3)
                        end
                    end
                end
            end

            if AutoCollectConsoleCoinsEnabled then
                local ticketFolder = Workspace:FindFirstChild("ArcadeEventTickets")
                local hasTickets = ticketFolder and #ticketFolder:GetChildren() > 0
                
                if not (AutoCollectTicketsEnabled and hasTickets) then
                    local consoleFolder = Workspace:FindFirstChild("ArcadeEventConsoles")
                    if consoleFolder then
                        local items = consoleFolder:GetDescendants()
                        for i = 1, #items do
                            if not AutoCollectConsoleCoinsEnabled then break end
                            if AutoCollectTicketsEnabled then
                                ticketFolder = Workspace:FindFirstChild("ArcadeEventTickets")
                                if ticketFolder and #ticketFolder:GetChildren() > 0 then break end
                            end
                            
                            local item = items[i]
                            if item:IsA("BasePart") then
                                character = LocalPlayer.Character
                                root = character and character:FindFirstChild("HumanoidRootPart")
                                if not root then break end
                                
                                root.CFrame = item.CFrame
                                if firetouchinterest then
                                    firetouchinterest(root, item, 0)
                                    task.wait()
                                    firetouchinterest(root, item, 1)
                                end
                                local prompt = item:FindFirstChildWhichIsA("ProximityPrompt") or item.Parent:FindFirstChildWhichIsA("ProximityPrompt")
                                if prompt and fireproximityprompt then
                                    fireproximityprompt(prompt)
                                end
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ===================================================
--         🗺️ MAP PAGE CONTENT
-- ===================================================

local GodModeEnabled = false

local function enableGodMode()
	if GodModeEnabled then return end
	GodModeEnabled = true
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		humanoid.MaxHealth = math.huge
		humanoid.Health = math.huge
	end
end

local function disableGodMode()
	if not GodModeEnabled then return end
	GodModeEnabled = false
	local player = LocalPlayer
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
	end
end

createButton(mapPage, "Go to Celestial Area", "Teleports you to the celestial area through the map", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	
	enableGodMode()
	
	local originalGravity = Workspace.Gravity
	Workspace.Gravity = 0.00001
	
	local speed = 220
	local noclip = true
	
	local noclipConn = RunService.Stepped:Connect(function()
		if noclip and character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
	
	showNotification("Teleporting to Celestial Area...")
	
	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, -2.7, 137.0),
			Vector3.new(2607, -2.7, 137.0),
			Vector3.new(2607, -2.8, 6.9)
		}
		
		for _, targetPos in ipairs(waypoints) do
			while (root.Position - targetPos).Magnitude > 2.5 do
				local direction = (targetPos - root.Position).Unit
				local dt = RunService.Heartbeat:Wait()
				root.CFrame = root.CFrame + (direction * speed * dt)
				root.Velocity = Vector3.new(0, 0, 0)
			end
		end
		
		noclip = false
		noclipConn:Disconnect()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
		end
		
		Workspace.Gravity = originalGravity
		disableGodMode()
		showNotification("Arrived at Celestial Area!")
	end)
end)

createButton(mapPage, "Go to Arcade Celestial Area", "Only works when arcade event is active!!", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	
	enableGodMode()
	
	local originalGravity = Workspace.Gravity
	Workspace.Gravity = 0.00001
	
	local speed = 220
	local noclip = true
	
	local noclipConn = RunService.Stepped:Connect(function()
		if noclip and character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
	
	showNotification("Teleporting to Arcade Celestial Area...")
	
	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, -2.7, 137.0),
			Vector3.new(4025, -2.7, 137.0),
			Vector3.new(4025, -2.7, -9.8)
		}
		
		for _, targetPos in ipairs(waypoints) do
			while (root.Position - targetPos).Magnitude > 2.5 do
				local direction = (targetPos - root.Position).Unit
				local dt = RunService.Heartbeat:Wait()
				root.CFrame = root.CFrame + (direction * speed * dt)
				root.Velocity = Vector3.new(0, 0, 0)
			end
		end
		
		noclip = false
		noclipConn:Disconnect()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
		end
		
		Workspace.Gravity = originalGravity
		disableGodMode()
		showNotification("Arrived at Arcade Celestial Area!")
	end)
end)

createButton(mapPage, "Go to Base", "Returns you to the base safely", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	
	enableGodMode()
	
	local originalGravity = Workspace.Gravity
	Workspace.Gravity = 0.00001
	
	local speed = 220
	local noclip = true
	
	local noclipConn = RunService.Stepped:Connect(function()
		if noclip and character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
	
	showNotification("Teleporting to Base...")
	
	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, -2.7, 137.0),
			Vector3.new(148.0, 3.3, 137.0)
		}
		
		for _, targetPos in ipairs(waypoints) do
			while (root.Position - targetPos).Magnitude > 2.5 do
				local direction = (targetPos - root.Position).Unit
				local dt = RunService.Heartbeat:Wait()
				root.CFrame = root.CFrame + (direction * speed * dt)
				root.Velocity = Vector3.new(0, 0, 0)
			end
		end
		
		noclip = false
		noclipConn:Disconnect()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
		end
		
		Workspace.Gravity = originalGravity
		disableGodMode()
		showNotification("Complete (If you din't die in the process)")
	end)
end)

createButton(mapPage, "Go to Arcade", "Teleports you to the arcade area through the map", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	
	enableGodMode()
	
	local originalGravity = Workspace.Gravity
	Workspace.Gravity = 0.00001
	
	local speed = 220
	local noclip = true
	
	local noclipConn = RunService.Stepped:Connect(function()
		if noclip and character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
	
	showNotification("Teleporting to Arcade...")
	
	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, 3.3, -137.0),
			Vector3.new(152.5, 3.3, -135),
			Vector3.new(755, -2.7, -137)
		}
		
		for _, targetPos in ipairs(waypoints) do
			while (root.Position - targetPos).Magnitude > 2.5 do
				local direction = (targetPos - root.Position).Unit
				local dt = RunService.Heartbeat:Wait()
				root.CFrame = root.CFrame + (direction * speed * dt)
				root.Velocity = Vector3.new(0, 0, 0)
			end
		end
		
		noclip = false
		noclipConn:Disconnect()
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
		end
		
		Workspace.Gravity = originalGravity
		disableGodMode()
      Workspace.Gravity = originalGravity
		showNotification("Arrived at Arcade!")
	end)
end)


-- ===================================================
--       ⚙️ SETTINGS PAGE CONTENT
-- ===================================================

local NoclipEnabled = false

createToggle(settingsPage, "Noclip", "Walk through walls", function(enabled)
	NoclipEnabled = enabled
	if enabled then
		showNotification("Noclip Enabled")
		task.spawn(function()
			while NoclipEnabled do
				local player = LocalPlayer
				local character = player.Character
				if character then
					for _, part in ipairs(character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
				RunService.Stepped:Wait()
			end
		end)
	else
		showNotification("Noclip Disabled")
		local player = LocalPlayer
		local character = player.Character
		if character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
					part.CanCollide = true
				end
			end
		end
	end
end)

createButton(settingsPage, "Money Event Script", "Goes back to an older version, makes sure It works for both events", function()
	showNotification("Loading Money Event Script...")
	
	farming = false
	autoSpinEnabled = false
	spinning = false
	removingBases = false
	NoclipEnabled = false
	
	Workspace.Gravity = 196.2
	disableGodMode()
	
	local player = LocalPlayer
	local character = player.Character
	if character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.CanCollide = true
			end
		end
	end
	
	if gui then gui:Destroy() end
	task.wait(0.5)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/klimplimRBX/GGHub/main/GGHubMoneyEvent.lua"))()
end)

-- ===================================================
--         INITIALIZE & CLOSE/MIN LOGIC
-- ===================================================

showPage("Home")

local function toggleUI()
	MainFrame.Visible = not MainFrame.Visible
	MiniGG.Visible = not MainFrame.Visible
end

CloseBtn.Active = true
MinBtn.Active = true
MiniGG.Active = true

CloseBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
	toggleUI()
end)

MiniGG.MouseButton1Click:Connect(function()
	toggleUI()
end)

if loadingGui then
	loadingGui:Destroy()
end

print("GGHub Fully Loaded")
