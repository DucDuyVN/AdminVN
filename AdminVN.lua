-- ==========================================
-- ADMIN SCRIPT: AdminVN (Bản Hoàn Chỉnh Có Icon Kira)
-- Tác giả: DucDuyVN
-- ==========================================

-- 1. Sửa lỗi dòng số 9: Thư viện tạo Menu GUI (Kavo Library)
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = KavoUi.CreateLib("AdminVN - Infinite Yield Mini", "Midnight")

-- 2. Thông báo chào mừng AdminVN khi kích hoạt
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AdminVN Loaded!",
    Text = "Đã tích hợp Icon lơ lửng ẩn/hiện Menu phong cách Kira!",
    Duration = 5
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- ==========================================
-- HỆ THỐNG ICON LƠ LỬNG PHONG CÁCH KIRA HUB
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

-- Đưa Icon vào CoreGui để không bị mất khi nhân vật hồi sinh
ScreenGui.Name = "AdminVN_KiraToggle"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Cấu hình Nút bấm lơ lửng (Hình tròn, màu đen đỏ đồng bộ menu)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Position = UDim2.new(0, 10, 0, 150) -- Vị trí xuất hiện ban đầu (Bên trái màn hình)
ToggleButton.Size = UDim2.new(0, 50, 0, 50) -- Kích thước nút 50x50 pixel
ToggleButton.Image = "rbxassetid://6031225818" -- Icon hình bánh răng quản trị chuyên nghiệp
ToggleButton.ImageColor3 = Color3.fromRGB(255, 0, 0) -- Màu icon màu đỏ rực
ToggleButton.Active = true
ToggleButton.Draggable = true -- Cho phép người chơi dùng tay/chuột kéo icon đi khắp màn hình

UICorner.CornerRadius = UDim.new(0, 25) -- Bo tròn tuyệt đối tạo thành hình tròn giống Kira
UICorner.Parent = ToggleButton

-- Lập trình sự kiện khi chạm/click vào Icon để Ẩn/Hiện Menu
local menuOpen = true
ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        -- Mở lại menu
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
        -- Kavo UI tự động nhận diện phím ảo, đoạn này gọi hàm ẩn hiện gốc của Kavo
        pcall(function()
            local gui = CoreGui:FindFirstChild("AdminVN - Infinite Yield Mini") or LocalPlayer.PlayerGui:FindFirstChild("AdminVN - Infinite Yield Mini")
            if gui then gui.Enabled = true end
        end)
    else
        -- Ẩn tạm thời menu
        pcall(function()
            local gui = CoreGui:FindFirstChild("AdminVN - Infinite Yield Mini") or LocalPlayer.PlayerGui:FindFirstChild("AdminVN - Infinite Yield Mini")
            if gui then gui.Enabled = false end
        end)
    end
end)

-- ==========================================
-- CÁC CHỨC NĂNG MENU ADMINVN (ĐÃ ĐỒNG BỘ ĐẦY ĐỦ)
-- ==========================================
-- TAB 1: LỆNH DI CHUYỂN
local PlayerTab = Window:NewTab("Lệnh Cơ Bản")
local MovementSection = PlayerTab:NewSection("Di Chuyển")

MovementSection:NewSlider("Tốc Độ (Speed)", "Chạy nhanh như Flash", 500, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

MovementSection:NewSlider("Nhảy Cao (Jump)", "Nhảy cao như Hulk", 500, 50, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

local noclipConnection
MovementSection:NewToggle("Xuyên Tường (Noclip)", "Đi xuyên mọi vật thể", function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

local infJumpConnection
MovementSection:NewToggle("Nhảy Vô Hạn (Inf Jump)", "Nhảy liên tục trên không", function(state)
    if state then
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        if infJumpConnection then infJumpConnection:Disconnect() end
    end
end)

-- TAB 2: LỆNH THEO DÕI & DỊCH CHUYỂN
local VisionTab = Window:NewTab("Do Thám")
local EspSection = VisionTab:NewSection("Nhìn Xuyên Tường")

local espBoxes = {}
EspSection:NewToggle("Bật ESP Người Chơi", "Thấy vị trí mọi người qua tường", function(state)
    if state then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not espBoxes[p] then
                local box = Instance.new("Highlight")
                box.FillColor = Color3.fromRGB(255, 0, 0)
                box.FillOpacity = 0.5
                box.OutlineColor = Color3.fromRGB(255, 255, 255)
                box.Parent = p.Character
                espBoxes[p] = box
            end
        end
    else
        for p, box in pairs(espBoxes) do
            if box then box:Destroy() end
        end
        espBoxes = {}
    end
end)

local TeleportSection = VisionTab:NewSection("Dịch Chuyển Tức Thời")
TeleportSection:NewButton("Dịch Chuyển Đến Người Khác", "Teleport ngẫu nhiên đến một người", function()
    local allPlayers = Players:GetPlayers()
    if #allPlayers > 1 then
        local target = allPlayers[math.random(1, #allPlayers)]
        while target == LocalPlayer do
            target = allPlayers[math.random(1, #allPlayers)]
        end
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

-- TAB 3: GAME STEAL AN EGG & HỆ THỐNG
local GameTab = Window:NewTab("Steal An Egg")
local FarmSection = GameTab:NewSection("Auto Farm")

_G.AdminVNFarm = false
FarmSection:NewToggle("Auto Hút Trứng", "Gom tất cả trứng siêu nhanh", function(state)
    _G.AdminVNFarm = state
    if state then
        task.spawn(function()
            while _G.AdminVNFarm do
                pcall(function()
                    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    for _, egg in pairs(workspace:GetChildren()) do
                        if egg:IsA("Model") and (egg.Name:match("Egg") or egg.Name:match("Trứng")) then
                            egg:MoveTo(root.Position)
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
end)
