-- =====================================

--[[ GGHub is an open source script :D
       So have fun getting some functions 
       from here and using then on your own script
]]--

-- ============= GGHub v0.9 (Animated btw because i'm proud of this now) ===============

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
blur.Size = 0
blur.Parent = Lighting

TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 20}):Play()

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

local blurGuard = Lighting.DescendantAdded:Connect(function(obj)
	if obj:IsA("BlurEffect") and obj.Name ~= "__GGHUB_LOADING_BLUR__" then
		obj:Destroy()
	end
end)

local frame = Instance.new("Frame", loadingGui)
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local UIScale_Loading = Instance.new("UIScale", frame)
UIScale_Loading.Scale = 0.85

TweenService:Create(frame, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
TweenService:Create(UIScale_Loading, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

local title = Instance.new("TextLabel", frame)
title.Text = "GGHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 56
title.TextColor3 = Color3.new(1, 1, 1)
title.TextTransparency = 1
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 24, 0, 24)
title.Size = UDim2.new(1, -48, 0, 60)
title.TextXAlignment = Enum.TextXAlignment.Left

task.delay(0.2, function()
	TweenService:Create(title, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
end)

local sub = Instance.new("TextLabel", frame)
sub.Text = "Made by KlimplimRBX"
sub.Font = Enum.Font.Gotham
sub.TextSize = 16
sub.TextColor3 = Color3.fromRGB(180, 180, 180)
sub.TextTransparency = 1
sub.BackgroundTransparency = 1
sub.Position = UDim2.new(0, 26, 0, 88)
sub.Size = UDim2.new(1, -52, 0, 20)
sub.TextXAlignment = Enum.TextXAlignment.Left
task.delay(0.35, function()
	TweenService:Create(sub, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
end)

local loadingText = Instance.new("TextLabel", frame)
loadingText.Text = "Loading script..."
loadingText.Font = Enum.Font.Gotham
loadingText.TextSize = 22
loadingText.TextColor3 = Color3.fromRGB(220, 220, 220)
loadingText.TextTransparency = 1
loadingText.BackgroundTransparency = 1
loadingText.Position = UDim2.new(0, 26, 1, -88)
loadingText.Size = UDim2.new(1, -52, 0, 30)
loadingText.TextXAlignment = Enum.TextXAlignment.Left
task.delay(0.45, function()
	TweenService:Create(loadingText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
end)

local dotTexts = {"Loading script.", "Loading script..", "Loading script...", "Loading script"}
local dotIndex = 1
task.spawn(function()
	while loadingGui and loadingGui.Parent do
		task.wait(0.45)
		dotIndex = (dotIndex % #dotTexts) + 1
		loadingText.Text = dotTexts[dotIndex]
	end
end)

local progressTrack = Instance.new("Frame", frame)
progressTrack.Size = UDim2.new(0, 368, 0, 6)
progressTrack.Position = UDim2.new(0, 26, 1, -36)
progressTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressTrack.BorderSizePixel = 0
Instance.new("UICorner", progressTrack).CornerRadius = UDim.new(1, 0)

local progressBar = Instance.new("Frame", progressTrack)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = Color3.new(1, 1, 1)
progressBar.BorderSizePixel = 0
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

local progressTween = TweenService:Create(progressBar, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})
progressTween:Play()

local grid = Instance.new("Frame", frame)
grid.Size = UDim2.new(0, 96, 0, 96)
grid.Position = UDim2.new(1, -126, 1, -148)
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
	sq.BackgroundTransparency = 1
	Instance.new("UICorner", sq).CornerRadius = UDim.new(0, 5)
	squares[index] = sq
	task.delay(0.5 + index * 0.05, function()
		TweenService:Create(sq, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
	end)
end

task.spawn(function()
	local order = {1, 2, 3, 4, 5, 6, 7, 8}
	local step = 1
	while loadingGui and loadingGui.Parent do
		for _, sq in pairs(squares) do
			if sq then
				TweenService:Create(sq, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
		local current = order[step]
		if squares[current] then
			TweenService:Create(squares[current], TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
		end
		step = (step % #order) + 1
		task.wait(0.12)
	end
end)

_G.HideGGHubLoading = function()
	if not loadingGui or not loadingGui.Parent then return end
	blurGuard:Disconnect()
	TweenService:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 0}):Play()
	TweenService:Create(UIScale_Loading, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.9}):Play()
	TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	for _, v in ipairs(frame:GetDescendants()) do
		if v:IsA("TextLabel") then
			TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
		elseif v:IsA("Frame") then
			TweenService:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		end
	end
	task.delay(0.45, function()
		if loadingGui then loadingGui:Destroy() end
	end)
end

-- ===================================================
--           SECURITY CHECK (PlaceId and executor)
-- ===================================================

local _ex = string.lower(identifyexecutor() or "") -- If your executor does not have this shit, then fuck it, Just unninstall It at this point
local _tg = "\115\111\108\97\114\97"

if string.find(_ex, _tg) then
	local _k = "K".."i".."c".."k"
	local p = game:GetService("Players").LocalPlayer
	p[_k](p, "\n[GGHub Security & Compatability Check]\nYour executor (Solara) is NOT supported.\nPlease use a supported executor like Bunni, wave or Xeno, or others")
end

local ALLOWED_PLACE_IDS = {131623223084840, 111917342868480}
local placeAllowed = false
for _, id in ipairs(ALLOWED_PLACE_IDS) do
	if game.PlaceId == id then placeAllowed = true; break end
end

if not placeAllowed then
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
	return
end

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
	ButtonHover = Color3.fromRGB(70, 70, 70),
	Accent = Color3.fromRGB(0, 85, 165),
}

if PlayerGui:FindFirstChild("GGHub_v09") then
	PlayerGui.GGHub_v09:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "GGHub_v09"
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
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
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

local notificationList = {}

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

	local label = Instance.new("TextLabel", notif)
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
	label.ZIndex = 20

	table.insert(notificationList, notif)

	TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = notif.Position - UDim2.new(0, 0, 0, 20)
	}):Play()

	task.delay(3, function()
		if not notif or not notif.Parent then return end
		TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1,
			Position = notif.Position - UDim2.new(0, 0, 0, 20)
		}):Play()
		TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 1
		}):Play()
		task.delay(0.5, function()
			if notif then notif:Destroy() end
			local index = table.find(notificationList, notif)
			if index then table.remove(notificationList, index) end
			for i, n in ipairs(notificationList) do
				TweenService:Create(n, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, -20, 1, -20 - ((i - 1) * 55))
				}):Play()
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
MiniGG.TextScaled = true
MiniGG.Font = Enum.Font.SourceSansBold
MiniGG.TextColor3 = Color3.new(1, 1, 1)
MiniGG.BackgroundColor3 = Color3.new(0, 0, 0)
MiniGG.Visible = false
MiniGG.Parent = gui
Instance.new("UICorner", MiniGG).CornerRadius = UDim.new(0, 10)
local kStroke = Instance.new("UIStroke")
kStroke.Color = Color3.fromRGB(60, 60, 60)
kStroke.Thickness = 0.7
kStroke.Parent = MiniGG
makeDraggable(MiniGG)

task.spawn(function()
	local hue = 0
	while true do
		if MiniGG.Visible then
			hue = (hue + 0.8) % 360
			kStroke.Color = Color3.fromHSV(hue / 360, 0.75, 1)
		end
		RunService.Heartbeat:Wait()
	end
end)

MiniGG.MouseEnter:Connect(function()
	TweenService:Create(MiniGG, TweenInfo.new(0.11), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
end)
MiniGG.MouseLeave:Connect(function()
	TweenService:Create(MiniGG, TweenInfo.new(0.11), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
end)

local MainFrame = Instance.new("CanvasGroup")
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -180)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.GroupTransparency = 1
MainFrame.Visible = false
MainFrame.Parent = gui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke")
mStroke.Color = Color3.fromRGB(60, 60, 60)
mStroke.Parent = MainFrame
makeDraggable(MainFrame)

local UIScale_Main = Instance.new("UIScale", MainFrame)
UIScale_Main.Scale = 0.9


-- ===================================================
--              HEADER BAR
-- ===================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local AppTitle = Instance.new("TextLabel")
AppTitle.Text = "GGHub v0.9"
AppTitle.Size = UDim2.new(0, 200, 0, 20)
AppTitle.Position = UDim2.new(0, 15, 0, 12)
AppTitle.Font = Enum.Font.GothamBold
AppTitle.TextSize = 18
AppTitle.TextColor3 = Colors.TextMain
AppTitle.TextXAlignment = Enum.TextXAlignment.Left
AppTitle.BackgroundTransparency = 1
AppTitle.Parent = Header

local AppSignature = Instance.new("TextLabel")
AppSignature.Text = "Made by KlimplimRBX - The last update before the biggest yet"
AppSignature.Size = UDim2.new(0, 300, 0, 15)
AppSignature.Position = UDim2.new(0, 15, 0, 32)
AppSignature.Font = Enum.Font.Gotham
AppSignature.TextSize = 11
AppSignature.TextColor3 = Colors.TextSub
AppSignature.TextXAlignment = Enum.TextXAlignment.Left
AppSignature.BackgroundTransparency = 1
AppSignature.Parent = Header

local HeaderLine = Instance.new("Frame", MainFrame)
HeaderLine.Size = UDim2.new(1, -20, 0, 1)
HeaderLine.Position = UDim2.new(0, 10, 0, 50)
HeaderLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
HeaderLine.BorderSizePixel = 0

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 9)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.TextColor3 = Colors.TextMain
CloseBtn.TextSize = 24
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn)

local MinBtn = Instance.new("TextButton")
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -80, 0, 9)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinBtn.TextColor3 = Colors.TextMain
MinBtn.TextSize = 20
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn)

local function addHeaderBtnHover(btn, hoverColor, normalColor)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.11), {BackgroundColor3 = hoverColor}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.11), {BackgroundColor3 = normalColor}):Play()
	end)
	btn.MouseButton1Down:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.055), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
	end)
	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.077), {BackgroundColor3 = hoverColor}):Play()
	end)
end

addHeaderBtnHover(CloseBtn, Color3.fromRGB(185, 45, 45), Color3.fromRGB(45, 45, 45))
addHeaderBtnHover(MinBtn, Color3.fromRGB(60, 60, 60), Color3.fromRGB(45, 45, 45))

-- ===================================================
--         PAGE SYSTEM & SIDEBAR
-- ===================================================

local BodyFrame = Instance.new("Frame")
BodyFrame.Size = UDim2.new(1, 0, 1, -55)
BodyFrame.Position = UDim2.new(0, 0, 0, 55)
BodyFrame.BackgroundTransparency = 1
BodyFrame.Parent = MainFrame

local Pages = {}
local SidebarButtons = {}
local currentPage = nil

local function createPage(name)
	local wrapper = Instance.new("CanvasGroup")
	wrapper.Name = name .. "Page"
	wrapper.Size = UDim2.new(1, -85, 1, -20)
	wrapper.Position = UDim2.new(0, 75, 0, 10)
	wrapper.BackgroundTransparency = 1
	wrapper.BorderSizePixel = 0
	wrapper.Visible = false
	wrapper.GroupTransparency = 1
	wrapper.Parent = BodyFrame

	local page = Instance.new("ScrollingFrame", wrapper)
	page.Name = "Scroll"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	Instance.new("UIListLayout", page).Padding = UDim.new(0, 10)

	Pages[name] = wrapper
	return page
end

local function showPage(name)
	if name == currentPage then return end
	if currentPage and Pages[currentPage] then
		local old = Pages[currentPage]
		TweenService:Create(old, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1}):Play()
		task.delay(0.077, function() old.Visible = false end)
	end

	task.delay(currentPage and 0.06 or 0, function()
		local p = Pages[name]
		if p then
			p.Visible = true
			p.GroupTransparency = 1
			TweenService:Create(p, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
		end
	end)

	for n, b in pairs(SidebarButtons) do
		local isActive = (n == name)
		TweenService:Create(b, TweenInfo.new(0.154), {
			BackgroundTransparency = isActive and 0.8 or 1,
			TextColor3 = isActive and Colors.TextMain or Color3.fromRGB(100, 100, 100)
		}):Play()
		if isActive then
			local sc = b:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", b)
			TweenService:Create(sc, TweenInfo.new(0.077, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.15}):Play()
			task.delay(0.077, function()
				TweenService:Create(sc, TweenInfo.new(0.11, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
			end)
		end
	end

	currentPage = name
end

local homePage = createPage("Home")
local scriptPage = createPage("Scripts")
local mapPage = createPage("Map")
local settingsPage = createPage("Settings")

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 65, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = BodyFrame

local function addSideIcon(text, yPos, target)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(0, 50, 0, 50)
	btn.Position = UDim2.new(0.5, -25, 0, yPos)
	btn.BackgroundTransparency = 1
	btn.TextSize = 28
	btn.Parent = Sidebar
	btn.TextColor3 = Color3.fromRGB(100, 100, 100)
	Instance.new("UICorner", btn)
	Instance.new("UIScale", btn).Scale = 1
	SidebarButtons[target] = btn

	btn.MouseEnter:Connect(function()
		if currentPage ~= target then
			local sc = btn:FindFirstChildOfClass("UIScale")
			TweenService:Create(sc, TweenInfo.new(0.11, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.1}):Play()
			TweenService:Create(btn, TweenInfo.new(0.11), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
		end
	end)
	btn.MouseLeave:Connect(function()
		if currentPage ~= target then
			local sc = btn:FindFirstChildOfClass("UIScale")
			TweenService:Create(sc, TweenInfo.new(0.11), {Scale = 1}):Play()
			TweenService:Create(btn, TweenInfo.new(0.11), {TextColor3 = Color3.fromRGB(100, 100, 100)}):Play()
		end
	end)

	btn.MouseButton1Click:Connect(function()
		showPage(target)
	end)
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
	ToggleFrame.Size = UDim2.new(1, -10, 0, 65)
	ToggleFrame.BackgroundColor3 = Colors.ItemBG
	ToggleFrame.Parent = parent
	Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = titleText
	TTitle.Size = UDim2.new(1, -75, 0, 25)
	TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1
	TTitle.TextColor3 = Colors.TextMain
	TTitle.Font = Enum.Font.GothamBold
	TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left
	TTitle.Parent = ToggleFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = desc
	TDesc.Size = UDim2.new(1, -75, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1
	TDesc.TextColor3 = Colors.TextSub
	TDesc.Font = Enum.Font.Gotham
	TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left
	TDesc.Parent = ToggleFrame

	local SwitchBase = Instance.new("TextButton")
	SwitchBase.Text = ""
	SwitchBase.Size = UDim2.new(0, 50, 0, 28)
	SwitchBase.Position = UDim2.new(1, -65, 0.5, -14)
	SwitchBase.BackgroundColor3 = Colors.ToggleOff
	SwitchBase.Parent = ToggleFrame
	Instance.new("UICorner", SwitchBase).CornerRadius = UDim.new(1, 0)

	local Knob = Instance.new("Frame")
	Knob.Size = UDim2.new(0, 22, 0, 22)
	Knob.Position = UDim2.new(0, 3, 0.5, -11)
	Knob.BackgroundColor3 = Color3.new(1, 1, 1)
	Knob.Parent = SwitchBase
	Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

	local KnobStroke = Instance.new("UIStroke", Knob)
	KnobStroke.Color = Color3.fromRGB(0, 0, 0)
	KnobStroke.Thickness = 1
	KnobStroke.Transparency = 0.6

	ToggleFrame.MouseEnter:Connect(function()
		TweenService:Create(ToggleFrame, TweenInfo.new(0.11), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()
	end)
	ToggleFrame.MouseLeave:Connect(function()
		TweenService:Create(ToggleFrame, TweenInfo.new(0.11), {BackgroundColor3 = Colors.ItemBG}):Play()
	end)

	local toggled = false
	SwitchBase.MouseButton1Click:Connect(function()
		toggled = not toggled

		TweenService:Create(SwitchBase, TweenInfo.new(0.121, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = toggled and Colors.ToggleOn or Colors.ToggleOff
		}):Play()
		TweenService:Create(Knob, TweenInfo.new(0.121, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = toggled and UDim2.new(0, 25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
		}):Play()

		if toggled then
			TweenService:Create(mStroke, TweenInfo.new(0.154), {Color = Colors.Accent}):Play()
			task.delay(0.308, function()
				TweenService:Create(mStroke, TweenInfo.new(0.308), {Color = Color3.fromRGB(60, 60, 60)}):Play()
			end)
		end

		task.spawn(function() pcall(callback, toggled) end)
	end)
end

local function createButton(parent, titleText, desc, callback)
	local BtnWrapper = Instance.new("Frame")
	BtnWrapper.Size = UDim2.new(1, -10, 0, 60)
	BtnWrapper.BackgroundTransparency = 1
	BtnWrapper.Parent = parent

	local BtnFrame = Instance.new("TextButton")
	BtnFrame.Size = UDim2.new(1, 0, 1, 0)
	BtnFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	BtnFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	BtnFrame.BackgroundColor3 = Colors.ItemBG
	BtnFrame.Parent = BtnWrapper
	BtnFrame.Text = ""
	BtnFrame.AutoButtonColor = false
	Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0, 12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = titleText
	TTitle.Size = UDim2.new(1, -20, 0, 25)
	TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1
	TTitle.TextColor3 = Colors.TextMain
	TTitle.Font = Enum.Font.GothamBold
	TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left
	TTitle.Parent = BtnFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = desc
	TDesc.Size = UDim2.new(1, -20, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1
	TDesc.TextColor3 = Colors.TextSub
	TDesc.Font = Enum.Font.Gotham
	TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left
	TDesc.Parent = BtnFrame

	local Arrow = Instance.new("TextLabel")
	Arrow.Text = "›"
	Arrow.Size = UDim2.new(0, 20, 0, 20)
	Arrow.Position = UDim2.new(1, -30, 0.5, -10)
	Arrow.BackgroundTransparency = 1
	Arrow.TextColor3 = Color3.fromRGB(80, 80, 80)
	Arrow.TextSize = 20
	Arrow.Font = Enum.Font.GothamBold
	Arrow.Parent = BtnFrame

	local BtnScale = Instance.new("UIScale", BtnFrame)
	BtnScale.Scale = 1

	BtnFrame.MouseEnter:Connect(function()
		TweenService:Create(BtnFrame, TweenInfo.new(0.11), {BackgroundColor3 = Colors.ButtonHover}):Play()
		TweenService:Create(Arrow, TweenInfo.new(0.11), {
			TextColor3 = Colors.Accent,
			Position = UDim2.new(1, -26, 0.5, -10)
		}):Play()
	end)
	BtnFrame.MouseLeave:Connect(function()
		TweenService:Create(BtnFrame, TweenInfo.new(0.11), {BackgroundColor3 = Colors.ItemBG}):Play()
		TweenService:Create(Arrow, TweenInfo.new(0.11), {
			TextColor3 = Color3.fromRGB(80, 80, 80),
			Position = UDim2.new(1, -30, 0.5, -10)
		}):Play()
	end)

	BtnFrame.MouseButton1Click:Connect(function()
		TweenService:Create(BtnScale, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.97}):Play()
		task.delay(0.06, function()
			TweenService:Create(BtnScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
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
	DTitle.Font = Enum.Font.GothamBold
	DTitle.TextSize = 16
	DTitle.TextXAlignment = Enum.TextXAlignment.Left
	DTitle.Parent = DropFrame

	local Arrow = Instance.new("TextLabel")
	Arrow.Text = "↓"
	Arrow.Size = UDim2.new(0, 30, 0, 30)
	Arrow.Position = UDim2.new(1, -40, 0, 15)
	Arrow.BackgroundTransparency = 1
	Arrow.TextColor3 = Colors.TextSub
	Arrow.TextSize = 14
	Arrow.Font = Enum.Font.Gotham
	Arrow.Parent = DropFrame

	local ExpandBtn = Instance.new("TextButton")
	ExpandBtn.Size = UDim2.new(1, 0, 0, baseHeight)
	ExpandBtn.BackgroundTransparency = 1
	ExpandBtn.Text = ""
	ExpandBtn.Parent = DropFrame

	ExpandBtn.MouseEnter:Connect(function()
		TweenService:Create(DropFrame, TweenInfo.new(0.154), {BackgroundColor3 = Colors.ButtonHover}):Play()
	end)
	ExpandBtn.MouseLeave:Connect(function()
		TweenService:Create(DropFrame, TweenInfo.new(0.154), {BackgroundColor3 = Colors.ItemBG}):Play()
	end)

	local ListContainer = Instance.new("Frame")
	ListContainer.Size = UDim2.new(1, -20, 0, #options * optionHeight)
	ListContainer.Position = UDim2.new(0, 10, 0, baseHeight)
	ListContainer.BackgroundTransparency = 1
	ListContainer.Parent = DropFrame
	Instance.new("UIListLayout", ListContainer).Padding = UDim.new(0, 5)

	for _, optName in ipairs(options) do
		local OptBtn = Instance.new("TextButton")
		OptBtn.Size = UDim2.new(1, 0, 0, 30)
		OptBtn.BackgroundColor3 = Colors.Button
		OptBtn.Text = optName
		OptBtn.TextColor3 = Colors.TextSub
		OptBtn.Font = Enum.Font.Gotham
		OptBtn.TextSize = 14
		OptBtn.Parent = ListContainer
		Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

		OptBtn.MouseEnter:Connect(function()
			TweenService:Create(OptBtn, TweenInfo.new(0.11), {BackgroundColor3 = Color3.fromRGB(65, 65, 65), TextColor3 = Colors.TextMain}):Play()
		end)
		OptBtn.MouseLeave:Connect(function()
			TweenService:Create(OptBtn, TweenInfo.new(0.11), {BackgroundColor3 = Colors.Button, TextColor3 = Colors.TextSub}):Play()
		end)

		OptBtn.MouseButton1Click:Connect(function()
			DTitle.Text = titleText .. ": " .. optName
			callback(optName)
			isOpened = false
			TweenService:Create(DropFrame, TweenInfo.new(0.231, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -10, 0, baseHeight)
			}):Play()
			TweenService:Create(Arrow, TweenInfo.new(0.231), {Rotation = 0}):Play()
		end)
	end

	ExpandBtn.MouseButton1Click:Connect(function()
		isOpened = not isOpened
		TweenService:Create(DropFrame, TweenInfo.new(0.231, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, -10, 0, isOpened and totalHeight or baseHeight)
		}):Play()
		TweenService:Create(Arrow, TweenInfo.new(0.231), {Rotation = isOpened and 180 or 0}):Play()
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

local removingBases = false

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
--       ⚡ SCRIPTS PAGE CONTENT - VALENTINE EVENT
-- ===================================================

local AutoFarmDoomCoinEnabled = false
local AutoPressDoomButtonEnabled = false
local lastCollectedDoomCoin = nil

local moveLocked = false
local function acquireMoveLock()
	while moveLocked do task.wait(0.02) end
	moveLocked = true
end
local function releaseMoveLock()
	moveLocked = false
end

LocalPlayer.CharacterAdded:Connect(function()
	moveLocked = false
	lastCollectedDoomCoin = nil
end)

local function getPosition(obj)
	if obj:IsA("BasePart") then
		return obj.Position
	elseif obj:IsA("Model") then
		if obj.PrimaryPart then return obj.PrimaryPart.Position end
		local part = obj:FindFirstChildWhichIsA("BasePart", true)
		if part then return part.Position end
	end
	return nil
end

local function isCharacterAlive(root, humanoid)
	if not root or not root.Parent then return false end
	if not humanoid or not humanoid.Parent then return false end
	if humanoid.Health <= 0 then return false end
	return true
end

local function getCharacterRoots()
	local character = LocalPlayer.Character
	if not character then return nil, nil end
	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	return root, humanoid
end

local function waitForCharacterSafe()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart", 10)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not root or not humanoid then return nil, nil end
	local elapsed = 0
	while humanoid.Health <= 0 do
		local dt = RunService.Heartbeat:Wait()
		elapsed = elapsed + dt
		if elapsed > 10 then return nil, nil end
		if LocalPlayer.Character ~= character then return nil, nil end
	end
	task.wait(0.2)
	return root, humanoid
end

local function flyToPos(targetPos, speed)
	speed = speed or 4000
	local root, humanoid = getCharacterRoots()
	if not isCharacterAlive(root, humanoid) then return false end

	while (root.Position - targetPos).Magnitude > 1.5 do
		local dt = RunService.Heartbeat:Wait()
		if not isCharacterAlive(root, humanoid) then return false end
		local remaining = (targetPos - root.Position)
		local step = math.min(speed * dt, remaining.Magnitude)
		root.CFrame = root.CFrame + remaining.Unit * step
		root.AssemblyLinearVelocity = Vector3.zero
	end

	if isCharacterAlive(root, humanoid) then
		root.CFrame = CFrame.new(targetPos)
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
	return true
end

local function collectItem(targetPos, heightOffset)
	local root = waitForCharacterSafe()
	if not root then return end

	acquireMoveLock()
	local ok, err = pcall(function()
		local cx, cz = root.Position.X, root.Position.Z
		flyToPos(Vector3.new(cx, -25, cz), 1000)
		task.wait(0.01)
		flyToPos(Vector3.new(targetPos.X, -25, targetPos.Z), 1000)
		task.wait(0.01)
		flyToPos(Vector3.new(targetPos.X, heightOffset, targetPos.Z), 1000)
		task.wait(0.01)
	end)
	releaseMoveLock()

	if not ok then warn("[collectItem] Movement error: " .. tostring(err)) end
end

task.spawn(function()
	while true do
		if AutoFarmDoomCoinEnabled then
			local root = getCharacterRoots()
			if root then
				local doomEventParts = Workspace:FindFirstChild("DoomEventParts")
				if doomEventParts then
					local coins = {}
					for _, coin in ipairs(doomEventParts:GetChildren()) do
						if coin.Name == "DoomCoin" and coin.Parent then
							local pos = getPosition(coin)
							if pos then
								table.insert(coins, {
									obj  = coin,
									pos  = pos,
									dist = (root.Position - pos).Magnitude
								})
							end
						end
					end

					if #coins > 0 then
						table.sort(coins, function(a, b) return a.dist < b.dist end)
						local target = nil
						if lastCollectedDoomCoin and coins[1] and coins[1].obj == lastCollectedDoomCoin and coins[2] then
							target = coins[2]
						elseif coins[1] then
							target = coins[1]
						end
						if target and target.obj.Parent then
							collectItem(target.pos, 3.3)
							lastCollectedDoomCoin = target.obj
						end
					else
						lastCollectedDoomCoin = nil
						task.wait(1)
					end
				end
			end
		end
		task.wait(0.02)
	end
end)

createToggle(scriptPage, "Auto Farm Doom Coins", "Auto Farms Doom Coins for ya", function(state)
	AutoFarmDoomCoinEnabled = state
	lastCollectedDoomCoin = nil
	if state then
		showNotification("Auto Farm Doom Coins Enabled")
	else
		showNotification("Auto Farm Doom Coins Disabled")
	end
end)

local doomButtonsBusy = false

task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if AutoPressDoomButtonEnabled and not doomButtonsBusy then
			local root = getCharacterRoots()
			if root then
				local pos = root.Position
				if pos.Y ~= -25 then
					root.CFrame = CFrame.new(pos.X, -25, pos.Z)
					root.AssemblyLinearVelocity = Vector3.zero
					root.AssemblyAngularVelocity = Vector3.zero
				end
			end
		end
	end)
end)

task.spawn(function()
	while true do
		task.wait(0.3)
		if AutoPressDoomButtonEnabled then
			local doomButtons = Workspace:FindFirstChild("DoomEventButtons")
			if doomButtons then
				for _, button in ipairs(doomButtons:GetChildren()) do
					if button.Name == "Button" and button.Parent then
						local union = button:FindFirstChild("Union")
						if union then
							local prompt = union:FindFirstChild("ProximityPrompt")
							if prompt then
								local pos = getPosition(button)
								if pos then
									doomButtonsBusy = true
									acquireMoveLock()
									pcall(function()
										local root = getCharacterRoots()
										if root then
											flyToPos(Vector3.new(pos.X, -25, pos.Z), 2000)
											task.wait(0.01)
											flyToPos(Vector3.new(pos.X, pos.Y + 3, pos.Z), 2000)
											task.wait(0.5)
										end
										for _ = 1, 3 do
											local ok = pcall(fireproximityprompt, prompt)
											if ok then break end
											task.wait(0.3)
										end
									end)
									releaseMoveLock()
									doomButtonsBusy = false
									task.wait(1)
								end
							end
						end
					end
				end
			end
		end
	end
end)

createToggle(scriptPage, "Auto press Doom buttons", "Auto presses Doom event buttons for you", function(state)
	AutoPressDoomButtonEnabled = state
	if state then
		showNotification("Auto press Doom buttons Enabled")
	else
		showNotification("Auto press Doom buttons Disabled")
	end
end)

-- ===================================================
--         🗺️ MAP PAGE CONTENT
-- ===================================================

local function flyThroughWaypoints(waypoints, speed)
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	speed = speed or 1000
	local noclip = true

	local noclipConn = RunService.Stepped:Connect(function()
		if noclip and character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)

	for i, targetPos in ipairs(waypoints) do
		while (root.Position - targetPos).Magnitude > 2 do
			local direction = (targetPos - root.Position).Unit
			local dt = RunService.Heartbeat:Wait()
			root.CFrame = root.CFrame + (direction * speed * dt)
			root.Velocity = Vector3.new(0, 0, 0)
		end

		if i < #waypoints then
			task.wait(0.25)
		end
	end

	noclip = false
	noclipConn:Disconnect()
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			part.CanCollide = true
		end
	end
end

createButton(mapPage, "Go to celestial area", "Goes to the celestial area", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	showNotification("Going to celestial area...")

	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, -20, 0),
			Vector3.new(4025.0, -20, 0),
			Vector3.new(4025.0, -2.7, 0)
		}

		flyThroughWaypoints(waypoints, 1000)
		showNotification("Arrived at celestial area!")
	end)
end)

createButton(mapPage, "Go back to base", "Goes back to your base safely", function()
	local player = LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	showNotification("Going back to base...")

	task.spawn(function()
		local waypoints = {
			Vector3.new(root.Position.X, -20, 0),
			Vector3.new(125, -20, 0),
			Vector3.new(125, 3.3, 0)
		}

		flyThroughWaypoints(waypoints, 1000)
		showNotification("Arrived at base!")
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

-- ===================================================
--         INITIALIZE & CLOSE/MIN LOGIC
-- ===================================================

showPage("Home")

local uiOpen = true

local function openUI()
	uiOpen = true
	MiniGG.Visible = false
	MainFrame.Visible = true
	UIScale_Main.Scale = 0.92
	MainFrame.GroupTransparency = 1
	mStroke.Transparency = 1
	TweenService:Create(MainFrame, TweenInfo.new(0.231, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
	TweenService:Create(UIScale_Main, TweenInfo.new(0.231, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	TweenService:Create(mStroke, TweenInfo.new(0.231), {Transparency = 0}):Play()
end

local function closeUI()
	uiOpen = false
	TweenService:Create(MainFrame, TweenInfo.new(0.154, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {GroupTransparency = 1}):Play()
	TweenService:Create(UIScale_Main, TweenInfo.new(0.154, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.92}):Play()
	TweenService:Create(mStroke, TweenInfo.new(0.132), {Transparency = 1}):Play()
	task.delay(0.165, function()
		MainFrame.Visible = false
		MiniGG.Visible = true
		local sc = MiniGG:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", MiniGG)
		sc.Scale = 0.5
		TweenService:Create(sc, TweenInfo.new(0.198, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end)
end

CloseBtn.Active = true
MinBtn.Active = true
MiniGG.Active = true

CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.165, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {GroupTransparency = 1}):Play()
	TweenService:Create(UIScale_Main, TweenInfo.new(0.165, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.88}):Play()
	TweenService:Create(mStroke, TweenInfo.new(0.132), {Transparency = 1}):Play()
	task.delay(0.198, function() gui:Destroy() end)
end)

MinBtn.MouseButton1Click:Connect(function()
	if uiOpen then closeUI() else openUI() end
end)

MiniGG.MouseButton1Click:Connect(function()
	openUI()
end)

-- =================================================================================================================
-- LOADING BAR FUNC - If you have seen this, know that GGHub loads in like 0.5s, but Just to make It more cooler and Professional i extended It a lil
-- =================================================================================================================
task.spawn(function()
	task.wait(2.4)

	_G.HideGGHubLoading()

	task.wait(0.308)
	MainFrame.Visible = true
	mStroke.Transparency = 1
	UIScale_Main.Scale = 0.88
	TweenService:Create(MainFrame, TweenInfo.new(0.231, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		GroupTransparency = 0
	}):Play()
	TweenService:Create(UIScale_Main, TweenInfo.new(0.231, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Scale = 1
	}):Play()
	TweenService:Create(mStroke, TweenInfo.new(0.231), {Transparency = 0}):Play()

	print("GGHub Fully Loaded")
end)
