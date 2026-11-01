local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

getgenv().kienRemote = nil
pcall(function()
    getgenv().kienRemote = ReplicatedStorage:FindFirstChild("RideADinoNet")
    if not getgenv().kienRemote then
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                getgenv().kienRemote = v
                break
            end
        end
    end
end)

getgenv().HOME_CFRAME = CFrame.new(-0.19, 22.22, -2791.91)

getgenv().kienConfig = {
    AutoSoul = false,
    AutoReturnHome = true,
    FitLag = false,
    RequiredSouls = 500,
    TeleportCount = 0
}

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local old = playerGui:FindFirstChild("KEY_Lop94")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KEY_Lop94"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.fromOffset(42, 42)
openBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
openBtn.Text = "K"
openBtn.TextColor3 = Color3.fromRGB(255, 48, 75)
openBtn.TextSize = 20
openBtn.Font = Enum.Font.GothamBlack
openBtn.AutoButtonColor = false
openBtn.ZIndex = 100
openBtn.Parent = gui

local obCorner = Instance.new("UICorner") obCorner.CornerRadius = UDim.new(0, 10) obCorner.Parent = openBtn
local obStroke = Instance.new("UIStroke") obStroke.Color = Color3.fromRGB(255, 48, 75) obStroke.Thickness = 2 obStroke.Parent = openBtn

local btnDragging, btnDragStart, btnStartPos = false, nil, nil
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true btnDragStart = input.Position btnStartPos = openBtn.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        openBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then btnDragging = false end
end)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.fromOffset(480, 300)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
main.BorderSizePixel = 0
main.Visible = false
main.ClipsDescendants = true
main.Parent = gui

local mCorner = Instance.new("UICorner") mCorner.CornerRadius = UDim.new(0, 12) mCorner.Parent = main
local mStroke = Instance.new("UIStroke") mStroke.Color = Color3.fromRGB(255, 48, 75) mStroke.Thickness = 1.5 mStroke.Parent = main

local resizeBtn = Instance.new("TextButton")
resizeBtn.Name = "ResizeBtn"
resizeBtn.Size = UDim2.fromOffset(20, 20)
resizeBtn.Position = UDim2.new(1, -20, 1, -20)
resizeBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
resizeBtn.Text = "⇲"
resizeBtn.TextColor3 = Color3.fromRGB(255, 48, 75)
resizeBtn.TextSize = 12
resizeBtn.Font = Enum.Font.GothamBold
resizeBtn.ZIndex = 50
resizeBtn.Parent = main
local rsCorner = Instance.new("UICorner") rsCorner.CornerRadius = UDim.new(0, 4) rsCorner.Parent = resizeBtn

local resizing, resizeStart, startSize = false, nil, nil
resizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true resizeStart = input.Position startSize = main.Size
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newX = math.clamp(startSize.X.Offset + delta.X, 320, 800)
        local newY = math.clamp(startSize.Y.Offset + delta.Y, 220, 600)
        main.Size = UDim2.fromOffset(newX, newY)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then resizing = false end
end)

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 45)
top.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
top.BorderSizePixel = 0
top.Parent = main

local line = Instance.new("Frame")
line.Position = UDim2.new(0, 0, 1, -2)
line.Size = UDim2.new(1, 0, 0, 2)
line.BackgroundColor3 = Color3.fromRGB(255, 48, 75)
line.BorderSizePixel = 0
line.Parent = top

local title = Instance.new("TextLabel")
title.Position = UDim2.new(0, 12, 0, 6)
title.Size = UDim2.new(0, 350, 0, 18)
title.BackgroundTransparency = 1
title.Text = "KIÊN LỚP 94 — THCS NGUYỄN VĂN BÁNH"
title.TextColor3 = Color3.fromRGB(245, 245, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBlack
title.TextSize = 12
title.Parent = top

local subTitle = Instance.new("TextLabel")
subTitle.Position = UDim2.new(0, 12, 0, 24)
subTitle.Size = UDim2.new(0, 300, 0, 14)
subTitle.BackgroundTransparency = 1
subTitle.Text = "BLACK NEBULA  •  RADAR TELEPORT ENGINE"
subTitle.TextColor3 = Color3.fromRGB(145, 145, 160)
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Font = Enum.Font.GothamMedium
subTitle.TextSize = 8
subTitle.Parent = top

local closeBtn = Instance.new("TextButton")
closeBtn.Position = UDim2.new(1, -32, 0, 8)
closeBtn.Size = UDim2.fromOffset(24, 24)
closeBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 48, 75)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.AutoButtonColor = false
closeBtn.Parent = top
local cbCorner = Instance.new("UICorner") cbCorner.CornerRadius = UDim.new(0, 6) cbCorner.Parent = closeBtn

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.new(0, 0, 0, 45)
sidebar.Size = UDim2.new(0, 120, 1, -45)
sidebar.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sbList = Instance.new("UIListLayout") sbList.Padding = UDim.new(0, 6) sbList.SortOrder = Enum.SortOrder.LayoutOrder sbList.Parent = sidebar
local sbPadding = Instance.new("UIPadding") sbPadding.PaddingTop = UDim.new(0, 10) sbPadding.PaddingLeft = UDim.new(0, 8) sbPadding.PaddingRight = UDim.new(0, 8) sbPadding.Parent = sidebar

local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Position = UDim2.new(0, 120, 0, 45)
contentArea.Size = UDim2.new(1, -120, 1, -45)
contentArea.BackgroundTransparency = 1
contentArea.Parent = main

openBtn.Activated:Connect(function() main.Visible = not main.Visible end)
closeBtn.Activated:Connect(function() main.Visible = false end)

local winDragging, winDragStart, winStartPos = false, nil, nil
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        winDragging = true winDragStart = input.Position winStartPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if winDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - winDragStart
        main.Position = UDim2.new(winStartPos.X.Scale, winStartPos.X.Offset + delta.X, winStartPos.Y.Scale, winStartPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then winDragging = false end
end)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("KEY_Lop94")
local mainFrame = mainGui:WaitForChild("Main")
local sidebar = mainFrame:WaitForChild("Sidebar")
local contentArea = mainFrame:WaitForChild("ContentArea")

local function createTabFrame(name)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = name .. "_Frame"
    scroll.Position = UDim2.new(0, 10, 0, 10)
    scroll.Size = UDim2.new(1, -20, 1, -20)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 48, 75)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Visible = false
    scroll.Parent = contentArea

    local layout = Instance.new("UIListLayout") layout.Padding = UDim.new(0, 8) layout.SortOrder = Enum.SortOrder.LayoutOrder layout.Parent = scroll
    return scroll
end

local tabFarmFrame = createTabFrame("FARM")
local tabLagFrame = createTabFrame("LAG")
local tabInfoFrame = createTabFrame("INFO")

local function addToggle(parent, name, desc, defaultState, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 52)
    card.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    card.BorderSizePixel = 0
    card.Parent = parent

    local cc = Instance.new("UICorner") cc.CornerRadius = UDim.new(0, 8) cc.Parent = card
    local cs = Instance.new("UIStroke") cs.Color = Color3.fromRGB(120, 20, 40) cs.Thickness = 1 cs.Transparency = 0.3 cs.Parent = card

    local t1 = Instance.new("TextLabel")
    t1.Position = UDim2.new(0, 10, 0, 8) t1.Size = UDim2.new(1, -60, 0, 16)
    t1.BackgroundTransparency = 1 t1.Text = name t1.TextColor3 = Color3.fromRGB(245, 245, 250)
    t1.TextXAlignment = Enum.TextXAlignment.Left t1.Font = Enum.Font.GothamBold t1.TextSize = 11 t1.Parent = card

    local t2 = Instance.new("TextLabel")
    t2.Position = UDim2.new(0, 10, 0, 26) t2.Size = UDim2.new(1, -60, 0, 18)
    t2.BackgroundTransparency = 1 t2.Text = desc t2.TextColor3 = Color3.fromRGB(145, 145, 160)
    t2.TextXAlignment = Enum.TextXAlignment.Left t2.Font = Enum.Font.Gotham t2.TextSize = 9 t2.TextWrapped = true t2.Parent = card

    local switch = Instance.new("TextButton")
    switch.AnchorPoint = Vector2.new(1, 0.5) switch.Position = UDim2.new(1, -10, 0.5, 0)
    switch.Size = UDim2.fromOffset(36, 18)
    switch.BackgroundColor3 = defaultState and Color3.fromRGB(255, 48, 75) or Color3.fromRGB(55, 55, 66)
    switch.Text = "" switch.AutoButtonColor = false switch.Parent = card
    local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 9) sc.Parent = switch

    local knob = Instance.new("Frame")
    knob.Position = defaultState and UDim2.new(1, -16, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    knob.Size = UDim2.fromOffset(12, 12) knob.BackgroundColor3 = Color3.fromRGB(245, 245, 250) knob.BorderSizePixel = 0 knob.Parent = switch
    local kc = Instance.new("UICorner") kc.CornerRadius = UDim.new(0, 6) kc.Parent = knob

    local state = defaultState
    switch.Activated:Connect(function()
        state = not state
        switch.BackgroundColor3 = state and Color3.fromRGB(255, 48, 75) or Color3.fromRGB(55, 55, 66)
        knob.Position = state and UDim2.new(1, -16, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        callback(state)
    end)
end

local function addButton(parent, name, desc, btnText, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 52)
    card.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    card.BorderSizePixel = 0
    card.Parent = parent

    local cc = Instance.new("UICorner") cc.CornerRadius = UDim.new(0, 8) cc.Parent = card
    local cs = Instance.new("UIStroke") cs.Color = Color3.fromRGB(120, 20, 40) cs.Thickness = 1 cs.Transparency = 0.3 cs.Parent = card

    local t1 = Instance.new("TextLabel")
    t1.Position = UDim2.new(0, 10, 0, 8) t1.Size = UDim2.new(1, -90, 0, 16)
    t1.BackgroundTransparency = 1 t1.Text = name t1.TextColor3 = Color3.fromRGB(245, 245, 250)
    t1.TextXAlignment = Enum.TextXAlignment.Left t1.Font = Enum.Font.GothamBold t1.TextSize = 11 t1.Parent = card

    local t2 = Instance.new("TextLabel")
    t2.Position = UDim2.new(0, 10, 0, 26) t2.Size = UDim2.new(1, -90, 0, 18)
    t2.BackgroundTransparency = 1 t2.Text = desc t2.TextColor3 = Color3.fromRGB(145, 145, 160)
    t2.TextXAlignment = Enum.TextXAlignment.Left t2.Font = Enum.Font.Gotham t2.TextSize = 9 t2.TextWrapped = true t2.Parent = card

    local action = Instance.new("TextButton")
    action.AnchorPoint = Vector2.new(1, 0.5) action.Position = UDim2.new(1, -10, 0.5, 0)
    action.Size = UDim2.fromOffset(70, 24) action.BackgroundColor3 = Color3.fromRGB(120, 20, 40)
    action.Text = btnText action.TextColor3 = Color3.fromRGB(245, 245, 250) action.Font = Enum.Font.GothamBold action.TextSize = 8 action.Parent = card
    local ac = Instance.new("UICorner") ac.CornerRadius = UDim.new(0, 6) ac.Parent = action

    action.Activated:Connect(callback)
end

local tabButtons = {}
local function switchTab(tabName, frame)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
        btn.TextColor3 = Color3.fromRGB(145, 145, 160)
    end
    for _, child in pairs(contentArea:GetChildren()) do
        if child:IsA("ScrollingFrame") then child.Visible = false end
    end
    tabButtons[tabName].BackgroundColor3 = Color3.fromRGB(120, 20, 40)
    tabButtons[tabName].TextColor3 = Color3.fromRGB(245, 245, 250)
    frame.Visible = true
end

local function addTabButton(name, frame, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(145, 145, 160)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    btn.Parent = sidebar
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 6) bc.Parent = btn

    tabButtons[name] = btn
    btn.Activated:Connect(function() switchTab(name, frame) end)
end

addTabButton("⚡ FARM", tabFarmFrame, 1)
addTabButton("🚀 FIT LAG", tabLagFrame, 2)
addTabButton("📌 THÔNG TIN", tabInfoFrame, 3)

local counterLabel = Instance.new("TextLabel")
counterLabel.Size = UDim2.new(1, -4, 0, 28)
counterLabel.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
counterLabel.Text = "Số lần Teleport linh hồn: 0 / 500"
counterLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
counterLabel.Font = Enum.Font.GothamBold
counterLabel.TextSize = 10
counterLabel.Parent = tabFarmFrame
local clCorner = Instance.new("UICorner") clCorner.CornerRadius = UDim.new(0, 6) clCorner.Parent = counterLabel

addToggle(tabFarmFrame, "Auto Radar Teleport Soul", "Quét radar & bỏ qua linh hồn đã nhặt.", false, function(v)
    getgenv().kienConfig.AutoSoul = v
end)

addToggle(tabFarmFrame, "Về Nhà Khi Đủ 500 Lần Tele", "Chạy đủ 500 lần tele nhặt soul sẽ tự về nhà.", true, function(v)
    getgenv().kienConfig.AutoReturnHome = v
end)

addToggle(tabLagFrame, "Super Fit Lag Mạnh Nhất", "Xóa hiệu ứng đồ họa nhẹ máy Realme.", false, function(v)
    getgenv().kienConfig.FitLag = v
end)

addButton(tabLagFrame, "Đổi Server Ít Người", "Chuyển sang server vắng một mình.", "THỰC HIỆN", function()
    pcall(function()
        local servers = {}
        local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        if req and req.data then
            for _, s in pairs(req.data) do
                if type(s) == "table" and s.playing and s.maxPlayers and s.id then
                    if s.playing < s.maxPlayers and s.id ~= game.JobId then table.insert(servers, s.id) end
                end
            end
        end
        if #servers > 0 then TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player) end
    end)
end)

addButton(tabInfoFrame, "Chủ Script: Trương Trọng Kiên", "Lớp 9 - THCS Nguyễn Văn Bánh", "OK", function() end)
addButton(tabInfoFrame, "Tọa Độ Nhà", "CFrame.new(-0.19, 22.22, -2791.91)", "OK", function() end)

switchTab("⚡ FARM", tabFarmFrame)

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
                if Terrain then Terrain.WaterWaveSize = 0 Terrain.WaterTransparency = 1 end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local isSoul = (v.Name == "GraveyardSoul" or v.Name:lower():find("soul"))
                        local isPlayerPart = v:IsDescendantOf(player.Character or workspace)
                        if not isSoul and not isPlayerPart then v.Transparency = 0.85 v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false end
                end
            end)
        end
    end
end)

-- VÒNG LẶP TELEPORT TỨC THÌ CÓ BLACKLIST (DANH SÁCH ĐEN BỎ QUA SOUL ĐÃ NHẶT)
task.spawn(function()
    local blacklist = {}

    while true do
        task.wait(0.001)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul then
                pcall(function()
                    if getgenv().kienConfig.AutoReturnHome and getgenv().kienConfig.TeleportCount >= getgenv().kienConfig.RequiredSouls then
                        hrp.CFrame = getgenv().HOME_CFRAME
                        counterLabel.Text = "ĐẢ ĐỦ 500 LẦN TELE! ĐÃ VỀ NHÀ."
                        task.wait(5)
                        return
                    end

                    -- Tự dọn dẹp danh sách đen nếu linh hồn không còn tồn tại trên map
                    for obj, _ in pairs(blacklist) do
                        if not obj or not obj.Parent then
                            blacklist[obj] = nil
                        end
                    end

                    local bestTarget = nil
                    local shortestDist = math.huge

                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().kienConfig.AutoSoul then break end
                        
                        -- Kiểm tra nếu đúng tên linh hồn VÀ CHƯA CÓ TRONG DANH SÁCH ĐEN
                        if (obj.Name == "GraveyardSoul" or obj.Name:lower():find("soul")) and not blacklist[obj] then
                            local isPlayerRelated = false
                            local ancestor = obj.Parent
                            while ancestor and ancestor ~= workspace do
                                local p = Players:GetPlayerFromCharacter(ancestor)
                                if p and p ~= player then isPlayerRelated = true break end
                                ancestor = ancestor.Parent
                            end

                            if not isPlayerRelated then
                                local pos = nil
                                if obj:IsA("BasePart") then pos = obj.Position
                                elseif obj:IsA("Model") and obj.PrimaryPart then pos = obj.PrimaryPart.Position
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

                    if bestTarget and bestTarget.position then
                        -- LƯU LINH HỒN NÀY VÀO BLACKLIST ĐỂ BỎ QUA LẦN SAU
                        blacklist[bestTarget.instance] = true

                        -- TELEPORT TỨC THÌ ĐẾN VỊ TRÍ SOUL
                        hrp.CFrame = CFrame.new(bestTarget.position + Vector3.new(0, 1.5, 0))
                        
                        if getgenv().kienRemote then
                            local vecPos = (typeof(vector) == "table" and vector.create) and vector.create(bestTarget.position.X, bestTarget.position.Y, bestTarget.position.Z) or Vector3.new(bestTarget.position.X, bestTarget.position.Y, bestTarget.position.Z)
                            
                            local args = {
                                "GraveyardSoul",
                                {
                                    a = "soul",
                                    gen = 18,
                                    at = vecPos,
                                    slot = 23
                                }
                            }
                            
                            for i = 1, 3 do
                                getgenv().kienRemote:FireServer(unpack(args))
                            end
                        end
                        
                        getgenv().kienConfig.TeleportCount = getgenv().kienConfig.TeleportCount + 1
                        counterLabel.Text = "Số lần Teleport linh hồn: " .. tostring(getgenv().kienConfig.TeleportCount) .. " / 500"
                        task.wait(0.05)
                    else
                        -- Nếu không còn linh hồn mới chưa nhặt, reset danh sách đen để quét lại lượt mới
                        blacklist = {}
                        task.wait(0.1)
                    end
                end)
            else
                blacklist = {}
                task.wait(0.1)
            end
        end
    end
end)
