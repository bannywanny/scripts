local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local toggle = true
local toolMissingTime = 0
local toolName = "Sword"

local function getClosestPlayerNotOnNeutralOrSameTeam()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Team ~= nil then
            local character = player.Character
            local localCharacter = localPlayer.Character

            if character and localCharacter then
                local targetRootPart = character:FindFirstChild("HumanoidRootPart")
                local localRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")

                if targetRootPart and localRootPart and humanoid and humanoid.Health > 0 then
                    local distance = (localRootPart.Position - targetRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function equipToolByName(toolName)
    local backpack = localPlayer:FindFirstChild("Backpack")
    local character = localPlayer.Character

    if backpack and character then
        local tool = backpack:FindFirstChild(toolName)
        if tool and tool.Parent ~= character then
            tool.Parent = character
        end
    end
end

local function checkToolExists(toolName)
    local backpack = localPlayer:FindFirstChild("Backpack")
    local character = localPlayer.Character

    if backpack and character then
        local toolInBackpack = backpack:FindFirstChild(toolName)
        local toolInCharacter = character:FindFirstChild(toolName)

        if not toolInBackpack and not toolInCharacter then
            toolMissingTime = toolMissingTime + RunService.Heartbeat:Wait()
            if toolMissingTime >= 5 then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        else
            toolMissingTime = 0
        end
    end
end

local function onCharacterAdded(character)
    wait(1)
    checkToolExists(toolName)
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Nine then
        toggle = not toggle
    end
end)

RunService.Heartbeat:Connect(function()
    if toggle then
        local localCharacter = localPlayer.Character
        if localCharacter and localCharacter:FindFirstChild("Humanoid") then
            local humanoid = localCharacter:FindFirstChild("Humanoid")
            if humanoid.Health <= 0 then
                wait(0.5)
                return
            end
        end

        checkToolExists(toolName)
        equipToolByName(toolName)
        
        local targetPlayer = getClosestPlayerNotOnNeutralOrSameTeam()

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, -12, 0)
            if localCharacter and localCharacter:FindFirstChild("HumanoidRootPart") then
                localCharacter.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end
        
        wait(1)
    end
end)
