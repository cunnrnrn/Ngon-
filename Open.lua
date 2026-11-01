--[[
    ================================================
    KEY | KIÊN LỚP 94 — TRƯỜNG THCS NGUYỄN VĂN BÁNH
    BLACK NEBULA — PART 1: UI & CONFIG
    ================================================
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remote Event RideADinoNet
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

-- Tọa độ nhà cố định
getgenv().HOME_CFRAME = CFrame.new(-0.19, 22.22, -2791.91)

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

local old = playerGui:FindFirstChild("KEY_Lop94")
if old then old:Destroy() end

local C = {
    Background = Color3.fromRGB(10, 10, 14),
    Panel = Color3.fromRGB(17, 17, 23),
    Card = Color3.fromRGB(24, 24, 32),
    Red = Color3.fromRGB(255, 48, 75),
    RedDark = Color3.fromRGB(120, 20, 40),
    White = Color3.fromRGB(245, 245, 250),
    Muted = Color3.fromRGB(145, 145, 160),
    Green = Color3.fromRGB(70, 230, 155),
}

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius or 10)}, parent)
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or C.Red,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parent)
end

local function tween(obj, duration, props)
    local t = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local gui = create("ScreenGui", {
    Name = "KEY_Lop94",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- FLOATING BUTTON K
local openButton = create("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 18, 0.5, -29),
    BackgroundColor3 = C.Background,
    Text = "K",
    TextColor3 = C.Red,
    TextSize = 27,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
}, gui)
round(openButton, 18)
stroke(openButton, C.Red, 2)

-- MAIN FRAME
local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(650, 420),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true,
}, gui)
round(main, 16)
stroke(main, C.Red, 1.5)

local scale = create("UIScale", {Scale = 1}, main)
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    scale.Scale = math.min(camera.ViewportSize.X / 690, camera.ViewportSize.Y / 460, 1)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

-- TOP BAR
local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 64),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
}, main)

create("Frame", {
    Position = UDim2.new(0, 0, 1, -2),
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0,
}, top)

local logo = create("Frame", {
    Position = UDim2.new(0, 17, 0.5, -19),
    Size = UDim2.fromOffset(38, 38),
    BackgroundColor3 = C.RedDark,
}, top)
round(logo, 12)
stroke(logo, C.Red, 1)

create("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "K",
    TextColor3 = C.White,
    Font = Enum.Font.GothamBlack,
    TextSize = 23,
}, logo)

create("TextLabel", {
    Position = UDim2.new(0, 65, 0, 8),
    Size = UDim2.new(0, 450, 0, 25),
    BackgroundTransparency = 1,
    Text = "KIÊN LỚP 94 — THCS NGUYỄN VĂN BÁNH",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    TextSize = 15,
}, top)

create("TextLabel", {
    Position = UDim2.new(0, 66, 0, 35),
    Size = UDim2.new(0, 350, 0, 17),
    BackgroundTransparency = 1,
    Text = "BLACK NEBULA  •  RADAR AUTO SOUL ENGINE",
    TextColor3 = C.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    TextSize = 9,
}, top)

local close = create("TextButton", {
    Position = UDim2.new(1, -45, 0, 15),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = C.Card,
    Text = "×",
    TextColor3 = C.Red,
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
}, top)
round(close, 9)

-- SIDEBAR & CONTENT
local sidebar = create("Frame", {
    Position = UDim2.new(0, 0, 0, 66),
    Size = UDim2.new(0, 155, 1, -66),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
}, main)

local navLayout = create("UIListLayout", {Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder}, sidebar)
create("UIPadding", {PaddingTop = UDim.new(0, 17), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, sidebar)

local content = create("Frame", {
    Position = UDim2.new(0, 155, 0, 66),
    Size = UDim2.new(1, -155, 1, -66),
    BackgroundTransparency = 1,
}, main)

local pageTitle = create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 15),
    Size = UDim2.new(1, -40, 0, 30),
    BackgroundTransparency = 1,
    Text = "AUTO FARM / RADAR SOUL",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
}, content)

local pageHint = create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 44),
    Size = UDim2.new(1, -40, 0, 20),
    BackgroundTransparency = 1,
    Text = "Quét Radar toàn map & tự về nhà khi đủ 500",
    TextColor3 = C.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    TextSize = 11,
}, content)

local pageBody = create("ScrollingFrame", {
    Position = UDim2.new(0, 15, 0, 75),
    Size = UDim2.new(1, -30, 1, -88),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Red,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

local bodyLayout = create("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, pageBody)

-- TOAST NOTIFY
local toast = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -12),
    Size = UDim2.fromOffset(270, 38),
    BackgroundColor3 = C.Card,
    TextColor3 = C.White,
    Text = "",
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    Visible = false,
    ZIndex = 10,
}, main)
round(toast, 10)
stroke(toast, C.Red, 1)

local toastVersion = 0
getgenv().notify = function(message)
    toastVersion += 1
    local version = toastVersion
    toast.Text = message
    toast.Visible = true
    toast.TextTransparency = 1
    tween(toast, 0.2, {TextTransparency = 0})
    task.delay(1.8, function()
        if toastVersion == version then
            tween(toast, 0.2, {TextTransparency = 1})
            task.wait(0.22)
            if toastVersion == version then toast.Visible = false end
        end
    end)
end

print(">>> [PART 1 LOADED SUCCESS] <<<")
--[[
    ================================================
    KEY | KIÊN LỚP 94 — TRƯỜNG THCS NGUYỄN VĂN BÁNH
    BLACK NEBULA — PART 2: RADAR & AUTO SOUL LOOP
    ================================================
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local pages = {
    FARM = {
        title = "AUTO FARM / RADAR SOUL",
        hint = "Quét Radar toàn map nhặt linh hồn liên tục không dừng",
        items = {
            {kind = "toggle", title = "Auto Soul (Radar Quét Toàn Map)", desc = "Tự động quét Radar và bay nhặt liên tục mọi linh hồn.", default = false},
            {kind = "toggle", title = "Tự Động Về Nhà Khi Đủ 500 Hồn", desc = "Đủ 500 hồn tự động tele về vị trí nhà.", default = true},
        },
    },
    VISUAL = {
        title = "VISUAL / FIT LAG",
        hint = "Tối ưu hóa đồ họa cực nhẹ cho Realme",
        items = {
            {kind = "toggle", title = "Super Fit Lag Mạnh Nhất", desc = "Giảm tải đồ họa tối đa giúp mượt game.", default = false},
            {kind = "button", title = "Đổi Server Ít Người (1 Mình)", desc = "Tìm và đổi sang server vắng người.", actionType = "hop"},
        },
    },
    INFO = {
        title = "INFO / CÁ NHÂN",
        hint = "Thông tin thương hiệu",
        items = {
            {kind = "info", title = "HỌC SINH", desc = "Trương Trọng Kiên • Lớp 9"},
            {kind = "info", title = "TRƯỜNG", desc = "THCS Nguyễn Văn Bánh"},
            {kind = "info", title = "TỌA ĐỘ NHÀ", desc = "CFrame.new(-0.19, 22.22, -2791.91)"},
        },
    },
}

local states = {}
local currentPage = "FARM"

local function clearBody()
    local pageBody = playerGui.KEY_Lop94.Main.Frame.ScrollingFrame
    for _, child in ipairs(pageBody:GetChildren()) do
        if child:IsA("GuiObject") and not child:IsA("UIListLayout") then child:Destroy() end
    end
end

local function makeCard(titleText, descText, height)
    local pageBody = playerGui.KEY_Lop94.Main.Frame.ScrollingFrame
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, height or 68)
    card.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    card.BorderSizePixel = 0
    card.Parent = pageBody
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = card
    local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(120, 20, 40) s.Thickness = 1 s.Transparency = 0.35 s.Parent = card

    local t1 = Instance.new("TextLabel")
    t1.Position = UDim2.new(0, 14, 0, 11) t1.Size = UDim2.new(1, -28, 0, 20)
    t1.BackgroundTransparency = 1 t1.Text = titleText t1.TextColor3 = Color3.fromRGB(245, 245, 250)
    t1.TextXAlignment = Enum.TextXAlignment.Left t1.Font = Enum.Font.GothamBold t1.TextSize = 12 t1.Parent = card

    local t2 = Instance.new("TextLabel")
    t2.Position = UDim2.new(0, 14, 0, 34) t2.Size = UDim2.new(1, -28, 0, 22)
    t2.BackgroundTransparency = 1 t2.Text = descText t2.TextColor3 = Color3.fromRGB(145, 145, 160)
    t2.TextXAlignment = Enum.TextXAlignment.Left t2.Font = Enum.Font.Gotham t2.TextSize = 10 t2.TextWrapped = true t2.Parent = card

    return card
end

local function addToggle(item)
    local card = makeCard(item.title, item.desc, 72)
    local key = currentPage .. "_" .. item.title
    if states[key] == nil then states[key] = item.default end

    local switch = Instance.new("TextButton")
    switch.AnchorPoint = Vector2.new(1, 0.5) switch.Position = UDim2.new(1, -13, 0.5, 0)
    switch.Size = UDim2.fromOffset(42, 23)
    switch.BackgroundColor3 = states[key] and Color3.fromRGB(255, 48, 75) or Color3.fromRGB(55, 55, 66)
    switch.Text = "" switch.AutoButtonColor = false switch.Parent = card
    local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 12) sc.Parent = switch

    local knob = Instance.new("Frame")
    knob.Position = states[key] and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8)
    knob.Size = UDim2.fromOffset(16, 16) knob.BackgroundColor3 = Color3.fromRGB(245, 245, 250) knob.BorderSizePixel = 0 knob.Parent = switch
    local kc = Instance.new("UICorner") kc.CornerRadius = UDim.new(0, 8) kc.Parent = knob

    switch.Activated:Connect(function()
        states[key] = not states[key]
        local enabled = states[key]
        switch.BackgroundColor3 = enabled and Color3.fromRGB(255, 48, 75) or Color3.fromRGB(55, 55, 66)
        knob.Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8)
        
        if getgenv().notify then getgenv().notify(item.title .. (enabled and " : ON" or " : OFF")) end

        if item.title:find("Auto Soul") then getgenv().kienConfig.AutoSoul = enabled
        elseif item.title:find("Tự Động Về Nhà") then getgenv().kienConfig.AutoReturnHome = enabled
        elseif item.title:find("Fit Lag") then getgenv().kienConfig.FitLag = enabled end
    end)
end

local function renderPage(name)
    currentPage = name
    local data = pages[name]
    if not data then return end
    clearBody()

    for _, item in ipairs(data.items) do
        if item.kind == "toggle" then addToggle(item)
        elseif item.kind == "button" then
            local card = makeCard(item.title, item.desc, 76)
            local action = Instance.new("TextButton")
            action.AnchorPoint = Vector2.new(1, 0.5) action.Position = UDim2.new(1, -12, 0.5, 0)
            action.Size = UDim2.fromOffset(78, 28) action.BackgroundColor3 = Color3.fromRGB(120, 20, 40)
            action.Text = "THỰC HIỆN" action.TextColor3 = Color3.fromRGB(245, 245, 250) action.Font = Enum.Font.GothamBold action.TextSize = 9 action.Parent = card
            local ac = Instance.new("UICorner") ac.CornerRadius = UDim.new(0, 8) ac.Parent = action
            action.Activated:Connect(function()
                if item.actionType == "hop" then
                    if getgenv().notify then getgenv().notify("Đang quét server ít người...") end
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
                end
            end)
        else makeCard(item.title, item.desc, 68) end
    end
end

-- Bật/Tắt Menu
local mainGui = playerGui.KEY_Lop94
local openBtn = mainGui.OpenButton
local mainFrame = mainGui.Main

openBtn.Activated:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
mainFrame.Frame.TextButton.Activated:Connect(function() mainFrame.Visible = false end)

renderPage("FARM")

-- ĐỌC LINH HỒN MÀN HÌNH
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
                        if val and val > count then count = val end
                    end
                end
            end
        end
    end)
    if count == 0 then count = getgenv().kienConfig.SessionSouls end
    return count
end

-- FIT LAG
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

-- VÒNG LẶP RADAR QUÉT SOUL LIÊN TỤC VÔ TẬN
task.spawn(function()
    while true do
        task.wait(0.001)
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart

            if getgenv().kienConfig.AutoSoul then
                pcall(function()
                    -- Tự động về nhà khi đủ 500 hồn
                    if getgenv().kienConfig.AutoReturnHome then
                        local currentSouls = getScreenSoulCount()
                        if currentSouls >= getgenv().kienConfig.RequiredSouls then
                            hrp.CFrame = getgenv().HOME_CFRAME
                            if getgenv().notify then getgenv().notify("Đã đủ 500 hồn! Tự động về nhà an toàn.") end
                            task.wait(4)
                            return
                        end
                    end

                    local bestTarget = nil
                    local shortestDist = math.huge

                    -- RADAR QUÉT TOÀN MAP
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().kienConfig.AutoSoul then break end
                        
                        if obj.Name == "GraveyardSoul" or obj.Name:lower():find("soul") then
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
                        -- Bay trực tiếp đến vị trí linh hồn
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
                        
                        getgenv().kienConfig.SessionSouls = getgenv().kienConfig.SessionSouls + 1
                    end
                end)
            end
        end
    end
end)

if getgenv().notify then getgenv().notify("KIÊN LỚP 94 — SẴN SÀNG QUÉT RADAR SOUL") end
