-- ==========================================
-- ADMIN SCRIPT: AdminVN Ultimate Edition
-- Phiên bản: V5 (Max Lệnh + Game Custom)
-- Tác giả: DucDuyVN
-- ==========================================

-- 1. Kích hoạt toàn bộ lõi hệ thống hàng trăm lệnh của Infinite Yield gốc
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- 2. Khởi tạo thêm Menu GUI độc quyền của thương hiệu AdminVN
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = KavoUi.CreateLib("AdminVN V5 - Bản Tối Thượng Thừa Hưởng IY", "Midnight")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AdminVN V5 ĐÃ LIÊN KẾT!",
    Text = "Nhấn ( ; ) để dùng 400+ lệnh IY. Dùng Menu để Auto Farm!",
    Duration = 7
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local farmConnection
local autoeag = false

-- TAB ĐỘC QUYỀN: STEAL AN EGG HACK
local GameTab = Window:NewTab("Steal An Egg")
local FarmSec = GameTab:NewSection("Auto Cày Cuốc")

-- Tính năng Auto hút trứng siêu tốc
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

-- Tính năng chống AFK bảo vệ server khi treo máy
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

-- TAB HƯỚNG DẪN SỬ DỤNG LỆNH CHỮ CỦA INFINITE YIELD
local HelpTab = Window:NewTab("Mẹo Lệnh Chữ (IY)")
local HelpSec = HelpTab:NewSection("Các lệnh gõ bằng dấu chấm phẩy ( ; )")
HelpSec:NewButton("Lệnh Di Chuyển: ;fly | ;noclip | ;infjump", "Bấm để xem mẹo gõ", function() end)
HelpSec:NewButton("Lệnh Chỉ Số: ;speed [số] | ;hipheight [số]", "Chỉnh tốc độ và độ cao", function() end)
HelpSec:NewButton("Lệnh Người Chơi: ;goto [tên] | ;esp | ;view [tên]", "Theo dõi người khác", function() end)
HelpSec:NewButton("Lệnh Thần Thánh: ;god | ;invisible | ;loopjump", "Các lệnh gian lận tối cao", function() end)
