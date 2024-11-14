local players = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local SendNotification = function(Ti, Te)
    game:GetService("StarterGui"):SetCore('SendNotification', {Title = tostring(Ti), Text = tostring(Te)})
end

local toggle = true

uis.InputBegan:Connect(function(i, gpe)
    if not gpe and i.KeyCode == Enum.KeyCode.Zero then
        toggle = not toggle
        if toggle then
            SendNotification("Cheats", "True")
        else
            SendNotification("Cheats", "False")
        end
    end
end)

local function onCharacterAdded(character)
    local function updateLimbTouch()
        pcall(function()
            for _, limbName in ipairs({"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}) do
                local limb = character:WaitForChild(limbName, 5) -- waits for each limb
                if limb and limb:IsA("Part") then
                    limb.CanTouch = not toggle or not players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                end
            end
        end)
    end

    run.Stepped:Connect(updateLimbTouch)
end

players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- If the character is already loaded, connect immediately
if players.LocalPlayer.Character then
    onCharacterAdded(players.LocalPlayer.Character)
end
