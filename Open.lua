-- =================================================================
-- PHẦN 1: KHỞI TẠO GIAO DIỆN CHÍNH & HÌNH NỀN FREE FIRE
-- TRƯƠNG TRỌNG KIÊN - LỚP 9.4 • NHUẬN PHÚ TÂN
-- =================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dọn dẹp Gui cũ nếu chạy lại
local old = playerGui:FindFirstChild("KEY_Lop94")
if old then old:Destroy() end

-- Bảng màu Black Nebula chuẩn
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
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    create("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent)
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

-- Nút mở/tắt menu dạng tròn nổi
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
    Active = true,
    Draggable = true,
}, gui)
round(openButton, 18)
stroke(openButton, C.Red, 2)

-- Khung Main chính
local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(650, 420),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true,
    Active = true,
}, gui)
round(main, 16)
stroke(main, C.Red, 1.5)

-- Hình nền Free Fire (ID chính xác theo yêu cầu)
create("ImageLabel", {
    Name = "FreeFireBG",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://117828154165313",
    ImageTransparency = 0.7,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0,
}, main)

local scale = create("UIScale", { Scale = 1 }, main)
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.min(viewport.X / 690, viewport.Y / 460, 1)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

-- Thanh Top Bar
local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 64),
    BackgroundColor3 = C.Panel,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    ZIndex = 2,
}, main)

create("Frame", {
    Position = UDim2.new(0, 0, 1, -2),
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0,
    ZIndex = 2,
}, top)

local logo = create("Frame", {
    Position = UDim2.new(0, 17, 0.5, -19),
    Size = UDim2.fromOffset(38, 38),
    BackgroundColor3 = C.RedDark,
    ZIndex = 2,
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
    ZIndex = 2,
}, logo)

create("TextLabel", {
    Position = UDim2.new(0, 65, 0, 10),
    Size = UDim2.new(0, 320, 0, 25),
    BackgroundTransparency = 1,
    Text = "TRƯƠNG TRỌNG KIÊN  •  HUB PRO MAX",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    TextSize = 16,
    ZIndex = 2,
}, top)

create("TextLabel", {
    Position = UDim2.new(0, 66, 0, 35),
    Size = UDim2.new(0, 280, 0, 17),
    BackgroundTransparency = 1,
    Text = "LỚP 9.4  •  NHUẬN PHÚ TÂN  •  BLACK NEBULA",
    TextColor3 = C.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    TextSize = 9,
    ZIndex = 2,
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
    ZIndex = 2,
}, top)
round(close, 9)

-- Thanh Sidebar bên trái
local sidebar = create("Frame", {
    Position = UDim2.new(0, 0, 0, 66),
    Size = UDim2.new(0, 155, 1, -66),
    BackgroundColor3 = C.Panel,
    BackgroundTransparency = 0.25,
    BorderSizePixel = 0,
    ZIndex = 2,
}, main)

create("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, sidebar)
create("UIPadding", { PaddingTop = UDim.new(0, 17), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, sidebar)

local content = create("Frame", {
    Position = UDim2.new(0, 155, 0, 66),
    Size = UDim2.new(1, -155, 1, -66),
    BackgroundTransparency = 1,
    ZIndex = 2,
}, main)

local pageTitle = create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 15),
    Size = UDim2.new(1, -40, 0, 30),
    BackgroundTransparency = 1,
    Text = "TỐC ĐỘ & SỨC NHẢY",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    ZIndex = 2,
}, content)

local pageBody = create("ScrollingFrame", {
    Position = UDim2.new(0, 15, 0, 50),
    Size = UDim2.new(1, -30, 1, -60),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Red,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 2,
}, content)

local bodyLayout = create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }, pageBody)
-- =================================================================
-- PHẦN 2: HỆ THỐNG THÔNG BÁO TRẠNG THÁI & LOGIC TÍNH NĂNG
-- =================================================================

-- Bảng thông báo trạng thái chức năng (Toast Notification)
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
local function notify(message)
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
            if toastVersion == version then
                toast.Visible = false
            end
        end
    end)
end

-- Biến lưu trạng thái
local Config = {
    WalkSpeed = 16,
    JumpPower = 50,
    Noclip = false,
    InfJump = false,
    AutoClick = false,
    AntiAFK = true,
}

local SavedBase1 = nil

-- Kích hoạt vòng lặp Noclip
RunService.Stepped:Connect(function()
    if Config.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Kích hoạt vòng lặp nhảy trên không
UserInputService.JumpRequest:Connect(function()
    if Config.InfJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Chống AFK văng game
player.Idled:Connect(function()
    if Config.AntiAFK then
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Các hàm tạo UI thành phần
local function makeCard(titleText, height)
    local card = create("Frame", {
        Size = UDim2.new(1, -4, 0, height or 65),
        BackgroundColor3 = C.Card,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, pageBody)
    round(card, 10)
    stroke(card, C.RedDark, 1, 0.35)

    create("TextLabel", {
        Position = UDim2.new(0, 14, 0, 12),
        Size = UDim2.new(0.6, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = C.White,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        ZIndex = 2,
    }, card)

    return card
end

local function addSlider(titleText, min, max, default, callback)
    local card = makeCard(titleText, 60)
    
    local valueText = create("TextLabel", {
        Position = UDim2.new(0.6, 0, 0, 12),
        Size = UDim2.new(0.35, -10, 0, 20),
        BackgroundTransparency = 1,
        Text = tostring(default),
        TextColor3 = C.Red,
        TextXAlignment = Enum.TextXAlignment.Right,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        ZIndex = 2,
    }, card)

    local barBg = create("Frame", {
        Position = UDim2.new(0, 14, 0, 38),
        Size = UDim2.new(1, -28, 0, 8),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        ZIndex = 2,
    }, card)
    round(barBg, 4)

    local barFill = create("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = C.Red,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, barBg)
    round(barFill, 4)

    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        barFill.Size = UDim2.new(pos, 0, 1, 0)
        valueText.Text = tostring(val)
        pcall(callback, val)
    end

    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

local function addToggle(titleText, default, callback)
    local card = makeCard(titleText, 52)
    local enabled = default

    local switch = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(42, 22),
        BackgroundColor3 = enabled and C.Red or Color3.fromRGB(55, 55, 66),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
    }, card)
    round(switch, 11)

    local knob = create("Frame", {
        Position = enabled and UDim2.new(1, -19, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
        Size = UDim2.fromOffset(14, 14),
        BackgroundColor3 = C.White,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, switch)
    round(knob, 7)

    switch.Activated:Connect(function()
        enabled = not enabled
        tween(switch, 0.15, {BackgroundColor3 = enabled and C.Red or Color3.fromRGB(55, 55, 66)})
        tween(knob, 0.15, {Position = enabled and UDim2.new(1, -19, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
        notify("Trạng thái: " .. titleText .. (enabled and " [BẬT]" : " [TẮT]"))
        pcall(callback, enabled)
    end)
end

local function addButton(titleText, btnText, callback)
    local card = makeCard(titleText, 52)

    local btn = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(75, 26),
        BackgroundColor3 = C.RedDark,
        Text = btnText or "THỰC THI",
        TextColor3 = C.White,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        AutoButtonColor = false,
        ZIndex = 2,
    }, card)
    round(btn, 6)

    btn.Activated:Connect(function()
        pcall(callback)
        notify("Thành công: " .. titleText)
    end)
end
-- =================================================================
-- PHẦN 3: RENDER TRANG, ĐIỀU HƯỚNG & HOÀN TẤT SCRIPT
-- =================================================================

local function clearBody()
    for _, child in ipairs(pageBody:GetChildren()) do
        if child:IsA("GuiObject") and child ~= bodyLayout then
            child:Destroy()
        end
    end
end

local function renderPage(name)
    clearBody()
    if name == "TỐC ĐỘ" then
        pageTitle.Text = "TỐC ĐỘ & TÙY CHỈNH CHUẨN"
        
        addSlider("Tốc Độ Chạy (WalkSpeed)", 16, 350, Config.WalkSpeed, function(v)
            Config.WalkSpeed = v
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
            end
        end)

        addSlider("Sức Nhảy (JumpPower)", 50, 400, Config.JumpPower, function(v)
            Config.JumpPower = v
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local h = player.Character:FindFirstChildOfClass("Humanoid")
                h.UseJumpPower = true
                h.JumpPower = v
            end
        end)

        addButton("Tự Sát Nhanh (Reset)", "RESET", function()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").Health = 0
            end
        end)

    elseif name == "TIỆN ÍCH" then
        pageTitle.Text = "TIỆN ÍCH TRỢ GIÚP GAMEPLAY"

        addToggle("Đi Xuyên Tường (Noclip)", Config.Noclip, function(v)
            Config.Noclip = v
        end)

        addToggle("Nhảy Trên Không (Inf Jump)", Config.InfJump, function(v)
            Config.InfJump = v
        end)

        addToggle("Tự Động Click (Auto Click)", Config.AutoClick, function(v)
            Config.AutoClick = v
            task.spawn(function()
                while Config.AutoClick do
                    mouse1click()
                    task.wait(0.05)
                end
            end)
        end)

        addToggle("Chống Treo Máy (Anti-AFK)", Config.AntiAFK, function(v)
            Config.AntiAFK = v
        end)

        addButton("Shift Lock Mobile", "BẬT/TẮT", function()
            local lockBtn = gui:FindFirstChild("MobileLock")
            if lockBtn then lockBtn:Destroy() else
                lockBtn = create("TextButton", {
                    Name = "MobileLock",
                    Size = UDim2.fromOffset(45, 45),
                    Position = UDim2.new(0.8, 0, 0.5, 0),
                    BackgroundColor3 = C.Panel,
                    Text = "🎯",
                    TextSize = 20,
                    Active = true,
                    Draggable = true,
                }, gui)
                round(lockBtn, 22)
                stroke(lockBtn, C.Red, 1.5)
            end
        end)

    elseif name == "TELEPORT" then
        pageTitle.Text = "TELEPORT & TỌA ĐỘ BASE"

        addButton("Lưu Tọa Độ Base", "LƯU BASE", function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                SavedBase1 = player.Character.HumanoidRootPart.CFrame
            end
        end)

        addButton("Teleport Về Base", "BAY VỀ", function()
            if SavedBase1 and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = SavedBase1
            end
        end)

        addButton("Click TP (Nhận Tool)", "LẤY TOOL", function()
            local mouse = player:GetMouse()
            local tool = Instance.new("Tool")
            tool.Name = "Click TP Tool"
            tool.RequiresHandle = false
            tool.Activated:Connect(function()
                if mouse.Hit and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end)
            tool.Parent = player.Backpack
        end)

    elseif name == "HỆ THỐNG" then
        pageTitle.Text = "HỆ THỐNG & ĐỔI SERVER"

        addButton("Đổi Server Ngẫu Nhiên", "HOP", function()
            TeleportService:Teleport(game.PlaceId, player)
        end)

        addButton("Vào Lại Server (Rejoin)", "REJOIN", function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
        end)

        addButton("Tối Ưu Đồ Họa (Xóa Texture)", "TỐI ƯU", function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                end
            end
        end)
    end
end

-- Tạo danh sách menu tab phía trái
local navItems = {"TỐC ĐỘ", "TIỆN ÍCH", "TELEPORT", "HỆ THỐNG"}
local navButtons = {}

for index, name in ipairs(navItems) do
    local button = create("TextButton", {
        Name = name,
        LayoutOrder = index,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = index == 1 and C.RedDark or C.Panel,
        Text = "   " + name,
        TextColor3 = index == 1 and C.White or C.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false,
        ZIndex = 2,
    }, sidebar)
    
    -- Fix hiển thị Text cho đúng cú pháp Luau
    button.Text = "   " .. name
    
    round(button, 9)
    navButtons[name] = button

    button.Activated:Connect(function()
        for _, other in pairs(navButtons) do
            tween(other, 0.15, {BackgroundColor3 = C.Panel})
            other.TextColor3 = C.Muted
        end
        tween(button, 0.15, {BackgroundColor3 = C.RedDark})
        button.TextColor3 = C.White
        renderPage(name)
    end)
end

-- Xử lý mở/tắt bảng chính qua nút nổi hoặc dấu ×
local function setOpen(visible)
    if visible then
        main.Visible = true
        main.Size = UDim2.fromOffset(610, 390)
        tween(main, 0.2, {Size = UDim2.fromOffset(650, 420)})
    else
        tween(main, 0.18, {Size = UDim2.fromOffset(610, 390)})
        task.delay(0.19, function()
            main.Visible = false
        end)
    end
end

openButton.Activated:Connect(function()
    setOpen(not main.Visible)
end)

close.Activated:Connect(function()
    setOpen(false)
end)

-- Cho phép kéo bảng menu linh hoạt trên màn hình điện thoại/PC
local dragging = false
local dragStart, startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Khởi chạy trang mặc định ban đầu
renderPage("TỐC ĐỘ")
notify("TRƯƠNG TRỌNG KIÊN - HUB PRO MAX SẴN SÀNG!")
