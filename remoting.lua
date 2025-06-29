-- RemoteSpy GUI: Elegan + Filter + Auto Scroll + Clear Log
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "RemoteSpyUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 540, 0, 360)
frame.Position = UDim2.new(0.5, -270, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- 🔘 Toggle Button
local toggleButton = Instance.new("TextButton", frame)
toggleButton.Text = "🟢 RemoteSpy ON"
toggleButton.Size = UDim2.new(0.35, -5, 0, 30)
toggleButton.Position = UDim2.new(0, 0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamSemibold
toggleButton.TextSize = 14

-- 🔍 Filter Box
local filterBox = Instance.new("TextBox", frame)
filterBox.PlaceholderText = "Filter remote name"
filterBox.Text = ""
filterBox.Size = UDim2.new(0.4, -5, 0, 30)
filterBox.Position = UDim2.new(0.35, 5, 0, 0)
filterBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
filterBox.TextColor3 = Color3.fromRGB(255, 255, 255)
filterBox.Font = Enum.Font.Gotham
filterBox.TextSize = 14

-- ❌ Clear Button
local clearButton = Instance.new("TextButton", frame)
clearButton.Text = "🧹 Clear Log"
clearButton.Size = UDim2.new(0.25, 0, 0, 30)
clearButton.Position = UDim2.new(0.75, 5, 0, 0)
clearButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.Font = Enum.Font.GothamSemibold
clearButton.TextSize = 14

-- 🧾 Log Frame
local logBox = Instance.new("ScrollingFrame", frame)
logBox.Size = UDim2.new(1, -20, 1, -40)
logBox.Position = UDim2.new(0, 10, 0, 40)
logBox.CanvasSize = UDim2.new(0, 0, 5, 0)
logBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
logBox.ScrollBarThickness = 6
logBox.BorderSizePixel = 0
logBox.AutomaticCanvasSize = Enum.AutomaticSize.Y
logBox.Name = "LogBox"

local layout = Instance.new("UIListLayout", logBox)
layout.Padding = UDim.new(0, 5)

-- 🔁 State
local spying = true
toggleButton.MouseButton1Click:Connect(function()
    spying = not spying
    toggleButton.Text = spying and "🟢 RemoteSpy ON" or "🔴 RemoteSpy OFF"
end)

-- 🧹 Clear Log
clearButton.MouseButton1Click:Connect(function()
    for _, child in pairs(logBox:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end)

-- 🧠 Remote Hooking
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if spying and (method == "FireServer" or method == "InvokeServer") and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
        local remoteName = self:GetFullName()
        local filter = string.lower(filterBox.Text)

        if filter == "" or string.find(string.lower(remoteName), filter, 1, true) then
            local args = {...}
            local msg = remoteName .. " [" .. method .. "]\nArgs:"
            for i, v in ipairs(args) do
                msg = msg .. "\n  [" .. i .. "] = " .. tostring(v)
            end

            local label = Instance.new("TextLabel")
            label.Text = msg
            label.Size = UDim2.new(1, -10, 0, 60)
            label.TextWrapped = true
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Top
            label.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            label.TextColor3 = Color3.fromRGB(200, 255, 200)
            label.Font = Enum.Font.Code
            label.TextSize = 14
            label.Parent = logBox

            task.wait(0.05)
            logBox.CanvasPosition = Vector2.new(0, logBox.CanvasSize.Y.Offset)
        end
    end
    return old(self, ...)
end)

setreadonly(mt, true)
