-- GUI Flutuante para Barraca Dourada + Texto Arco-íris
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "CustomBoothGUI"

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 12)

-- Botão para pintar a barraca de dourado
local goldButton = Instance.new("TextButton", frame)
goldButton.Size = UDim2.new(1, -20, 0, 40)
goldButton.Position = UDim2.new(0, 10, 0, 10)
goldButton.Text = "Barraca Dourada"
goldButton.TextColor3 = Color3.new(1, 1, 0)
goldButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local corner1 = Instance.new("UICorner", goldButton)
corner1.CornerRadius = UDim.new(0, 8)

-- Botão para texto arco-íris
local rainbowButton = Instance.new("TextButton", frame)
rainbowButton.Size = UDim2.new(1, -20, 0, 40)
rainbowButton.Position = UDim2.new(0, 10, 0, 60)
rainbowButton.Text = "Texto Arco-Íris"
rainbowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rainbowButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local corner2 = Instance.new("UICorner", rainbowButton)
corner2.CornerRadius = UDim.new(0, 8)

-- Função para encontrar o estande
local function getBooth()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("BoothClaim") and v:FindFirstChild("Sign") then
            if v.BoothClaim:FindFirstChild("Player") and v.BoothClaim.Player.Value == player then
                return v
            end
        end
    end
end

-- Pintar barraca de dourado
goldButton.MouseButton1Click:Connect(function()
    local booth = getBooth()
    if booth then
        for _, part in ipairs(booth:GetDescendants()) do
            if part:IsA("BasePart") then
                part.BrickColor = BrickColor.new("Bright yellow")
                part.Material = Enum.Material.Neon
            end
        end
    end
end)

-- Aplicar texto arco-íris
rainbowButton.MouseButton1Click:Connect(function()
    local booth = getBooth()
    if booth and booth:FindFirstChild("Sign") then
        local sign = booth.Sign:FindFirstChildWhichIsA("TextLabel")
        if sign then
            spawn(function()
                while true do
                    for i = 0, 1, 0.01 do
                        local r = math.sin(i * math.pi * 2) * 0.5 + 0.5
                        local g = math.sin(i * math.pi * 2 + 2) * 0.5 + 0.5
                        local b = math.sin(i * math.pi * 2 + 4) * 0.5 + 0.5
                        sign.TextColor3 = Color3.new(r, g, b)
                        wait(0.05)
                    end
                end
            end)
        end
    end
end)
