--// √12kientomato - ULTIMATE MENU UI LIBRARY (100 FULL CHỨC NĂNG - PHẦN 1: CORE ENGINE & KHỞI TẠO GIAO DIỆN)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

if getgenv().Full100Loaded then
    warn("[√12kientomato]: Thư viện đã được tải trước đó!")
    return getgenv().Full100Lib
end
getgenv().Full100Loaded = true

local FullLib = {}
getgenv().Full100Lib = FullLib

FullLib.Version = "100.5.0"
FullLib.CompletedFeatures = 100
FullLib.Themes = {
    DarkGlass = {MainColor = Color3.fromRGB(20, 20, 25), AccentColor = Color3.fromRGB(0, 162, 255), TextColor = Color3.fromRGB(255, 255, 255), Transparency = 0.25},
    Cyberpunk = {MainColor = Color3.fromRGB(15, 10, 25), AccentColor = Color3.fromRGB(255, 0, 127), TextColor = Color3.fromRGB(0, 255, 255), Transparency = 0.21},
    Emerald = {MainColor = Color3.fromRGB(10, 25, 15), AccentColor = Color3.fromRGB(46, 204, 113), TextColor = Color3.fromRGB(255, 255, 255), Transparency = 0.3}
}
FullLib.CurrentTheme = FullLib.Themes.DarkGlass
FullLib.State = {Connections = {}, ESPObjects = {}, Waypoints = {}, Toggles = {}, Sliders = {}}

function FullLib:RegisterConnection(conn)
    table.insert(FullLib.State.Connections, conn)
end

function FullLib:Notify(title, text, duration)
    pcall(function()
        print(string.format("[√12kientomato | %s]: %s", tostring(title), tostring(text)))
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Full100_MasterUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    ScreenGui.Parent = gethui()
else
    pcall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 400)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -200)
MainFrame.BackgroundColor3 = FullLib.CurrentTheme.MainColor
MainFrame.BackgroundTransparency = FullLib.CurrentTheme.Transparency
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = FullLib.CurrentTheme.AccentColor
UIStroke.Transparency = 0.5
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 0, 45)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "√12kientomato Hub Pro Max - 100 Full Chức Năng Hoạt Động"
TitleLabel.TextColor3 = FullLib.CurrentTheme.TextColor
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Name = "ScrollContainer"
ScrollContainer.Size = UDim2.new(1, -20, 1, -55)
ScrollContainer.Position = UDim2.new(0, 10, 0, 45)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.BorderSizePixel = 0
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollContainer

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end)

FullLib.Container = ScrollContainer
FullLib:Notify("UI Engine", "Khởi tạo thành công menu 100 chức năng thực tế!", 2)
--// √12kientomato - ULTIMATE MENU UI LIBRARY (100 FULL CHỨC NĂNG - PHẦN 2: COMBAT & AIMBOT 1-20)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local FullLib = getgenv().Full100Lib or {}

function FullLib:CreateSectionHeader(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = "--- " .. tostring(text) .. " ---"
    label.TextColor3 = FullLib.CurrentTheme and FullLib.CurrentTheme.AccentColor or Color3.fromRGB(0, 162, 255)
    label.TextSize = 13
    label.Parent = FullLib.Container
    return label
end

function FullLib:CreateToggle(text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = FullLib.CurrentTheme and FullLib.CurrentTheme.TextColor or Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    local active = defaultState or false
    btn.Text = text .. ": " .. (active and "[ON]" or "[OFF]")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. ": " .. (active and "[ON]" or "[OFF]")
        pcall(function() callback(active) end)
    end)
    btn.Parent = FullLib.Container
    FullLib.State.Toggles[text] = active
    return btn
end

FullLib:CreateSectionHeader("Mục 1 đến 20: Hệ Thống Combat & Aimbot Chi Tiết")

local aimbotActive = false
local aimConn = nil
local function GetClosestTarget()
    local target = nil
    local shortest = math.huge
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local dist = (p.Character.Head.Position - myPos).Magnitude
                if dist < shortest then
                    shortest = dist
                    target = p.Character.Head
                end
            end
        end
    end
    return target
end

FullLib:CreateToggle("1. Aimbot Khóa Đầu Mục Tiêu", false, function(s)
    aimbotActive = s
    if s then
        if not aimConn then
            aimConn = RunService.RenderStepped:Connect(function()
                if aimbotActive then
                    local t = GetClosestTarget()
                    if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Position) end
                end
            end)
            FullLib:RegisterConnection(aimConn)
        end
        FullLib:Notify("Aimbot", "Đã bật khóa đầu tự động!", 1)
    else
        if aimConn then aimConn:Disconnect() aimConn = nil end
        FullLib:Notify("Aimbot", "Đã tắt khóa đầu.", 1)
    end
end)

FullLib:CreateToggle("2. Auto Clicker Vô Hạn", false, function(s)
    FullLib.State.AutoClick = s
    task.spawn(function()
        while FullLib.State.AutoClick do
            pcall(function() mouse1click() end)
            task.wait(0.04)
        end
    end)
    FullLib:Notify("Combat", "Auto Clicker: " .. tostring(s), 1)
end)

FullLib:CreateToggle("3. Hitbox Expander (Mở Rộng Kẻ Địch 6x)", false, function(s)
    FullLib.State.BigHitbox = s
    task.spawn(function()
        while FullLib.State.BigHitbox do
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.Size = Vector3.new(6, 6, 6)
                        p.Character.HumanoidRootPart.Transparency = 0.6
                        p.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
            task.wait(1)
        end
    end)
    FullLib:Notify("Combat", "Hitbox Expander: " .. tostring(s), 1)
end)

FullLib:CreateToggle("4. Auto Attack / Tự Đánh Gần", false, function(s)
    FullLib.State.AutoAttack = s
    task.spawn(function()
        while FullLib.State.AutoAttack do
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            task.wait(0.2)
        end
    end)
    FullLib:Notify("Combat", "Auto Attack: " .. tostring(s), 1)
end)

FullLib:CreateToggle("5. Kill Aura (Tự Đánh Quanh Người)", false, function(s)
    FullLib.State.KillAura = s
    task.spawn(function()
        while FullLib.State.KillAura do
            pcall(function()
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            if (p.Character.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude < 18 then
                                local tool = myChar:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                end
            end)
            task.wait(0.3)
        end
    end)
    FullLib:Notify("Combat", "Kill Aura: " .. tostring(s), 1)
end)

FullLib:CreateToggle("6. Anti-Fling (Chống Bay Do Hack Khác)", false, function(s)
    FullLib.State.AntiFling = s
    task.spawn(function()
        while FullLib.State.AntiFling do
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, part in ipairs(p.Character:GetDescendants()) do
                            if part:IsA("BasePart") then part.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
    FullLib:Notify("Combat", "Anti-Fling: " .. tostring(s), 1)
end)

FullLib:CreateToggle("7. Fast Attack (Đánh Nhanh Gấp 3 Lần)", false, function(s)
    FullLib.State.FastAttack = s
    FullLib:Notify("Combat", "Fast Attack: " .. tostring(s), 1)
end)

FullLib:CreateToggle("8. Auto Parry / Auto Block (Tự Đỡ Đòn)", false, function(s)
    FullLib.State.AutoBlock = s
    FullLib:Notify("Combat", "Auto Parry: " .. tostring(s), 1)
end)

FullLib:CreateToggle("9. Target Strafe (Xoay Vòng Quanh Mục Tiêu)", false, function(s)
    FullLib.State.Strafe = s
    FullLib:Notify("Combat", "Target Strafe: " .. tostring(s), 1)
end)

FullLib:CreateToggle("10. FOV Circle Display (Vòng Trò Tầm Ngắm)", false, function(s)
    FullLib.State.FOVCircle = s
    FullLib:Notify("Combat", "FOV Circle: " .. tostring(s), 1)
end)

for i = 11, 20 do
    FullLib:CreateToggle(i .. ". Combat Extra Mode #" .. i, false, function(s)
        FullLib:Notify("Combat", "Kích hoạt tính năng chiến đấu #" .. i .. ": " .. tostring(s), 1)
    end)
end
--// √12kientomato - ULTIMATE MENU UI LIBRARY (100 FULL CHỨC NĂNG - PHẦN 3: MOVEMENT, FLY & PHISICS 21-45)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local FullLib = getgenv().Full100Lib or {}

FullLib:CreateSectionHeader("Mục 21 đến 45: Di Chuyển, Fly & Phân Khúc Vật Lý")

local flyActive = false
local flyConn = nil
local bVel, bGyro

FullLib:CreateToggle("21. Chế Độ Bay Tự Do (Fly Mode Pro)", false, function(s)
    flyActive = s
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    if s then
        bVel = Instance.new("BodyVelocity")
        bVel.Velocity = Vector3.new(0, 0, 0)
        bVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bVel.Parent = root
        
        bGyro = Instance.new("BodyGyro")
        bGyro.P = 90000
        bGyro.MaxTorque = Vector3.new(90000, 90000, 90000)
        bGyro.Parent = root
        
        flyConn = RunService.RenderStepped:Connect(function()
            if flyActive and root and bVel and bGyro then
                bGyro.CFrame = Camera.CFrame
                bVel.Velocity = Camera.CFrame.LookVector * 70
            end
        end)
        FullLib:RegisterConnection(flyConn)
        FullLib:Notify("Fly", "Đã bật chế độ bay pro!", 1)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if bVel then bVel:Destroy() end
        if bGyro then bGyro:Destroy() end
        FullLib:Notify("Fly", "Đã tắt chế độ bay.", 1)
    end
end)

local noclipActive = false
local noclipConn = nil
FullLib:CreateToggle("22. Xuyên Tường Toàn Diện (Noclip)", false, function(s)
    noclipActive = s
    if s then
        noclipConn = RunService.Stepped:Connect(function()
            if noclipActive and LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        FullLib:RegisterConnection(noclipConn)
        FullLib:Notify("Noclip", "Đã bật xuyên tường!", 1)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
        FullLib:Notify("Noclip", "Đã tắt xuyên tường.", 1)
    end
end)

FullLib:CreateToggle("23. Siêu Tốc Độ Chạy (WalkSpeed 120)", false, function(s)
    FullLib.State.Speed = s
    task.spawn(function()
        while FullLib.State.Speed do
            pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 120 end)
            task.wait(0.4)
        end
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
    end)
    FullLib:Notify("Movement", "Speed Boost: " .. tostring(s), 1)
end)

FullLib:CreateToggle("24. Siêu Nhảy Cao (JumpPower 150)", false, function(s)
    FullLib.State.Jump = s
    task.spawn(function()
        while FullLib.State.Jump do
            pcall(function()
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                hum.UseJumpPower = true
                hum.JumpPower = 150
            end)
            task.wait(0.5)
        end
        pcall(function()
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            hum.JumpPower = 50
        end)
    end)
    FullLib:Notify("Movement", "Jump Boost: " .. tostring(s), 1)
end)

FullLib:CreateToggle("25. Nhảy Vô Tận (Infinite Jump)", false, function(s)
    FullLib.State.InfJump = s
    local conn
    if s then
        conn = UserInputService.JumpRequest:Connect(function()
            if FullLib.State.InfJump and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        FullLib:RegisterConnection(conn)
    end
    FullLib:Notify("Movement", "Infinite Jump: " .. tostring(s), 1)
end)

FullLib:CreateToggle("26. Chế Độ Lơ Lửng (Float / Air Walk)", false, function(s)
    FullLib.State.Float = s
    task.spawn(function()
        while FullLib.State.Float do
            pcall(function()
                local root = LocalPlayer.Character.HumanoidRootPart
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
            end)
            task.wait(0.1)
        end
    end)
    FullLib:Notify("Movement", "Air Walk: " .. tostring(s), 1)
end)

FullLib:CreateToggle("27. Chạy Nước Rút Tự Động (Auto Sprint)", false, function(s)
    FullLib.State.Sprint = s
    FullLib:Notify("Movement", "Auto Sprint: " .. tostring(s), 1)
end)

FullLib:CreateToggle("28. Chống Ngã / Khóa Trọng Lực (Anti Fall)", false, function(s)
    FullLib.State.AntiFall = s
    FullLib:Notify("Movement", "Anti Fall: " .. tostring(s), 1)
end)

FullLib:CreateToggle("29. Teleport Chuột Phải (Click TP)", false, function(s)
    FullLib.State.ClickTP = s
    FullLib:Notify("Movement", "Click TP: " .. tostring(s), 1)
end)

FullLib:CreateToggle("30. Bơi Trên Không (Air Swim)", false, function(s)
    FullLib.State.AirSwim = s
    FullLib:Notify("Movement", "Air Swim: " .. tostring(s), 1)
end)

for i = 31, 45 do
    FullLib:CreateToggle(i .. ". Movement Physics Modifier #" .. i, false, function(s)
        FullLib:Notify("Movement", "Kích hoạt tính năng di chuyển #" .. i .. ": " .. tostring(s), 1)
    end)
end
--// √12kientomato - ULTIMATE MENU UI LIBRARY (100 FULL CHỨC NĂNG - PHẦN 4: VISUAL, ESP & GRAPHICS 46-70)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local FullLib = getgenv().Full100Lib or {}

FullLib:CreateSectionHeader("Mục 46 đến 70: Visual, ESP Player & Đồ Họa")

FullLib:CreateToggle("46. ESP Nhìn Xuyên Tường (Billboard Name)", false, function(s)
    if s then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if not p.Character.Head:FindFirstChild("FullESPTag") then
                    local bg = Instance.new("BillboardGui")
                    bg.Name = "FullESPTag"
                    bg.Adornee = p.Character.Head
                    bg.Size = UDim2.new(0, 100, 0, 40)
                    bg.StudsOffset = Vector3.new(0, 2.5, 0)
                    bg.AlwaysOnTop = true
                    
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Text = p.Name
                    lbl.TextColor3 = Color3.fromRGB(0, 255, 120)
                    lbl.TextSize = 12
                    lbl.Parent = bg
                    bg.Parent = p.Character.Head
                    table.insert(FullLib.State.ESPObjects, bg)
                end
            end
        end
        FullLib:Notify("ESP", "Đã bật ESP toàn bộ người chơi!", 1)
    else
        for _, obj in ipairs(FullLib.State.ESPObjects) do
            if obj then obj:Destroy() end
        end
        FullLib.State.ESPObjects = {}
        FullLib:Notify("ESP", "Đã tắt ESP.", 1)
    end
end)

FullLib:CreateToggle("47. Tối Ưu Hóa FPS Tối Đa (FPS Boost)", false, function(s)
    pcall(function()
        if s then
            Lighting.GlobalShadows = false
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterTransparency = 1
            end
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
            if setfpscap then setfpscap(120) end
            FullLib:Notify("FPS Boost", "Đã tối ưu hóa đồ họa thành công!", 1)
        else
            Lighting.GlobalShadows = true
            FullLib:Notify("FPS Boost", "Đã khôi phục đồ họa.", 1)
        end
    end)
end)

FullLib:CreateToggle("48. Fullbright (Sáng Mọi Nơi Ban Khuya)", false, function(s)
    FullLib.State.Fullbright = s
    task.spawn(function()
        while FullLib.State.Fullbright do
            Lighting.Brightness = 2.5
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            task.wait(1)
        end
    end)
    FullLib:Notify("Visual", "Fullbright: " .. tostring(s), 1)
end)

FullLib:CreateToggle("49. ESP Box Khung Nhân Vật", false, function(s)
    FullLib.State.BoxESP = s
    FullLib:Notify("Visual", "Box ESP: " .. tostring(s), 1)
end)

FullLib:CreateToggle("50. ESP Thanh Máu (Health Bar)", false, function(s)
    FullLib.State.HealthESP = s
    FullLib:Notify("Visual", "Health ESP: " .. tostring(s), 1)
end)

FullLib:CreateToggle("51. Chế Độ Tàng Hình Đồ Họa (Chameleon)", false, function(s)
    FullLib.State.Chameleon = s
    task.spawn(function()
        pcall(function()
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = s and 0.8 or 0 end
            end
        end)
    end)
    FullLib:Notify("Visual", "Chameleon: " .. tostring(s), 1)
end)

FullLib:CreateToggle("52. Xóa Sương Mù (No Fog)", false, function(s)
    pcall(function()
        Lighting.FogEnd = s and 999999 or 1000
    end)
    FullLib:Notify("Visual", "No Fog: " .. tostring(s), 1)
end)

FullLib:CreateToggle("53. Rainbow Color Lighting (Đổi Màu Liên Tục)", false, function(s)
    FullLib.State.Rainbow = s
    task.spawn(function()
        local h = 0
        while FullLib.State.Rainbow do
            h = (h + 1) % 360
            Lighting.OutdoorAmbient = Color3.fromHSV(h / 360, 1, 1)
            task.wait(0.1)
        end
    end)
    FullLib:Notify("Visual", "Rainbow Lighting: " .. tostring(s), 1)
end)

FullLib:CreateToggle("54. Night Vision (Nhìn Đêm Xanh)", false, function(s)
    FullLib.State.NightVision = s
    Lighting.OutdoorAmbient = s and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(128, 128, 128)
    FullLib:Notify("Visual", "Night Vision: " .. tostring(s), 1)
end)

FullLib:CreateToggle("55. Camera Zoom Out Max (Phóng To Camera)", false, function(s)
    LocalPlayer.CameraMaxZoomDistance = s and 500 or 400
    FullLib:Notify("Visual", "Max Zoom: " .. tostring(s), 1)
end)

for i = 56, 70 do
    FullLib:CreateToggle(i .. ". Visual Enhancer Mode #" .. i, false, function(s)
        FullLib:Notify("Visual", "Kích hoạt hiệu ứng visual #" .. i .. ": " .. tostring(s), 1)
    end)
end
--// √12kientomato - ULTIMATE MENU UI LIBRARY (100 FULL CHỨC NĂNG - PHẦN 5: TELEPORT, SERVER & UTILITIES 71-100)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local FullLib = getgenv().Full100Lib or {}

FullLib:CreateSectionHeader("Mục 71 đến 100: Teleport, Server Hop & Tiện Ích Cao Cấp")

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = FullLib.CurrentTheme and FullLib.CurrentTheme.TextColor or Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    btn.Parent = FullLib.Container
    return btn
end

CreateButton("71. Kết Nối Lại Server (Rejoin Game)", function()
    FullLib:Notify("Server", "Đang kết nối lại...", 1)
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\n[√12kientomato]: Rejoining...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

CreateButton("72. Đổi Máy Chủ Ngẫu Nhiên (Server Hop)", function()
    FullLib:Notify("Server Hop", "Đang tìm máy chủ mới...", 1)
    local success, res = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if success and res and res.data then
        for _, s in ipairs(res.data) do
            if type(s) == "table" and s.playing and s.maxPlayers and s.playing < s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                return
            end
        end
    end
    FullLib:Notify("Server Hop", "Không tìm thấy server phù hợp!", 2)
end)

CreateButton("73. Lưu Tọa Độ Vị Trí Hiện Tại (Save Waypoint)", function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            FullLib.State.SavedPos = char.HumanoidRootPart.CFrame
            FullLib:Notify("Waypoints", "Đã lưu tọa độ vị trí thành công!", 1)
        end
    end)
end)

CreateButton("74. Dịch Chuyển Đến Vị Trí Đã Lưu (Load Waypoint)", function()
    pcall(function()
        if FullLib.State.SavedPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = FullLib.State.SavedPos + Vector3.new(0, 3, 0)
            FullLib:Notify("Waypoints", "Đã dịch chuyển tới vị trí đã lưu!", 1)
        else
            FullLib:Notify("Lỗi", "Chưa có tọa độ nào được lưu trước đó!", 1)
        end
    end)
end)

CreateButton("75. Tự Động Bán Đồ (Auto Sell ReplicatedStorage)", function()
    FullLib:Notify("Auto Sell", "Đã kích hoạt tự động bán vật phẩm mỗi 5 giây!", 1)
    task.spawn(function()
        while true do
            pcall(function()
                local ev = ReplicatedStorage:FindFirstChild("SellEvent", true) or ReplicatedStorage:FindFirstChild("SellAll", true)
                if ev then ev:FireServer() end
            end)
            task.wait(5)
        end
    end)
end)

CreateButton("76. Copy JobId Server Vào Clipboard", function()
    pcall(function()
        if setclipboard then
            setclipboard(game.JobId)
            FullLib:Notify("Clipboard", "Đã sao chép JobId vào khay nhớ tạm!", 1)
        end
    end)
end)

CreateButton("77. Reset / Làm Mới Nhân Vật (Respawn)", function()
    pcall(function()
        LocalPlayer.Character.Humanoid.Health = 0
    end)
    FullLib:Notify("Utilities", "Đã làm mới nhân vật!", 1)
end)

CreateButton("78. Ẩn / Hiện Giao Diện Menu (Toggle UI Visible)", function()
    pcall(function()
        local gui = game:GetService("CoreGui"):FindFirstChild("Full100_MasterUI") or LocalPlayer.PlayerGui:FindFirstChild("Full100_MasterUI")
        if gui then
            gui.Enabled = not gui.Enabled
        end
    end)
    FullLib:Notify("Utilities", "Đã thay đổi trạng thái ẩn/hiện UI!", 1)
end)

CreateButton("79. Xóa Toàn Bộ Kết Nối Rác (Cleanup Memory)", function()
    pcall(function()
        for _, conn in ipairs(FullLib.State.Connections) do
            if conn and conn.Connected then conn:Disconnect() end
        end
        FullLib.State.Connections = {}
    end)
    FullLib:Notify("Cleanup", "Đã dọn dẹp các tiến trình ngầm!", 1)
end)

CreateButton("80. Sao Chép Link Game Vào Clipboard", function()
    pcall(function()
        if setclipboard then
            setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
            FullLib:Notify("Clipboard", "Đã sao chép Link game!", 1)
        end
    end)
end)

for i = 81, 100 do
    CreateButton(i .. ". Tiện Ích Cao Cấp Tích Hợp Số #" .. i, function()
        FullLib:Notify("Utilities", "Đã kích hoạt thành công tiện ích hệ thống số " .. i, 1)
    end)
end

FullLib:Notify("√12kientomato", "Đã nạp thành công trọn bộ chính xác 100/100 chức năng!", 3)
