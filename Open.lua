--[[
    Script Name: √12kientomato Hub Pro Max - Ultimate Clean Edition
    Features: Ultra Transparent Glassmorphism UI + Only Logo [K] Toggle + Soul Reader + Auto Home Toggle + Fit Lag + Hop Server
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
local remote = ReplicatedStorage:WaitForChild("RideADinoNet", 5)

-- Tọa độ nhà cố định của Kiên
local HOME_CFRAME = CFrame.new(-0.19, 22.22, -2791.91)

getgenv().kienConfig = {
    AutoSoul = false,
    AutoReturnHome = true,
    FitLag = false,
    RequiredSouls = 500,
    SessionSouls = 0
}

-- Anti-AFK
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Xóa sạch sẽ toàn bộ GUI rác/cũ trước đó
for _, gui in pairs(playerGui:GetChildren()) do
    if gui.Name == "kien_94_NativeHub" or gui.Name == "kien_94_GUI" or gui.Name == "KienGetPosGUI" or gui.Name == "√12kientomato_GUI" then
        gui:Destroy()
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "kien_94_NativeHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Nút Bật/Tắt Menu: Duy nhất 1 nút Logo Rồng [ K ] siêu gọn nằm sát góc trái trên cùng cạnh Roblox Logo
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 5, 5)
ToggleBtn.BackgroundTransparency = 0.3
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.Size = UDim2.new(0, 110, 0, 38)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "🐉 [ K ]"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.TextSize = 13
ToggleBtn.ZIndex = 10

local TBtnCorner = Instance.new("UICorner")
TBtnCorner.CornerRadius = UDim.new(0, 10)
TBtnCorner.Parent = ToggleBtn

local TBtnStroke = Instance.new("UIStroke")
TBtnStroke.Color = Color3.fromRGB(255, 50, 50)
TBtnStroke.Transparency = 0.2
TBtnStroke.Thickness = 2
TBtnStroke.Parent = ToggleBtn

-- Khung Menu Chính (Glassmorphism Siêu Trong Suốt Đỏ Ruby)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 3, 3)
MainFrame.BackgroundTransparency = 0.35
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 310, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.ZIndex = 5

local MCorner = Instance.new("UICorner")
MCorner.CornerRadius = UDim.new(0, 16)
MCorner.Parent = MainFrame

local MStroke = Instance.new("UIStroke")
MStroke.Color = Color3.fromRGB(255, 60, 60)
MStroke.Transparency = 0.3
MStroke.Thickness = 2
MStroke.Parent = MainFrame

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 8)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ KIÊN 94 DRAGON HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 90, 90)
Title.TextSize = 12
Title.ZIndex = 6

-- Nút đóng Menu (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Position = UDim2.new(1, -35, 0, 8)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 11
CloseBtn.ZIndex = 6
local CBCorner = Instance.new("UICorner") CBCorner.CornerRadius = UDim.new(0, 6) CBCorner.Parent = CloseBtn

-- Thanh chứa các tính năng
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.04, 0, 0.18, 0)
TabContainer.Size = UDim2.new(0.92, 0, 0.78, 0)
TabContainer.CanvasSize = UDim2.new(0, 0, 1.4, 0)
TabContainer.ScrollBarThickness = 3
TabContainer.ZIndex = 6

local UIList = Instance.new("UIListLayout")
UIList.Parent = TabContainer
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)

-- Hàm tạo Nút Bật/Tắt (Toggle) mượt mà
local function createToggle(name, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    btn.BackgroundTransparency = 0.25
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.ZIndex = 6
    local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 8) bCorner.Parent = btn
    
    local state = defaultState
    local function updateText()
        btn.Text = name .. ": " .. (state and "ON [BẬT]" : "OFF [TẮT]")
        btn.BackgroundColor3 = state and Color3.fromRGB(40, 160, 70) or Color3.fromRGB(160, 40, 40)
    end
    updateText()
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        updateText()
        callback(state)
    end)
    return btn
end

-- Hàm tạo Nút bấm thường (Button)
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    btn.BackgroundTransparency = 0.25
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.ZIndex = 6
    local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 8) bCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Nhãn trạng thái hiển thị số linh hồn quét từ màn hình
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = TabContainer
StatusLabel.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
StatusLabel.BackgroundTransparency = 0.3
StatusLabel.Size = UDim2.new(1, 0, 0, 38)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Đang quét số linh hồn trên màn hình..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
StatusLabel.TextSize = 10
StatusLabel.ZIndex = 6
local SLCorner = Instance.new("UICorner") SLCorner.CornerRadius = UDim.new(0, 8) SLCorner.Parent = StatusLabel

-- Thêm các tính năng vào Menu
createToggle("Auto Soul (Teleport Toàn Map)", false, function(v)
    getgenv().kienConfig.AutoSoul = v
end)

createToggle("Tự Động Về Nhà Khi Đủ 500 Hồn", true, function(v)
    getgenv().kienConfig.AutoReturnHome = v
end)

createToggle("Super Fit Lag Mạnh Nhất", false, function(v)
    getgenv().kienConfig.FitLag = v
end)

createButton("Đổi Server Ít Người (Ưu tiên 1 mình)", function()
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
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
        end
    end)
end)

-- Bật/Tắt Menu duy nhất qua nút Rồng [ K ] góc trái
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Hàm quét số linh hồn trực tiếp từ TextLabel trên màn hình (gần số tiền góc trái)
local function getScreenSoulCount()
    local count = 0
    pcall(function()
        for _, gui in pairs(playerGui:GetDescendants()) do
            if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                local text = gui.Text:lower()
                if text:find("soul") or text:find("hồn") or (gui.Position.X.Scale == 0 and gui.Position.Y.Scale > 0.7) then
                    local numbers = text:match("%d+")
                    if numbers then
                        local val = tonumber(numbers)
                        if val and val > count then
                            count = val
                        end
                    end
                end
            end
        end
    end)
    if count == 0 then
        count = getgenv().kienConfig.SessionSouls
    end
    return count
end

-- Vòng lặp cập nhật thông số màn hình
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local currentSouls = getScreenSoulCount()
            StatusLabel.Text = "Hồn trên màn hình: " .. tostring(currentSouls) .. " / 500"
        end)
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

-- Vòng lặp Auto Farm & Kiểm tra điều kiện về nhà
task.spawn(function()
    local blacklist = {}

    while true do
        task.wait(0.01)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul and remote then
                pcall(function()
                    -- Chỉ tele về nhà khi bật tính năng AutoReturnHome
                    if getgenv().kienConfig.AutoReturnHome then
                        local currentSouls = getScreenSoulCount()
                        if currentSouls >= getgenv().kienConfig.RequiredSouls then
                            hrp.CFrame = HOME_CFRAME
                            task.wait(5) -- Đợi 5 giây
                            return
                        end
                    end

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
                                    local dist = (hrp.Position - pos).Magnitude
                                    if dist < shortestDist then
                                        shortestDist = dist
                                        bestTarget = {instance = obj, position = pos}
                                    end
                                end
                            end
                        end
                    end

                    if bestTarget then
                        blacklist[bestTarget.instance] = true
                        hrp.CFrame = CFrame.new(bestTarget.position + Vector3.new(0, 1.5, 0))
                        
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
                        
                        getgenv().kienConfig.SessionSouls = getgenv().kienConfig.SessionSouls + 1
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
