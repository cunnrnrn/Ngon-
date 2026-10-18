local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("KienRPGHub") then
    CoreGui.KienRPGHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KienRPGHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function playClickSound()
    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://6042053636"
    sound.Volume = 0.6
    sound:Play()
    task.delay(1, function() sound:Destroy() end)
end

local function notify(text)
    playClickSound()
    local note = Instance.new("Frame", ScreenGui)
    note.Size = UDim2.new(0, 0, 0, 38)
    note.Position = UDim2.new(0.5, 0, 0, -50)
    note.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
    note.BackgroundTransparency = 0.15
    Instance.new("UICorner", note).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", note)
    stroke.Color = Color3.fromRGB(0, 240, 255)
    stroke.Thickness = 2

    local lbl = Instance.new("TextLabel", note)
    lbl.Size = UDim2.new(1, -20, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "👑 " .. text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(note, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 280, 0, 38),
        Position = UDim2.new(0.5, -140, 0, 15)
    }):Play()

    task.delay(2.2, function()
        local tw = TweenService:Create(note, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 38),
            Position = UDim2.new(0.5, 0, 0, -50)
        })
        tw:Play()
        tw.Completed:Connect(function() note:Destroy() end)
    end)
end

-- 1. NÚT TRƯỢT / BẤM MỞ MENU NGOÀI MÀN HÌNH (SLIDE BAR)
local SlideArea = Instance.new("TextButton", ScreenGui)
SlideArea.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
SlideArea.BackgroundTransparency = 0.2
SlideArea.Position = UDim2.new(0.005, 0, 0.005, 0)
SlideArea.Size = UDim2.new(0, 36, 0, 26)
SlideArea.Font = Enum.Font.GothamBold
SlideArea.Text = "≡"
SlideArea.TextColor3 = Color3.fromRGB(10, 10, 16)
SlideArea.TextSize = 18
SlideArea.AutoButtonColor = false
Instance.new("UICorner", SlideArea).CornerRadius = UDim.new(0, 8)
local slideStroke = Instance.new("UIStroke", SlideArea)
slideStroke.Color = Color3.fromRGB(255, 255, 255)
slideStroke.Transparency = 0.3

-- 2. NÚT SHIFT LOCK MOBILE
local ShiftLockButton = Instance.new("TextButton", ScreenGui)
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
ShiftLockButton.BackgroundTransparency = 0.2
ShiftLockButton.Position = UDim2.new(0.045, 0, 0.005, 0)
ShiftLockButton.Size = UDim2.new(0, 32, 0, 26)
ShiftLockButton.Font = Enum.Font.GothamBold
ShiftLockButton.Text = "🎯"
ShiftLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.TextSize = 13
ShiftLockButton.Visible = false
Instance.new("UICorner", ShiftLockButton).CornerRadius = UDim.new(0, 8)
local LockStroke = Instance.new("UIStroke", ShiftLockButton)
LockStroke.Color = Color3.fromRGB(255, 60, 60)
LockStroke.Thickness = 1.5

-- 3. KHUNG MENU CHÍNH PHONG CÁCH RPG FANTASY
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.Size = UDim2.new(0, 420, 0, 300)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 230, 255)
MainStroke.Thickness = 2.5

-- Hiệu ứng viền chạy RGB cho nút SlideBar
task.spawn(function()
    while true do
        for hue = 0, 1, 0.01 do
            local col = Color3.fromHSV(hue, 1, 1)
            SlideArea.BackgroundColor3 = col
            task.wait(0.08)
        end
    end
end)

local TitleFrame = Instance.new("Frame", MainFrame)
TitleFrame.Size = UDim2.new(1, 0, 0, 42)
TitleFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
TitleFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", TitleFrame).CornerRadius = UDim.new(0, 16)

local TitleLabel = Instance.new("TextLabel", TitleFrame)
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "❖ TRƯƠNG TRỌNG KIÊN - 9.4 NHUẬN PHÚ TÂN ❖"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 11
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleFrame)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- THANH TAB DỌC BÊN TRÁI
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.Size = UDim2.new(0, 110, 1, -60)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
Sidebar.BackgroundTransparency = 0.4
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 6)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Position = UDim2.new(0, 128, 0, 50)
ContentFrame.Size = UDim2.new(1, -138, 1, -60)
ContentFrame.BackgroundTransparency = 1

local tabs = {}
local currentTab = nil

local function switchTab(name)
    playClickSound()
    for tName, page in pairs(tabs) do
        page.Visible = (tName == name)
    end
end

local function createTab(name, icon)
    local tBtn = Instance.new("TextButton", Sidebar)
    tBtn.Size = UDim2.new(1, 0, 0, 38)
    tBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    tBtn.BackgroundTransparency = 0.5
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = icon .. " " .. name
    tBtn.TextColor3 = Color3.fromRGB(160, 175, 200)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
    
    local page = Instance.new("ScrollingFrame", ContentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 260)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pLayout.Padding = UDim.new(0, 6)
    
    tabs[name] = page
    tBtn.MouseButton1Click:Connect(function()
        for _, otherBtn in ipairs(Sidebar:GetChildren()) do
            if otherBtn:IsA("TextButton") then
                otherBtn.TextColor3 = Color3.fromRGB(160, 175, 200)
                otherBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
            end
        end
        tBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        tBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
        switchTab(name)
    end)
    
    if not currentTab then
        currentTab = name
        page.Visible = true
        tBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        tBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    end
    return page
end

local TabHome = createTab("Cài Đặt", "🏠")
local TabUtility = createTab("Tiện Ích", "⚡")
local TabAnims = createTab("Dáng Chạy", "🏃‍♂️")
local TabBoost = createTab("Tối Ưu", "🚀")
local TabInfo = createTab("Thông Tin", "ℹ️")

local ThemeLabel = Instance.new("TextLabel", TabHome)
ThemeLabel.Size = UDim2.new(1, 0, 0, 20)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Text = "💎 ĐỘ TRONG SUỐT GIAO DIỆN:"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.TextSize = 10
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left

local transLevels = {{"Trong 10%", 0.1}, {"Mặc Định", 0.15}, {"Mờ 50%", 0.5}, {"Đậm 80%", 0.8}}
for _, level in ipairs(transLevels) do
    local tBtn = Instance.new("TextButton", TabHome)
    tBtn.Size = UDim2.new(1, 0, 0, 32)
    tBtn.BackgroundColor3 = Color3.fromRGB(24, 30, 45)
    tBtn.BackgroundTransparency = 0.3
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = level[1]
    tBtn.TextColor3 = Color3.fromRGB(200, 210, 230)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
    tBtn.MouseButton1Click:Connect(function()
        MainFrame.BackgroundTransparency = level[2]
        notify("Đã đặt độ trong suốt: " .. level[1])
    end)
end

local function createButton(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(210, 220, 240)
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(45, 55, 80)
    stroke.Thickness = 1
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -6, 0, 35)}):Play()
        task.delay(0.1, function()
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 38)}):Play()
        end)
        
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(35, 50, 80)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            stroke.Color = Color3.fromRGB(0, 240, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
            btn.TextColor3 = Color3.fromRGB(210, 220, 240)
            stroke.Color = Color3.fromRGB(45, 55, 80)
        end
        callback(active)
    end)
end
local noclipConn = nil
createButton(TabUtility, "👻 Đi Xuyên Tường (Noclip)", function(state)
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
        notify("Đã bật: Đi Xuyên Tường")
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local char = LocalPlayer.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
        notify("Đã tắt: Đi Xuyên Tường")
    end
end)

local espActive = false
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "KienESPFolder"

local function addESPToPlayer(v)
    if v == LocalPlayer then return end
    if not v.Character then return end
    local root = v.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local bg = Instance.new("BillboardGui")
    bg.Name = v.Name
    bg.Parent = espFolder
    bg.Adornee = root
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(0, 150, 0, 40)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    
    local txt = Instance.new("TextLabel")
    txt.Parent = bg
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 11
    txt.TextColor3 = Color3.fromRGB(0, 255, 200)
    txt.TextStrokeTransparency = 0
    txt.Text = v.DisplayName
    
    task.spawn(function()
        while espActive and v.Character and root and root.Parent do
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((myChar.HumanoidRootPart.Position - root.Position).Magnitude)
                txt.Text = "🎯 " .. v.DisplayName .. "\n[" .. dist .. "m]"
            end
            task.wait(0.1)
        end
        bg:Destroy()
    end)
end

createButton(TabUtility, "👁️ Định Vị Người Chơi (ESP)", function(state)
    espActive = state
    espFolder:ClearAllChildren()
    if state then
        for _, v in ipairs(Players:GetPlayers()) do
            addESPToPlayer(v)
        end
        notify("Đã bật Định Vị chuẩn khoảng cách!")
    else
        notify("Đã tắt Định Vị!")
    end
end)

local shiftLockEnabled = false
local isLocked = false
local slConn = nil

createButton(TabUtility, "🔒 Khóa Màn Hình (Shift Lock)", function(state)
    shiftLockEnabled = state
    ShiftLockButton.Visible = state
    if state then
        slConn = RunService.RenderStepped:Connect(function()
            if isLocked then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    local camVector = Camera.CFrame.LookVector
                    local targetAngle = math.atan2(-camVector.X, -camVector.Z)
                    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, targetAngle, 0)
                end
            end
        end)
        notify("Đã bật Shift Lock (Bấm nút 🎯 màn hình)")
    else
        isLocked = false
        ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
        LockStroke.Color = Color3.fromRGB(255, 60, 60)
        if slConn then slConn:Disconnect(); slConn = nil end
        notify("Đã tắt Shift Lock")
    end
end)

ShiftLockButton.MouseButton1Click:Connect(function()
    if shiftLockEnabled then
        isLocked = not isLocked
        if isLocked then
            ShiftLockButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            LockStroke.Color = Color3.fromRGB(0, 255, 0)
        else
            ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
            LockStroke.Color = Color3.fromRGB(255, 60, 60)
        end
    end
end)

createButton(TabUtility, "⚡ Nhặt Đồ / Tương Tác Tức Thì", function(state)
    getgenv().FastInteract = state
    task.spawn(function()
        while getgenv().FastInteract do
            task.wait(0.3)
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    prompt.HoldDuration = 0
                end
            end
        end
    end)
    notify(state and "Đã bật: Nhặt đồ tức thì" or "Đã tắt: Nhặt đồ tức thì")
end)

local legFlyConn = nil
createButton(TabAnims, "🚀 Dáng Chạy Lơ Lửng (Fly V3)", function(state)
    if state then
        legFlyConn = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp then
                if humanoid.MoveDirection.Magnitude > 0 then
                    local animate = char:FindFirstChild("Animate")
                    if animate then animate.Enabled = false end
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.15, 0)
                else
                    local animate = char:FindFirstChild("Animate")
                    if animate then animate.Enabled = true end
                end
            end
        end)
        notify("Đã bật Fly V3: Kẹp chân lướt gió!")
    else
        if legFlyConn then legFlyConn:Disconnect(); legFlyConn = nil end
        local char = LocalPlayer.Character
        if char then
            local animate = char:FindFirstChild("Animate")
            if animate then animate.Enabled = true end
        end
        notify("Đã tắt dáng lơ lửng!")
    end
end)

createButton(TabBoost, "🚀 Chống Lag / Anti-Lag (Tăng FPS)", function(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
                v.Enabled = false
            end
        end
        notify("Đã bật Anti-Lag tối đa tăng FPS!")
    else
        Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        notify("Đã tắt Anti-Lag!")
    end
end)

local InfoBg = Instance.new("Frame", TabInfo)
InfoBg.Size = UDim2.new(1, 0, 1, 0)
InfoBg.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
InfoBg.BackgroundTransparency = 0.4
Instance.new("UICorner", InfoBg).CornerRadius = UDim.new(0, 10)

local InfoStroke = Instance.new("UIStroke", InfoBg)
InfoStroke.Color = Color3.fromRGB(255, 215, 0)
InfoStroke.Thickness = 1.5

local InfoText = Instance.new("TextLabel", InfoBg)
InfoText.Size = UDim2.new(1, -16, 1, -16)
InfoText.Position = UDim2.new(0, 8, 0, 8)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "👑 TÁC GIẢ VIP: Trương Trọng Kiên\n🏫 Lớp: 9.4 - THCS Nhuận Phú Tân\n\n✨ Menu RPG Fantasy Edition:\n- Bố cục Tab dọc phong cách game AAA\n- Nút trượt mở menu nhanh chóng ở góc màn hình\n- Tích hợp đầy đủ mọi tính năng độc quyền!"
InfoText.TextColor3 = Color3.fromRGB(240, 245, 255)
InfoText.TextSize = 10
InfoText.TextWrapped = true

-- HIỆU ỨNG BẬT/TẮT MENU QUA NÚT SLIDEBAR VÀ KÉO NGANG
local isMenuOpen = false
local function toggleMenu()
    playClickSound()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 420, 0, 300),
            Rotation = 0,
            Position = UDim2.new(0.5, -210, 0.5, -150)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Rotation = 180
        })
        tw:Play()
        tw.Completed:Connect(function() if not isMenuOpen then MainFrame.Visible = false end end)
    end
end

SlideArea.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(toggleMenu)

-- Hỗ trợ cử chỉ vuốt kéo sang phải để bật menu
local startX = 0
SlideArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        startX = input.Position.X
    end
end)
SlideArea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if input.Position.X - startX > 20 then
            if not isMenuOpen then toggleMenu() end
        end
    end
end)
