-- Ultra-Light RemoteSpy GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "RemoteSpyLite"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 440, 0, 260)
frame.Position = UDim2.new(0.5, -220, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Toggle
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.3, -5, 0, 22)
toggle.Position = UDim2.new(0, 5, 0, 5)
toggle.Text = "ON"
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 12
toggle.Font = Enum.Font.SourceSans

-- Filter
local filterBox = Instance.new("TextBox", frame)
filterBox.Size = UDim2.new(0.5, -5, 0, 22)
filterBox.Position = UDim2.new(0.3, 5, 0, 5)
filterBox.PlaceholderText = "Filter"
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
filterBox.TextColor3 = Color3.new(1, 1, 1)
filterBox.TextSize = 12
filterBox.Font = Enum.Font.SourceSans

-- Clear
local clear = Instance.new("TextButton", frame)
clear.Size = UDim2.new(0.2, -10, 0, 22)
clear.Position = UDim2.new(0.8, 5, 0, 5)
clear.Text = "Clear"
clear.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
clear.TextColor3 = Color3.new(1, 1, 1)
clear.TextSize = 12
clear.Font = Enum.Font.SourceSans

-- Scroll Log
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -35)
scroll.Position = UDim2.new(0, 5, 0, 30)
scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 4
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 2)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- State
local spying = true
local maxLogs = 30

toggle.MouseButton1Click:Connect(function()
	spying = not spying
	toggle.Text = spying and "ON" or "OFF"
end)

clear.MouseButton1Click:Connect(function()
	for _,v in ipairs(scroll:GetChildren()) do
		if v:IsA("TextLabel") then v:Destroy() end
	end
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
		local f = string.lower(filterBox.Text)
		if f == "" or string.find(string.lower(name), f, 1, true) then
			-- clean oldest if too many
			local logs = {}
			for _,v in ipairs(scroll:GetChildren()) do
				if v:IsA("TextLabel") then table.insert(logs, v) end
			end
			if #logs >= maxLogs then logs[1]:Destroy() end

			local label = Instance.new("TextLabel", scroll)
			label.Size = UDim2.new(1, -4, 0, 40)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Top
			label.TextSize = 12
			label.Font = Enum.Font.Code
			label.TextColor3 = Color3.new(0.7, 1, 0.7)
			label.Text = "["..method.."] "..name
			for i,v in ipairs(args) do
				label.Text = label.Text.."\n["..i.."] = "..tostring(v)
			end

			scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y)
		end
	end
	return old(self, ...)
end)

setreadonly(mt, true)
