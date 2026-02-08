-- =====================================

--[[ GGHub is an open source script :D
       So have fun getting some functions 
       from here and using then on your own script
]]--

-- =====================================

_G.ScriptLoadstring = [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/klimplimRBX/GGHub/main/GGHubMoneyEvent.lua"))()
]]


-- ===== GGHub v0.8 =======

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

local DataFolder = "GGHub_Data"
local SettingsFile = DataFolder .. "/settings.json"

local function ensureFolder()
    if not isfolder(DataFolder) then
        makefolder(DataFolder)
    end
end

local function saveData(data)
    ensureFolder()
    local success, err = pcall(function()
        writefile(SettingsFile, game:GetService("HttpService"):JSONEncode(data))
    end)
    return success
end

local function loadData()
    if isfile(SettingsFile) then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(SettingsFile))
        end)
        if success then return result end
    end
    return {}
end

local function clearData()
    if isfile(SettingsFile) then
        delfile(SettingsFile)
    end
end

local savedData = loadData()

_G.StopRequested = false

local function createStopButton()
    local stopGui = Instance.new("ScreenGui")
    stopGui.Name = "GGHub_StopButton"
    stopGui.ResetOnSpawn = false
    stopGui.Parent = PlayerGui
    
    local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0, 80, 0, 35)
stopBtn.Position = UDim2.new(1, -90, 0, 10)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69) 
stopBtn.Text = "⏹ STOP"
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 16
stopBtn.BorderSizePixel = 0
stopBtn.Parent = stopGui
stopBtn.ZIndex = 1000

Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", stopBtn)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.Transparency = 0.5

stopBtn.MouseEnter:Connect(function()
    stopBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 55)
    stroke.Transparency = 0
end)

stopBtn.MouseLeave:Connect(function()
    stopBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    stroke.Transparency = 0.5
end)
    
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", stopBtn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    
    stopBtn.MouseButton1Click:Connect(function()
        _G.StopRequested = true
        
        local data = loadData()
        data.repeatMode = false
        data.autoExecute = false
        saveData(data)
        
        stopGui:Destroy()
        
        local _k = "K".."i".."c".."k"
        local p = game:GetService("Players").LocalPlayer
        p[_k](p, "Auto-farming stopped! Rejoin to use the script normally.")
    end)

    return stopGui
end

-- ===== AUTO EXECUTE LOGIC =====
if savedData.repeatMode and savedData.rejoinMode == "same" and savedData.jobId then
    if game.JobId ~= savedData.jobId then
        task.spawn(function()
            task.wait(2)
            local TeleportService = game:GetService("TeleportService")
            TeleportService:TeleportToPlaceInstance(game.PlaceId, savedData.jobId, LocalPlayer)
        end)
    end
end

if savedData.repeatMode then
    createStopButton()
    task.spawn(function()
        task.wait(3)
        
        local currentData = loadData()
        if not currentData.repeatMode then return end
        
        _G.AutoExecuteFarming = true
    end)
end


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

local COIN_NAME = "GoldBar"
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
AppTitle.Text = "GGHub v0.8 (outdated)"
AppTitle.Size = UDim2.new(0, 200, 0, 20)
AppTitle.Position = UDim2.new(0, 15, 0, 12)
AppTitle.Font = Enum.Font.GothamBold; AppTitle.TextSize = 18; AppTitle.TextColor3 = Colors.TextMain
AppTitle.TextXAlignment = Enum.TextXAlignment.Left; AppTitle.BackgroundTransparency = 1; AppTitle.Parent = Header

local AppSignature = Instance.new("TextLabel")
AppSignature.Text = "Made by KlimplimRBX - New features"
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
--     COIN FARM & AUTO SPIN LOGIC
-- ===================================================

local function getChar() return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart") end
local FLY_SPEED = 800
local lastCollected = nil

local function flyTo(hrp, targetPos)
    local distance = (targetPos - hrp.Position).Magnitude
    local direction = (targetPos - hrp.Position).Unit
    local velocity = direction * FLY_SPEED
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = velocity
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Parent = hrp
    
    local timeToReach = distance / FLY_SPEED
    task.wait(timeToReach)
    
    bodyVelocity:Destroy()
end

local function startFarm()
    if farming then return end
    farming = true
    
    if getChar() then
        makeImmortal(getChar())
    end
    
    task.spawn(function()
        while farming do
            local hrp = getHRP()
            local moneyParts = Workspace:FindFirstChild("MoneyEventParts")
            
            if hrp and moneyParts then
                local goldBarFolder = moneyParts:FindFirstChild("GoldBar")
                
                if goldBarFolder then
                    local bars = {}
                    
                    for _, obj in pairs(goldBarFolder:GetChildren()) do
                        if obj:IsA("BasePart") and obj.Parent then
                            local dist = (hrp.Position - obj.Position).Magnitude
                            table.insert(bars, {part = obj, dist = dist})
                        end
                    end
                    
                    table.sort(bars, function(a, b) return a.dist < b.dist end)
                    
                    local target = nil
                    if lastCollected and bars[1] and bars[1].part == lastCollected and bars[2] then
                        target = bars[2].part
                    elseif bars[1] then
                        target = bars[1].part
                    end
                    
                    if target then
                        flyTo(hrp, target.Position)
                        lastCollected = target
                    else
                        lastCollected = nil
                    end
                end
            end
            
            task.wait(0.267)
        end
    end)
end

local function stopFarm()
    farming = false
    lastCollected = nil
end

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

			local function ClearOtherBases()
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

createToggle(scriptPage, "Auto Farm Bars", "Teleports you to gold bars automatically (BETA TESTING - MAY NOT WORK)", function(state)
	if state then
		showNotification("Farming Started")
		startFarm()
	else
		showNotification("Farming Stopped")
		stopFarm()
	end
end)

createToggle(scriptPage, "Auto Spin", "SPAM SPINNNNSS", function(state)
    autoSpinEnabled = state
    if autoSpinEnabled then
        showNotification("SPAMMINGGGG")
        task.spawn(function()
            while autoSpinEnabled do
                if SpinRF then
                    -- fuck the wait start another one
                    task.spawn(function()
                        pcall(function()
                            SpinRF:InvokeServer()
                        end)
                    end)
                end
                task.wait(0.5) 
            end
        end)
    else
        showNotification("Auto spin stopped")
    end
end)


local spinNote = Instance.new("TextLabel")
spinNote.Name = "AutoSpinNote"
spinNote.Text = [[Some functions are on beta testing so they might not work]]
spinNote.Size = UDim2.new(1, -20, 0, 10)
spinNote.BackgroundTransparency = 1
spinNote.TextColor3 = Colors.TextSub
spinNote.Font = Enum.Font.Gotham
spinNote.TextSize = 10
spinNote.TextWrapped = true
spinNote.TextXAlignment = Enum.TextXAlignment.Left
spinNote.TextYAlignment = Enum.TextYAlignment.Top
spinNote.Parent = scriptPage

do
	local finishObbyFrame = Instance.new("Frame")
	finishObbyFrame.Size = UDim2.new(1, -10, 0, 60)
	finishObbyFrame.BackgroundColor3 = Colors.ItemBG
	finishObbyFrame.Parent = scriptPage
	Instance.new("UICorner", finishObbyFrame).CornerRadius = UDim.new(0,12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = "Finish All Obbys"
	TTitle.Size = UDim2.new(1, -20, 0, 25)
	TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1
	TTitle.TextColor3 = Colors.TextMain
	TTitle.Font = Enum.Font.GothamBold
	TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left
	TTitle.Parent = finishObbyFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = "Auto-completes every obby with teleports instead of the old fly"
	TDesc.Size = UDim2.new(1, -20, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1
	TDesc.TextColor3 = Colors.TextSub
	TDesc.Font = Enum.Font.Gotham
	TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left
	TDesc.Parent = finishObbyFrame

	local executeBtn = Instance.new("TextButton")
	executeBtn.Text = "Execute"
	executeBtn.Font = Enum.Font.GothamBold
	executeBtn.TextSize = 14
	executeBtn.TextColor3 = Colors.TextMain
	executeBtn.Size = UDim2.new(0, 80, 0, 30)
	executeBtn.Position = UDim2.new(1, -95, 0, 15)
	executeBtn.BackgroundColor3 = Colors.Button
	executeBtn.BorderSizePixel = 0
	executeBtn.Parent = finishObbyFrame
	Instance.new("UICorner", executeBtn).CornerRadius = UDim.new(0, 6)

	executeBtn.MouseEnter:Connect(function() executeBtn.BackgroundColor3 = Colors.ButtonHover end)
	executeBtn.MouseLeave:Connect(function() executeBtn.BackgroundColor3 = Colors.Button end)

	local subOptionsFrame = Instance.new("Frame")
	subOptionsFrame.Size = UDim2.new(1, -20, 0, 40)
	subOptionsFrame.Position = UDim2.new(0, 10, 0, 65)
	subOptionsFrame.BackgroundTransparency = 1
	subOptionsFrame.Parent = finishObbyFrame
	subOptionsFrame.Visible = false

	local rejoinToggleFrame = Instance.new("Frame")
	rejoinToggleFrame.Size = UDim2.new(1, 0, 0, 40)
	rejoinToggleFrame.BackgroundColor3 = Colors.Background
	rejoinToggleFrame.Parent = subOptionsFrame
	Instance.new("UICorner", rejoinToggleFrame).CornerRadius = UDim.new(0, 8)

	local rejoinTitle = Instance.new("TextLabel")
	rejoinTitle.Text = "Auto Rejoin"
	rejoinTitle.Size = UDim2.new(1, -75, 0, 15)
	rejoinTitle.Position = UDim2.new(0, 10, 0, 5)
	rejoinTitle.BackgroundTransparency = 1
	rejoinTitle.TextColor3 = Colors.TextMain
	rejoinTitle.Font = Enum.Font.GothamBold
	rejoinTitle.TextSize = 13
	rejoinTitle.TextXAlignment = Enum.TextXAlignment.Left
	rejoinTitle.Parent = rejoinToggleFrame

	local rejoinDesc = Instance.new("TextLabel")
	rejoinDesc.Text = "Rejoins to get more rewards, see settings for server preference"
	rejoinDesc.Size = UDim2.new(1, -75, 0, 15)
	rejoinDesc.Position = UDim2.new(0, 10, 0, 20)
	rejoinDesc.BackgroundTransparency = 1
	rejoinDesc.TextColor3 = Colors.TextSub
	rejoinDesc.Font = Enum.Font.Gotham
	rejoinDesc.TextSize = 10
	rejoinDesc.TextXAlignment = Enum.TextXAlignment.Left
	rejoinDesc.Parent = rejoinToggleFrame

	local rejoinSwitch = Instance.new("TextButton")
	rejoinSwitch.Text = ""
	rejoinSwitch.Size = UDim2.new(0, 40, 0, 22)
	rejoinSwitch.Position = UDim2.new(1, -50, 0.5, -11)
	rejoinSwitch.BackgroundColor3 = Colors.ToggleOff
	rejoinSwitch.Parent = rejoinToggleFrame
	Instance.new("UICorner", rejoinSwitch).CornerRadius = UDim.new(1,0)

	local rejoinKnob = Instance.new("Frame")
	rejoinKnob.Size = UDim2.new(0, 18, 0, 18)
	rejoinKnob.Position = UDim2.new(0, 2, 0.5, -9)
	rejoinKnob.BackgroundColor3 = Color3.new(1,1,1)
	rejoinKnob.Parent = rejoinSwitch
	Instance.new("UICorner", rejoinKnob).CornerRadius = UDim.new(1,0)

	local autoRejoinEnabled = false
	rejoinSwitch.MouseButton1Click:Connect(function()
		autoRejoinEnabled = not autoRejoinEnabled
		TweenService:Create(rejoinSwitch, TweenInfo.new(0.15), {BackgroundColor3 = autoRejoinEnabled and Colors.ToggleOn or Colors.ToggleOff}):Play()
		TweenService:Create(rejoinKnob, TweenInfo.new(0.15), {Position = autoRejoinEnabled and UDim2.new(0, 20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
		showNotification(autoRejoinEnabled and "Auto Rejoin Enabled" or "Auto Rejoin Disabled")
	end)

	local expandBtn = Instance.new("TextButton")
	expandBtn.Text = "▼"
	expandBtn.Font = Enum.Font.Gotham
	expandBtn.TextSize = 12
	expandBtn.TextColor3 = Colors.TextSub
	expandBtn.Size = UDim2.new(0, 25, 0, 25)
	expandBtn.Position = UDim2.new(1, -120, 0, 17.5)
	expandBtn.BackgroundTransparency = 1
	expandBtn.Parent = finishObbyFrame

	local isExpanded = false
	expandBtn.MouseButton1Click:Connect(function()
		isExpanded = not isExpanded
		subOptionsFrame.Visible = isExpanded
		TweenService:Create(finishObbyFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, isExpanded and 115 or 60)}):Play()
		TweenService:Create(expandBtn, TweenInfo.new(0.2), {Rotation = isExpanded and 180 or 0}):Play()
	end)

	local function executeFarming()
		local player = game.Players.LocalPlayer
		local noclip = false
		local godMode = false
		local noclipConn
		local godLoop

		local function enableNoclip()
			noclip = true
			noclipConn = RunService.Stepped:Connect(function()
				if noclip and player.Character then
					for _, part in ipairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end
			end)
		end

		local function disableNoclip()
			noclip = false
			if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
			if player.Character then
				for _, part in ipairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
				end
			end
		end

		local function startGod()
			godMode = true
			godLoop = task.spawn(function()
				while godMode do
					task.wait(0.1)
					if player.Character then
						local hum = player.Character:FindFirstChild("Humanoid")
						if hum then
							hum.MaxHealth = 1e6
							hum.Health = 1e6
							hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
						end
					end
				end
			end)
		end

		local function resetCharacter()
			godMode = false
			if godLoop then task.cancel(godLoop); godLoop = nil end
			if player.Character then
				local hum = player.Character:FindFirstChild("Humanoid")
				if hum then
					hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
					hum.Health = 0
				end
			end
			player.CharacterAdded:Wait()
			task.wait(0.367)
		end

		local function getRoot()
			return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		end

		showNotification("Starting...")

		task.spawn(function()
			local schedule = {
				{pos = Vector3.new(397.4, -6.7, -135), duration = 0.75}, 
				{pos = Vector3.new(423, -6.6, -340), duration = 1.5},
				{pos = Vector3.new(1132, -0.7, 137), duration = 1},
				{pos = Vector3.new(1132, 8.7, 529), duration = 2.5},
				{pos = Vector3.new(2250, -5.7, -135.3), duration = 1},
				{pos = Vector3.new(2572, -6.5, -337.0), duration = 2.5}
			}

			enableNoclip()
			startGod()

			for _, step in ipairs(schedule) do
				local endTime = tick() + step.duration
				while tick() < endTime do
					local root = getRoot()
					if root then
						root.CFrame = CFrame.new(step.pos)
					end
					RunService.Heartbeat:Wait()
				end
			end

			disableNoclip()
			resetCharacter()

			showNotification("Finished Successfully")

			local currentData = loadData()
			if autoRejoinEnabled or currentData.repeatMode then
				if _G.StopRequested then return end
				
				task.wait(2)
				
				currentData.repeatMode = true
				saveData(currentData)
				
				showNotification("Rejoining...")
				task.wait(1)
				rejoinGame()
			end
		end)
	end

	executeBtn.MouseButton1Click:Connect(function()
		executeFarming()
	end)
	
	task.spawn(function()
		task.wait(3)
		if _G.AutoExecuteFarming then
			_G.AutoExecuteFarming = false
			executeFarming()
		end
	end)
end

-- ===================================================
--         🗺️ MAP PAGE CONTENT
-- ===================================================

createButton(mapPage, "Go to Celestial Area", "Teleports you to the celestial area through the map", function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local waypoints = {
		Vector3.new(152.5, 3.3, 137.0),
		Vector3.new(2607, -2.7, 137.0),
		Vector3.new(2607, -2.8, 6.9)
	}
	local speed = 200
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
		showNotification("Arrived at Celestial Area!")
	end)
end)

createButton(mapPage, "Go Back to Base", "Returns you to the base safely", function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local speed = 200
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
		showNotification("Complete (If you din't die in the process)")
	end)
end)

-- ===================================================
--       ⚙️ SETTINGS PAGE CONTENT
-- ===================================================

do
	local autoExecFrame = Instance.new("Frame")
	autoExecFrame.Size = UDim2.new(1, -10, 0, 60)
	autoExecFrame.BackgroundColor3 = Colors.ItemBG
	autoExecFrame.Parent = settingsPage
	Instance.new("UICorner", autoExecFrame).CornerRadius = UDim.new(0,12)

	local TTitle = Instance.new("TextLabel")
	TTitle.Text = "Auto Execute"
	TTitle.Size = UDim2.new(1, -75, 0, 25)
	TTitle.Position = UDim2.new(0, 15, 0, 10)
	TTitle.BackgroundTransparency = 1
	TTitle.TextColor3 = Colors.TextMain
	TTitle.Font = Enum.Font.GothamBold
	TTitle.TextSize = 16
	TTitle.TextXAlignment = Enum.TextXAlignment.Left
	TTitle.Parent = autoExecFrame

	local TDesc = Instance.new("TextLabel")
	TDesc.Text = "Auto execute the script on join (PS: There is a button on the right to stop It)"
	TDesc.Size = UDim2.new(1, -75, 0, 20)
	TDesc.Position = UDim2.new(0, 15, 0, 32)
	TDesc.BackgroundTransparency = 1
	TDesc.TextColor3 = Colors.TextSub
	TDesc.Font = Enum.Font.Gotham
	TDesc.TextSize = 12
	TDesc.TextXAlignment = Enum.TextXAlignment.Left
	TDesc.Parent = autoExecFrame

	local SwitchBase = Instance.new("TextButton")
	SwitchBase.Text = ""
	SwitchBase.Size = UDim2.new(0, 50, 0, 28)
	SwitchBase.Position = UDim2.new(1, -65, 0, 15)
	SwitchBase.BackgroundColor3 = Colors.ToggleOff
	SwitchBase.Parent = autoExecFrame
	Instance.new("UICorner", SwitchBase).CornerRadius = UDim.new(1,0)

	local Knob = Instance.new("Frame")
	Knob.Size = UDim2.new(0, 22, 0, 22)
	Knob.Position = UDim2.new(0, 3, 0.5, -11)
	Knob.BackgroundColor3 = Color3.new(1,1,1)
	Knob.Parent = SwitchBase
	Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

	local subOptionsFrame = Instance.new("Frame")
	subOptionsFrame.Size = UDim2.new(1, -20, 0, 30)
	subOptionsFrame.Position = UDim2.new(0, 10, 0, 65)
	subOptionsFrame.BackgroundTransparency = 1
	subOptionsFrame.Parent = autoExecFrame
	subOptionsFrame.Visible = false

	local rejoinSameBtn = Instance.new("TextButton")
	rejoinSameBtn.Text = "Rejoin Same Server"
	rejoinSameBtn.Font = Enum.Font.Gotham
	rejoinSameBtn.TextSize = 11
	rejoinSameBtn.TextColor3 = Colors.TextMain
	rejoinSameBtn.Size = UDim2.new(0.48, 0, 1, 0)
	rejoinSameBtn.Position = UDim2.new(0, 0, 0, 0)
	rejoinSameBtn.BackgroundColor3 = Colors.Button
	rejoinSameBtn.BorderSizePixel = 0
	rejoinSameBtn.Parent = subOptionsFrame
	Instance.new("UICorner", rejoinSameBtn).CornerRadius = UDim.new(0, 6)

	local rejoinDiffBtn = Instance.new("TextButton")
	rejoinDiffBtn.Text = "Rejoin Different Server"
	rejoinDiffBtn.Font = Enum.Font.Gotham
	rejoinDiffBtn.TextSize = 11
	rejoinDiffBtn.TextColor3 = Colors.TextMain
	rejoinDiffBtn.Size = UDim2.new(0.48, 0, 1, 0)
	rejoinDiffBtn.Position = UDim2.new(0.52, 0, 0, 0)
	rejoinDiffBtn.BackgroundColor3 = Colors.Button
	rejoinDiffBtn.BorderSizePixel = 0
	rejoinDiffBtn.Parent = subOptionsFrame
	Instance.new("UICorner", rejoinDiffBtn).CornerRadius = UDim.new(0, 6)

	rejoinSameBtn.MouseEnter:Connect(function() rejoinSameBtn.BackgroundColor3 = Colors.ButtonHover end)
	rejoinSameBtn.MouseLeave:Connect(function() rejoinSameBtn.BackgroundColor3 = Colors.Button end)
	rejoinDiffBtn.MouseEnter:Connect(function() rejoinDiffBtn.BackgroundColor3 = Colors.ButtonHover end)
	rejoinDiffBtn.MouseLeave:Connect(function() rejoinDiffBtn.BackgroundColor3 = Colors.Button end)

	local toggled = false
	SwitchBase.MouseButton1Click:Connect(function()
		toggled = not toggled
		TweenService:Create(SwitchBase, TweenInfo.new(0.15), {BackgroundColor3 = toggled and Colors.ToggleOn or Colors.ToggleOff}):Play()
		TweenService:Create(Knob, TweenInfo.new(0.15), {Position = toggled and UDim2.new(0, 25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)}):Play()
		
		local data = loadData()
		data.autoExecute = toggled
		saveData(data)
		
		subOptionsFrame.Visible = toggled
		TweenService:Create(autoExecFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, toggled and 105 or 60)}):Play()
		showNotification(toggled and "Auto Execute Enabled" or "Auto Execute Disabled")
	end)

    rejoinSameBtn.MouseButton1Click:Connect(function()
        local data = loadData()
        data.rejoinMode = "same"
        data.jobId = game.JobId
        saveData(data)
        savedData.rejoinMode = "same"
        
        rejoinSameBtn.BackgroundColor3 = Colors.ToggleOn
        rejoinDiffBtn.BackgroundColor3 = Colors.Button
        showNotification("Set to Rejoin Same Server")
    end)

    rejoinDiffBtn.MouseButton1Click:Connect(function()
        local data = loadData()
        data.rejoinMode = "different"
        data.jobId = nil
        saveData(data)
        savedData.rejoinMode = "different"
        
        rejoinSameBtn.BackgroundColor3 = Colors.Button
        rejoinDiffBtn.BackgroundColor3 = Colors.ToggleOn
        showNotification("Set to Rejoin Different Server")
    end)

	if savedData.autoExecute then
		toggled = true
		SwitchBase.BackgroundColor3 = Colors.ToggleOn
		Knob.Position = UDim2.new(0, 25, 0.5, -11)
		subOptionsFrame.Visible = true
		autoExecFrame.Size = UDim2.new(1, -10, 0, 105)
	end
end

createButton(settingsPage, "Reset All Settings", "Clears all data, stops all features, and resets character", function()
    local player = game:GetService("Players").LocalPlayer
    
    clearData()
    if SwitchBase and Knob then
        SwitchBase.BackgroundColor3 = Colors.ToggleOff
        Knob.Position = UDim2.new(0, 3, 0.5, -11)
        if subOptionsFrame then
            subOptionsFrame.Visible = false
        end
        if autoExecFrame then
            autoExecFrame.Size = UDim2.new(1, -10, 0, 60)
        end
    end
    
    if rejoinSameBtn then rejoinSameBtn.BackgroundColor3 = Colors.Button end
    if rejoinDiffBtn then rejoinDiffBtn.BackgroundColor3 = Colors.Button end
    
    if player.Character then
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            hum.MaxHealth = 100
            hum.Health = 100
        end
    end
    
    showNotification("Settings cleared")
    task.wait(3)
    showNotification("Rejoin to complete reset")
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
