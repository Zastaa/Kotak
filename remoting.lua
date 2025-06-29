-- RemoteSpy Lite for Mobile (Floating, Filter, Toggleable, Mobile-Drag)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "MobileRemoteSpy"
gui.Parent = PlayerGui
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 260)
frame.Position = UDim2.new(0.5, -200, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = gui

-- Header
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 50)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.Text = "📡 RemoteSpy (Mobile)"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle button
local toggleBtn = Instance.new("TextButton", header)
toggleBtn.Size = UDim2.new(0, 50, 1, 0)
toggleBtn.Position = UDim2.new(1, -130, 0, 0)
toggleBtn.Text = "ON"
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 60)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 12

-- Minimize button
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 60, 1, 0)
minimizeBtn.Position = UDim2.new(1, -65, 0, 0)
minimizeBtn.Text = "Minimize"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.Gotham
minimizeBtn.TextSize = 12

-- Filter box
local filterBox = Instance.new("TextBox", frame)
filterBox.Size = UDim2.new(1, -10, 0, 24)
filterBox.Position = UDim2.new(0, 5, 0, 35)
filterBox.PlaceholderText = "Filter Remote Name..."
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
filterBox.TextColor3 = Color3.new(1, 1, 1)
filterBox.Font = Enum.Font.Code
filterBox.TextSize = 12

-- Log ScrollArea
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -65)
scroll.Position = UDim2.new(0, 5, 0, 65)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
scroll.ScrollBarThickness = 4
scroll.BorderSizePixel = 0
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

-- Dragging support (MOBILE)
local dragging, dragStart, startPos = false
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- State
local spying = false
local minimized = false
local logCount = 0
local maxLogs = 30

-- Toggle logic
toggleBtn.MouseButton1Click:Connect(function()
	spying = not spying
	toggleBtn.Text = spying and "ON" or "OFF"
	toggleBtn.BackgroundColor3 = spying and Color3.fromRGB(60, 130, 60) or Color3.fromRGB(130, 60, 60)
end)

-- Minimize logic
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	filterBox.Visible = not minimized
	scroll.Visible = not minimized
	frame.Size = minimized and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 260)
	minimizeBtn.Text = minimized and "Expand" or "Minimize"
end)

-- Remote Hook
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if spying and (method == "FireServer" or method == "InvokeServer") and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
		local name = self:GetFullName()
		local args = {...}
		local filter = string.lower(filterBox.Text)
		if filter == "" or string.find(string.lower(name), filter, 1, true) then
			-- Limit entries
			if logCount >= maxLogs then
				for _, v in ipairs(scroll:GetChildren()) do
					if v:IsA("TextLabel") then
						v:Destroy()
						logCount -= 1
						break
					end
				end
			end

			local log = Instance.new("TextLabel", scroll)
			log.Size = UDim2.new(1, -4, 0, 0)
			log.AutomaticSize = Enum.AutomaticSize.Y
			log.BackgroundTransparency = 1
			log.TextXAlignment = Enum.TextXAlignment.Left
			log.TextYAlignment = Enum.TextYAlignment.Top
			log.TextSize = 12
			log.Font = Enum.Font.Code
			log.TextWrapped = true
			log.TextColor3 = Color3.new(0.7, 1, 0.7)

			log.Text = "["..method.."] "..name
			for i, v in ipairs(args) do
				log.Text = log.Text.."\n["..i.."] = "..tostring(v)
			end

			logCount += 1
			task.defer(function()
				scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y + 100)
			end)
		end
	end
	return old(self, ...)
end)

setreadonly(mt, true)
