-- ==============================================================================
-- Trương Trọng Kiên Hub - Pro Max ESP Edition (Lớp 9.4 THCS Nhuận Phú Tân)
-- ==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
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

-- HỆ THỐNG THÔNG BÁO SIÊU GỌN (NOTIFY TOAST)
local function notify(text)
    local note = Instance.new("Frame", ScreenGui)
    note.Size = UDim2.new(0, 0, 0, 36)
    note.Position = UDim2.new(0.5, 0, 0, -50)
    note.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    note.BackgroundTransparency = 0.15
    Instance.new("UICorner", note).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", note)
    stroke.Color = Color3.fromRGB(160, 0, 255)
    stroke.Thickness = 1.5

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
        Size = UDim2.new(0, 270, 0, 36),
        Position = UDim2.new(0.5, -135, 0, 15)
    }):Play()

    task.delay(2.2, function()
        local tw = TweenService:Create(note, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 36),
            Position = UDim2.new(0.5, 0, 0, -50)
        })
        tw:Play()
        tw.Completed:Connect(function() note:Destroy() end)
    end)
end

-- 1. NÚT KÉO NGANG (SLIDE BAR) SÁT MÉP TRÊN
local SlideArea = Instance.new("TextButton", ScreenGui)
SlideArea.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
SlideArea.BackgroundTransparency = 0.2
SlideArea.Position = UDim2.new(0.005, 0, 0.005, 0)
SlideArea.Size = UDim2.new(0, 32, 0, 24)
SlideArea.Font = Enum.Font.GothamBold
SlideArea.Text = "≡"
SlideArea.TextColor3 = Color3.fromRGB(255, 255, 255)
SlideArea.TextSize = 16
SlideArea.AutoButtonColor = false
Instance.new("UICorner", SlideArea).CornerRadius = UDim.new(0, 6)

-- 2. NÚT KHÓA MÀN HÌNH (SHIFT LOCK)
local ShiftLockButton = Instance.new("TextButton", ScreenGui)
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
ShiftLockButton.BackgroundTransparency = 0.3
ShiftLockButton.Position = UDim2.new(0.038, 0, 0.005, 0)
ShiftLockButton.Size = UDim2.new(0, 30, 0, 24)
ShiftLockButton.Font = Enum.Font.GothamBold
ShiftLockButton.Text = "🎯"
ShiftLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.TextSize = 13
ShiftLockButton.Visible = false
Instance.new("UICorner", ShiftLockButton).CornerRadius = UDim.new(0, 6)
local LockStroke = Instance.new("UIStroke", ShiftLockButton)
LockStroke.Color = Color3.fromRGB(255, 60, 60)
LockStroke.Thickness = 1.5

-- 3. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
MainFrame.BackgroundTransparency = 0.18
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -135)
MainFrame.Size = UDim2.new(0, 360, 0, 270)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(160, 0, 255)
MainStroke.Thickness = 2

-- TIÊU ĐỀ
local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, -80, 0, 40)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "👑 Kiên 9.4 Nhuận Phú Tân Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 12
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- NÚT THU GỌN VÀ ĐÓNG
local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Position = UDim2.new(1, -68, 0, 8)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
MinimizeBtn.BackgroundTransparency = 0.3
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- THANH TAB
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Position = UDim2.new(0, 12, 0, 42)
TabBar.Size = UDim2.new(1, -24, 0, 32)
TabBar.BackgroundTransparency = 1

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Position = UDim2.new(0, 12, 0, 80)
ContentFrame.Size = UDim2.new(1, -24, 1, -88)
ContentFrame.BackgroundTransparency = 1

local tabs = {}
local currentTab = nil

local function switchTab(name)
    for tName, page in pairs(tabs) do
        page.Visible = (tName == name)
    end
end

local function createTab(name)
    local tBtn = Instance.new("TextButton", TabBar)
    tBtn.Size = UDim2.new(0.23, 0, 1, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    tBtn.BackgroundTransparency = 0.4
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = name
    tBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 6)
    
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

-- TAB 1: CÀI ĐẶT
local ThemeLabel = Instance.new("TextLabel", TabHome)
ThemeLabel.Size = UDim2.new(1, 0, 0, 20)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Text = "🎨 Chọn Chủ Đề Màu:"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.TextSize = 11
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left

local ColorContainer = Instance.new("Frame", TabHome)
ColorContainer.Size = UDim2.new(1, 0, 0, 32)
ColorContainer.BackgroundTransparency = 1
local ColorList = Instance.new("UIListLayout", ColorContainer)
ColorList.FillDirection = Enum.FillDirection.Horizontal
ColorList.SortOrder = Enum.SortOrder.LayoutOrder
ColorList.Padding = UDim.new(0, 5)

local colors = {
    {Color3.fromRGB(160, 0, 255)}, {Color3.fromRGB(255, 50, 50)},
    {Color3.fromRGB(0, 150, 255)}, {Color3.fromRGB(0, 230, 100)},
    {Color3.fromRGB(255, 105, 180)}, {Color3.fromRGB(255, 140, 0)}, {Color3.fromRGB(255, 215, 0)}
}

for _, col in ipairs(colors) do
    local cBtn = Instance.new("TextButton", ColorContainer)
    cBtn.Size = UDim2.new(0, 38, 0, 28)
    cBtn.BackgroundColor3 = col[1]
    cBtn.Text = ""
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
    cBtn.MouseButton1Click:Connect(function()
        MainStroke.Color = col[1]
        SlideArea.BackgroundColor3 = col[1]
        notify("Đã chuyển màu giao diện!")
    end)
end

-- HÀM TẠO NÚT BẤM CHUẨN ĐẸP
local function createButton(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(210, 210, 220)
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(45, 45, 65)
    stroke.Thickness = 1
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -6, 0, 35)}):Play()
        task.delay(0.1, function()
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 38)}):Play()
        end)
        
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            stroke.Color = Color3.fromRGB(160, 0, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            btn.TextColor3 = Color3.fromRGB(210, 210, 220)
            stroke.Color = Color3.fromRGB(45, 45, 65)
        end
        callback(active)
    end)
end

-- TAB 2: TIỆN ÍCH (XUYÊN TƯỜNG, SHIFT LOCK, NHẶT ĐỒ, ĐỊNH VỊ ESP)

-- 1. Đi Xuyên Tường
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

-- 2. ĐỊNH VỊ NGƯỜI CHƠI (ESP PLAYER TRACKER - BẤT TỬ KHI CHẾT)
local espActive = false
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "KienESPFolder"

local function applyESP(player)
    if player == LocalPlayer then return end
    
    local function createHighlight(char)
        if not char then return end
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if not root then return end
        
        -- Xóa khung cũ nếu bị đúp
        if espFolder:FindFirstChild(player.Name) then
            espFolder[player.Name]:Destroy()
        end
        
        local bg = Instance.new("BillboardGui", espFolder)
        bg.Name = player.Name
        bg.AlwaysOnTop = true
        bg.Size = UDim2.new(0, 100, 0, 40)
        bg.Adornee = root
        
        local txt = Instance.new("TextLabel", bg)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.GothamBold
        txt.TextColor3 = Color3.fromRGB(0, 255, 200)
        txt.TextSize = 11
        txt.TextStrokeTransparency = 0
        
        -- Cập nhật khoảng cách & tự nhận diện khi hồi sinh/chết
        task.spawn(function()
            while espActive and char and char:Parent() and root and root:Parent() do
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    local dist = math.floor((myChar.HumanoidRootPart.Position - root.Position).Magnitude)
                    txt.Text = "👤 " .. player.Name .. "\n[" .. dist .. "m]"
                end
                task.wait(0.1)
            end
            bg:Destroy()
        end)
    end
    
    -- Tự động định vị lại kể cả khi người chơi đó chết rồi hồi sinh
    player.CharacterAdded:Connect(function(newChar)
        if espActive then createHighlight(newChar) end
    end)
    if player.Character then createHighlight(player.Character) end
end

createButton(TabUtility, "👁️ Định Vị Người Chơi (ESP Always)", function(state)
    espActive = state
    espFolder:ClearAllChildren()
    
    if state then
        for _, plr in ipairs(Players:GetPlayers()) do
            applyESP(plr)
        end
        Players.PlayerAdded:Connect(function(plr)
            if espActive then applyESP(plr) end
        end)
        notify("Đã bật: Định vị người chơi (Xuyên tường)!")
    else
        notify("Đã tắt: Định vị!")
    end
end)

-- 3. Khóa Màn Hình (Shift Lock Mobile)
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
        ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
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
            ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
            LockStroke.Color = Color3.fromRGB(255, 60, 60)
        end
    end
end)

-- 4. Nhặt Đồ Tức Thì
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

-- TAB 3: DÁNG CHẠY BAY LƠ LỬNG
local legFlyConn = nil
createButton(TabAnims, "🚀 Dáng Chạy Lơ Lửng (Kẹp Chân Bay)", function(state)
    if state then
        legFlyConn = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            
            if hrp and humanoid then
                if humanoid.MoveDirection.Magnitude > 0 then
                    local animate = char:FindFirstChild("Animate")
                    if animate then
                        local runAnim = animate:FindFirstChild("run")
                        if runAnim then runAnim:FindFirstChildOfClass("Animation").AnimationId = "" end
                    end
                    
                    local rightHip = char:FindFirstChild("Right Hip", true) or char:FindFirstChild("RightHip", true)
                    local leftHip = char:FindFirstChild("Left Hip", true) or char:FindFirstChild("LeftHip", true)
                    
                    if rightHip then rightHip.C0 = CFrame.new(0.5, -1, 0) * CFrame.Angles(0, 0, 0) end
                    if leftHip then leftHip.C0 = CFrame.new(-0.5, -1, 0) * CFrame.Angles(0, 0, 0) end
                    
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.2, 0)
                end
            end
        end)
        notify("Đã bật: Kẹp chân lơ lửng như bay!")
    else
        if legFlyConn then legFlyConn:Disconnect(); legFlyConn = nil end
        notify("Đã tắt dáng lơ lửng!")
    end
end)

-- TAB 4: TỐI ƯU (ANTI-LAG)
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
        notify("Đã bật Anti-Lag tăng FPS cực mượt!")
    else
        Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        notify("Đã tắt Anti-Lag!")
    end
end)

-- HIỆU ỨNG MỞ MENU
local isMenuOpen = false
local function toggleMenu()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, 270),
            Rotation = 0,
            Position = UDim2.new(0.5, -180, 0.5, -135)
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
