local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CUSTOM_IMAGE_ID = "rbxassetid://117828154165313"

if CoreGui:FindFirstChild("HubGUI") then CoreGui.HubGUI:Destroy() end

local C = {
    Background = Color3.fromRGB(10, 10, 14),
    Panel = Color3.fromRGB(17, 17, 23),
    Card = Color3.fromRGB(24, 24, 32),
    Red = Color3.fromRGB(255, 48, 75),
    RedDark = Color3.fromRGB(120, 20, 40),
    White = Color3.fromRGB(245, 245, 250),
    Muted = Color3.fromRGB(145, 145, 160),
    Green = Color3.fromRGB(70, 230, 155),
    Pink = Color3.fromRGB(255, 105, 180),
}

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(parent, radius) create("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent) end
local function stroke(parent, color, thickness) return create("UIStroke", { Color = color or C.Red, Thickness = thickness or 1 }, parent) end

local function tween(obj, duration, props)
    local t = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play() return t
end

local function playClickSound()
    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://6042053636" sound.Volume = 0.6 sound:Play()
    task.delay(1, function() sound:Destroy() end)
end

local gui = create("ScreenGui", { Name = "HubGUI", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, CoreGui)

local function notify(message)
    playClickSound()
    local toast = create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 15), Size = UDim2.fromOffset(310, 38),
        BackgroundColor3 = C.Card, TextColor3 = C.White, Text = "⚡ " .. message, TextSize = 11, Font = Enum.Font.GothamBold, ZIndex = 999
    }, gui)
    round(toast, 10) stroke(toast, C.Red, 1.5)
    tween(toast, 0.3, {Position = UDim2.new(0.5, 0, 0, 25)})
    task.delay(2.2, function()
        tween(toast, 0.2, {TextTransparency = 1, BackgroundTransparency = 1})
        task.delay(0.2, function() toast:Destroy() end)
    end)
end

local openButton = create("ImageButton", { Name = "OpenButton", Size = UDim2.fromOffset(48, 48), Position = UDim2.new(0.01, 0, 0.3, 0), BackgroundColor3 = C.Background, Image = CUSTOM_IMAGE_ID, AutoButtonColor = false }, gui)
round(openButton, 14) stroke(openButton, C.Red, 2)

local StopFlyButton = create("TextButton", { Name = "StopFlyButton", BackgroundColor3 = Color3.fromRGB(230, 30, 50), Position = UDim2.new(0.92, 0, 0.02, 0), Size = UDim2.fromOffset(38, 38), Font = Enum.Font.GothamBold, Text = "✕", TextColor3 = C.White, TextSize = 18, Visible = false }, gui)
round(StopFlyButton, 12) stroke(StopFlyButton, C.White, 2)

local ShiftLockButton = create("TextButton", { BackgroundColor3 = Color3.fromRGB(18, 22, 32), Position = UDim2.new(0.08, 0, 0.3, 0), Size = UDim2.fromOffset(36, 36), Font = Enum.Font.GothamBold, Text = "🎯", TextColor3 = C.White, TextSize = 16, Visible = false }, gui)
round(ShiftLockButton, 10) stroke(ShiftLockButton, Color3.fromRGB(255, 60, 60), 2)

local main = create("Frame", { Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(650, 420), BackgroundColor3 = C.Background, BorderSizePixel = 0, Visible = false, ClipsDescendants = true }, gui)
round(main, 16) stroke(main, C.Red, 1.5)

local BgImage = create("ImageLabel", { Image = CUSTOM_IMAGE_ID, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ImageTransparency = 0.78, ScaleType = Enum.ScaleType.Crop }, main)
round(BgImage, 16)

local scale = create("UIScale", { Scale = 1 }, main)
local function updateScale()
    if Camera then scale.Scale = math.min(Camera.ViewportSize.X / 690, Camera.ViewportSize.Y / 460, 1) end
end
updateScale()
if Camera then Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale) end

local top = create("Frame", { Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = C.Panel, BackgroundTransparency = 0.2, BorderSizePixel = 0 }, main)
create("Frame", { Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = C.Red, BorderSizePixel = 0 }, top)
create("TextLabel", { Position = UDim2.new(0, 20, 0, 12), Size = UDim2.new(0, 400, 0, 25), BackgroundTransparency = 1, Text = "👑 TRƯƠNG TRỌNG KIÊN - HUB PRO MAX", TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBlack, TextSize = 15 }, top)
create("TextLabel", { Position = UDim2.new(0, 21, 0, 37), Size = UDim2.new(0, 350, 0, 15), BackgroundTransparency = 1, Text = "LỚP 9.4 • TRƯỜNG THCS NHUẬN PHÚ TÂN (30+ FEATURES)", TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 9 }, top)

local close = create("TextButton", { Position = UDim2.new(1, -45, 0, 15), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = C.Card, Text = "×", TextColor3 = C.Red, TextSize = 23, Font = Enum.Font.GothamBold, AutoButtonColor = false }, top)
round(close, 9)

local sidebar = create("Frame", { Position = UDim2.new(0, 0, 0, 66), Size = UDim2.new(0, 155, 1, -66), BackgroundColor3 = C.Panel, BackgroundTransparency = 0.2, BorderSizePixel = 0 }, main)
create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, sidebar)
create("UIPadding", { PaddingTop = UDim.new(0, 15), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, sidebar)

local content = create("Frame", { Position = UDim2.new(0, 155, 0, 66), Size = UDim2.new(1, -155, 1, -66), BackgroundTransparency = 1 }, main)
local pageTitle = create("TextLabel", { Position = UDim2.new(0, 20, 0, 12), Size = UDim2.new(1, -40, 0, 25), BackgroundTransparency = 1, Text = "TIỆN ÍCH", TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 15 }, content)
local pageBody = create("ScrollingFrame", { Position = UDim2.new(0, 15, 0, 45), Size = UDim2.new(1, -30, 1, -55), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = C.Red, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y }, content)
create("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, pageBody)
local function clearBody()
    for _, child in ipairs(pageBody:GetChildren()) do
        if child:IsA("GuiObject") and not child:IsA("UIListLayout") then child:Destroy() end
    end
end

local function makeCard(titleText, descText, height)
    local card = create("Frame", { Size = UDim2.new(1, -4, 0, height or 62), BackgroundColor3 = C.Card, BackgroundTransparency = 0.2, BorderSizePixel = 0 }, pageBody)
    round(card, 10) stroke(card, C.RedDark, 1)
    create("TextLabel", { Position = UDim2.new(0, 12, 0, 10), Size = UDim2.new(1, -24, 0, 20), BackgroundTransparency = 1, Text = titleText, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 11 }, card)
    create("TextLabel", { Position = UDim2.new(0, 12, 0, 30), Size = UDim2.new(1, -24, 0, 22), BackgroundTransparency = 1, Text = descText, TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 9, TextWrapped = true }, card)
    return card
end

-- BIẾN HỆ THỐNG
local noclipConn, espActive, boxEspActive, shiftLockEnabled, isLocked, slConn, savedPos1, savedPos2, isFlying, selectedTarget = nil, false, false, false, false, nil, nil, nil, false, nil
local speedEnabled, jumpEnabled, infJumpEnabled, flyEnabled = false, false, false, false
local customSpeed, customJump, customFov = 16, 50, 70
local speedConn, jumpConn, infJumpConn, autoClickEnabled, antiAfkConn = nil, nil, nil, false, nil
local tracerEspActive, headDotActive = false, false

local espFolder = Instance.new("Folder", gui) espFolder.Name = "ESPFolder"
local boxEspFolder = Instance.new("Folder", gui) boxEspFolder.Name = "BoxESPFolder"

local function flyToCFrame(targetCFrame)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local myHrp = char.HumanoidRootPart
        isFlying = true StopFlyButton.Visible = true
        notify("Đang bay mượt!")
        task.spawn(function()
            local speed = 165
            while isFlying and targetCFrame do
                local direction = (targetCFrame.Position - myHrp.Position)
                local distance = direction.Magnitude
                if distance < 5 or not isFlying then break end
                myHrp.CFrame = myHrp.CFrame + (direction.Unit * math.min(distance, speed * 0.03))
                RunService.RenderStepped:Wait()
            end
            if isFlying then myHrp.CFrame = targetCFrame end
            isFlying = false StopFlyButton.Visible = false
            notify("Đã đến nơi!")
        end)
    end
end
StopFlyButton.MouseButton1Click:Connect(function() isFlying = false StopFlyButton.Visible = false notify("Đã dừng bay!") end)

local MiniFrame = create("Frame", { Size = UDim2.new(0, 160, 0, 110), Position = UDim2.new(0.85, -80, 0.2, 0), BackgroundColor3 = C.Background, BackgroundTransparency = 0.1, Visible = false, Active = true, Draggable = true }, gui)
round(MiniFrame, 12) stroke(MiniFrame, C.Red, 2)
create("TextLabel", { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "📌 MINI BASE TELEPORT", TextColor3 = C.White, TextSize = 10 }, MiniFrame)
local mBtn1 = create("TextButton", { Position = UDim2.new(0, 8, 0, 30), Size = UDim2.new(1, -16, 0, 32), BackgroundColor3 = C.RedDark, Font = Enum.Font.GothamBold, Text = "🚀 VỊ TRÍ 1", TextColor3 = C.White, TextSize = 10 }, MiniFrame) round(mBtn1, 6)
local mBtn2 = create("TextButton", { Position = UDim2.new(0, 8, 0, 68), Size = UDim2.new(1, -16, 0, 32), BackgroundColor3 = C.RedDark, Font = Enum.Font.GothamBold, Text = "🚀 VỊ TRÍ 2", TextColor3 = C.White, TextSize = 10 }, MiniFrame) round(mBtn2, 6)
mBtn1.MouseButton1Click:Connect(function() if savedPos1 then flyToCFrame(savedPos1) else notify("Chưa lưu Vị Trí 1!") end end)
mBtn2.MouseButton1Click:Connect(function() if savedPos2 then flyToCFrame(savedPos2) else notify("Chưa lưu Vị Trí 2!") end end)

local pages = {
    UTILITY = {
        title = "TIỆN ÍCH HỮU ÍCH (1-8)",
        build = function()
            -- 1. Noclip
            local c1 = makeCard("1. Đi Xuyên Tường (Noclip)", "Đi xuyên qua mọi vật cản")
            local b1 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c1) round(b1, 6)
            local noclipOn = false
            b1.MouseButton1Click:Connect(function()
                noclipOn = not noclipOn b1.BackgroundColor3 = noclipOn and C.Green or C.RedDark b1.Text = noclipOn and "TẮT" or "BẬT"
                if noclipOn then
                    noclipConn = RunService.Stepped:Connect(function()
                        if LocalPlayer.Character then for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
                    end) notify("Đã bật Noclip")
                else if noclipConn then noclipConn:Disconnect(); noclipConn = nil end notify("Đã tắt Noclip") end
            end)

            -- 2. ESP Red Name
            local c2 = makeCard("2. Định Vị Tên Đỏ (Name ESP)", "Hiển thị tên & khoảng cách chữ màu đỏ")
            local b2 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c2) round(b2, 6)
            b2.MouseButton1Click:Connect(function()
                espActive = not espActive b2.BackgroundColor3 = espActive and C.Green or C.RedDark b2.Text = espActive and "TẮT" or "BẬT" espFolder:ClearAllChildren()
                if espActive then
                    for _, v in ipairs(Players:GetPlayers()) do
                        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local bg = Instance.new("BillboardGui", espFolder) bg.Adornee = v.Character.HumanoidRootPart bg.AlwaysOnTop = true bg.Size = UDim2.new(0, 150, 0, 40) bg.StudsOffset = Vector3.new(0, 3, 0)
                            local txt = Instance.new("TextLabel", bg) txt.Size = UDim2.new(1, 0, 1, 0) txt.BackgroundTransparency = 1 txt.Font = Enum.Font.GothamBold txt.TextSize = 12 txt.TextColor3 = Color3.fromRGB(255, 50, 50) txt.TextStrokeTransparency = 0
                            task.spawn(function()
                                while espActive and v.Character and v.Character:FindFirstChild("HumanoidRootPart") do
                                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                        txt.Text = v.DisplayName .. " [" .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
                                    end task.wait(0.1)
                                end bg:Destroy()
                            end)
                        end
                    end notify("Đã bật ESP Tên Đỏ!")
                else notify("Đã tắt ESP!") end
            end)

            -- 3. Box ESP Pink
            local cBox = makeCard("3. Bao Bọc Hồng (Box ESP)", "Khung 3D màu hồng bao quanh người chơi")
            local bBox = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, cBox) round(bBox, 6)
            bBox.MouseButton1Click:Connect(function()
                boxEspActive = not boxEspActive bBox.BackgroundColor3 = boxEspActive and C.Green or C.RedDark bBox.Text = boxEspActive and "TẮT" or "BẬT" boxEspFolder:ClearAllChildren()
                if boxEspActive then
                    for _, v in ipairs(Players:GetPlayers()) do
                        if v ~= LocalPlayer and v.Character then
                            local box = Instance.new("Highlight", boxEspFolder) box.Adornee = v.Character box.FillColor = C.Pink box.OutlineColor = Color3.fromRGB(255, 255, 255) box.FillTransparency = 0.5 box.OutlineTransparency = 0
                        end
                    end notify("Đã bật Box ESP Hồng!")
                else notify("Đã tắt Box ESP!") end
            end)

            -- 4. Shift Lock Mobile
            local c3 = makeCard("4. Khóa Màn Hình (Shift Lock)", "Góc nhìn di động khóa theo tâm màn hình")
            local b3 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c3) round(b3, 6)
            b3.MouseButton1Click:Connect(function()
                shiftLockEnabled = not shiftLockEnabled ShiftLockButton.Visible = shiftLockEnabled b3.BackgroundColor3 = shiftLockEnabled and C.Green or C.RedDark b3.Text = shiftLockEnabled and "TẮT" or "BẬT"
                if shiftLockEnabled then
                    if slConn then slConn:Disconnect() end
                    slConn = RunService.RenderStepped:Connect(function()
                        if isLocked and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local camLook = Camera.CFrame.LookVector
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(-camLook.X, -camLook.Z), 0)
                        end
                    end) notify("Đã bật Shift Lock!")
                else isLocked = false ShiftLockButton.BackgroundColor3 = Color3.fromRGB(18, 22, 32) if slConn then slConn:Disconnect(); slConn = nil end notify("Đã tắt Shift Lock") end
            end)
            ShiftLockButton.MouseButton1Click:Connect(function()
                if shiftLockEnabled then isLocked = not isLocked ShiftLockButton.BackgroundColor3 = isLocked and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(18, 22, 32) end
            end)

            -- 5. Fast Interact
            local c4 = makeCard("5. Nhặt Đồ Tức Thì", "Tương tác nhặt đồ không cần giữ nút")
            local b4 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c4) round(b4, 6)
            b4.MouseButton1Click:Connect(function()
                getgenv().FastInteract = not getgenv().FastInteract b4.BackgroundColor3 = getgenv().FastInteract and C.Green or C.RedDark b4.Text = getgenv().FastInteract and "TẮT" or "BẬT"
                task.spawn(function()
                    while getgenv().FastInteract do task.wait(0.3) for _, prompt in ipairs(workspace:GetDescendants()) do if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end end end
                end) notify(getgenv().FastInteract and "Đã bật Fast Interact" or "Đã tắt")
            end)

            -- 6. Auto Click / Fast Tap
            local c5 = makeCard("6. Tự Động Click (Auto Tap)", "Tự click màn hình liên tục cho mọi game")
            local b5 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c5) round(b5, 6)
            b5.MouseButton1Click:Connect(function()
                autoClickEnabled = not autoClickEnabled b5.BackgroundColor3 = autoClickEnabled and C.Green or C.RedDark b5.Text = autoClickEnabled and "TẮT" or "BẬT"
                task.spawn(function()
                    while autoClickEnabled do
                        task.wait(0.05)
                        pcall(function()
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                                LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                            end
                        end)
                    end
                end) notify(autoClickEnabled and "Đã bật Auto Click!" or "Đã tắt Auto Click!")
            end)

            -- 7. Infinite Jump
            local c6 = makeCard("7. Nhảy Trên Không (Inf Jump)", "Nhảy liên tục trên không không giới hạn")
            local b6 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c6) round(b6, 6)
            b6.MouseButton1Click:Connect(function()
                infJumpEnabled = not infJumpEnabled b6.BackgroundColor3 = infJumpEnabled and C.Green or C.RedDark b6.Text = infJumpEnabled and "TẮT" or "BẬT"
                if infJumpEnabled then
                    infJumpConn = UserInputService.JumpRequest:Connect(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                        end
                    end) notify("Đã bật Inf Jump!")
                else if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end notify("Đã tắt Inf Jump") end
            end)

            -- 8. Anti-AFK
            local c7 = makeCard("8. Chống Treo Máy (Anti-AFK)", "Không lo bị văng game khi cắm máy treo đồ")
            local b7 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c7) round(b7, 6)
            b7.MouseButton1Click:Connect(function()
                if not antiAfkConn then
                    antiAfkConn = LocalPlayer.Idled:Connect(function()
                        local bb = game:GetService("VirtualUser")
                        bb:Button2Down(Vector2.new(0, 0), Camera.CFrame)
                        task.wait(1)
                        bb:Button2Up(Vector2.new(0, 0), Camera.CFrame)
                    end)
                    b7.BackgroundColor3 = C.Green b7.Text = "TẮT" notify("Đã bật Anti-AFK treo máy!")
                else
                    antiAfkConn:Disconnect(); antiAfkConn = nil
                    b7.BackgroundColor3 = C.RedDark b7.Text = "BẬT" notify("Đã tắt Anti-AFK!")
                end
            end)
        end,
    },
    PLAYERMOD = {
        title = "CHỈ SỐ BẢN THÂN (9-15)",
        build = function()
            -- 9. Speed
            local c1 = makeCard("9. Tốc Độ Chạy (WalkSpeed)", "Tùy chỉnh tốc độ di chuyển nhân vật") c1.Size = UDim2.new(1, -4, 0, 75)
            local bSpd = create("TextButton", { Position = UDim2.new(0, 12, 0, 42), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c1) round(bSpd, 6)
            local tSpdBox = create("TextBox", { Position = UDim2.new(0, 75, 0, 42), Size = UDim2.fromOffset(80, 26), BackgroundColor3 = C.Panel, Text = tostring(customSpeed), TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11 }, c1) round(tSpdBox, 6)
            bSpd.MouseButton1Click:Connect(function()
                speedEnabled = not speedEnabled bSpd.BackgroundColor3 = speedEnabled and C.Green or C.RedDark bSpd.Text = speedEnabled and "TẮT" or "BẬT"
                customSpeed = tonumber(tSpdBox.Text) or 16
                if speedEnabled then
                    speedConn = RunService.RenderStepped:Connect(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            LocalPlayer.Character.Humanoid.WalkSpeed = customSpeed
                        end
                    end) notify("Đã bật Speed: " .. customSpeed)
                else if speedConn then speedConn:Disconnect(); speedConn = nil end if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end notify("Đã tắt Speed") end
            end)

            -- 10. Jump Power
            local c2 = makeCard("10. Sức Bật Nhảy (JumpPower)", "Tùy chỉnh độ cao khi nhảy") c2.Size = UDim2.new(1, -4, 0, 75)
            local bJmp = create("TextButton", { Position = UDim2.new(0, 12, 0, 42), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c2) round(bJmp, 6)
            local tJmpBox = create("TextBox", { Position = UDim2.new(0, 75, 0, 42), Size = UDim2.fromOffset(80, 26), BackgroundColor3 = C.Panel, Text = tostring(customJump), TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11 }, c2) round(tJmpBox, 6)
            bJmp.MouseButton1Click:Connect(function()
                jumpEnabled = not jumpEnabled bJmp.BackgroundColor3 = jumpEnabled and C.Green or C.RedDark bJmp.Text = jumpEnabled and "TẮT" or "BẬT"
                customJump = tonumber(tJmpBox.Text) or 50
                if jumpEnabled then
                    jumpConn = RunService.RenderStepped:Connect(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = customJump
                        end
                    end) notify("Đã bật Jump: " .. customJump)
                else if jumpConn then jumpConn:Disconnect(); jumpConn = nil end if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end notify("Đã tắt Jump") end
            end)

            -- 11. Gravity Control
            local c3 = makeCard("11. Trọng Lực (Gravity)", "Chỉnh độ trôi nhẹ khi nhảy (Mặc định 196.2)") c3.Size = UDim2.new(1, -4, 0, 75)
            local tGravBox = create("TextBox", { Position = UDim2.new(0, 12, 0, 42), Size = UDim2.fromOffset(80, 26), BackgroundColor3 = C.Panel, Text = "196.2", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11 }, c3) round(tGravBox, 6)
            local bGrav = create("TextButton", { Position = UDim2.new(0, 100, 0, 42), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "ÁP DỤNG", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c3) round(bGrav, 6)
            bGrav.MouseButton1Click:Connect(function()
                workspace.Gravity = tonumber(tGravBox.Text) or 196.2
                notify("Đã chỉnh Gravity: " .. workspace.Gravity)
            end)

            -- 12. FOV Changer
            local c4 = makeCard("12. Tầm Nhìn Camera (FOV)", "Chỉnh độ rộng góc nhìn camera") c4.Size = UDim2.new(1, -4, 0, 75)
            local tFovBox = create("TextBox", { Position = UDim2.new(0, 12, 0, 42), Size = UDim2.fromOffset(80, 26), BackgroundColor3 = C.Panel, Text = "70", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11 }, c4) round(tFovBox, 6)
            local bFov = create("TextButton", { Position = UDim2.new(0, 100, 0, 42), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "ÁP DỤNG", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c4) round(bFov, 6)
            bFov.MouseButton1Click:Connect(function()
                Camera.FieldOfView = tonumber(tFovBox.Text) or 70
                notify("Đã chỉnh FOV: " .. Camera.FieldOfView)
            end)

            -- 13. Fullbright
            local c5 = makeCard("13. Nhìn Trong Đêm (Fullbright)", "Làm sáng toàn bộ bản đồ tối")
            local bBright = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "BẬT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c5) round(bBright, 6)
            local isBright = false
            bBright.MouseButton1Click:Connect(function()
                isBright = not isBright bBright.BackgroundColor3 = isBright and C.Green or C.RedDark bBright.Text = isBright and "TẮT" or "BẬT"
                if isBright then Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.Brightness = 2 notify("Đã bật Fullbright!")
                else Lighting.Ambient = Color3.fromRGB(128, 128, 128) Lighting.Brightness = 1 notify("Đã tắt Fullbright!") end
            end)

            -- 14. Reset Character Fast
            local c6 = makeCard("14. Tự Sát Nhanh (Reset Char)", "Hồi sinh ngay lập tức về vị trí gốc")
            local bResetChar = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "RESET", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c6) round(bResetChar, 6)
            bResetChar.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
                    notify("Đã tự sát hồi sinh!")
                end
            end)

            -- 15. Invisible Seat / Sit
            local c7 = makeCard("15. Bật Chế Độ Ngồi (Sit Toggle)", "Cho nhân vật ngồi ngay tại chỗ")
            local bSit = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(55, 26), BackgroundColor3 = C.RedDark, Text = "NGỒI", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c7) round(bSit, 6)
            bSit.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = not LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                end
            end)
        end,
    },
}
local function appendPart3()
    -- Tab Teleport
    pages.TELEPORT = {
        title = "TELEPORT & TỌA ĐỘ (16-20)",
        build = function()
            -- 16. 2 Base Teleport
            local c1 = makeCard("16. Hệ Thống Lưu Tọa Độ (2 Base)", "Lưu vị trí và bay đến lập tức") c1.Size = UDim2.new(1, -4, 0, 178)
            local bSave1 = create("TextButton", { Position = UDim2.new(0, 12, 0, 56), Size = UDim2.new(0.47, 0, 0, 30), BackgroundColor3 = C.Panel, Text = "💾 LƯU VỊ TRÍ 1", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(bSave1, 6)
            local bSave2 = create("TextButton", { Position = UDim2.new(0.51, 0, 0, 56), Size = UDim2.new(0.47, 0, 0, 30), BackgroundColor3 = C.Panel, Text = "💾 LƯU VỊ TRÍ 2", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(bSave2, 6)
            bSave1.MouseButton1Click:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then savedPos1 = LocalPlayer.Character.HumanoidRootPart.CFrame notify("Đã lưu Vị Trí 1!") end end)
            bSave2.MouseButton1Click:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then savedPos2 = LocalPlayer.Character.HumanoidRootPart.CFrame notify("Đã lưu Vị Trí 2!") end end)
            local bFly1 = create("TextButton", { Position = UDim2.new(0, 12, 0, 92), Size = UDim2.new(0.47, 0, 0, 32), BackgroundColor3 = C.RedDark, Text = "🚀 BAY VỊ TRÍ 1", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(bFly1, 6)
            local bFly2 = create("TextButton", { Position = UDim2.new(0.51, 0, 0, 92), Size = UDim2.new(0.47, 0, 0, 32), BackgroundColor3 = C.RedDark, Text = "🚀 BAY VỊ TRÍ 2", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(bFly2, 6)
            bFly1.MouseButton1Click:Connect(function() if savedPos1 then flyToCFrame(savedPos1) else notify("Chưa lưu Vị Trí 1!") end end)
            bFly2.MouseButton1Click:Connect(function() if savedPos2 then flyToCFrame(savedPos2) else notify("Chưa lưu Vị Trí 2!") end end)
            
            -- 17. Mini Teleport Window
            local bMini = create("TextButton", { Position = UDim2.new(0, 12, 0, 132), Size = UDim2.new(1, -24, 0, 32), BackgroundColor3 = Color3.fromRGB(120, 40, 180), Text = "📌 17. TÁCH BẢNG MINI BẬT NHANH", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10 }, c1) round(bMini, 6)
            bMini.MouseButton1Click:Connect(function() MiniFrame.Visible = not MiniFrame.Visible notify(MiniFrame.Visible and "Đã hiện Bảng Mini!" or "Đã ẩn Bảng Mini") end)

            -- 18. Click To TP (Bấm tool/màn hình để dịch chuyển)
            local c2 = makeCard("18. Click Dịch Chuyển (Click TP Tool)", "Tạo công cụ bấm đến vị trí bất kỳ trên bản đồ")
            local bClickTp = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "LẤY TOOL", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c2) round(bClickTp, 6)
            bClickTp.MouseButton1Click:Connect(function()
                local tool = Instance.new("Tool") tool.Name = "⚡ Click Teleport" tool.RequiresHandle = false tool.Parent = LocalPlayer.Backpack
                tool.Activated:Connect(function()
                    local pos = LocalPlayer:GetMouse().Hit
                    if pos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z)
                        notify("Đã dịch chuyển đến vị trí chỉ định!")
                    end
                end) notify("Đã thêm Tool Click TP vào rương đồ!")
            end)

            -- 19. Teleport To Random Player
            local c3 = makeCard("19. Dịch Chuyển Ngẫu Nhiên", "Bay ngẫu nhiên tới 1 người trong phòng")
            local bRandTp = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "BAY NGAY", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c3) round(bRandTp, 6)
            bRandTp.MouseButton1Click:Connect(function()
                local plrs = {}
                for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(plrs, p) end end
                if #plrs > 0 then
                    local target = plrs[math.random(1, #plrs)]
                    flyToCFrame(target.Character.HumanoidRootPart.CFrame)
                else notify("Không tìm thấy người chơi nào!") end
            end)

            -- 20. Safe Zone Teleport (Bay lên không trung trú ẩn)
            local c4 = makeCard("20. Bay Lên Trú Ẩn An Toàn", "Bay đứng yên trên cao trốn nguy hiểm")
            local bSafe = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "LÊN CAO", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c4) round(bSafe, 6)
            bSafe.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 300, 0)
                    notify("Đã dịch chuyển lên an toàn an toàn +300m!")
                end
            end)
        end,
    }

    -- Tab Player Teleport (21 - 23)
    pages.PLAYERTP = {
        title = "BAY ĐẾN PLAYER (21-23)",
        build = function()
            local cTop = makeCard("21. Quét Danh Sách Server", "Chọn mục tiêu để bay tốc độ mượt 165") cTop.Size = UDim2.new(1, -4, 0, 45)
            
            -- 22. Reset Scan List
            local bRefresh = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(80, 26), BackgroundColor3 = C.RedDark, Text = "🔄 RESET (22)", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, cTop) round(bRefresh, 6)
            local listContainer = create("ScrollingFrame", { Size = UDim2.new(1, -4, 0, 190), BackgroundColor3 = C.Card, BackgroundTransparency = 0.3, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2 }, pageBody) round(listContainer, 8)
            create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, listContainer)
            local function loadPlayers()
                for _, child in ipairs(listContainer:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        local pBtn = create("TextButton", { Size = UDim2.new(1, -4, 0, 32), BackgroundColor3 = C.Panel, BackgroundTransparency = 0.3, Font = Enum.Font.GothamBold, Text = "👤 " .. plr.DisplayName .. " (@" .. plr.Name .. ")", TextColor3 = C.White, TextSize = 10 }, listContainer) round(pBtn, 6)
                        pBtn.MouseButton1Click:Connect(function() selectedTarget = plr notify("Đã chọn: " .. plr.DisplayName) end)
                    end
                end
            end
            bRefresh.MouseButton1Click:Connect(function() loadPlayers() notify("Đã quét lại danh sách!") end) loadPlayers()

            -- 23. Fly To Target Button
            local bGo = create("TextButton", { Size = UDim2.new(1, -4, 0, 38), BackgroundColor3 = Color3.fromRGB(255, 140, 0), Font = Enum.Font.GothamBold, Text = "🚀 23. BAY MƯỢT ĐẾN MỤC TIÊU ĐÃ CHỌN", TextColor3 = C.White, TextSize = 11 }, pageBody) round(bGo, 8)
            bGo.MouseButton1Click:Connect(function()
                if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") then flyToCFrame(selectedTarget.Character.HumanoidRootPart.CFrame) else notify("Chưa chọn mục tiêu!") end
            end)
        end,
    }

    -- Tab Config (24 - 25)
    pages.CONFIG = {
        title = "QUẢN LÝ CONFIG (24-25)",
        build = function()
            -- 24. Save Config
            local c1 = makeCard("24. Lưu Cấu Hình (Save Config)", "Lưu lại toàn bộ thông số cài đặt cá nhân")
            local b1 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.Green, Text = "SAVE", TextColor3 = C.Background, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(b1, 6)
            b1.MouseButton1Click:Connect(function()
                local data = { speed = customSpeed, jump = customJump, fov = Camera.FieldOfView }
                pcall(function() writefile("KienHubConfig.json", HttpService:JSONEncode(data)) end)
                notify("Đã lưu Config thành công!")
            end)

            -- 25. Load Config
            local c2 = makeCard("25. Tải Cấu Hình (Load Config)", "Khôi phục cấu hình cá nhân đã lưu")
            local b2 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "LOAD", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c2) round(b2, 6)
            b2.MouseButton1Click:Connect(function()
                pcall(function()
                    if isfile and isfile("KienHubConfig.json") then
                        local decoded = HttpService:JSONDecode(readfile("KienHubConfig.json"))
                        customSpeed = decoded.speed or 16 customJump = decoded.jump or 50 Camera.FieldOfView = decoded.fov or 70
                        notify("Đã tải Config: Speed " .. customSpeed)
                    else notify("Chưa có file Config lưu!") end
                end)
            end)
        end,
    }

    -- Tab Server (26 - 28)
    pages.SERVER = {
        title = "QUẢN LÝ SERVER (26-28)",
        build = function()
            -- 26. Server Hop
            local c1 = makeCard("26. Đổi Server (Server Hop)", "Chuyển sang server ngẫu nhiên khác")
            local b1 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "ĐỔI SERVER", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(b1, 6)
            b1.MouseButton1Click:Connect(function()
                notify("Đang tìm server...")
                local servers = {}
                pcall(function()
                    local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
                    for _, s in ipairs(req.data) do if type(s) == "table" and s.playing and s.maxPlayers and s.playing < s.maxPlayers and s.id ~= game.JobId then table.insert(servers, s.id) end end
                end)
                if #servers > 0 then TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer) else TeleportService:Teleport(game.PlaceId, LocalPlayer) end
            end)

            -- 27. Low Server Hop
            local cLow = makeCard("27. Đổi Server Ít Người (Low Hop)", "Ưu tiên chọn phòng còn vắng người chơi")
            local bLow = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "VẮNG NGƯỜI", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, cLow) round(bLow, 6)
            bLow.MouseButton1Click:Connect(function()
                notify("Đang tìm server vắng...")
                pcall(function()
                    local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
                    if req.data and #req.data > 0 then TeleportService:TeleportToPlaceInstance(game.PlaceId, req.data[#req.data].id, LocalPlayer) end
                end)
            end)

            -- 28. Rejoin Server
            local c2 = makeCard("28. Vào Lại Server Cũ (Rejoin)", "Kết nối lại ngay lập tức vào server hiện tại")
            local b2 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(75, 26), BackgroundColor3 = C.RedDark, Text = "REJOIN", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c2) round(b2, 6)
            b2.MouseButton1Click:Connect(function() notify("Đang kết nối lại...") TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
        end,
    }

    -- Tab Boost (29 - 30)
    pages.BOOST = {
        title = "TỐI ƯU & HỆ THỐNG (29-30)",
        build = function()
            -- 29. Super Anti-Lag
            local c1 = makeCard("29. Siêu Anti-Lag Cường Hóa", "Gỡ hiệu ứng cấu hình thấp nhất tăng tối đa FPS")
            local b1 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "KÍCH HOẠT", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c1) round(b1, 6)
            b1.MouseButton1Click:Connect(function()
                Lighting.GlobalShadows = false Lighting.FogEnd = 9e9 Lighting.Brightness = 1
                for _, v in ipairs(workspace:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then v.Enabled = false end end
                notify("Đã bật Anti-Lag tối đa FPS!")
            end)

            -- 30. Clear Texture / Remove Textures
            local c2 = makeCard("30. Xóa Đồ Họa 3D (Remove Textures)", "Xóa toàn bộ họa tiết kết cấu bề mặt đồ họa")
            local b2 = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(65, 26), BackgroundColor3 = C.RedDark, Text = "XÓA ĐỒ HỌA", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9 }, c2) round(b2, 6)
            b2.MouseButton1Click:Connect(function()
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
                    if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
                end
                notify("Đã chuyển bề mặt mượt siêu nhẹ!")
            end)
        end,
    }
end

appendPart3()

local navItems = {
    {name = "TIỆN ÍCH", id = "UTILITY"}, {name = "TỐC ĐỘ", id = "PLAYERMOD"},
    {name = "LƯU VỊ TRÍ", id = "TELEPORT"}, {name = "BAY PLAYER", id = "PLAYERTP"},
    {name = "CONFIG", id = "CONFIG"}, {name = "SERVER", id = "SERVER"}, {name = "TỐI ƯU FPS", id = "BOOST"}
}
local navButtons = {}
local function renderPage(id) pageTitle.Text = pages[id].title clearBody() pages[id].build() end

for index, info in ipairs(navItems) do
    local button = create("TextButton", { Name = info.id, LayoutOrder = index, Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = info.id == "UTILITY" and C.RedDark or C.Panel, Text = info.name, TextColor3 = info.id == "UTILITY" and C.White or C.Muted, Font = Enum.Font.GothamBold, TextSize = 10, AutoButtonColor = false }, sidebar) round(button, 8)
    navButtons[info.id] = button
    button.MouseButton1Click:Connect(function()
        for _, btn in pairs(navButtons) do tween(btn, 0.15, {BackgroundColor3 = C.Panel}) btn.TextColor3 = C.Muted end
        tween(button, 0.15, {BackgroundColor3 = C.RedDark}) button.TextColor3 = C.White renderPage(info.id)
    end)
end

local function setOpen(visible)
    if visible then
        main.Visible = true main.Size = UDim2.fromOffset(610, 390)
        tween(main, 0.22, {Size = UDim2.fromOffset(650, 420)})
    else
        tween(main, 0.18, {Size = UDim2.fromOffset(610, 390)})
        task.delay(0.19, function() main.Visible = false end)
    end
end

openButton.MouseButton1Click:Connect(function() setOpen(not main.Visible) end)
close.MouseButton1Click:Connect(function() setOpen(false) end)

local dragging, dragStart, startPosition = false, nil, nil
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPosition = main.Position end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

renderPage("UTILITY")
notify("Chào mừng Trương Trọng Kiên trở lại!")
