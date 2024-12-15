local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Oxygenz Hub" .. Fluent.Version,
    SubTitle = "by tigers1337",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" })
}

Tabs.Main:AddButton({
    Title = "ESP",
    Description = "มองศัตรู",
    Callback = function()
        Fluent:Notify({
            Title = "Button Clicked",
            Content = "You clicked the button!",
            Duration = 5 -- Notification disappears after 5 seconds
        })
        -- Parent this script to ServerScriptService or Workspace for it to work correctly.

local Players = game:GetService("Players")

-- Function to highlight a character
local function highlightCharacter(character)
    if not character:FindFirstChild("Highlight") then
        -- Create a Highlight instance
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(1, 0, 0) -- Red color
        highlight.FillTransparency = 0.5 -- Slight transparency
        highlight.OutlineTransparency = 0.5
        highlight.Parent = character
    end
end

-- Function to handle when a player's character is added
local function onCharacterAdded(character)
    highlightCharacter(character)
end

-- Function to handle when a player joins
local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded) -- Highlight the character when it spawns
    if player.Character then
        highlightCharacter(player.Character) -- If the character already exists, highlight it
    end
end

-- Connect existing players
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Listen for new players joining
Players.PlayerAdded:Connect(onPlayerAdded)

-- Listen for players leaving to clean up (optional)
Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character and character:FindFirstChild("Highlight") then
        character.Highlight:Destroy()
    end
end)

    end
})
Tabs.Main:AddButton({
    Title = "AIMLOCK",
    Description = "ล็อคหัวตึงๆๆๆ",
    Callback = function()
        Fluent:Notify({
            Title = "Button Clicked",
            Content = "You clicked the button!",
            Duration = 5 -- Notification disappears after 5 seconds
        })
       local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local lockTarget = nil

-- เพิ่ม _G.aim สำหรับการเปิด/ปิดระบบล็อค
_G.aim = false

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") and otherPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = otherPlayer.Character.Humanoid
            if humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end

    return closestPlayer
end

local function updateLockTarget()
    if lockTarget and lockTarget.Character and lockTarget.Character:FindFirstChild("Humanoid") then
        if lockTarget.Character.Humanoid.Health <= 0 then
            lockTarget = nil
        end
    end

    if not lockTarget then
        lockTarget = getClosestPlayer()
    end
end

local function aimAtTarget()
    if lockTarget and lockTarget.Character and lockTarget.Character:FindFirstChild("Head") then
        local targetHead = lockTarget.Character.Head
        camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
    end
end

local isLocking = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton2 and _G.aim then
        isLocking = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton2 then
        isLocking = false
        lockTarget = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if isLocking and _G.aim then
        updateLockTarget()
        aimAtTarget()
    end
end)

    end
})

Window:SelectTab(1)

Fluent:Notify({
    Title = "Oxygenz Hub",
    Content = "Thx for use my script",
    Duration = 8
})
