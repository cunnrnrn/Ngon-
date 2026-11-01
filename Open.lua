--[[
    Script Name: kiên 94 Hub Pro Max (Part 1 - Ultra Glassmorphic Edition)
    Features: Slide-to-Open Dragon 'K' Button + Super Transparent Glass UI + Tabbed Navigation
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera
local remote = ReplicatedStorage:WaitForChild("RideADinoNet", 5)

-- Anti-AFK
local antiAfkConn = player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

getgenv().kienConfig = {
    AutoSoul = false,
    FitLag = false,
    Delay = 0.008,
    SafeDistance = 12
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

-- Nút Trượt Ngang Bật/Tắt Menu (Slide Toggle) ở góc trái trên cùng
local ToggleSlider = Instance.new("Frame")
ToggleSlider.Name = "ToggleSlider"
ToggleSlider.Parent = ScreenGui
ToggleSlider.BackgroundColor3 = Color3.fromRGB(20, 5, 5)
ToggleSlider.BackgroundTransparency = 0.4
ToggleSlider.Position = UDim2.new(0, 15, 0, 15)
ToggleSlider.Size = UDim2.new(0, 130, 0, 42)
ToggleSlider.ZIndex = 10

local TSliderCorner = Instance.new("UICorner")
TSliderCorner.CornerRadius = UDim.new(0, 21)
TSliderCorner.Parent = ToggleSlider

local TSliderStroke = Instance.new("UIStroke")
TSliderStroke.Color = Color3.fromRGB(255, 50, 50)
TSliderStroke.Transparency = 0.2
TSliderStroke.Thickness = 2
TSliderStroke.Parent = ToggleSlider

-- Thanh trượt (Knob) mang hình tượng Rồng [ K ]
local Knob = Instance.new("TextButton")
Knob.Name = "Knob"
Knob.Parent = ToggleSlider
Knob.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
Knob.Position = UDim2.new(0, 3, 0, 3)
Knob.Size = UDim2.new(0, 50, 0, 36)
Knob.Font = Enum.Font.GothamBold
Knob.Text = "🐉 K"
Knob.TextColor3 = Color3.fromRGB(255, 255, 255)
Knob.TextSize = 12
Knob.ZIndex = 11

local KnobCorner = Instance.new("UICorner")
KnobCorner.CornerRadius = UDim.new(0, 18)
KnobCorner.Parent = Knob

-- Khung chính Menu (Siêu trong suốt Glassmorphism Đỏ Ruby)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
MainFrame.BackgroundTransparency = 0.35
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

-- Tiêu đề Menu & Nút phụ
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 8)
Title.Size = UDim2.new(0.65, 0, 0, 28)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ KIÊN 94 DRAGON HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 90, 90)
Title.TextSize = 12
Title.ZIndex = 6

-- Nút Thu Gọn Menu
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 20)
MinimizeBtn.BackgroundTransparency = 0.3
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
DestroyBtn.BackgroundTransparency = 0.3
DestroyBtn.Position = UDim2.new(0.84, 0, 0, 8)
DestroyBtn.Size = UDim2.new(0, 38, 0, 26)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.Text = "Xóa"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.TextSize = 11
DestroyBtn.ZIndex = 6
local DesCorner = Instance.new("UICorner") DesCorner.CornerRadius = UDim.new(0, 6) DesCorner.Parent = DestroyBtn

-- Thanh Tab
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
AutoSoulBtn.Size = UDim2.new(1, 0, 0, 48)
AutoSoulBtn.Font = Enum.Font.GothamBold
AutoSoulBtn.Text = "Auto Soul (Teleport Khám Phá): OFF"
AutoSoulBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSoulBtn.TextSize = 11
AutoSoulBtn.ZIndex = 6
local ASCorner = Instance.new("UICorner") ASCorner.CornerRadius = UDim.new(0, 8) ASCorner.Parent = AutoSoulBtn

local SoulStatus = Instance.new("TextLabel")
SoulStatus.Parent = Tab1Container
SoulStatus.BackgroundTransparency = 1
SoulStatus.Position = UDim2.new(0, 0, 0.45, 0)
SoulStatus.Size = UDim2.new(1, 0, 0.5, 0)
SoulStatus.Font = Enum.Font.Gotham
SoulStatus.Text = "Trạng thái: Farm mượt mà, bạn thoải mái chạy đi khám phá map."
SoulStatus.TextColor3 = Color3.fromRGB(220, 180, 180)
SoulStatus.TextSize = 11
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
FitLagDesc.Text = "Xóa hiệu ứng, làm mờ map trong suốt mượt mà."
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

-- LOGIC TRƯỢT NGANG NÚT BẬT/TẮT MENU (Slide Toggle)
local menuOpen = false
local dragging = false
local dragStart = 0
local startPos = 0

Knob.MouseButton1Down:Connect(function(inputX)
    dragging = true
    dragStart = UserInputService:GetMouseLocation().X
    startPos = Knob.Position.X.Offset
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false
            local currentX = Knob.Position.X.Offset
            if currentX > 35 then
                -- Kéo sang phải -> Mở Menu
                menuOpen = true
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 77, 0, 3)}):Play()
                MainFrame.Visible = true
                MainFrame.Size = UDim2.new(0, 0, 0, 0)
                MainFrame.Rotation = -180
                TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 290, 0, 230),
                    Rotation = 0,
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play()
            else
                -- Kéo về trái -> Đóng Menu
                menuOpen = false
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0, 3)}):Play()
                local tw = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Rotation = 180
                })
                tw:Play()
                tw.Completed:Connect(function()
                    if not menuOpen then MainFrame.Visible = false end
                end)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mouseX = UserInputService:GetMouseLocation().X
        local delta = mouseX - dragStart
        local newX = math.clamp(startPos + delta, 3, 77)
        Knob.Position = UDim2.new(0, newX, 0, 3)
    end
end)

-- Nút Thu Gọn Menu
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Tab1Container.Visible = not isMinimized
    Tab2Container.Visible = false
    Tab3Container.Visible = false
    TabBar.Visible = not isMinimized
    MinimizeBtn.Text = isMinimized and "Hiện" or "Ẩn"
    
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = isMinimized and UDim2.new(0, 290, 0, 50) or UDim2.new(0, 290, 0, 230)
    }):Play()
end)

-- Nút Xóa Vĩnh Viễn Script
DestroyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        getgenv().kienConfig.AutoSoul = false
        getgenv().kienConfig.FitLag = false
        if antiAfkConn then antiAfkConn:Disconnect() end
        ScreenGui:Destroy()
    end)
end)

-- Xử lý Auto Soul (Ghi nhớ vị trí khi bật, tự về chỗ cũ khi tắt, cho phép bạn đi khám phá map thoải mái)
AutoSoulBtn.MouseButton1Click:Connect(function()
    getgenv().kienConfig.AutoSoul = not getgenv().kienConfig.AutoSoul
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if getgenv().kienConfig.AutoSoul then
        if hrp then
            getgenv().kienConfig.OriginCFrame = hrp.CFrame
        end
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
        AutoSoulBtn.Text = "Auto Soul (Khám Phá): ON"
        SoulStatus.Text = "Trạng thái: Đang farm ẩn danh, bạn có thể tự do chạy đi chơi!"
    else
        AutoSoulBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        AutoSoulBtn.Text = "Auto Soul (Khám Phá): OFF"
        SoulStatus.Text = "Trạng thái: Đã tắt, đang về chỗ cũ..."

        if hrp and getgenv().kienConfig.OriginCFrame then
            hrp.CFrame = getgenv().kienConfig.OriginCFrame
            task.wait(0.2)
            SoulStatus.Text = "Trạng thái: Đã về lại chỗ cũ an toàn."
        end
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

-- Vòng lặp Fit Lag
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

-- Vòng lặp Auto Farm Teleport chuẩn xác tuyệt đối (Không bị lơ lửng, hạ xuống lượm ngay lập tức)
task.spawn(function()
    local blacklist = {}

    while true do
        task.wait(getgenv().kienConfig.Delay)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul and remote then
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
                                local p = Players:GetPlayerFromCharacter(ancestor)
                                if p and p ~= player then
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
                        
                        -- TELEPORT CHUẨN XÁC: Đặt chân đúng ngay sát linh hồn (Cộng thêm 1.5 đơn vị chiều cao để không bị chìm hay lơ lửng)
                        hrp.CFrame = CFrame.new(bestTarget.position + Vector3.new(0, 1.5, 0))
                        
                        -- Gửi lệnh nhặt siêu tốc
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
                    else
                        task.wait(0.1)
                    end
                end)
            else
                blacklist = {}
            end
        end
    end
end)
