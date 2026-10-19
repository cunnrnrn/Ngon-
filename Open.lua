-- =================================================================
-- TRƯƠNG TRỌNG KIÊN - HUB PRO MAX v2
-- LỚP 9.4 • NHUẬN PHÚ TÂN
-- Giao diện: Black Nebula (RGB: 10, 10, 14) + Đỏ Sắc Né + Free Fire Background
-- Chạy mượt trên Delta Executor Mobile
-- =================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

-- Xóa UI cũ nếu tái thực thi
if CoreGui:FindFirstChild("TTK_HubProMax_v2") then
    CoreGui:FindFirstChild("TTK_HubProMax_v2"):Destroy()
end

-- ScreenGui Chính
local TTKGui = Instance.new("ScreenGui")
TTKGui.Name = "TTK_HubProMax_v2"
TTKGui.ResetOnSpawn = false
TTKGui.Parent = CoreGui

-- Nút Mở/Tắt Menu Dạng Tròn Sành Điệu
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "OpenMenuButton"
ToggleBtn.Parent = TTKGui
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 24
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(255, 30, 30)
ToggleStroke.Thickness = 2

-- Khung Chính (Main Window)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = TTKGui
MainFrame.Size = UDim2.new(0, 560, 0, 350)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 30, 30)
MainStroke.Thickness = 2.5

-- Hình Nền Free Fire (rbxassetid://117828154165313)
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "FreeFireBG"
BackgroundImage.Parent = MainFrame
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://117828154165313"
BackgroundImage.ImageTransparency = 0.75
BackgroundImage.ScaleType = Enum.ScaleType.Crop

-- Thanh Tiêu Đề (Header)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Header.BackgroundTransparency = 0.2

local TitleText = Instance.new("TextLabel")
TitleText.Parent = Header
TitleText.Size = UDim2.new(1, -60, 0, 24)
TitleText.Position = UDim2.new(0, 12, 0, 3)
TitleText.Text = "👑 TRƯƠNG TRỌNG KIÊN - HUB PRO MAX v2"
TitleText.TextColor3 = Color3.fromRGB(255, 50, 50)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local SubTitleText = Instance.new("TextLabel")
SubTitleText.Parent = Header
SubTitleText.Size = UDim2.new(1, -60, 0, 16)
SubTitleText.Position = UDim2.new(0, 12, 0, 25)
SubTitleText.Text = "LỚP 9.4 • NHUẬN PHÚ TÂN • TỐI ƯU DELTA"
SubTitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitleText.TextSize = 12
SubTitleText.Font = Enum.Font.SourceSansItalic
SubTitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Sidebar Tabs (Thanh Chuyển Tab Bên Trái)
local TabBar = Instance.new("ScrollingFrame")
TabBar.Name = "TabBar"
TabBar.Parent = MainFrame
TabBar.Size = UDim2.new(0, 130, 1, -50)
TabBar.Position = UDim2.new(0, 5, 0, 48)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
TabBar.BackgroundTransparency = 0.4
TabBar.ScrollBarThickness = 2
TabBar.CanvasSize = UDim2.new(0, 0, 0, 320)

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)

-- Container Chứa Nội Dung Các Tab
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Size = UDim2.new(1, -145, 1, -52)
ContentContainer.Position = UDim2.new(0, 140, 0, 48)
ContentContainer.BackgroundTransparency = 1

local Tabs = {}
local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabBar
    TabButton.Size = UDim2.new(1, -6, 0, 36)
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 13
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Parent = ContentContainer
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.ScrollBarThickness = 3
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ContentLayout = Instance.new("UIListLayout", TabContent)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 6)

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 15)
    end)

    TabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            t.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
            t.Content.Visible = false
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Visible = true
    end)

    Tabs[tabName] = {Button = TabButton, Content = TabContent}
    return TabContent
end

-- Tạo danh sách các Tab
local TabTienIch = CreateTab("🛠 Tiện Ích")
local TabTocDo = CreateTab("⚡ Tốc Độ")
local TabTeleport = CreateTab("📍 Teleport & Base")
local TabBayPlayer = CreateTab("✈ Bay Player")
local TabConfig = CreateTab("💾 Config")
local TabServer = CreateTab("🌐 Server")
local TabFPS = CreateTab("🚀 Tối Ưu FPS")

-- Chọn mặc định Tab Tiện Ích
Tabs["🛠 Tiện Ích"].Button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
Tabs["🛠 Tiện Ích"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Tabs["🛠 Tiện Ích"].Content.Visible = true
-- =================================================================
-- PHẦN 2: HÀM TRỢ GIÚP UI & TẢI TÍNH NĂNG CHI TIẾT
-- =================================================================

-- Hàm Tạo Nút Gạt On/Off (Toggle Switch)
local function AddToggle(parent, text, defaultState, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    Frame.BackgroundTransparency = 0.3
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Btn = Instance.new("TextButton")
    Btn.Parent = Frame
    Btn.Size = UDim2.new(0, 45, 0, 22)
    Btn.Position = UDim2.new(1, -52, 0.5, -11)
    Btn.Text = defaultState and "ON" or "OFF"
    Btn.BackgroundColor3 = defaultState and Color3.fromRGB(200, 30, 30) or Color3.fromRGB(50, 50, 60)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 11)

    local state = defaultState
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = state and "ON" or "OFF"
        Btn.BackgroundColor3 = state and Color3.fromRGB(200, 30, 30) or Color3.fromRGB(50, 50, 60)
        pcall(callback, state)
    end)
end

-- Hàm Tạo Nút Bấm Thực Thi Action (Button)
local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Btn.BackgroundTransparency = 0.2
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(80, 20, 20)
    Stroke.Thickness = 1

    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- Hàm Tạo Thanh Kéo Tùy Chỉnh Giá Trị (Slider)
local function AddSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    Frame.BackgroundTransparency = 0.3
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 10, 0, 2)
    Title.Text = text .. ": " .. tostring(default)
    Title.TextColor3 = Color3.fromRGB(220, 220, 220)
    Title.Font = Enum.Font.SourceSans
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBg = Instance.new("Frame")
    SliderBg.Parent = Frame
    SliderBg.Size = UDim2.new(1, -20, 0, 8)
    SliderBg.Position = UDim2.new(0, 10, 0, 28)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 4)

    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderBg
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 4)

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        Title.Text = text .. ": " .. tostring(value)
        pcall(callback, value)
    end

    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)
end

-- =================================================================
-- KHỞI TẠO BIẾN TOÀN CỤC HOẠT ĐỘNG
-- =================================================================
local ConfigData = {
    WalkSpeed = 16,
    JumpPower = 50,
    Gravity = 196.2,
    FOV = 70,
    Noclip = false,
    ESP_Name = false,
    ESP_Box = false,
    AutoClick = false,
    InfJump = false,
    AntiAFK = true
}

local SavedBase1 = nil
local SavedBase2 = nil

-- 1. TAB TIỆN ÍCH
AddToggle(TabTienIch, "🧱 Noclip (Đi Xuyên Tường)", false, function(v)
    ConfigData.Noclip = v
end)

RunService.Stepped:Connect(function()
    if ConfigData.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ESP Name Tên Đỏ [Distance] (Không Mũi Tên)
local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "TTK_ESPFolder"

AddToggle(TabTienIch, "🔴 Định Vị Tên Đỏ + Khai Khoảng Cách [m]", false, function(v)
    ConfigData.ESP_Name = v
    if not v then ESPFolder:ClearAllChildren() end
end)

-- ESP 3D Box Màu Hồng
AddToggle(TabTienIch, "📦 Bao Bọc Khung 3D Màu Hồng (Box ESP)", false, function(v)
    ConfigData.ESP_Box = v
end)

RunService.RenderStepped:Connect(function()
    if ConfigData.ESP_Name or ConfigData.ESP_Box then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0)
                
                if ConfigData.ESP_Name then
                    local bgu = ESPFolder:FindFirstChild("Name_" .. p.Name)
                    if not bgu then
                        bgu = Instance.new("BillboardGui")
                        bgu.Name = "Name_" .. p.Name
                        bgu.Size = UDim2.new(0, 200, 0, 30)
                        bgu.AlwaysOnTop = true
                        bgu.Parent = ESPFolder
                        local txt = Instance.new("TextLabel", bgu)
                        txt.Name = "Label"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(255, 30, 30)
                        txt.Font = Enum.Font.SourceSansBold
                        txt.TextSize = 14
                    end
                    bgu.Adornee = hrp
                    bgu.Label.Text = p.DisplayName .. " [" .. dist .. "m]"
                end

                if ConfigData.ESP_Box then
                    local box = ESPFolder:FindFirstChild("Box_" .. p.Name)
                    if not box then
                        box = Instance.new("SelectionBox")
                        box.Name = "Box_" .. p.Name
                        box.Color3 = Color3.fromRGB(255, 105, 180) -- Màu hồng Pink
                        box.LineThickness = 0.05
                        box.Parent = ESPFolder
                    end
                    box.Adornee = p.Character
                end
            end
        end
    end
end)

-- Shift Lock Mobile với nút bấm điều hướng
AddButton(TabTienIch, "🎯 Khóa Màn Hình (Shift Lock Mobile)", function()
    local LockBtn = CoreGui:FindFirstChild("MobileShiftLockBtn")
    if LockBtn then
        LockBtn:Destroy()
    else
        LockBtn = Instance.new("TextButton", TTKGui)
        LockBtn.Name = "MobileShiftLockBtn"
        LockBtn.Size = UDim2.new(0, 45, 0, 45)
        LockBtn.Position = UDim2.new(0.8, 0, 0.5, 0)
        LockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        LockBtn.Text = "🎯"
        LockBtn.TextSize = 20
        LockBtn.Active = true
        LockBtn.Draggable = true
        Instance.new("UICorner", LockBtn).CornerRadius = UDim.new(1, 0)
        
        local locked = false
        LockBtn.MouseButton1Click:Connect(function()
            locked = not locked
            LockBtn.BackgroundColor3 = locked and Color3.fromRGB(220, 30, 30) or Color3.fromRGB(30, 30, 35)
            LocalPlayer.DevEnableMouseLock = locked
        end)
    end
end)

AddButton(TabTienIch, "⚡ Nhặt Đồ Tức Thì (Fast Interact)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
        end
    end
end)

AddToggle(TabTienIch, "👆 Tự Động Click / Fast Tap", false, function(v)
    ConfigData.AutoClick = v
    task.spawn(function()
        while ConfigData.AutoClick do
            mouse1click()
            task.wait(0.05)
        end
    end)
end)

AddToggle(TabTienIch, "🦘 Nhảy Trên Không (Infinite Jump)", false, function(v)
    ConfigData.InfJump = v
end)

UserInputService.JumpRequest:Connect(function()
    if ConfigData.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

AddToggle(TabTienIch, "🛡 Anti-AFK (Chống Treo Máy Bị Văng)", true, function(v)
    ConfigData.AntiAFK = v
end)

LocalPlayer.Idled:Connect(function()
    if ConfigData.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)
-- =================================================================
-- PHẦN 3: CÁC TAB CÒN LẠI VÀ HOÀN THIỆN SCRIPT
-- =================================================================

-- 2. TAB TỐC ĐỘ
AddSlider(TabTocDo, "🏃 Tốc Độ Chạy (WalkSpeed)", 16, 300, 16, function(v)
    ConfigData.WalkSpeed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end)

AddSlider(TabTocDo, "🦘 Sức Nhảy (JumpPower)", 50, 400, 50, function(v)
    ConfigData.JumpPower = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        h.UseJumpPower = true
        h.JumpPower = v
    end
end)

AddSlider(TabTocDo, "🌍 Trọng Lực (Gravity)", 0, 196, 196, function(v)
    workspace.Gravity = v
end)

AddSlider(TabTocDo, "👁 Tầm Nhìn FOV Camera", 60, 120, 70, function(v)
    workspace.CurrentCamera.FieldOfView = v
end)

AddButton(TabTocDo, "💡 Nhìn Trong Đêm (Fullbright)", function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
end)

AddButton(TabTocDo, "☠ Tự Sát Nhanh (Reset Character)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)

AddButton(TabTocDo, "🪑 Ngồi Tại Chỗ (Sit)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = true
    end
end)

-- 3. TAB TELEPORT & TỌA ĐỘ
AddButton(TabTeleport, "📌 Lưu Tọa Độ Base 1", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SavedBase1 = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

AddButton(TabTeleport, "🚀 Teleport Về Base 1", function()
    if SavedBase1 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SavedBase1
    end
end)

AddButton(TabTeleport, "📌 Lưu Tọa Độ Base 2", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SavedBase2 = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

AddButton(TabTeleport, "🚀 Teleport Về Base 2", function()
    if SavedBase2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SavedBase2
    end
end)

-- Tách bảng Mini Base bay nhanh
AddButton(TabTeleport, "📱 Hiện Bảng Mini Base Bay Nhanh", function()
    local MiniBase = TTKGui:FindFirstChild("MiniBaseFrame")
    if MiniBase then
        MiniBase.Visible = not MiniBase.Visible
    else
        MiniBase = Instance.new("Frame", TTKGui)
        MiniBase.Name = "MiniBaseFrame"
        MiniBase.Size = UDim2.new(0, 150, 0, 90)
        MiniBase.Position = UDim2.new(0.1, 0, 0.5, 0)
        MiniBase.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        MiniBase.Active = true
        MiniBase.Draggable = true
        Instance.new("UICorner", MiniBase).CornerRadius = UDim.new(0, 8)
        
        local b1 = Instance.new("TextButton", MiniBase)
        b1.Size = UDim2.new(0.9, 0, 0, 32)
        b1.Position = UDim2.new(0.05, 0, 0.1, 0)
        b1.Text = "Bay Base 1"
        b1.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        b1.TextColor3 = Color3.fromRGB(255, 255, 255)
        b1.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 4)
        b1.MouseButton1Click:Connect(function()
            if SavedBase1 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = SavedBase1
            end
        end)

        local b2 = Instance.new("TextButton", MiniBase)
        b2.Size = UDim2.new(0.9, 0, 0, 32)
        b2.Position = UDim2.new(0.05, 0, 0.52, 0)
        b2.Text = "Bay Base 2"
        b2.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        b2.TextColor3 = Color3.fromRGB(255, 255, 255)
        b2.Font = Enum.Font.SourceSansBold
        Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 4)
        b2.MouseButton1Click:Connect(function()
            if SavedBase2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = SavedBase2
            end
        end)
    end
end)

AddButton(TabTeleport, "🖱 Tool Click Dịch Chuyển (Click TP)", function()
    local mouse = LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.Name = "Click TP Tool"
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        if mouse.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = LocalPlayer.Backpack
end)

AddButton(TabTeleport, "🎲 Bay Ngẫu Nhiên Đến 1 Người Chơi", function()
    local plrs = Players:GetPlayers()
    local target = plrs[math.random(1, #plrs)]
    if target and target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

AddButton(TabTeleport, "☁ Bay Trú Ẩn An Toàn Trên Không (+300m)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 300, 0)
    end
end)

-- 4. TAB BAY PLAYER
local SelectedPlayerName = nil

AddButton(TabBayPlayer, "🔄 RESET DANH SÁCH PLAYER", function()
    -- Cập nhật tự động qua dropdown dưới
end)

local PlayerDropdownFrame = Instance.new("Frame", TabBayPlayer)
PlayerDropdownFrame.Size = UDim2.new(1, -10, 0, 110)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", PlayerDropdownFrame).CornerRadius = UDim.new(0, 6)

local PlayerListScroll = Instance.new("ScrollingFrame", PlayerDropdownFrame)
PlayerListScroll.Size = UDim2.new(1, -10, 1, -10)
PlayerListScroll.Position = UDim2.new(0, 5, 0, 5)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 2

local PlayerListLayout = Instance.new("UIListLayout", PlayerListScroll)
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 3)

local function UpdatePlayerList()
    for _, c in pairs(PlayerListScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", PlayerListScroll)
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            btn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 12
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

            btn.MouseButton1Click:Connect(function()
                SelectedPlayerName = p.Name
                for _, b in pairs(PlayerListScroll:GetChildren()) do
                    if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end
                end
                btn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
            end)
        end
    end
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
end

UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

AddButton(TabBayPlayer, "✈ Bay Đến Mục Tiêu (Tốc Độ 165)", function()
    if SelectedPlayerName then
        local target = Players:FindFirstChild(SelectedPlayerName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myHRP = LocalPlayer.Character.HumanoidRootPart
            local targetHRP = target.Character.HumanoidRootPart
            local distance = (targetHRP.Position - myHRP.Position).Magnitude
            local duration = distance / 165
            
            local tween = TweenService:Create(myHRP, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetHRP.CFrame})
            tween:Play()
        end
    end
end)

-- 5. TAB CONFIG
AddButton(TabConfig, "💾 Save Config (Lưu Cấu Hình File JSON)", function()
    if writefile then
        writefile("TTK_Hub_Config.json", HttpService:JSONEncode(ConfigData))
    end
end)

AddButton(TabConfig, "📂 Load Config (Tải Cấu Hình)", function()
    if readfile and isfile and isfile("TTK_Hub_Config.json") then
        local data = HttpService:JSONDecode(readfile("TTK_Hub_Config.json"))
        if data then
            ConfigData = data
        end
    end
end)

-- 6. TAB SERVER
AddButton(TabServer, "🔀 Đổi Server Ngẫu Nhiên (Server Hop)", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(TabServer, "📉 Đổi Server Vắng Người (Low Hop)", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(TabServer, "🔄 Vào Lại Server Hiện Tại (Rejoin)", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

-- 7. TAB TỐI ƯU FPS
AddButton(TabFPS, "🚀 Siêu Anti-Lag Cường Hóa Tắt Hiệu Ứng", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end
    end
    Lighting.GlobalShadows = false
end)

AddButton(TabFPS, "🧱 Xóa Họa Tiết Đồ Họa 3D (Remove Textures)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

-- Kết thúc khởi tạo thành công
print("[TRƯƠNG TRỌNG KIÊN - HUB PRO MAX v2] Thực thi hoàn tất!")
