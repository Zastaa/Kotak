```lua
-- Mendapatkan layanan yang dibutuhkan
local CoreGui = game:GetService("CoreGui")

-- Membuat ScreenGui sebagai kontainer utama
local SimpleSpy2 = Instance.new("ScreenGui")
SimpleSpy2.Name = "SimpleSpy2"
SimpleSpy2.ResetOnSpawn = false
SimpleSpy2.Parent = CoreGui

-- Membuat Frame utama (Background)
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = SimpleSpy2
Background.BackgroundColor3 = Color3.new(1, 1, 1)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0, 500, 0, 200)
Background.Size = UDim2.new(0, 450, 0, 268)

-- Membuat TopBar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = Background
TopBar.BackgroundColor3 = Color3.fromRGB(37, 35, 38)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 450, 0, 19)

-- Membuat tombol SimpleSpy di TopBar
local Simple = Instance.new("TextButton")
Simple.Name = "Simple"
Simple.Parent = TopBar
Simple.BackgroundTransparency = 1
Simple.Position = UDim2.new(0, 5, 0, 0)
Simple.Size = UDim2.new(0, 57, 0, 18)
Simple.Font = Enum.Font.SourceSansBold
Simple.Text = "SimpleSpy"
Simple.TextColor3 = Color3.new(1, 1, 1)
Simple.TextSize = 14
Simple.TextXAlignment = Enum.TextXAlignment.Left

-- Membuat tombol Close
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -19, 0, 0)
CloseButton.Size = UDim2.new(0, 19, 0, 19)
CloseButton.Text = ""

-- Menambahkan ikon untuk tombol Close
local CloseIcon = Instance.new("ImageLabel")
CloseIcon.Parent = CloseButton
CloseIcon.BackgroundTransparency = 1
CloseIcon.Position = UDim2.new(0, 5, 0, 5)
CloseIcon.Size = UDim2.new(0, 9, 0, 9)
CloseIcon.Image = "http://www.roblox.com/asset/?id=5597086202"

-- Membuat tombol Maximize
local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Position = UDim2.new(1, -38, 0, 0)
MaximizeButton.Size = UDim2.new(0, 19, 0, 19)
MaximizeButton.Text = ""

-- Menambahkan ikon untuk tombol Maximize
local MaximizeIcon = Instance.new("ImageLabel")
MaximizeIcon.Parent = MaximizeButton
MaximizeIcon.BackgroundTransparency = 1
MaximizeIcon.Position = UDim2.new(0, 5, 0, 5)
MaximizeIcon.Size = UDim2.new(0, 9, 0, 9)
MaximizeIcon.Image = "http://www.roblox.com/asset/?id=5597108117"

-- Membuat tombol Minimize
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -57, 0, 0)
MinimizeButton.Size = UDim2.new(0, 19, 0, 19)
MinimizeButton.Text = ""

-- Menambahkan ikon untuk tombol Minimize
local MinimizeIcon = Instance.new("ImageLabel")
MinimizeIcon.Parent = MinimizeButton
MinimizeIcon.BackgroundTransparency = 1
MinimizeIcon.Position = UDim2.new(0, 5, 0, 5)
MinimizeIcon.Size = UDim2.new(0, 9, 0, 9)
MinimizeIcon.Image = "http://www.roblox.com/asset/?id=5597105827"

-- Membuat LeftPanel untuk log
local LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = Background
LeftPanel.BackgroundColor3 = Color3.fromRGB(53, 52, 55)
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 0, 0, 19)
LeftPanel.Size = UDim2.new(0, 131, 0, 249)

-- Membuat ScrollingFrame untuk daftar log
local LogList = Instance.new("ScrollingFrame")
LogList.Name = "LogList"
LogList.Parent = LeftPanel
LogList.BackgroundTransparency = 1
LogList.BorderSizePixel = 0
LogList.Position = UDim2.new(0, 0, 0, 9)
LogList.Size = UDim2.new(0, 131, 0, 232)
LogList.CanvasSize = UDim2.new(0, 0, 0, 0)
LogList.ScrollBarThickness = 4

-- Membuat UIListLayout untuk LogList
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = LogList
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Membuat template untuk log
local RemoteTemplate = Instance.new("Frame")
RemoteTemplate.Name = "RemoteTemplate"
RemoteTemplate.BackgroundTransparency = 1
RemoteTemplate.Size = UDim2.new(0, 117, 0, 27)

local ColorBar = Instance.new("Frame")
ColorBar.Name = "ColorBar"
ColorBar.Parent = RemoteTemplate
ColorBar.BackgroundColor3 = Color3.fromRGB(255, 242, 0)
ColorBar.BorderSizePixel = 0
ColorBar.Position = UDim2.new(0, 0, 0, 1)
ColorBar.Size = UDim2.new(0, 7, 0, 18)
ColorBar.ZIndex = 2

local Text = Instance.new("TextLabel")
Text.Name = "Text"
Text.Parent = RemoteTemplate
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0, 12, 0, 1)
Text.Size = UDim2.new(0, 105, 0, 18)
Text.ZIndex = 2
Text.Font = Enum.Font.SourceSans
Text.Text = "RemoteEvent"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.TextWrapped = true

local Button = Instance.new("TextButton")
Button.Name = "Button"
Button.Parent = RemoteTemplate
Button.BackgroundColor3 = Color3.new(0, 0, 0)
Button.BackgroundTransparency = 0.75
Button.BorderColor3 = Color3.new(1, 1, 1)
Button.Position = UDim2.new(0, 0, 0, 1)
Button.Size = UDim2.new(0, 117, 0, 18)
Button.Text = ""

-- Menambahkan beberapa log dummy
for i = 1, 3 do
    local log = RemoteTemplate:Clone()
    log.Text.Text = "RemoteEvent" .. i
    log.Parent = LogList
end

-- Membuat RightPanel untuk codebox dan tombol
local RightPanel = Instance.new("Frame")
RightPanel.Name = "RightPanel"
RightPanel.Parent = Background
RightPanel.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 131, 0, 19)
RightPanel.Size = UDim2.new(0, 319, 0, 249)

-- Membuat CodeBox
local CodeBox = Instance.new("TextBox")
CodeBox.Name = "CodeBox"
CodeBox.Parent = RightPanel
CodeBox.BackgroundColor3 = Color3.fromRGB(21, 19, 20)
CodeBox.BorderSizePixel = 0
CodeBox.Size = UDim2.new(0, 319, 0, 119)
CodeBox.Font = Enum.Font.SourceSans
CodeBox.TextColor3 = Color3.new(1, 1, 1)
CodeBox.TextSize = 14
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.Text = "-- Contoh kode akan ditampilkan di sini"
CodeBox.ClearTextOnFocus = false

-- Membuat ScrollingFrame untuk tombol fungsi
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = RightPanel
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 0, 0.5, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.5, -9)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

-- Membuat UIGridLayout untuk tombol fungsi
local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.Parent = ScrollingFrame
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 94, 0, 27)

-- Membuat template untuk tombol fungsi
local FunctionTemplate = Instance.new("Frame")
FunctionTemplate.Name = "FunctionTemplate"
FunctionTemplate.BackgroundTransparency = 1
FunctionTemplate.Size = UDim2.new(0, 117, 0, 23)

local ColorBar2 = Instance.new("Frame")
ColorBar2.Name = "ColorBar"
ColorBar2.Parent = FunctionTemplate
ColorBar2.BackgroundColor3 = Color3.new(1, 1, 1)
ColorBar2.BorderSizePixel = 0
ColorBar2.Position = UDim2.new(0, 7, 0, 10)
ColorBar2.Size = UDim2.new(0, 7, 0, 18)
ColorBar2.ZIndex = 3

local Text2 = Instance.new("TextLabel")
Text2.Name = "Text"
Text2.Parent = FunctionTemplate
Text2.BackgroundTransparency = 1
Text2.Position = UDim2.new(0, 19, 0, 10)
Text2.Size = UDim2.new(0, 69, 0, 18)
Text2.ZIndex = 2
Text2.Font = Enum.Font.SourceSans
Text2.Text = "Button"
Text2.TextColor3 = Color3.new(1, 1, 1)
Text2.TextSize = 14
Text2.TextXAlignment = Enum.TextXAlignment.Left

local Button2 = Instance.new("TextButton")
Button2.Name = "Button"
Button2.Parent = FunctionTemplate
Button2.BackgroundColor3 = Color3.new(0, 0, 0)
Button2.BackgroundTransparency = 0.7
Button2.BorderColor3 = Color3.new(1, 1, 1)
Button2.Position = UDim2.new(0, 7, 0, 10)
Button2.Size = UDim2.new(0, 80, 0, 18)
Button2.Text = ""

-- Menambahkan beberapa tombol fungsi dummy
for _, name in ipairs({"Copy Code", "Run Code", "Clear Logs"}) do
    local button = FunctionTemplate:Clone()
    button.Text.Text = name
    button.Parent = ScrollingFrame
end

-- Membuat ToolTip
local ToolTip = Instance.new("Frame")
ToolTip.Name = "ToolTip"
ToolTip.Parent = SimpleSpy2
ToolTip.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
ToolTip.BackgroundTransparency = 0.1
ToolTip.BorderColor3 = Color3.new(1, 1, 1)
ToolTip.Size = UDim2.new(0, 200, 0, 50)
ToolTip.ZIndex = 3
ToolTip.Visible = false

local ToolTipText = Instance.new("TextLabel")
ToolTipText.Parent = ToolTip
ToolTipText.BackgroundTransparency = 1
ToolTipText.Position = UDim2.new(0, 2, 0, 2)
ToolTipText.Size = UDim2.new(0, 196, 0, 46)
ToolTipText.ZIndex = 3
ToolTipText.Font = Enum.Font.SourceSans
ToolTipText.Text = "Ini adalah deskripsi."
ToolTipText.TextColor3 = Color3.new(1, 1, 1)
ToolTipText.TextSize = 14
ToolTipText.TextWrapped = true
ToolTipText.TextXAlignment = Enum.TextXAlignment.Left
ToolTipText.TextYAlignment = Enum.TextYAlignment.Top
```