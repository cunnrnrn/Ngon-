local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("KienProHub") then
    CoreGui.KienProHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KienProHub"
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
    note.Size = UDim2.new(0, 0, 0, 40)
    note.Position = UDim2.new(0.5, 0, 0, -50)
    note.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    note.BackgroundTransparency = 0.1
    Instance.new("UICorner", note).CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", note)
    stroke.Color = Color3.fromRGB(0, 240, 255)
    stroke.Thickness = 2

    local lbl = Instance.new("TextLabel", note)
    lbl.Size = UDim2.new(1, -20, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "👑 " .. text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(note, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 40),
        Position = UDim2.new(0.5, -150, 0, 15)
    }):Play()

    task.delay(2.5, function()
        local tw = TweenService:Create(note, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 40),
            Position = UDim2.new(0.5, 0, 0, -50)
        })
        tw:Play()
        tw.Completed:Connect(function() note:Destroy() end)
    end)
end

local SlideArea = Instance.new("TextButton", ScreenGui)
SlideArea.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
SlideArea.BackgroundTransparency = 0.15
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

local ShiftLockButton = Instance.new("TextButton", ScreenGui)
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ShiftLockButton.BackgroundTransparency = 0.25
ShiftLockButton.Position = UDim2.new(0.042, 0, 0.005, 0)
ShiftLockButton.Size = UDim2.new(0, 34, 0, 26)
ShiftLockButton.Font = Enum.Font.GothamBold
ShiftLockButton.Text = "🎯"
ShiftLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.TextSize = 14
ShiftLockButton.Visible = false
Instance.new("UICorner", ShiftLockButton).CornerRadius = UDim.new(0, 8)
local LockStroke = Instance.new("UIStroke", ShiftLockButton)
LockStroke.Color = Color3.fromRGB(255, 60, 60)
LockStroke.Thickness = 1.5

-- KHUNG MENU ĐƯỢC PHÓNG TO RỘNG RÃI & SANG TRỌNG (440 x 330)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -165)
MainFrame.Size = UDim2.new(0, 440, 0, 330)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 240, 255)
MainStroke.Thickness = 3

-- HIỆU ỨNG VIỀN HOLOGRAPHIC CHUYỂN MÀU LIÊN TỤC CỰC KỲ ĐỈNH CAO
task.spawn(function()
    while true do
        for hue = 0, 1, 0.005 do
            local col = Color3.fromHSV(hue, 1, 1)
            MainStroke.Color = col
            SlideArea.BackgroundColor3 = col
            task.wait(0.05)
        end
    end
end)

local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, -90, 0, 48)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "👑 Trương Trọng Kiên | 9.4 Nhuận Phú Tân"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Position = UDim2.new(1, -74, 0, 10)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MinimizeBtn.BackgroundTransparency = 0.3
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Position = UDim2.new(1, -38, 0, 10)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 60)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Position = UDim2.new(0, 14, 0, 50)
TabBar.Size = UDim2.new(1, -28, 0, 36)
TabBar.BackgroundTransparency = 1

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Position = UDim2.new(0, 14, 0, 95)
ContentFrame.Size = UDim2.new(1, -28, 1, -105)
ContentFrame.BackgroundTransparency = 1

local tabs = {}
local currentTab = nil

local function switchTab(name)
    playClickSound()
    for tName, page in pairs(tabs) do
        page.Visible = (tName == name)
    end
end

local function createTab(name)
    local tBtn = Instance.new("TextButton", TabBar)
    tBtn.Size = UDim2.new(0.19, 0, 1, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tBtn.BackgroundTransparency = 0.4
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = name
    tBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
    
    local page = Instance.new("ScrollingFrame", ContentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 300)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pLayout.Padding = UDim.new(0, 8)
    
    tabs[name] = page
    tBtn.MouseButton1Click:Connect(function()
        for _, otherBtn in ipairs(TabBar:GetChildren()) do
            if otherBtn:IsA("TextButton") then
                otherBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
            end
        end
        tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        switchTab(name)
    end)
    
    if not currentTab then
        currentTab = name
        page.Visible = true
        tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    return page
end

local TabHome = createTab("🏠 Cài Đặt")
local TabUtility = createTab("⚡ Tiện Ích")
local TabAnims = createTab("🏃‍♂️ Dáng Chạy")
local TabBoost = createTab("🚀 Tối Ưu")
local TabInfo = createTab("ℹ️ Info")

local ThemeLabel = Instance.new("TextLabel", TabHome)
ThemeLabel.Size = UDim2.new(1, 0, 0, 22)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Text = "💎 ĐIỀU CHỈNH ĐỘ TRONG SUỐT KÍNH MỜ:"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.TextSize = 11
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left

local TransContainer = Instance.new("Frame", TabHome)
TransContainer.Size = UDim2.new(1, 0, 0, 36)
TransContainer.Position = UDim2.new(0, 0, 0, 28)
TransContainer.BackgroundTransparency = 1
local TransList = Instance.new("UIListLayout", TransContainer)
TransList.FillDirection = Enum.FillDirection.Horizontal
TransList.SortOrder = Enum.SortOrder.LayoutOrder
TransList.Padding = UDim.new(0, 8)

local transLevels = {{"Trong 10%", 0.1}, {"Mặc Định", 0.15}, {"Mờ 50%", 0.5}, {"Đậm 80%", 0.8}}
for _, level in ipairs(transLevels) do
    local tBtn = Instance.new("TextButton", TransContainer)
    tBtn.Size = UDim2.new(0, 90, 0, 32)
    tBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    tBtn.BackgroundTransparency = 0.3
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = level[1]
    tBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
    tBtn.MouseButton1Click:Connect(function()
        MainFrame.BackgroundTransparency = level[2]
        notify("Đã đặt độ trong suốt: " .. level[1])
    end)
end

local function createButton(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(210, 210, 220)
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(45, 45, 65)
    stroke.Thickness = 1
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Back), {Size = UDim2.new(1, -8, 0, 38)}):Play()
        task.delay(0.12, function()
            TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 0, 42)}):Play()
        end)
        
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            stroke.Color = Color3.fromRGB(0, 240, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
            btn.TextColor3 = Color3.fromRGB(210, 210, 220)
            stroke.Color = Color3.fromRGB(45, 45, 65)
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

-- HỆ THỐNG ĐỊNH VỊ ESP CHUẨN XÁC TÊN & KHOẢNG CÁCH
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
    bg.Size = UDim2.new(0, 160, 0, 50)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    
    local txt = Instance.new("TextLabel")
    txt.Parent = bg
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 12
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
createButton(TabUtility, "🔒 Khóa Màn Hình (Shift Lock Mobile)", function(state)
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
        notify("Đã bật Shift Lock (Bấm nút 🎯 ngoài màn hình)")
    else
        isLocked = false
        ShiftLockButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
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
            ShiftLockButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
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
        notify("Đã bật Fly V3: Kẹp chân lướt gió siêu ngầu!")
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
InfoBg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
InfoBg.BackgroundTransparency = 0.4
Instance.new("UICorner", InfoBg).CornerRadius = UDim.new(0, 12)

local InfoStroke = Instance.new("UIStroke", InfoBg)
InfoStroke.Color = Color3.fromRGB(255, 215, 0)
InfoStroke.Thickness = 2

task.spawn(function()
    while true do
        for hue = 0, 1, 0.01 do
            InfoStroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.1)
        end
    end
end)

local InfoText = Instance.new("TextLabel", InfoBg)
InfoText.Size = UDim2.new(1, -20, 1, -20)
InfoText.Position = UDim2.new(0, 10, 0, 10)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "👑 TÁC GIẢ VIP: Trương Trọng Kiên\n🏫 Lớp: 9.4 - THCS Nhuận Phú Tân\n\n✨ [Next-Gen Cyber Glass UI]:\n- Giao diện phóng to rộng rãi, thoáng đãng\n- Viền Hologram đổi màu RGB liên tục\n- Định vị ESP chuẩn xác tên & mét thực tế\n- Dáng chạy Fly V3 kẹp chân lướt gió đỉnh cao\n\n🔥 Chúc ông trải nghiệm siêu phẩm tuyệt đỉnh này!"
InfoText.TextColor3 = Color3.fromRGB(240, 240, 255)
InfoText.TextSize = 12
InfoText.TextWrapped = true
InfoText.TextXAlignment = Enum.TextXAlignment.Center

local isMenuOpen = false
local function toggleMenu()
    playClickSound()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 440, 0, 330),
            Rotation = 0,
            Position = UDim2.new(0.5, -220, 0.5, -165)
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
MinimizeBtn.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

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
