--[[
    Script Name: √12kientomato Hub Pro Max - Rayfield Edition (Full Features)
    Features: Rayfield Library UI + Auto Soul + Screen Soul Reader + Auto Return Home Toggle + Fit Lag + Server Hop
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remote = nil
pcall(function()
    remote = ReplicatedStorage:FindFirstChild("RideADinoNet")
    if not remote then
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                remote = v
                break
            end
        end
    end
end)

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

-- Tạo Window Rayfield
local Window = Rayfield:CreateWindow({
   Name = "√12kientomato Hub Pro Max - Dragon Edition",
   LoadingTitle = "Đang khởi động Dragon Hub...",
   LoadingSubtitle = "By Kiên 94",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "KienHubConfig",
      FileName = "RideADinoNet"
   },
   KeySystem = false,
})

-- Tạo Tab
local TabFarm = Window:CreateTab("⚡ Auto Farm", 4483362458)
local TabLag = Window:CreateTab("🚀 Fit Lag & Server", 4483362458)

-- ================= TAB FARM =================
TabFarm:CreateSection("Cài Đặt Tự Động Nhặt Linh Hồn")

TabFarm:CreateToggle({
   Name = "Auto Soul (Teleport Toàn Map)",
   CurrentValue = false,
   Flag = "AutoSoulFlag",
   Callback = function(Value)
      getgenv().kienConfig.AutoSoul = Value
   end,
})

TabFarm:CreateToggle({
   Name = "Tự Động Về Nhà Khi Đủ 500 Hồn",
   CurrentValue = true,
   Flag = "AutoReturnFlag",
   Callback = function(Value)
      getgenv().kienConfig.AutoReturnHome = Value
      Rayfield:Notify({
         Title = "Trạng Thái Tự Về Nhà",
         Content = Value and "Đã BẬT: Sẽ tự bay về nhà khi đủ linh hồn!" : "Đã TẮT: Chỉ farm, không bao giờ tự về nhà!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

TabFarm:CreateSlider({
   Name = "Mức Linh Hồn Để Về Nhà",
   Range = {100, 2000},
   Increment = 50,
   Suffix = " Linh Hồn",
   CurrentValue = 500,
   Flag = "SoulSliderFlag",
   Callback = function(Value)
      getgenv().kienConfig.RequiredSouls = Value
   end,
})

local LabelStatus = TabFarm:CreateLabel("Trạng thái: Đang quét số linh hồn trên màn hình...")

-- ================= TAB FIT LAG & SERVER =================
TabLag:CreateSection("Tối Ưu Hóa Đồ Họa (Realme)")

TabLag:CreateToggle({
   Name = "Super Fit Lag Mạnh Nhất",
   CurrentValue = false,
   Flag = "FitLagFlag",
   Callback = function(Value)
      getgenv().kienConfig.FitLag = Value
   end,
})

TabLag:CreateSection("Quản Lý Server")

TabLag:CreateButton({
   Name = "Đổi Server Ít Người (Ưu tiên 1 mình)",
   Callback = function()
      Rayfield:Notify({
         Title = "Hop Server",
         Content = "Đang quét server trống...",
         Duration = 3,
         Image = 4483362458,
      })
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
         else
             Rayfield:Notify({Title = "Lỗi", Content = "Không tìm thấy server phù hợp!", Duration = 3})
         end
      end)
   end,
})

-- Hàm đọc số linh hồn từ màn hình
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
            LabelStatus:Set("Hồn trên màn hình: " .. tostring(currentSouls) .. " / " .. tostring(getgenv().kienConfig.RequiredSouls))
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

            if getgenv().kienConfig.AutoSoul then
                pcall(function()
                    if getgenv().kienConfig.AutoReturnHome then
                        local currentSouls = getScreenSoulCount()
                        if currentSouls >= getgenv().kienConfig.RequiredSouls then
                            hrp.CFrame = HOME_CFRAME
                            Rayfield:Notify({Title = "Đã Đủ Chỉ Tiêu!", Content = "Đã tự động tele về nhà an toàn!", Duration = 3})
                            task.wait(5)
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
                        
                        if remote then
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
