-- GUI Menu dengan fitur Minimize/Maximize yang berfungsi
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Membuat ScreenGui utama
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "MenuGui"
MainGui.ResetOnSpawn = false
MainGui.Parent = playerGui

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner untuk membuat sudut rounded
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- TopBar/Header
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Fix corner untuk bagian bawah TopBar
local TopBarFix = Instance.new("Frame")
TopBarFix.Parent = TopBar
TopBarFix.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBarFix.BorderSizePixel = 0
TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
TopBarFix.Size = UDim2.new(1, 0, 0.5, 0)

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Menu GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -90, 0.5, -8)
MinimizeButton.Size = UDim2.new(0, 16, 0, 16)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.TextSize = 12
MinimizeButton.Font = Enum.Font.SourceSansBold

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

-- Tombol Maximize/Restore
local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Position = UDim2.new(1, -65, 0.5, -8)
MaximizeButton.Size = UDim2.new(0, 16, 0, 16)
MaximizeButton.Text = "□"
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.TextSize = 10
MaximizeButton.Font = Enum.Font.SourceSansBold

local MaximizeCorner = Instance.new("UICorner")
MaximizeCorner.CornerRadius = UDim.new(1, 0)
MaximizeCorner.Parent = MaximizeButton

-- Tombol Close
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0.5, -8)
CloseButton.Size = UDim2.new(0, 16, 0, 16)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.SourceSansBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.Size = UDim2.new(1, 0, 1, -30)

-- ScrollingFrame untuk menu items
local MenuScroll = Instance.new("ScrollingFrame")
MenuScroll.Name = "MenuScroll"
MenuScroll.Parent = ContentFrame
MenuScroll.BackgroundTransparency = 1
MenuScroll.Position = UDim2.new(0, 10, 0, 10)
MenuScroll.Size = UDim2.new(1, -20, 1, -20)
MenuScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
MenuScroll.ScrollBarThickness = 6
MenuScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

-- UIListLayout untuk menu items
local MenuLayout = Instance.new("UIListLayout")
MenuLayout.Parent = MenuScroll
MenuLayout.Padding = UDim.new(0, 5)
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Function untuk membuat menu button
local function createMenuButton(text, description, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text
    Button.Parent = MenuScroll
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Font = Enum.Font.SourceSans
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = Button
    
    -- Hover effect
    Button.MouseEnter:Connect(function()
        local tween = TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)})
        tween:Play()
    end)
    
    Button.MouseLeave:Connect(function()
        local tween = TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
        tween:Play()
    end)
    
    -- Click event
    if callback then
        Button.MouseButton1Click:Connect(callback)
    end
    
    return Button
end

-- Menambahkan menu items
createMenuButton("Teleport", "Teleport ke lokasi tertentu", function()
    print("Teleport clicked!")
    -- Tambahkan fungsi teleport di sini
end)

createMenuButton("Speed Boost", "Meningkatkan kecepatan karakter", function()
    print("Speed Boost clicked!")
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed == 16 and 50 or 16
    end
end)

createMenuButton("Jump Power", "Mengubah kekuatan lompat", function()
    print("Jump Power clicked!")
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = character.Humanoid.JumpPower == 50 and 100 or 50
    end
end)

createMenuButton("Noclip", "Berjalan menembus dinding", function()
    print("Noclip clicked!")
    -- Tambahkan fungsi noclip di sini
end)

createMenuButton("Fly", "Terbang di udara", function()
    print("Fly clicked!")
    -- Tambahkan fungsi fly di sini
end)

createMenuButton("ESP", "Melihat pemain lain melalui dinding", function()
    print("ESP clicked!")
    -- Tambahkan fungsi ESP di sini
end)

-- Update canvas size
MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MenuScroll.CanvasSize = UDim2.new(0, 0, 0, MenuLayout.AbsoluteContentSize.Y)
end)

-- Variables untuk state
local isMinimized = false
local isMaximized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

-- Fungsi Minimize
local function minimizeWindow()
    isMinimized = not isMinimized
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isMinimized then
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 400, 0, 30)
        })
        tween:Play()
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        ContentFrame.Visible = true
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = isMaximized and UDim2.new(0.8, 0, 0.8, 0) or originalSize
        })
        tween:Play()
        MinimizeButton.Text = "—"
    end
end

-- Fungsi Maximize
local function maximizeWindow()
    if isMinimized then return end
    
    isMaximized = not isMaximized
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isMaximized then
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0.8, 0, 0.8, 0),
            Position = UDim2.new(0.1, 0, 0.1, 0)
        })
        tween:Play()
        MaximizeButton.Text = "❐"
        MainFrame.Draggable = false
    else
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = originalSize,
            Position = originalPosition
        })
        tween:Play()
        MaximizeButton.Text = "□"
        MainFrame.Draggable = true
    end
end

-- Fungsi Close
local function closeWindow()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(MainFrame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    tween:Play()
    
    tween.Completed:Connect(function()
        MainGui:Destroy()
    end)
end

-- Event connections
MinimizeButton.MouseButton1Click:Connect(minimizeWindow)
MaximizeButton.MouseButton1Click:Connect(maximizeWindow)
CloseButton.MouseButton1Click:Connect(closeWindow)

-- Hotkey untuk toggle minimize (F1)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        if MainGui.Parent then
            minimizeWindow()
        end
    end
end)

print("Menu GUI berhasil dimuat! Tekan F1 untuk minimize/restore.")
print("Gunakan tombol di TopBar untuk kontrol window.")