--[[
    Script Name: kiên 94 Hub Pro Max (Dynamic Streaming Fit Lag Edition)
    Features: Red Neon Glassmorphism GUI + Real-time Streaming Map Cleaner + Smart Blacklist + Camera Lock
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local remote = ReplicatedStorage:WaitForChild("RideADinoNet", 5)

-- Anti-AFK chống văng game khi treo máy
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

getgenv().kienConfig = {
    AutoSoul = false,
    FitLag = false,
    Delay = 0.015,
    SafeDistance = 10
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

-- Nút Bật/Tắt Menu (Tone màu Đỏ VIP) ở góc trái trên cùng
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = ScreenGui
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
ToggleMenuBtn.BackgroundTransparency = 0.2
ToggleMenuBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleMenuBtn.Size = UDim2.new(0, 125, 0, 40)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.Text = "🔥 kiên 94 Hub"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ToggleMenuBtn.TextSize = 13
ToggleMenuBtn.ZIndex = 10

local TBtnCorner = Instance.new("UICorner")
TBtnCorner.CornerRadius = UDim.new(0, 10)
TBtnCorner.Parent = ToggleMenuBtn

local TBtnStroke = Instance.new("UIStroke")
TBtnStroke.Color = Color3.fromRGB(255, 50, 50)
TBtnStroke.Transparency = 0.2
TBtnStroke.Thickness = 2
TBtnStroke.Parent = ToggleMenuBtn

-- Khung chính Menu (Glassmorphism Đỏ Ruby cực đẹp)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 12, 12)
MainFrame.BackgroundTransparency = 0.25
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
UIStroke.Color = Color3.fromRGB(255, 60, 60)
UIStroke.Transparency = 0.3
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Font = Enum.Font.GothamBold
Title.Text = "👑 KIÊN 94 HUB PRO MAX 👑"
Title.TextColor3 = Color3.fromRGB(255, 90, 90)
Title.TextSize = 14
Title.ZIndex = 6

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
Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
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
Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
Tab3Btn.Position = UDim2.new(0.68, 0, 0, 0)
Tab3Btn.Size = UDim2.new(0.32, 0, 1, 0)
Tab3Btn.Font = Enum.Font.GothamBold
Tab3Btn.Text = "Fit Lag Map"
Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
Tab3Btn.TextSize = 10
Tab3Btn.ZIndex = 6
local T3C = Instance.new("UICorner") T3C.CornerRadius = UDim.new(0, 6) T3C.Parent = Tab3Btn

-- Container Tab 1 (Auto Soul)
local Tab1Container = Instance.new("Frame")
Tab1Container.Parent = MainFrame
Tab1Container.BackgroundTransparency = 1
Tab1Container.Position = UDim2.new(0.05, 0, 0.28, 0)
Tab1Container.Size = UDim2.new(0.9, 0, 0.68, 0)
Tab1Container.ZIndex = 6

local AutoSoulBtn = Instance.new("TextButton")
AutoSoulBtn.Parent = Tab1Container
AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AutoSoulBtn.BackgroundTransparency = 0.2
AutoSoulBtn.Size = UDim2.new(1, 0, 0, 45)
AutoSoulBtn.Font = Enum.Font.GothamBold
AutoSoulBtn.Text = "Auto Soul (Smart Blacklist): OFF"
AutoSoulBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSoulBtn.TextSize = 11
AutoSoulBtn.ZIndex = 6
local ASCorner = Instance.new("UICorner") ASCorner.CornerRadius = UDim.new(0, 8) ASCorner.Parent = AutoSoulBtn

local SoulStatus = Instance.new("TextLabel")
SoulStatus.Parent = Tab1Container
SoulStatus.BackgroundTransparency = 1
SoulStatus.Position = UDim2.new(0, 0, 0.5, 0)
SoulStatus.Size = UDim2.new(1, 0, 0.4, 0)
SoulStatus.Font = Enum.Font.Gotham
SoulStatus.Text = "Trạng thái: Camera cố định, quét linh hồn thông minh."
SoulStatus.TextColor3 = Color3.fromRGB(220, 180, 180)
SoulStatus.TextSize = 11
SoulStatus.TextWrapped = true
SoulStatus.TextYAlignment = Enum.TextYAlignment.Top
SoulStatus.ZIndex = 6

-- Container Tab 2 (Hop Server)
local Tab2Container = Instance.new("Frame")
Tab2Container.Parent = MainFrame
Tab2Container.BackgroundTransparency = 1
Tab2Container.Position = UDim2.new(0.05, 0, 0.28, 0)
Tab2Container.Size = UDim2.new(0.9, 0, 0.68, 0)
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

-- Container Tab 3 (Fit Lag Xóa Map Trong Suốt)
local Tab3Container = Instance.new("Frame")
Tab3Container.Parent = MainFrame
Tab3Container.BackgroundTransparency = 1
Tab3Container.Position = UDim2.new(0.05, 0, 0.28, 0)
Tab3Container.Size = UDim2.new(0.9, 0, 0.68, 0)
Tab3Container.Visible = false
Tab3Container.ZIndex = 6

local FitLagBtn = Instance.new("TextButton")
FitLagBtn.Parent = Tab3Container
FitLagBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
FitLagBtn.BackgroundTransparency = 0.2
FitLagBtn.Size = UDim2.new(1, 0, 0, 45)
FitLagBtn.Font = Enum.Font.GothamBold
FitLagBtn.Text = "Fit Lag Xóa Map Trong Suốt: OFF"
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
FitLagDesc.Text = "Tự động làm trong suốt map liên tục theo thời gian thực (giữ nguyên linh hồn và đứng được)."
FitLagDesc.TextColor3 = Color3.fromRGB(220, 180, 180)
FitLagDesc.TextSize = 11
FitLagDesc.TextWrapped = true
FitLagDesc.TextYAlignment = Enum.TextYAlignment.Top
FitLagDesc.ZIndex = 6

-- Chuyển Tab Logic
Tab1Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = true Tab2Container.Visible = false Tab3Container.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab2Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = false Tab2Container.Visible = true Tab3Container.Visible = false
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab1Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab3Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

Tab3Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = false Tab2Container.Visible = false Tab3Container.Visible = true
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) Tab3Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab1Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(45, 20, 20) Tab2Btn.TextColor3 = Color3.fromRGB(220, 150, 150)
end)

-- HIỆU ỨNG MỞ MENU SIÊU CẤP VIP PRO (Neon Glow, Scale & Spin mượt mà)
local menuOpen = false
ToggleMenuBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Rotation = -180
        
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 290, 0, 240),
            Rotation = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()

        TweenService:Create(ToggleMenuBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 130, 0, 42)
        }):Play()
        task.wait(0.15)
        TweenService:Create(ToggleMenuBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 125, 0, 40)
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

-- Xử lý Auto Soul
AutoSoulBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.AutoSoul = not getgenv().kienConfig.AutoSoul
    if getgenv().kienConfig.AutoSoul then
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
        AutoSoulBtn.Text = "Auto Soul (Smart Blacklist): ON"
        SoulStatus.Text = "Trạng thái: Đang chạy ẩn danh (Camera cố định)..."
    else
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AutoSoulBtn.Text = "Auto Soul (Smart Blacklist): OFF"
        SoulStatus.Text = "Trạng thái: Đã dừng hoạt động."
        camera.CameraType = Enum.CameraType.Custom
    end
end)

-- Xử lý Hop Server
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

-- Xử lý Fit Lag Xóa Map Trong Suốt (Chạy liên tục theo thời gian thực chống StreamingEnabled tải lại map)
FitLagBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.FitLag = not getgenv().kienConfig.FitLag
    if getgenv().kienConfig.FitLag then
        FitLagBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
        FitLagBtn.Text = "Fit Lag Xóa Map Trong Suốt: ON"
    else
        FitLagBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        FitLagBtn.Text = "Fit Lag Xóa Map Trong Suốt: OFF"
    end
end)

-- Vòng lặp Real-time Fit Lag (Tự động xóa/làm trong suốt mọi map mới tải ra liên tục)
task.spawn(function()
    while true do
        task.wait(1)
        if getgenv().kienConfig.FitLag then
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.Brightness = 1
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
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then 
                        v.Enabled = false 
                    end
                end
            end)
        end
    end
end)

-- Vòng lặp Auto Farm thông minh với Smart Blacklist & Khóa Camera
task.spawn(function()
    local lockedCameraCF = nil
    local isLockedCam = false
    local blacklist = {} -- Danh sách đen lưu linh hồn đã nhặt hoặc biến mất

    while true do
        task.wait(getgenv().kienConfig.Delay)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul and remote then
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

                    -- Dọn dẹp danh sách đen định kỳ các linh hồn đã biến mất khỏi map
                    for obj, _ in pairs(blacklist) do
                        if not obj or not obj.Parent then
                            blacklist[obj] = nil
                        end
                    end

                    -- Quét toàn bộ map tìm linh hồn
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
                                    -- Kiểm tra né người chơi khác (bán kính 10m)
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
                        -- Thêm ngay vào danh sách đen để không bao giờ tele lại cục đã nhặt/biến mất
                        blacklist[bestTarget.instance] = true

                        -- Teleport đến linh hồn
                        hrp.CFrame = CFrame.new(bestTarget.position + Vector3.new(0, 2, 0))
                        
                        -- Gửi lệnh nhặt lên server
                        local args = {
                            "GraveyardSoul",
                            {
                                a = "soul",
                                gen = 370,
                                at = vector.create(bestTarget.position.X, bestTarget.position.Y, bestTarget.position.Z),
                                slot = 129
                            }
                        }
                        remote:FireServer(unpack(args))
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
