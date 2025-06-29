-- RemoteSpy GUI Light + Floating + Toggle + Minimize
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "RemoteSpyUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- 🪟 FRAME UTAMA
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true

-- 🧲 MINIMIZE BUTTON
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 60, 0, 20)
minimize.Position = UDim2.new(1, -65, 0, 5)
minimize.Text = "Minimize"
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 12
minimize.Font = Enum.Font.SourceSans

-- 🔘 TOGGLE SPY
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.3, -5, 0, 20)
toggle.Position = UDim2.new(0, 5, 0, 5)
toggle.Text = "Spy OFF"
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 12
toggle.Font = Enum.Font.SourceSans

-- 🔍 FILTER
local filterBox = Instance.new("TextBox", frame)
filterBox.Size = UDim2.new(0.4, -5, 0, 20)
filterBox.Position = UDim2.new(0.3, 5, 0, 5)
filterBox.PlaceholderText = "Filter"
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
filterBox.TextColor3 = Color3.new(1, 1, 1)
filterBox.TextSize = 12
filterBox.Font = Enum.Font.SourceSans

-- 🧹 CLEAR
local clear = Instance.new("TextButton", frame)
clear.Size = UDim2.new(0.2, -5, 0, 20)
clear.Position = UDim2.new(0.7, 5, 0, 5)
clear.Text = "Clear"
clear.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
clear.TextColor3 = Color3.new(1, 1, 1)
clear.TextSize = 12
clear.Font = Enum.Font.SourceSans

-- 🧾 SCROLLING LOG
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -30)
scroll.Position = UDim2.new(0, 5, 0, 30)
scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 4

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

-- 📦 STATE
local spying = false
local minimized = false
local maxLogs = 30

-- 🔁 FUNGSI
toggle.MouseButton1Click:Connect(function()
	spying = not spying
	toggle.Text = spying and "Spy ON" or "Spy OFF"
end)

clear.MouseButton1Click:Connect(function()
	for _, v in ipairs(scroll:GetChildren()) do
		if v:IsA("TextLabel") then v:Destroy() end
	end
end)

minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	frame.Size = minimized and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 250)
	minimize.Text = minimized and "Expand" or "Minimize"
	scroll.Visible = not minimized
end)

-- 🕵️‍♂️ REMOTE SPY HOOK
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
			local logs = {}
			for _,v in ipairs(scroll:GetChildren()) do
				if v:IsA("TextLabel") then table.insert(logs, v) end
			end
			if #logs >= maxLogs then logs[1]:Destroy() end

			local label = Instance.new("TextLabel", scroll)
			label.Size = UDim2.new(1, -4, 0, 35)
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
