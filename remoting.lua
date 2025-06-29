-- RemoteSpy Clean & Lightweight v2
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "RemoteSpyLiteV2"
gui.Parent = PlayerGui
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Frame utama
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Draggable = true
frame.Active = true

-- Header
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 25)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
header.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "RemoteSpy Lite"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle spying
local toggleBtn = Instance.new("TextButton", header)
toggleBtn.Size = UDim2.new(0, 50, 1, 0)
toggleBtn.Position = UDim2.new(1, -130, 0, 0)
toggleBtn.Text = "ON"
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 60)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 12

-- Minimize
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 60, 1, 0)
minimizeBtn.Position = UDim2.new(1, -65, 0, 0)
minimizeBtn.Text = "Minimize"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.Gotham
minimizeBtn.TextSize = 12

-- Filter
local filterBox = Instance.new("TextBox", frame)
filterBox.Size = UDim2.new(1, -10, 0, 22)
filterBox.Position = UDim2.new(0, 5, 0, 30)
filterBox.PlaceholderText = "Filter..."
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
filterBox.TextColor3 = Color3.new(1, 1, 1)
filterBox.Font = Enum.Font.Code
filterBox.TextSize = 12

-- Scroll log area
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -60)
scroll.Position = UDim2.new(0, 5, 0, 60)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
scroll.ScrollBarThickness = 4
scroll.BorderSizePixel = 0
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

-- State
local spying = false
local minimized = false
local logCount = 0
local maxLogs = 30

-- Toggle Spy
toggleBtn.MouseButton1Click:Connect(function()
	spying = not spying
	toggleBtn.Text = spying and "ON" or "OFF"
	toggleBtn.BackgroundColor3 = spying and Color3.fromRGB(60, 130, 60) or Color3.fromRGB(130, 60, 60)
end)

-- Minimize
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	scroll.Visible = not minimized
	filterBox.Visible = not minimized
	frame.Size = minimized and UDim2.new(0, 420, 0, 25) or UDim2.new(0, 420, 0, 260)
	minimizeBtn.Text = minimized and "Expand" or "Minimize"
end)

-- Spy Hook
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
			if logCount >= maxLogs then
				for _, v in ipairs(scroll:GetChildren()) do
					if v:IsA("TextLabel") then
						v:Destroy()
						logCount -= 1
						break
					end
				end
			end

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -4, 0, 0)
			label.AutomaticSize = Enum.AutomaticSize.Y
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Top
			label.TextSize = 12
			label.Font = Enum.Font.Code
			label.TextWrapped = true
			label.TextColor3 = Color3.new(0.7, 1, 0.7)

			label.Text = "["..method.."] "..name
			for i,v in ipairs(args) do
				label.Text = label.Text.."\n["..i.."] = "..tostring(v)
			end

			label.Parent = scroll
			logCount += 1

			task.defer(function()
				scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y + 100)
			end)
		end
	end
	return old(self, ...)
end)

setreadonly(mt, true)
