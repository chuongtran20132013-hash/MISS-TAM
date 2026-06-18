local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChuongLuxury"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ================= BẢNG MÀU TÍM HƯ THỨC NEON =================
local PURPLE_MAIN = Color3.fromRGB(153, 0, 204)     -- Tím sáng lõi chiêu / Nút HIDE
local PURPLE_DARK = Color3.fromRGB(35, 15, 45)      -- Tím đen trầm nền nút (Khi tắt)
local PURPLE_LIGHT = Color3.fromRGB(200, 50, 255)   -- Tím Neon rực rỡ (Khi bật)
local PURPLE_WHITE_NEON = Color3.fromRGB(235, 180, 255) -- Tím trắng Neon (Màu viền phát sáng)
local BG_COLOR = Color3.fromRGB(12, 12, 14)         -- Nền menu tối sâu
local BOX_BG = Color3.fromRGB(22, 22, 26)           -- Nền ô nhập liệu

-- KHUNG VIỀN NEON TRUYỀN THỐNG (Thay thế UIStroke chống lỗi crash)
local BorderFrame = Instance.new("Frame", ScreenGui)
BorderFrame.Name = "BorderFrame"
BorderFrame.BackgroundColor3 = PURPLE_WHITE_NEON -- Màu viền tím trắng neon
BorderFrame.Size = UDim2.new(0, 264, 0, 484) -- Rộng hơn khung chính 4px để tạo viền
BorderFrame.Position = UDim2.new(0.5, -132, 0.5, -242)
BorderFrame.Active = true
BorderFrame.Draggable = true
Instance.new("UICorner", BorderFrame).CornerRadius = UDim.new(0, 10)

-- Khung chính của Menu (Nằm đè bên trong khung viền)
local MainFrame = Instance.new("Frame", BorderFrame)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.Size = UDim2.new(1, -4, 1, -4) -- Thu nhỏ lại 4px để lộ phần viền neon ra ngoài
MainFrame.Position = UDim2.new(0, 2, 0, 2)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 9)

-- Thanh Topbar phía trên
local Topbar = Instance.new("Frame", MainFrame)
Topbar.BackgroundColor3 = PURPLE_MAIN
Topbar.Size = UDim2.new(1, 0, 0, 35)
Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0, 9)

local Title = Instance.new("TextLabel", Topbar)
Title.Text = "  MMYTT | @CHUONG_LUXURY HUB"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Nút tắt Menu nhanh (X)
local CloseBtn = Instance.new("TextButton", Topbar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function() BorderFrame.Visible = false end)

-- Nút HIDE nổi góc màn hình
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.Size = UDim2.new(0, 85, 0, 35)
ToggleBtn.Text = "ON/OFF"
ToggleBtn.BackgroundColor3 = PURPLE_MAIN
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

ToggleBtn.MouseButton1Click:Connect(function() BorderFrame.Visible = not BorderFrame.Visible end)

-- Vùng cuộn chứa tính năng (Scrolling Frame)
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 0, 0, 42)
Container.Size = UDim2.new(1, 0, 1, -47)
Container.CanvasSize = UDim2.new(0, 0, 0, 580)
Container.ScrollBarThickness = 3
Container.ScrollBarImageColor3 = PURPLE_MAIN

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder -- Khóa cứng thứ tự sắp xếp theo số

-- Hệ thống lưu trạng thái ban đầu
local States = {HB = false, ESP = false, SPD = false, JP = false, InfJump = false, AntiStun = false, AutoDodge = false}
local Inputs = {Name = "all", Size = "30", Speed = "80", Jump = "50"}

local orderIndex = 1 

-- ================= HÀM TẠO THÀNH PHẦN GIAO DIỆN =================

-- Hàm tạo Ô Nhập Số (Nằm trên)
local function AddInput(placeholder, key)
    local box = Instance.new("TextBox", Container)
    box.Size = UDim2.new(0, 225, 0, 30)
    box.BackgroundColor3 = BOX_BG
    box.PlaceholderText = placeholder
    box.Text = Inputs[key]
    box.TextColor3 = Color3.fromRGB(240, 240, 240)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.LayoutOrder = orderIndex
    orderIndex = orderIndex + 1
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    
    box:GetPropertyChangedSignal("Text"):Connect(function() Inputs[key] = box.Text end)
end

-- Hàm tạo Nút Bật Tắt (Nằm dưới)
local function AddToggle(labelText, key)
    local btn = Instance.new("TextButton", Container)
    btn.Size = UDim2.new(0, 225, 0, 35)
    btn.Text = labelText .. " : OFF"
    btn.BackgroundColor3 = PURPLE_DARK
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.LayoutOrder = orderIndex
    orderIndex = orderIndex + 1
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        States[key] = not States[key]
        btn.Text = labelText .. (States[key] and " : ON" or " : OFF")
        btn.BackgroundColor3 = States[key] and PURPLE_LIGHT or PURPLE_DARK
        btn.TextColor3 = States[key] and Color3.new(1, 1, 1) or Color3.fromRGB(220, 220, 220)
    end)
end

-- ================= GHÉP CẶP TỪNG CHỨC NĂNG (TRÊN - DƯỚI) =================

-- Cụm 1: ESP Định Vị (Tên trên, nút dưới)
AddInput("Target Name (all/name)", "Name")
AddToggle("ESP ENABLE", "ESP")

-- Cụm 2: Hitbox (Số kích thước trên, nút bật dưới)
AddInput("Hitbox Size (Default: 30)", "Size")
AddToggle("HITBOX ENABLE", "HB")

-- Cụm 3: Speed Boost (Số tốc độ trên, nút bật dưới)
AddInput("Speed Value (50 - 150)", "Speed")
AddToggle("SPEED BOOST", "SPD")

-- Cụm 4: Lock Jump (Sức nhảy trên, nút bật dưới)
AddInput("Jump Power (Default: 50)", "Jump")
AddToggle("LOCK JUMP", "JP")

-- Các chức năng bổ trợ độc lập (Chỉ có nút bấm, tự xếp xuống đáy)
AddToggle("INF JUMP", "InfJump")
AddToggle("ANTI-STUN", "AntiStun")
AddToggle("AUTO DODGE", "AutoDodge")

-- ================= ĐỘNG CƠ CHẠY NGẦM LOGIC VẬN HÀNH =================
game:GetService("RunService").Heartbeat:Connect(function()
    local Player = game.Players.LocalPlayer
    local Target = string.lower(Inputs.Name)
    local HSize = tonumber(Inputs.Size) or 30
    local SpdVal = tonumber(Inputs.Speed) or 80
    local JumpVal = tonumber(Inputs.Jump) or 50

    if Player.Character then
        local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
        local Hum = Player.Character:FindFirstChildOfClass("Humanoid")

        if Hum and HRP then
            if States.SPD and Hum.MoveDirection.Magnitude > 0 then
                HRP.AssemblyLinearVelocity = Vector3.new(Hum.MoveDirection.X * SpdVal, HRP.AssemblyLinearVelocity.Y, Hum.MoveDirection.Z * SpdVal)
            end

            if States.JP then
                Hum.UseJumpPower = true 
                Hum.JumpPower = JumpVal
            end

            if States.AntiStun then
                Hum.PlatformStand = false
                Hum.Sit = false
                if Hum:GetState() == Enum.HumanoidStateType.Physics or Hum:GetState() == Enum.HumanoidStateType.Ragdoll then
                    Hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
                for _, v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("ValueBase") and (string.find(string.lower(v.Name), "stun") or string.find(string.lower(v.Name), "freeze")) then
                        v:Destroy()
                    end
                end
            end

            if States.AutoDodge then
                for _, obj in pairs(workspace:GetChildren()) do
                    if (obj:IsA("Part") or obj:IsA("MeshPart")) and obj.Name ~= "BasePlate" and not obj:IsDescendantOf(Player.Character) then
                        local dist = (obj.Position - HRP.Position).Magnitude
                        if dist < 16 and obj.AssemblyLinearVelocity.Magnitude > 18 then
                            local dodgeDir = obj.AssemblyLinearVelocity.Unit:Cross(Vector3.new(0, 1, 0))
                            HRP.CFrame = HRP.CFrame + (dodgeDir * 8)
                            break
                        end
                    end
                end
            end
        end
    end

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character then
            local vHRP = v.Character:FindFirstChild("HumanoidRootPart")
            local vHead = v.Character:FindFirstChild("Head")
            local isMatch = (Target == "all" or string.find(string.lower(v.Name), Target))

            if vHead then
                if States.ESP and isMatch then
                    if not vHead:FindFirstChild("LuxuryTag") then
                        local bg = Instance.new("BillboardGui", vHead); bg.Name = "LuxuryTag"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 120, 0, 30); bg.StudsOffset = Vector3.new(0, 3, 0)
                        local txt = Instance.new("TextLabel", bg); txt.Size = UDim2.new(1, 0, 1, 0); txt.Text = "[ " .. v.Name .. " ]"; txt.TextColor3 = PURPLE_LIGHT; txt.BackgroundTransparency = 1; txt.TextSize = 13; txt.Font = Enum.Font.SourceSansBold
                    end
                elseif vHead:FindFirstChild("LuxuryTag") then
                    vHead.LuxuryTag:Destroy()
                end
            end

            if vHRP then
                if States.HB and isMatch then
                    if vHRP.Size.X ~= HSize then
                        vHRP.Size = Vector3.new(HSize, HSize, HSize); vHRP.Transparency = 0.6; vHRP.CanCollide = false
                    end
                elseif vHRP.Size.X ~= 2 and vHRP.Size.X ~= 1 then 
                    vHRP.Size = Vector3.new(2, 2, 1); vHRP.Transparency = 1
                end
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if States.InfJump and game.Players.LocalPlayer.Character then
        local Hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Hum then Hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

