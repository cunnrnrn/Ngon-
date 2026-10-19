--// √12kientomato - ULTIMATE MENU UI LIBRARY (CLEAN & OPTIMIZED - PHẦN 1: CORE GIAO DIỆN)
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

if getgenv().UltimateCrackLoaded then
    warn("[√12kientomato]: Thư viện đã được tải trước đó!")
    return getgenv().UltimateCrackLib
end
getgenv().UltimateCrackLoaded = true

local UltimateLib = {}
getgenv().UltimateCrackLib = UltimateLib

UltimateLib.Version = "2026.1.0"
UltimateLib.Themes = {
    DarkGlass = {MainColor = Color3.fromRGB(15, 15, 22), AccentColor = Color3.fromRGB(255, 40, 90), TextColor = Color3.fromRGB(255, 255, 255), Transparency = 0.15},
    Cyberpunk = {MainColor = Color3.fromRGB(10, 10, 18), AccentColor = Color3.fromRGB(0, 240, 255), TextColor = Color3.fromRGB(255, 255, 255), Transparency = 0.1}
}
UltimateLib.CurrentTheme = UltimateLib.Themes.DarkGlass
UltimateLib.State = {Connections = {}, ESPObjects = {}, Waypoints = {}, Toggles = {}}

function UltimateLib:RegisterConnection(conn)
    table.insert(UltimateLib.State.Connections, conn)
end

function UltimateLib:Notify(title, text, duration)
    pcall(function()
        print(string.format("[√12kientomato | %s]: %s", tostring(title), tostring(text)))
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateCrack_UI"
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
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = UltimateLib.CurrentTheme.MainColor
MainFrame.BackgroundTransparency = UltimateLib.CurrentTheme.Transparency
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = UltimateLib.CurrentTheme.AccentColor
UIStroke.Transparency = 0.2
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 0, 40)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "√12kientomato Hub Pro - Ez Crack Edition"
TitleLabel.TextColor3 = UltimateLib.CurrentTheme.TextColor
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Name = "ScrollContainer"
ScrollContainer.Size = UDim2.new(1, -20, 1, -50)
ScrollContainer.Position = UDim2.new(0, 10, 0, 45)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.BorderSizePixel = 0
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = ScrollContainer

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end)

UltimateLib.Container = ScrollContainer
UltimateLib:Notify("UI Engine", "Đã tải giao diện tối ưu hóa cực mượt!", 2)
--// √12kientomato - ULTIMATE MENU UI LIBRARY (CLEAN & OPTIMIZED - PHẦN 2: COMBAT & AIMBOT PRO)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local UltimateLib = getgenv().UltimateCrackLib or {}

function UltimateLib:CreateSectionHeader(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 24)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = "--- " .. tostring(text) .. " ---"
    label.TextColor3 = UltimateLib.CurrentTheme and UltimateLib.CurrentTheme.AccentColor or Color3.fromRGB(255, 40, 90)
    label.TextSize = 12
    label.Parent = UltimateLib.Container
    return label
end

function UltimateLib:CreateToggle(text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = UltimateLib.CurrentTheme and UltimateLib.CurrentTheme.TextColor or Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
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
    btn.Parent = UltimateLib.Container
    return btn
end

UltimateLib:CreateSectionHeader("Hệ Thống Combat & Aimbot Chuẩn")

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

UltimateLib:CreateToggle("Aimbot Khóa Đầu (Target Lock)", false, function(s)
    aimbotActive = s
    if s then
        if not aimConn then
            aimConn = RunService.RenderStepped:Connect(function()
                if aimbotActive then
                    local t = GetClosestTarget()
                    if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Position) end
                end
            end)
            UltimateLib:RegisterConnection(aimConn)
        end
        UltimateLib:Notify("Aimbot", "Đã bật khóa đầu tự động!", 1)
    else
        if aimConn then aimConn:Disconnect() aimConn = nil end
        UltimateLib:Notify("Aimbot", "Đã tắt khóa đầu.", 1)
    end
end)

UltimateLib:CreateToggle("Auto Clicker Tốc Độ Cao", false, function(s)
    UltimateLib.State.AutoClick = s
    task.spawn(function()
        while UltimateLib.State.AutoClick do
            pcall(function() mouse1click() end)
            task.wait(0.04)
        end
    end)
    UltimateLib:Notify("Combat", "Auto Clicker: " .. tostring(s), 1)
end)

UltimateLib:CreateToggle("Hitbox Expander (Mở Rộng Kẻ Địch 5x)", false, function(s)
    UltimateLib.State.BigHitbox = s
    task.spawn(function()
        while UltimateLib.State.BigHitbox do
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.Size = Vector3.new(5, 5, 5)
                        p.Character.HumanoidRootPart.Transparency = 0.5
                        p.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
            task.wait(1)
        end
    end)
    UltimateLib:Notify("Combat", "Hitbox Expander: " .. tostring(s), 1)
end)
--// √12kientomato - ULTIMATE MENU UI LIBRARY (CLEAN & OPTIMIZED - PHẦN 3: MOVEMENT & FLY)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local UltimateLib = getgenv().UltimateCrackLib or {}

UltimateLib:CreateSectionHeader("Hệ Thống Di Chuyển & Vật Lý")

local flyActive = false
local flyConn = nil
local bVel, bGyro

UltimateLib:CreateToggle("Chế Độ Bay Tự Do (Fly Pro)", false, function(s)
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
        UltimateLib:RegisterConnection(flyConn)
        UltimateLib:Notify("Fly", "Đã bật chế độ bay!", 1)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if bVel then bVel:Destroy() end
        if bGyro then bGyro:Destroy() end
        UltimateLib:Notify("Fly", "Đã tắt chế độ bay.", 1)
    end
end)

local noclipActive = false
local noclipConn = nil
UltimateLib:CreateToggle("Xuyên Tường (Noclip)", false, function(s)
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
        UltimateLib:RegisterConnection(noclipConn)
        UltimateLib:Notify("Noclip", "Đã bật xuyên tường!", 1)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
        UltimateLib:Notify("Noclip", "Đã tắt xuyên tường.", 1)
    end
end)

UltimateLib:CreateToggle("Siêu Tốc Độ Chạy (WalkSpeed 100)", false, function(s)
    UltimateLib.State.Speed = s
    task.spawn(function()
        while UltimateLib.State.Speed do
            pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
            task.wait(0.4)
        end
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
    end)
    UltimateLib:Notify("Movement", "Speed Boost: " .. tostring(s), 1)
end)

UltimateLib:CreateToggle("Nhảy Vô Tận (Infinite Jump)", false, function(s)
    UltimateLib.State.InfJump = s
    local conn
    if s then
        conn = UserInputService.JumpRequest:Connect(function()
            if UltimateLib.State.InfJump and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        UltimateLib:RegisterConnection(conn)
    end
    UltimateLib:Notify("Movement", "Infinite Jump: " .. tostring(s), 1)
end)
--// √12kientomato - ULTIMATE MENU UI LIBRARY (CLEAN & OPTIMIZED - PHẦN 4: VISUAL, ESP & TIỆN ÍCH)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local UltimateLib = getgenv().UltimateCrackLib or {}

UltimateLib:CreateSectionHeader("Hệ Thống Visual, ESP & Tiện Ích")

UltimateLib:CreateToggle("ESP Nhìn Xuyên Tường (Player Tags)", false, function(s)
    if s then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if not p.Character.Head:FindFirstChild("CrackESPTag") then
                    local bg = Instance.new("BillboardGui")
                    bg.Name = "CrackESPTag"
                    bg.Adornee = p.Character.Head
                    bg.Size = UDim2.new(0, 100, 0, 40)
                    bg.StudsOffset = Vector3.new(0, 2, 0)
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
                    table.insert(UltimateLib.State.ESPObjects, bg)
                end
            end
        end
        UltimateLib:Notify("ESP", "Đã bật ESP người chơi!", 1)
    else
        for _, obj in ipairs(UltimateLib.State.ESPObjects) do
            if obj then obj:Destroy() end
        end
        UltimateLib.State.ESPObjects = {}
        UltimateLib:Notify("ESP", "Đã tắt ESP.", 1)
    end
end)

UltimateLib:CreateToggle("Tối Ưu Hóa FPS (FPS Boost)", false, function(s)
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
            UltimateLib:Notify("FPS Boost", "Đã tối ưu hóa đồ họa thành công!", 1)
        else
            Lighting.GlobalShadows = true
            UltimateLib:Notify("FPS Boost", "Đã tắt tối ưu đồ họa.", 1)
        end
    end)
end)

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = UltimateLib.CurrentTheme and UltimateLib.CurrentTheme.TextColor or Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    btn.Parent = UltimateLib.Container
    return btn
end

CreateButton("Kết Nối Lại Server (Rejoin Game)", function()
    UltimateLib:Notify("Server", "Đang kết nối lại...", 1)
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\n[√12kientomato]: Rejoining...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

CreateButton("Đổi Máy Chủ Ngẫu Nhiên (Server Hop)", function()
    UltimateLib:Notify("Server Hop", "Đang tìm máy chủ mới...", 1)
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
    UltimateLib:Notify("Server Hop", "Không tìm thấy server phù hợp!", 2)
end)

UltimateLib:Notify("√12kientomato", "Đã nạp thành công toàn bộ menu mượt mà, không lỗi vặt!", 3)
