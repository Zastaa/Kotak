-- Lightweight RemoteSpy GUI (Dark, Filter, Toggle, Ringan)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "RemoteSpyLite"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 460, 0, 280)
frame.Position = UDim2.new(0.5, -230, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- 🔘 Toggle
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.3, -5, 0, 25)
toggle.Position = UDim2.new(0, 5, 0, 5)
toggle.Text = "🟢 ON"
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.TextSize = 13
toggle.Font = Enum.Font.SourceSans

-- 🔍 Filter
local filterBox = Instance.new("TextBox", frame)
filterBox.Size = UDim2.new(0.5, -10, 0, 25)
filterBox.Position = UDim2.new(0.3, 5, 0, 5)
filterBox.PlaceholderText = "Filter..."
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
filterBox.TextColor3 = Color3.fromRGB(255, 255, 255)
filterBox.TextSize = 13
filterBox.Font = Enum.Font.SourceSans

-- 🧹 Clear
local clearBtn = Instance.new("TextButton", frame)
clearBtn.Size = UDim2.new(0.2, -5, 0, 25)
clearBtn.Position = UDim2.new(0.8, 5, 0, 5)
clearBtn.Text = "Clear"
clearBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.TextSize = 13
clearBtn.Font = Enum.Font.SourceSans

-- 🧾 Log
local log = Instance.new("TextLabel", frame)
log.Position = UDim2.new(0, 5, 0, 35)
log.Size = UDim2.new(1, -10, 1, -40)
log.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
log.TextColor3 = Color3.fromRGB(180, 255, 180)
log.TextXAlignment = Enum.TextXAlignment.Left
log.TextYAlignment = Enum.TextYAlignment.Top
log.Font = Enum.Font.Code
log.TextSize = 14
log.TextWrapped = true
log.Text = "[RemoteSpy Log]\n"
log.ClipsDescendants = true
log.TextYAlignment = Enum.TextYAlignment.Top
log.TextTruncate = Enum.TextTruncate.AtEnd

-- 🔁 State
local spying = true
local maxLines = 50

toggle.MouseButton1Click:Connect(function()
    spying = not spying
    toggle.Text = spying and "🟢 ON" or "🔴 OFF"
end)

clearBtn.MouseButton1Click:Connect(function()
    log.Text = "[RemoteSpy Log]\n"
end)

-- 📡 Spy logic
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if spying and (method == "FireServer" or method == "InvokeServer") and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
        local name = self:GetFullName()
        local filter = string.lower(filterBox.Text)
        if filter == "" or string.find(string.lower(name), filter, 1, true) then
            local args = {...}
            local text = "\n["..method.."] "..name
            for i,v in pairs(args) do
                text = text.."\n  ["..i.."] = "..tostring(v)
            end

            -- Keep only last 50 lines
            local split = string.split(log.Text, "\n")
            while #split > maxLines do table.remove(split, 2) end
            table.insert(split, text)
            log.Text = table.concat(split, "\n")
        end
    end
    return old(self, ...)
end)

setreadonly(mt, true)
