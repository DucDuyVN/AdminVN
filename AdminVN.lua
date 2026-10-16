-- ==========================================
-- ADMIN SCRIPT: AdminVN 
-- Phiên bản: Tối Thượng (Universal Admin)
-- Phát triển bởi: Đức Duy VN
-- ==========================================

-- 1. Khởi tạo giao diện Menu Kavo UI
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = KavoUi.CreateLib("AdminVN - Hệ Thống Lệnh Admin Tối Thượng", "Midnight")

-- 2. Thông báo chào mừng AdminVN khi kích hoạt thành công
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AdminVN Loaded!",
    Text = "Hệ thống quản trị AdminVN đã sẵn sàng thực thi lệnh!",
    Duration = 5
})

-- Các biến dịch vụ hệ thống cơ bản
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- TAB 1: CÁC LỆNH ADMIN CHO NGƯỜI CHƠI (PLAYER COMMANDS)
local PlayerTab = Window:NewTab("Lệnh Admin")
local MovementSection = PlayerTab:NewSection("Di Chuyển & Gian Lận")

-- Lệnh 1: Thay đổi tốc độ chạy (Speed)
MovementSection:NewSlider("Tốc Độ Chạy (Speed)", "Thay đổi tốc độ di chuyển của bạn", 500, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Lệnh 2: Thay đổi lực nhảy (Jump Power)
MovementSection:NewSlider("Sức Nhảy (Jump Power)", "Thay đổi độ cao khi nhảy", 500, 50, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

-- Lệnh 3: Đi xuyên tường (Noclip)
local noclipConnection
MovementSection:NewToggle("Đi Xuyên Tường (Noclip)", "Bật/Tắt tính năng đi xuyên qua mọi vật thể", function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

-- Lệnh 4: Nhảy vô hạn trên không (Inf Jump)
local infJumpConnection
MovementSection:NewToggle("Nhảy Vô Hạn (Inf Jump)", "Cho phép bạn nhảy liên tục trên không trung", function(state)
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

-- TAB 2: TÍNH NĂNG ĐỘC QUYỀN STEAL AN EGG (GAME EXCLUSIVE)
local GameTab = Window:NewTab("Steal An Egg")
local FarmSection = GameTab:NewSection("Auto Farm Trứng")

_G.AdminVNFarm = false
FarmSection:NewToggle("Auto Gom Trứng", "Tự động hút toàn bộ trứng trên map về vị trí của bạn", function(state)
    _G.AdminVNFarm = state
    if state then
        task.spawn(function()
            while _G.AdminVNFarm do
                pcall(function()
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = character:FindFirstChild("HumanoidRootPart")
                    for _, egg in pairs(workspace:GetChildren()) do
                        if egg:IsA("Model") and (egg.Name:match("Egg") or egg.Name:match("Trứng")) then
                            egg:MoveTo(root.Position)
                        end
                    end
                end)
                task.wait(0.3) -- Quét cực nhanh tốc độ admin
            end
        end)
    end
end)

-- TAB 3: HỆ THỐNG AN TOÀN & TIỆN ÍCH (UTILITIES)
local UtilityTab = Window:NewTab("Hệ Thống")
local SystemSection = UtilityTab:NewSection("Công Cụ Hỗ Trợ")

-- Tính năng chống treo máy bảo vệ Server
SystemSection:NewButton("Bật Anti-AFK", "Ngăn chặn việc bị Kick khỏi server khi treo máy", function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new(0,0))
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "AdminVN",
        Text = "Hệ thống Anti-AFK đã được kích hoạt ngầm thành công!",
        Duration = 3
    })
end)

print("[AdminVN]: Khởi chạy thành công menu lệnh hệ thống!")
