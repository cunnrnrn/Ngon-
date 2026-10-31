--[[
    Script Name: kiên 94 Hub Pro Max (Part 1 - Dragon Edition)
    Features: Dragon 'K' Logo + Red Neon Glassmorphism UI + Multi-Fire Auto Soul + Smart Blacklist
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local remote = ReplicatedStorage:WaitForChild("RideADinoNet", 5)

-- Anti-AFK chống văng game khi treo máy
local antiAfkConn = player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

getgenv().kienConfig = {
    AutoSoul = false,
    FitLag = false,
    AutoTeleportBack = true,
    Delay = 0.01,
    SafeDistance = 10,
    SavedPosition = nil,
    SoulCount = 0
}

-- Xóa GUI cũ nếu có
if playerGui:FindFirstChild("kien_94_GUI") then
    playerGui["kien_94_GUI"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "kien_94_GUI"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Nút Bật/Tắt Menu cố định ở góc trái trên cùng với LOGO CHỮ K HÌNH CON RỒNG SIÊU ĐẸP
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = ScreenGui
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 8, 8)
ToggleMenuBtn.BackgroundTransparency = 0.15
ToggleMenuBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleMenuBtn.Size = UDim2.new(0, 135, 0, 42)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.Text = "🐉 [ K ] DRAGON"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ToggleMenuBtn.TextSize = 13
ToggleMenuBtn.ZIndex = 10

local TBtnCorner = Instance.new("UICorner")
TBtnCorner.CornerRadius = UDim.new(0, 12)
TBtnCorner.Parent = ToggleMenuBtn

local TBtnStroke = Instance.new("UIStroke")
TBtnStroke.Color = Color3.fromRGB(255, 30, 30)
TBtnStroke.Transparency = 0.1
TBtnStroke.Thickness = 2.5
TBtnStroke.Parent = ToggleMenuBtn

-- Khung chính Menu (Glassmorphism Đỏ Ruby Vực Sâu)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
MainFrame.BackgroundTransparency = 0.2
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Rotation = -90
MainFrame.ZIndex = 5

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Transparency = 0.2
UIStroke.Thickness = 2.2
UIStroke.Parent = MainFrame

-- Tiêu đề Menu & Nút điều khiển phụ (Thu gọn + Xóa vĩnh viễn)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 8)
Title.Size = UDim2.new(0.65, 0, 0, 28)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ KIÊN 94 DRAGON HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextSize = 12
Title.ZIndex = 6

-- Nút Thu Gọn Menu (- Minify)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 20)
MinimizeBtn.BackgroundTransparency = 0.2
MinimizeBtn.Position = UDim2.new(0.67, 0, 0, 8)
MinimizeBtn.Size = UDim2.new(0, 48, 0, 26)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "Ẩn"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 11
MinimizeBtn.ZIndex = 6
local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 6) MinCorner.Parent = MinimizeBtn

-- Nút Xóa Vĩnh Viễn Script (Kill Switch)
local DestroyBtn = Instance.new("TextButton")
DestroyBtn.Parent = MainFrame
DestroyBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
DestroyBtn.BackgroundTransparency = 0.2
DestroyBtn.Position = UDim2.new(0.84, 0, 0, 8)
DestroyBtn.Size = UDim2.new(0, 38, 0, 26)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.Text = "Xóa"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.TextSize = 11
DestroyBtn.ZIndex = 6
local DesCorner = Instance.new("UICorner") DesCorner.CornerRadius = UDim.new(0, 6) DesCorner.Parent = DestroyBtn

-- Thanh Tab chuyển đổi
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0.05, 0, 0.16, 0)
TabBar.Size = UDim2.new(0.9, 0, 0, 28)
TabBar.ZIndex = 6

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Parent = TabBar
Tab1Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
Tab1Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab1Btn.Font = Enum.Font.GothamBold
Tab1Btn.Text = "Auto Soul"
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.TextSize = 10
Tab1Btn.ZIndex = 6
local T1C = Instance.new("UICorner") T1C.CornerRadius = UDim.new(0, 6) T1C.Parent = Tab1Btn

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Parent = TabBar
Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15)
Tab2Btn.Position = UDim2.new(0.34, 0, 0, 0)
Tab2Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab2Btn.Font = Enum.Font.GothamBold
Tab2Btn.Text = "Hop Server"
Tab2Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
Tab2Btn.TextSize = 10
Tab2Btn.ZIndex = 6
local T2C = Instance.new("UICorner") T2C.CornerRadius = UDim.new(0, 6) T2C.Parent = Tab2Btn

local Tab3Btn = Instance.new("TextButton")
Tab3Btn.Parent = TabBar
Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15)
Tab3Btn.Position = UDim2.new(0.68, 0, 0, 0)
Tab3Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab3Btn.Font = Enum.Font.GothamBold
Tab3Btn.Text = "Super Fit Lag"
Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
Tab3Btn.TextSize = 9
Tab3Btn.ZIndex = 6
local T3C = Instance.new("UICorner") T3C.CornerRadius = UDim.new(0, 6) T3C.Parent = Tab3Btn
--[[
    Script Name: kiên 94 Hub Pro Max (Part 2 - Execution Engine)
]]

-- Container Tab 1 (Auto Soul)
local Tab1Container = Instance.new("Frame")
Tab1Container.Parent = MainFrame
Tab1Container.BackgroundTransparency = 1
Tab1Container.Position = UDim2.new(0.05, 0, 0.27, 0)
Tab1Container.Size = UDim2.new(0.9, 0, 0.7, 0)
Tab1Container.ZIndex = 6

local AutoSoulBtn = Instance.new("TextButton")
AutoSoulBtn.Parent = Tab1Container
AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AutoSoulBtn.BackgroundTransparency = 0.2
AutoSoulBtn.Size = UDim2.new(1, 0, 0, 36)
AutoSoulBtn.Font = Enum.Font.GothamBold
AutoSoulBtn.Text = "Auto Soul Multi-Fire (x5): OFF"
AutoSoulBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSoulBtn.TextSize = 11
AutoSoulBtn.ZIndex = 6
local ASCorner = Instance.new("UICorner") ASCorner.CornerRadius = UDim.new(0, 8) ASCorner.Parent = AutoSoulBtn

local SavePosBtn = Instance.new("TextButton")
SavePosBtn.Parent = Tab1Container
SavePosBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 30)
SavePosBtn.BackgroundTransparency = 0.2
SavePosBtn.Position = UDim2.new(0, 0, 0.24, 0)
SavePosBtn.Size = UDim2.new(1, 0, 0, 32)
SavePosBtn.Font = Enum.Font.GothamBold
SavePosBtn.Text = "Lưu Vị Trí Hiện Tại (0/1000)"
SavePosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SavePosBtn.TextSize = 11
SavePosBtn.ZIndex = 6
local SPC = Instance.new("UICorner") SPC.CornerRadius = UDim.new(0, 6) SPC.Parent = SavePosBtn

local ToggleTeleBackBtn = Instance.new("TextButton")
ToggleTeleBackBtn.Parent = Tab1Container
ToggleTeleBackBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
ToggleTeleBackBtn.BackgroundTransparency = 0.2
ToggleTeleBackBtn.Position = UDim2.new(0, 0, 0.46, 0)
ToggleTeleBackBtn.Size = UDim2.new(1, 0, 0, 32)
ToggleTeleBackBtn.Font = Enum.Font.GothamBold
ToggleTeleBackBtn.Text = "Auto Về Vị Trí (Đủ 1000): BẬT"
ToggleTeleBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleTeleBackBtn.TextSize = 11
ToggleTeleBackBtn.ZIndex = 6
local TTBC = Instance.new("UICorner") TTBC.CornerRadius = UDim.new(0, 6) TTBC.Parent = ToggleTeleBackBtn

local SoulStatus = Instance.new("TextLabel")
SoulStatus.Parent = Tab1Container
SoulStatus.BackgroundTransparency = 1
SoulStatus.Position = UDim2.new(0, 0, 0.72, 0)
SoulStatus.Size = UDim2.new(1, 0, 0.25, 0)
SoulStatus.Font = Enum.Font.Gotham
SoulStatus.Text = "Trạng thái: Sẵn sàng Multi-Fire nhặt nhanh..."
SoulStatus.TextColor3 = Color3.fromRGB(220, 180, 180)
SoulStatus.TextSize = 10
SoulStatus.TextWrapped = true
SoulStatus.TextYAlignment = Enum.TextYAlignment.Top
SoulStatus.ZIndex = 6

-- Container Tab 2 (Hop Server)
local Tab2Container = Instance.new("Frame")
Tab2Container.Parent = MainFrame
Tab2Container.BackgroundTransparency = 1
Tab2Container.Position = UDim2.new(0.05, 0, 0.27, 0)
Tab2Container.Size = UDim2.new(0.9, 0, 0.7, 0)
Tab2Container.Visible = false
Tab2Container.ZIndex = 6

local HopServerBtn = Instance.new("TextButton")
HopServerBtn.Parent = Tab2Container
HopServerBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
HopServerBtn.BackgroundTransparency = 0.2
HopServerBtn.Size = UDim2.new(1, 0, 0, 45)
HopServerBtn.Font = Enum.Font.GothamBold
HopServerBtn.Text = "Đổi Server Ít Người (Ưu tiên 1 mình)"
HopServerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopServerBtn.TextSize = 11
HopServerBtn.ZIndex = 6
local HSC = Instance.new("UICorner") HSC.CornerRadius = UDim.new(0, 8) HSC.Parent = HopServerBtn

local HopDesc = Instance.new("TextLabel")
HopDesc.Parent = Tab2Container
HopDesc.BackgroundTransparency = 1
HopDesc.Position = UDim2.new(0, 0, 0.5, 0)
HopDesc.Size = UDim2.new(1, 0, 0.4, 0)
HopDesc.Font = Enum.Font.Gotham
HopDesc.Text = "Tự động tìm server trống để farm linh hồn độc quyền."
HopDesc.TextColor3 = Color3.fromRGB(220, 180, 180)
HopDesc.TextSize = 11
HopDesc.TextWrapped = true
HopDesc.TextYAlignment = Enum.TextYAlignment.Top
HopDesc.ZIndex = 6

-- Container Tab 3 (Super Fit Lag)
local Tab3Container = Instance.new("Frame")
Tab3Container.Parent = MainFrame
Tab3Container.BackgroundTransparency = 1
Tab3Container.Position = UDim2.new(0.05, 0, 0.27, 0)
Tab3Container.Size = UDim2.new(0.9, 0, 0.7, 0)
Tab3Container.Visible = false
Tab3Container.ZIndex = 6

local FitLagBtn = Instance.new("TextButton")
FitLagBtn.Parent = Tab3Container
FitLagBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
FitLagBtn.BackgroundTransparency = 0.2
FitLagBtn.Size = UDim2.new(1, 0, 0, 45)
FitLagBtn.Font = Enum.Font.GothamBold
FitLagBtn.Text = "Super Fit Lag Mạnh Nhất: OFF"
FitLagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FitLagBtn.TextSize = 11
FitLagBtn.ZIndex = 6
local FLCorner = Instance.new("UICorner") FLCorner.CornerRadius = UDim.new(0, 8) FLCorner.Parent = FitLagBtn

local FitLagDesc = Instance.new("TextLabel")
FitLagDesc.Parent = Tab3Container
FitLagDesc.BackgroundTransparency = 1
FitLagDesc.Position = UDim2.new(0, 0, 0.5, 0)
FitLagDesc.Size = UDim2.new(1, 0, 0.4, 0)
FitLagDesc.Font = Enum.Font.Gotham
FitLagDesc.Text = "Xóa hiệu ứng, sương mù, trong suốt map mượt mà (giữ nguyên linh hồn & đứng bình thường)."
FitLagDesc.TextColor3 = Color3.fromRGB(220, 180, 180)
FitLagDesc.TextSize = 10
FitLagDesc.TextWrapped = true
FitLagDesc.TextYAlignment = Enum.TextYAlignment.Top
FitLagDesc.ZIndex = 6

-- Chuyển Tab Logic
Tab1Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = true Tab2Container.Visible = false Tab3Container.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab2Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = false Tab2Container.Visible = true Tab3Container.Visible = false
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab1Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

Tab3Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = false Tab2Container.Visible = false Tab3Container.Visible = true
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab3Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab1Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 15, 15) Tab2Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

-- HIỆU ỨNG MỞ MENU RỒNG ĐỎ VIP
local menuOpen = false
ToggleMenuBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 290, 0, 260),
            Rotation = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Rotation = 180
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not menuOpen then MainFrame.Visible = false end
        end)
    end
end)

-- Nút Thu Gọn Menu (Minimize / Unminimize)
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Tab1Container.Visible = not isMinimized
    Tab2Container.Visible = false
    Tab3Container.Visible = false
    TabBar.Visible = not isMinimized
    MinimizeBtn.Text = isMinimized and "Hiện" or "Ẩn"
    
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = isMinimized and UDim2.new(0, 290, 0, 50) or UDim2.new(0, 290, 0, 260)
    }):Play()
end)

-- Nút Xóa Vĩnh Viễn Script (Kill Switch - Hủy toàn bộ hoạt động, giải phóng RAM, xóa GUI)
DestroyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        getgenv().kienConfig.AutoSoul = false
        getgenv().kienConfig.FitLag = false
        if antiAfkConn then antiAfkConn:Disconnect() end
        camera.CameraType = Enum.CameraType.Custom
        ScreenGui:Destroy()
    end)
end)

-- Lưu Vị Trí
SavePosBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        getgenv().kienConfig.SavedPosition = char.HumanoidRootPart.CFrame
        SavePosBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
        SavePosBtn.Text = string.format("Đã lưu vị trí (%d/1000)", getgenv().kienConfig.SoulCount)
        task.delay(1.5, function() 
            SavePosBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
            SavePosBtn.Text = string.format("Lưu Vị Trí Hiện Tại (%d/1000)", getgenv().kienConfig.SoulCount)
        end)
    end
end)

ToggleTeleBackBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.AutoTeleportBack = not getgenv().kienConfig.AutoTeleportBack
    if getgenv().kienConfig.AutoTeleportBack then
        ToggleTeleBackBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
        ToggleTeleBackBtn.Text = "Auto Về Vị Trí (Đủ 1000): BẬT"
    else
        ToggleTeleBackBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        ToggleTeleBackBtn.Text = "Auto Về Vị Trí (Đủ 1000): TẮT"
    end
end)

AutoSoulBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.AutoSoul = not getgenv().kienConfig.AutoSoul
    if getgenv().kienConfig.AutoSoul then
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
        AutoSoulBtn.Text = "Auto Soul Multi-Fire (x5): ON"
        SoulStatus.Text = "Trạng thái: Đang nhặt siêu tốc Multi-Fire..."
    else
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AutoSoulBtn.Text = "Auto Soul Multi-Fire (x5): OFF"
        SoulStatus.Text = "Trạng thái: Đã dừng hoạt động."
        camera.CameraType = Enum.CameraType.Custom
    end
end)

HopServerBtn.MouseButton1Click:Connect(function()
    HopDesc.Text = "Đang quét tìm server ít người..."
    pcall(function()
        local servers = {}
        local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        if req and req.data then
            for _, s in pairs(req.data) do
                if type(s) == "table" and s.playing and s.maxPlayers and s.id then
                    if s.playing < s.maxPlayers and s.id ~= game.JobId then
                        table.insert(servers, s.id)
                    end
                end
            end
        end
        if #servers > 0 then
            HopDesc.Text = "Đang chuyển server..."
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
        else
            HopDesc.Text = "Không tìm thấy server!"
        end
    end)
end)

FitLagBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.FitLag = not getgenv().kienConfig.FitLag
    if getgenv().kienConfig.FitLag then
        FitLagBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
        FitLagBtn.Text = "Super Fit Lag Mạnh Nhất: ON"
    else
        FitLagBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        FitLagBtn.Text = "Super Fit Lag Mạnh Nhất: OFF"
    end
end)

-- Vòng lặp Fit Lag An Toàn (Không bị xì nhạc / tràn bộ nhớ)
task.spawn(function()
    while true do
        task.wait(2)
        if getgenv().kienConfig.FitLag then
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.Brightness = 1
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                for _, v in pairs(Lighting:GetChildren()) do 
                    if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") then v.Enabled = false end 
                end
                if Terrain then 
                    Terrain.WaterWaveSize = 0 
                    Terrain.WaterTransparency = 1
                end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local isSoul = (v.Name == "GraveyardSoul" or v.Name:lower():find("soul"))
                        local isPlayerPart = v:IsDescendantOf(player.Character or workspace)
                        
                        if not isSoul and not isPlayerPart then
                            v.Transparency = 0.85
                            v.Material = Enum.Material.SmoothPlastic
                            v.Reflectance = 0
                        end
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then 
                        v.Enabled = false 
                    end
                end
            end)
        end
    end
end)

-- Vòng lặp Auto Farm Multi-Fire + Smart Blacklist + Camera Lock (Tối ưu hóa chống kẹt/lag)
task.spawn(function()
    local lockedCameraCF = nil
    local isLockedCam = false
    local blacklist = {}

    while true do
        task.wait(getgenv().kienConfig.Delay)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul and remote then
                if getgenv().kienConfig.AutoTeleportBack and getgenv().kienConfig.SoulCount >= 1000 and getgenv().kienConfig.SavedPosition then
                    SoulStatus.Text = "Đã đủ 1000 linh hồn! Đang tele về vị trí lưu..."
                    hrp.CFrame = getgenv().kienConfig.SavedPosition
                    task.wait(1.5)
                    getgenv().kienConfig.SoulCount = 0
                    SavePosBtn.Text = "Lưu Vị Trí Hiện Tại (0/1000)"
                    return
                end

                if not isLockedCam then
                    lockedCameraCF = camera.CFrame
                    isLockedCam = true
                    camera.CameraType = Enum.CameraType.Scriptable
                end
                
                if lockedCameraCF then
                    camera.CFrame = lockedCameraCF
                end

                pcall(function()
                    local bestTarget = nil
                    local shortestDist = math.huge

                    for obj, _ in pairs(blacklist) do
                        if not obj or not obj.Parent then
                            blacklist[obj] = nil
                        end
                    end

                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().kienConfig.AutoSoul then break end
                        
                        if (obj.Name == "GraveyardSoul" or obj.Name:lower():find("soul")) and not blacklist[obj] then
                            local isPlayerRelated = false
                            local ancestor = obj.Parent
                            while ancestor and ancestor ~= workspace do
                                if Players:GetPlayerFromCharacter(ancestor) then
                                    isPlayerRelated = true
                                    break
                                end
                                ancestor = ancestor.Parent
                            end

                            if not isPlayerRelated then
                                local pos = nil
                                if obj:IsA("BasePart") then
                                    pos = obj.Position
                                elseif obj:IsA("Model") and obj.PrimaryPart then
                                    pos = obj.PrimaryPart.Position
                                elseif obj:IsA("Model") then
                                    local p = obj:FindFirstChildWhichIsA("BasePart")
                                    if p then pos = p.Position end
                                end

                                if pos then
                                    local tooCloseToOtherPlayer = false
                                    for _, otherPlayer in pairs(Players:GetPlayers()) do
                                        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            local pDist = (otherPlayer.Character.HumanoidRootPart.Position - pos).Magnitude
                                            if pDist < getgenv().kienConfig.SafeDistance then
                                                tooCloseToOtherPlayer = true
                                                break
                                            end
                                        end
                                    end

                                    if not tooCloseToOtherPlayer then
                                        local dist = (hrp.Position - pos).Magnitude
                                        if dist < shortestDist then
                                            shortestDist = dist
                                            bestTarget = {instance = obj, position = pos}
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if bestTarget then
                        blacklist[bestTarget.instance] = true
                        hrp.CFrame = CFrame.new(bestTarget.position + Vector3.new(0, 2, 0))
                        
                        local args = {
                            "GraveyardSoul",
                            {
                                a = "soul",
                                gen = 370,
                                at = vector.create(bestTarget.position.X, bestTarget.position.Y, bestTarget.position.Z),
                                slot = 129
                            }
                        }
                        for i = 1, 5 do
                            remote:FireServer(unpack(args))
                        end

                        getgenv().kienConfig.SoulCount = getgenv().kienConfig.SoulCount + 1
                        SavePosBtn.Text = string.format("Lưu Vị Trí Hiện Tại (%d/1000)", getgenv().kienConfig.SoulCount)
                    else
                        task.wait(0.1)
                    end
                end)
            else
                if isLockedCam then
                    isLockedCam = false
                    camera.CameraType = Enum.CameraType.Custom
                    lockedCameraCF = nil
                    blacklist = {}
                end
            end
        end
    end
end)
