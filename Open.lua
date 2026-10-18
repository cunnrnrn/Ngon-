local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CUSTOM_IMAGE_ID = "rbxassetid://117828154165313"

if CoreGui:FindFirstChild("KienProVIPHub") then
    CoreGui.KienProVIPHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KienProVIPHub"
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
    note.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
    note.BackgroundTransparency = 0.15
    Instance.new("UICorner", note).CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", note)
    stroke.Color = Color3.fromRGB(0, 240, 255)
    stroke.Thickness = 2.5

    local lbl = Instance.new("TextLabel", note)
    lbl.Size = UDim2.new(1, -20, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "👑 " .. text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(note, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 310, 0, 40),
        Position = UDim2.new(0.5, -155, 0, 15)
    }):Play()

    task.delay(2.2, function()
        local tw = TweenService:Create(note, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 40),
            Position = UDim2.new(0.5, 0, 0, -50)
        })
        tw:Play()
        tw.Completed:Connect(function() note:Destroy() end)
    end)
end

local StopFlyButton = Instance.new("TextButton", ScreenGui)
StopFlyButton.Name = "StopFlyButton"
StopFlyButton.BackgroundColor3 = Color3.fromRGB(230, 30, 50)
StopFlyButton.Position = UDim2.new(0.92, 0, 0.02, 0)
StopFlyButton.Size = UDim2.new(0, 38, 0, 38)
StopFlyButton.Font = Enum.Font.GothamBold
StopFlyButton.Text = "✕"
StopFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopFlyButton.TextSize = 18
StopFlyButton.Visible = false
Instance.new("UICorner", StopFlyButton).CornerRadius = UDim.new(0, 12)
local stopStroke = Instance.new("UIStroke", StopFlyButton)
stopStroke.Color = Color3.fromRGB(255, 255, 255)
stopStroke.Thickness = 2

local SlideArea = Instance.new("ImageButton", ScreenGui)
SlideArea.Image = CUSTOM_IMAGE_ID
SlideArea.BackgroundTransparency = 0.1
SlideArea.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
SlideArea.Position = UDim2.new(0.005, 0, 0.005, 0)
SlideArea.Size = UDim2.new(0, 42, 0, 42)
SlideArea.AutoButtonColor = false
Instance.new("UICorner", SlideArea).CornerRadius = UDim.new(0, 12)
local slideStroke = Instance.new("UIStroke", SlideArea)
slideStroke.Color = Color3.fromRGB(0, 240, 255)
slideStroke.Thickness = 2

local ShiftLockButton = Instance.new("TextButton", ScreenGui)
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
ShiftLockButton.BackgroundTransparency = 0.2
ShiftLockButton.Position = UDim2.new(0.058, 0, 0.005, 0)
ShiftLockButton.Size = UDim2.new(0, 36, 0, 36)
ShiftLockButton.Font = Enum.Font.GothamBold
ShiftLockButton.Text = "🎯"
ShiftLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.TextSize = 16
ShiftLockButton.Visible = false
Instance.new("UICorner", ShiftLockButton).CornerRadius = UDim.new(0, 10)
local LockStroke = Instance.new("UIStroke", ShiftLockButton)
LockStroke.Color = Color3.fromRGB(255, 60, 60)
LockStroke.Thickness = 2

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
MainFrame.BackgroundTransparency = 0.15
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 440, 0, 320)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 22)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 240, 255)
MainStroke.Thickness = 2.5

local BgImage = Instance.new("ImageLabel", MainFrame)
BgImage.Image = CUSTOM_IMAGE_ID
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.ImageTransparency = 0.72
BgImage.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BgImage).CornerRadius = UDim.new(0, 22)

task.spawn(function()
    while true do
        for hue = 0, 1, 0.005 do
            local col = Color3.fromHSV(hue, 1, 1)
            MainStroke.Color = col
            slideStroke.Color = col
            task.wait(0.06)
        end
    end
end)

local TitleFrame = Instance.new("Frame", MainFrame)
TitleFrame.Size = UDim2.new(1, 0, 0, 42)
TitleFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
TitleFrame.BackgroundTransparency = 0.35
Instance.new("UICorner", TitleFrame).CornerRadius = UDim.new(0, 22)

local TitleLabel = Instance.new("TextLabel", TitleFrame)
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "👑 TRƯƠNG TRỌNG KIÊN - 9.4 NHUẬN PHÚ TÂN 👑"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 11
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleFrame)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 60)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local TabBarScroller = Instance.new("ScrollingFrame", MainFrame)
TabBarScroller.Position = UDim2.new(0, 12, 0, 48)
TabBarScroller.Size = UDim2.new(1, -24, 0, 36)
TabBarScroller.BackgroundTransparency = 1
TabBarScroller.CanvasSize = UDim2.new(0, 520, 0, 0)
TabBarScroller.ScrollBarThickness = 0
TabBarScroller.ScrollingDirection = Enum.ScrollingDirection.X

local TabBarLayout = Instance.new("UIListLayout", TabBarScroller)
TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabBarLayout.Padding = UDim.new(0, 6)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Position = UDim2.new(0, 12, 0, 90)
ContentFrame.Size = UDim2.new(1, -24, 1, -98)
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
    local tBtn = Instance.new("TextButton", TabBarScroller)
    tBtn.Size = UDim2.new(0, 82, 1, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 44)
    tBtn.BackgroundTransparency = 0.4
    tBtn.Font = Enum.Font.GothamBold
    tBtn.Text = icon .. " " .. name
    tBtn.TextColor3 = Color3.fromRGB(160, 175, 200)
    tBtn.TextSize = 10
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 10)
    
    local page = Instance.new("ScrollingFrame", ContentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pLayout.Padding = UDim.new(0, 6)
    
    tabs[name] = page
    tBtn.MouseButton1Click:Connect(function()
        for _, otherBtn in ipairs(TabBarScroller:GetChildren()) do
            if otherBtn:IsA("TextButton") then
                otherBtn.TextColor3 = Color3.fromRGB(160, 175, 200)
                otherBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 44)
            end
        end
        tBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        tBtn.BackgroundColor3 = Color3.fromRGB(35, 50, 80)
        switchTab(name)
    end)
    
    if not currentTab then
        currentTab = name
        page.Visible = true
        tBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        tBtn.BackgroundColor3 = Color3.fromRGB(35, 50, 80)
    end
    return page
end

local TabHome = createTab("Cài Đặt", "🏠")
local TabUtility = createTab("Tiện Ích", "⚡")
local TabPos = createTab("Lưu Vị Trí", "📍")
local TabTeleport = createTab("Bay Mượt", "🚀")
local TabAnims = createTab("Dáng Chạy", "🏃‍♂️")
local TabBoost = createTab("Tối Ưu FPS", "🚀")
local TabInfo = createTab("Info Kiên", "👑")

local ThemeLabel = Instance.new("TextLabel", TabHome)
ThemeLabel.Size = UDim2.new(1, 0, 0, 22)
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
    tBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
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
    btn.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
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
            btn.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
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

createButton(TabUtility, "🔒 Khóa Màn Hình (Shift Lock Mobile)", function(state)
    shiftLockEnabled = state
    ShiftLockButton.Visible = state
    if state then
        slConn = RunService.RenderStepped:Connect(function()
            if isLocked then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    local camLook = Camera.CFrame.LookVector
                    local yaw = math.atan2(-camLook.X, -camLook.Z)
                    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, yaw, 0)
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

local savedPos1 = nil
local savedPos2 = nil
local selectedPos = 1
local isFlying = false

local posTitle = Instance.new("TextLabel", TabPos)
posTitle.Size = UDim2.new(1, 0, 0, 22)
posTitle.BackgroundTransparency = 1
posTitle.Font = Enum.Font.GothamBold
posTitle.Text = "📍 HỆ THỐNG LƯU & BAY TỌA ĐỘ (2 BASE):"
posTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
posTitle.TextSize = 10
posTitle.TextXAlignment = Enum.TextXAlignment.Left

local btnSave1 = Instance.new("TextButton", TabPos)
btnSave1.Size = UDim2.new(1, 0, 0, 34)
btnSave1.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
btnSave1.Font = Enum.Font.GothamBold
btnSave1.Text = "💾 LƯU VỊ TRÍ 1 (Chưa lưu)"
btnSave1.TextColor3 = Color3.fromRGB(0, 240, 255)
btnSave1.TextSize = 10
Instance.new("UICorner", btnSave1).CornerRadius = UDim.new(0, 8)

local btnSave2 = Instance.new("TextButton", TabPos)
btnSave2.Size = UDim2.new(1, 0, 0, 34)
btnSave2.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
btnSave2.Font = Enum.Font.GothamBold
btnSave2.Text = "💾 LƯU VỊ TRÍ 2 (Chưa lưu)"
btnSave2.TextColor3 = Color3.fromRGB(0, 240, 255)
btnSave2.TextSize = 10
Instance.new("UICorner", btnSave2).CornerRadius = UDim.new(0, 8)

btnSave1.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPos1 = char.HumanoidRootPart.CFrame
        btnSave1.Text = "✅ ĐÃ LƯU VỊ TRÍ 1!"
        notify("Đã lưu tọa độ Vị Trí 1!")
    end
end)

btnSave2.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPos2 = char.HumanoidRootPart.CFrame
        btnSave2.Text = "✅ ĐÃ LƯU VỊ TRÍ 2!"
        notify("Đã lưu tọa độ Vị Trí 2!")
    end
end)

local btnSelectPos = Instance.new("TextButton", TabPos)
btnSelectPos.Size = UDim2.new(1, 0, 0, 34)
btnSelectPos.BackgroundColor3 = Color3.fromRGB(35, 45, 70)
btnSelectPos.Font = Enum.Font.GothamBold
btnSelectPos.Text = "🎯 ĐANG CHỌN: VỊ TRÍ 1"
btnSelectPos.TextColor3 = Color3.fromRGB(255, 255, 255)
btnSelectPos.TextSize = 10
Instance.new("UICorner", btnSelectPos).CornerRadius = UDim.new(0, 8)

btnSelectPos.MouseButton1Click:Connect(function()
    if selectedPos == 1 then
        selectedPos = 2
        btnSelectPos.Text = "🎯 ĐANG CHỌN: VỊ TRÍ 2"
        notify("Đã chuyển chọn Vị Trí 2")
    else
        selectedPos = 1
        btnSelectPos.Text = "🎯 ĐANG CHỌN: VỊ TRÍ 1"
        notify("Đã chuyển chọn Vị Trí 1")
    end
end)

local function flyToCFrame(targetCFrame)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local myHrp = char.HumanoidRootPart
        isFlying = true
        StopFlyButton.Visible = true
        notify("Đang bay mượt (Bấm nút ✕ góc trên để DỪNG)!")
        
        task.spawn(function()
            local speed = 165
            while isFlying and targetCFrame do
                local direction = (targetCFrame.Position - myHrp.Position)
                local distance = direction.Magnitude
                if distance < 5 or not isFlying then break end
                local step = math.min(distance, speed * 0.03)
                myHrp.CFrame = myHrp.CFrame + (direction.Unit * step)
                RunService.RenderStepped:Wait()
            end
            if isFlying then myHrp.CFrame = targetCFrame end
            isFlying = false
            StopFlyButton.Visible = false
            notify("Đã hoàn tất hành trình!")
        end)
    end
end

StopFlyButton.MouseButton1Click:Connect(function()
    isFlying = false
    StopFlyButton.Visible = false
    notify("🛑 ĐÃ DỪNG BAY TỨC THÌ!")
end)

local btnFlySaved = Instance.new("TextButton", TabPos)
btnFlySaved.Size = UDim2.new(1, 0, 0, 38)
btnFlySaved.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
btnFlySaved.Font = Enum.Font.GothamBold
btnFlySaved.Text = "🚀 BAY VỀ VỊ TRÍ ĐÃ CHỌN"
btnFlySaved.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFlySaved.TextSize = 11
Instance.new("UICorner", btnFlySaved).CornerRadius = UDim.new(0, 8)

btnFlySaved.MouseButton1Click:Connect(function()
    local target = (selectedPos == 1) and savedPos1 or savedPos2
    if target then flyToCFrame(target) else notify("Chưa lưu Vị Trí " .. selectedPos .. "!") end
end)

local selectedTarget = nil
local TpLabel = Instance.new("TextLabel", TabTeleport)
TpLabel.Size = UDim2.new(1, 0, 0, 22)
TpLabel.BackgroundTransparency = 1
TpLabel.Font = Enum.Font.GothamBold
TpLabel.Text = "🚀 CHỌN BẠN BÈ ĐỂ BAY ĐẾN (SPEED 165):"
TpLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TpLabel.TextSize = 10
TpLabel.TextXAlignment = Enum.TextXAlignment.Left

local PlayerListContainer = Instance.new("ScrollingFrame", TabTeleport)
PlayerListContainer.Size = UDim2.new(1, 0, 0, 150)
PlayerListContainer.BackgroundColor3 = Color3.fromRGB(14, 18, 28)
PlayerListContainer.BackgroundTransparency = 0.3
PlayerListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerListContainer.ScrollBarThickness = 2
Instance.new("UICorner", PlayerListContainer).CornerRadius = UDim.new(0, 8)

local PlrListLayout = Instance.new("UIListLayout", PlayerListContainer)
PlrListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlrListLayout.Padding = UDim.new(0, 4)

local function refreshPlayerList()
    for _, child in ipairs(PlayerListContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerListContainer)
            pBtn.Size = UDim2.new(1, -4, 0, 32)
            pBtn.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
            pBtn.BackgroundTransparency = 0.3
            pBtn.Font = Enum.Font.GothamBold
            pBtn.Text = "👤 " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
            pBtn.TextColor3 = Color3.fromRGB(210, 220, 240)
            pBtn.TextSize = 10
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
            
            pBtn.MouseButton1Click:Connect(function()
                selectedTarget = plr
                notify("Đã chọn mục tiêu: " .. plr.DisplayName)
            end)
        end
    end
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

local TpActionButton = Instance.new("TextButton", TabTeleport)
TpActionButton.Size = UDim2.new(1, 0, 0, 38)
TpActionButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TpActionButton.Font = Enum.Font.GothamBold
TpActionButton.Text = "🚀 BAY MƯỢT ĐẾN BẠN (SPEED 165)"
TpActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TpActionButton.TextSize = 11
Instance.new("UICorner", TpActionButton).CornerRadius = UDim.new(0, 8)

TpActionButton.MouseButton1Click:Connect(function()
    if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
        flyToCFrame(selectedTarget.Character.HumanoidRootPart.CFrame)
    else
        notify("Chưa chọn bạn hoặc bạn ấy chưa vào game!")
    end
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

createButton(TabBoost, "⚡ SIÊU ANTI-LAG CƯỜNG HÓA (MAX FPS 100%)", function(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
        notify("⚡ ĐÃ KÍCH HOẠT ANTI-LAG TỐI ĐA (MAX FPS)!")
    else
        Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        notify("Đã khôi phục cài đặt đồ họa ban đầu")
    end
end)

local InfoBg = Instance.new("Frame", TabInfo)
InfoBg.Size = UDim2.new(1, 0, 1, 0)
InfoBg.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
InfoBg.BackgroundTransparency = 0.3
Instance.new("UICorner", InfoBg).CornerRadius = UDim.new(0, 10)

local InfoStroke = Instance.new("UIStroke", InfoBg)
InfoStroke.Color = Color3.fromRGB(255, 215, 0)
InfoStroke.Thickness = 2

local InfoText = Instance.new("TextLabel", InfoBg)
InfoText.Size = UDim2.new(1, -16, 1, -16)
InfoText.Position = UDim2.new(0, 8, 0, 8)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "👑 TÁC GIẢ SỞ HỮU: Trương Trọng Kiên\n🏫 Lớp: 9.4 - Trường THCS Nhuận Phú Tân\n\n✨ [Bản Cập Nhật Siêu Cấp]:\n- Dấu ✕ góc phải dừng bay ngay lập tức\n- Thanh Tab ngang vuốt qua lại cực mượt\n- Thuật toán bay 165 tối ưu chống lag tuyệt đối"
InfoText.TextColor3 = Color3.fromRGB(240, 245, 255)
InfoText.TextSize = 10
InfoText.TextWrapped = true

local isMenuOpen = false
local function toggleMenu()
    playClickSound()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 440, 0, 320),
            Rotation = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0)
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
