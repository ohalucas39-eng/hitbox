-- Hitbox Genişletici - KÜÇÜLTME ÇALIŞAN VERSİYON
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Ayarlar
local HeadSize = 50
local Enabled = false
local Transparency = 0.7
local HitboxColor = "Really red"
local HitboxMaterial = "Neon"

-- Menü değişkenleri
local scriptEnabled = true
local menuMinimized = false
local originalSize = UDim2.new(0, 300, 0, 300)

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HitboxExpanderGUI"
screenGui.Parent = player.PlayerGui

-- Ana Menü
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = originalSize
mainFrame.Position = UDim2.new(0, 50, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Başlık Çubuğu
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Hitbox Genişletici"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Kapatma Butonu
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 2)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

-- Minimal Buton
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -60, 0, 2)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

-- Hitbox Boyutu
local sizeLabel = Instance.new("TextLabel")
sizeLabel.Name = "SizeLabel"
sizeLabel.Size = UDim2.new(0, 120, 0, 25)
sizeLabel.Position = UDim2.new(0, 20, 0, 50)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "Hitbox Boyutu:"
sizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sizeLabel.TextSize = 14
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
sizeLabel.Parent = mainFrame

local sizeBox = Instance.new("TextBox")
sizeBox.Name = "SizeBox"
sizeBox.Size = UDim2.new(0, 60, 0, 25)
sizeBox.Position = UDim2.new(0, 150, 0, 50)
sizeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sizeBox.TextColor3 = Color3.fromRGB(0, 0, 0)
sizeBox.Text = tostring(HeadSize)
sizeBox.TextSize = 14
sizeBox.Font = Enum.Font.Gotham
sizeBox.PlaceholderText = "1-100"
sizeBox.Parent = mainFrame

-- Saydamlık
local transparencyLabel = Instance.new("TextLabel")
transparencyLabel.Name = "TransparencyLabel"
transparencyLabel.Size = UDim2.new(0, 120, 0, 25)
transparencyLabel.Position = UDim2.new(0, 20, 0, 90)
transparencyLabel.BackgroundTransparency = 1
transparencyLabel.Text = "Saydamlık:"
transparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
transparencyLabel.TextSize = 14
transparencyLabel.Font = Enum.Font.Gotham
transparencyLabel.TextXAlignment = Enum.TextXAlignment.Left
transparencyLabel.Parent = mainFrame

local transparencyBox = Instance.new("TextBox")
transparencyBox.Name = "TransparencyBox"
transparencyBox.Size = UDim2.new(0, 60, 0, 25)
transparencyBox.Position = UDim2.new(0, 150, 0, 90)
transparencyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
transparencyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
transparencyBox.Text = tostring(math.floor(Transparency * 255))
transparencyBox.TextSize = 14
transparencyBox.Font = Enum.Font.Gotham
transparencyBox.PlaceholderText = "0-255"
transparencyBox.Parent = mainFrame

-- Renk Seçimi
local colorLabel = Instance.new("TextLabel")
colorLabel.Name = "ColorLabel"
colorLabel.Size = UDim2.new(0, 120, 0, 25)
colorLabel.Position = UDim2.new(0, 20, 0, 130)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "Renk:"
colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
colorLabel.TextSize = 14
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = mainFrame

-- Renk butonları
local redButton = Instance.new("TextButton")
redButton.Name = "RedButton"
redButton.Size = UDim2.new(0, 40, 0, 25)
redButton.Position = UDim2.new(0, 150, 0, 130)
redButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
redButton.Text = "Kırmızı"
redButton.TextColor3 = Color3.fromRGB(255, 255, 255)
redButton.TextSize = 10
redButton.Font = Enum.Font.Gotham
redButton.Parent = mainFrame

local blueButton = Instance.new("TextButton")
blueButton.Name = "BlueButton"
blueButton.Size = UDim2.new(0, 40, 0, 25)
blueButton.Position = UDim2.new(0, 195, 0, 130)
blueButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
blueButton.Text = "Mavi"
blueButton.TextColor3 = Color3.fromRGB(255, 255, 255)
blueButton.TextSize = 10
blueButton.Font = Enum.Font.Gotham
blueButton.Parent = mainFrame

-- Aktif/Pasif Butonu
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 200, 0, 40)
toggleButton.Position = UDim2.new(0, 50, 0, 180)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
toggleButton.Text = "Hile Pasif (H: Aç)"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = mainFrame

-- Durum Bilgisi
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0, 250, 0, 20)
statusLabel.Position = UDim2.new(0, 25, 0, 230)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Durum: Pasif"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Tüm menü elementlerini bir tabloda tutalım (küçültme için)
local menuElements = {
    sizeLabel, sizeBox, transparencyLabel, transparencyBox, 
    colorLabel, redButton, blueButton, toggleButton, statusLabel
}

-- FONKSİYONLAR
local function updateHitboxes()
    if not scriptEnabled or not Enabled then return end
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            pcall(function()
                local character = v.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Hitbox'u güncelle
                        humanoidRootPart.Size = Vector3.new(HeadSize, HeadSize, HeadSize)
                        humanoidRootPart.Transparency = Transparency
                        humanoidRootPart.BrickColor = BrickColor.new(HitboxColor)
                        humanoidRootPart.Material = HitboxMaterial
                        humanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end
end

local function resetHitboxes()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            pcall(function()
                local character = v.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Orijinal boyutlara döndür
                        humanoidRootPart.Size = Vector3.new(2, 2, 1)
                        humanoidRootPart.Transparency = 0
                        humanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
                        humanoidRootPart.Material = "Plastic"
                        humanoidRootPart.CanCollide = true
                    end
                end
            end)
        end
    end
end

local function toggleHitbox()
    if not scriptEnabled then return end
    
    Enabled = not Enabled
    
    if Enabled then
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 200, 80)
        toggleButton.Text = "Hile Aktif (H: Kapat)"
        statusLabel.Text = "Durum: Aktif - Boyut: " .. HeadSize
        updateHitboxes()
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        toggleButton.Text = "Hile Pasif (H: Aç)"
        statusLabel.Text = "Durum: Pasif"
        resetHitboxes()
    end
end

local function disableScript()
    scriptEnabled = false
    Enabled = false
    
    -- Tüm hitbox'ları sıfırla
    resetHitboxes()
    
    -- GUI'yi kaldır
    screenGui:Destroy()
    
    print("Hitbox Genişletici tamamen kapatıldı!")
end

local function toggleMinimize()
    if not scriptEnabled then return end
    
    menuMinimized = not menuMinimized
    
    if menuMinimized then
        -- Menüyü küçült
        mainFrame.Size = UDim2.new(0, 300, 0, 30)
        minimizeButton.Text = "+"
        
        -- Tüm elementleri gizle
        for _, element in pairs(menuElements) do
            element.Visible = false
        end
    else
        -- Menüyü genişlet
        mainFrame.Size = originalSize
        minimizeButton.Text = "_"
        
        -- Tüm elementleri göster
        for _, element in pairs(menuElements) do
            element.Visible = true
        end
    end
end

-- EVENT HANDLER'LAR

-- Boyut kutusu
sizeBox.FocusLost:Connect(function(enterPressed)
    local text = sizeBox.Text
    local num = tonumber(text)
    
    if num and num >= 1 and num <= 100 then
        HeadSize = num
        sizeBox.Text = tostring(HeadSize)
        if Enabled then
            updateHitboxes()
            statusLabel.Text = "Durum: Aktif - Boyut: " .. HeadSize
        end
    else
        sizeBox.Text = tostring(HeadSize)
    end
end)

-- Saydamlık kutusu
transparencyBox.FocusLost:Connect(function(enterPressed)
    local text = transparencyBox.Text
    local num = tonumber(text)
    
    if num and num >= 0 and num <= 255 then
        Transparency = num / 255
        transparencyBox.Text = tostring(num)
        if Enabled then
            updateHitboxes()
        end
    else
        transparencyBox.Text = tostring(math.floor(Transparency * 255))
    end
end)

-- Renk butonları
redButton.MouseButton1Click:Connect(function()
    HitboxColor = "Really red"
    if Enabled then
        updateHitboxes()
    end
end)

blueButton.MouseButton1Click:Connect(function()
    HitboxColor = "Really blue"
    if Enabled then
        updateHitboxes()
    end
end)

-- Ana butonlar
toggleButton.MouseButton1Click:Connect(toggleHitbox)

closeButton.MouseButton1Click:Connect(disableScript)

minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- H tuşu kontrolü
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not scriptEnabled then return end
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.H then
        toggleHitbox()
    end
end)

-- Yeni oyuncuları takip et
Players.PlayerAdded:Connect(function(newPlayer)
    if Enabled then
        newPlayer.CharacterAdded:Connect(function(character)
            wait(1) -- Karakterin yüklenmesini bekle
            if Enabled then
                updateHitboxes()
            end
        end)
    end
end)

-- Ana güncelleme döngüsü
RunService.RenderStepped:Connect(function()
    if scriptEnabled and Enabled then
        updateHitboxes()
    end
end)

-- Başlangıçta mevcut oyuncular için
for _, existingPlayer in pairs(Players:GetPlayers()) do
    if existingPlayer ~= player then
        existingPlayer.CharacterAdded:Connect(function(character)
            wait(1)
            if Enabled then
                updateHitboxes()
            end
        end)
    end
end

print("=== Hitbox Genişletici Yüklendi ===")
print("H tuşu: Aç/Kapat")
print("Boyut: 1-100 (TextBox'a yaz)")
print("Saydamlık: 0-255 (TextBox'a yaz)")
print("Renk: Kırmızı/Mavi butonları")
print("_ butonu: Menüyü küçült")
print("X butonu: Tamamen kapat")