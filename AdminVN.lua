-- ==========================================
-- ADMIN SCRIPT: AdminVN Ultimate Edition
-- Phiên bản: V5 (Đã Liên Kết Ruột Code Gốc IY)
-- Tác giả: DucDuyVN
-- ==========================================

-- 1. Gọi trực tiếp toàn bộ 2.500 dòng code lõi Infinite Yield từ liên kết chuẩn của bạn
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- 2. Khởi tạo thêm Menu GUI độc quyền của thương hiệu AdminVN cho game Steal An Egg
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = KavoUi.CreateLib("AdminVN V5 - Bản Tối Thượng Thừa Hưởng IY", "Midnight")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AdminVN V5 ĐÃ LIÊN KẾT!",
    Text = "Nhấn phím ( ; ) để gõ lệnh IY. Dùng Menu để Auto Farm trứng!",
    Duration = 7
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local autoeag = false

-- TAB ĐỘC QUYỀN: STEAL AN EGG HACK
local GameTab = Window:NewTab("Steal An Egg")
local FarmSec = GameTab:NewSection("Auto Cày Cuốc")

-- Tính năng Auto hút trứng siêu tốc về vị trí nhân vật
FarmSec:NewToggle("Auto Hút Toàn Bộ Trứng", "Gom tất cả quả trứng trên map về chân", function(state)
    autoeag = state
    if state then
        task.spawn(function()
            while autoeag do
                pcall(function()
                    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        for _, egg in pairs(workspace:GetChildren()) do
                            if egg:IsA("Model") and (egg.Name:match("Egg") or egg.Name:match("Trứng") or egg.Name:match("Trung")) then
                                egg:MoveTo(root.Position)
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
end)

-- Tính năng chống AFK bảo vệ khi treo máy cày trứng
FarmSec:NewButton("Kích Hoạt Chống Treo Máy (Anti-AFK)", "Treo acc cả ngày không lo bị Roblox tự kick", function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new(0,0))
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "AdminVN Utility",
        Text = "Hệ thống Anti-AFK đã chạy ngầm bảo vệ bạn!",
        Duration = 3
    })
end)

-- TAB HƯỚNG DẪN SỬ DỤNG NHANH
local HelpTab = Window:NewTab("Mẹo Lệnh Chữ (IY)")
local HelpSec = HelpTab:NewSection("Các lệnh gõ bằng dấu chấm phẩy ( ; )")
HelpSec:NewButton("Lệnh Di Chuyển: ;fly | ;noclip | ;infjump", "Mẹo gõ lệnh di chuyển", function() end)
HelpSec:NewButton("Lệnh Chỉ Số: ;speed [số] | ;hipheight [số]", "Chỉnh thông số cơ thể", function() end)
HelpSec:NewButton("Lệnh Người Chơi: ;goto [tên] | ;esp | ;view [tên]", "Theo dõi và dịch chuyển", function() end)
HelpSec:NewButton("Lệnh Thần Thánh: ;god | ;invisible | ;fling", "Hệ thống phá đảo phòng game", function() end)
