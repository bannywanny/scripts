--[[
Universal tank script created by banov#0 made to be extremely hard to detect in order to improve my demongod antiexploit. | 12/11/24

If you were sent this script I ask you to not leak it because this script is made to bypass every current anti and therefore is not meant for exploiters to use.

A short explanation for why this script works is because the three ways you can get hit by a sword is your client, the server and the .touched firer's script
which causes you to be able to get damaged up to 3 times in 1 hit. This script changes your client so you do not take damage from sword hits on your screen
effectively giving you a large advantage.

helpers: jason, ludi, acy
--]]


getgenv().config = {
    ["Tank type"] = "handle", -- other tank types are "handle" and "secret", handle is the most likely to get detected by a good anti 
    ["Enabled"] = true, -- alternatively you can press [ to disable the tank
    ["BlatantMode"] = true, -- this can only be off if , if tank type is set to handle then it can be turned to false/legit mode
    ["Universal/Watchdog Bypass Mode"] = true, -- automatically gets turned off if you don't have wave or codex, edits the code in attempt to bypass extremely powerful antis. 
    ["Safe mode"] = false -- encases the entire script in a pcall and removes every print to prevent desperate antis detecting this script via LogService, turn this off for manual debugging.
}


-- // Keybinds \\ --

getgenv().keybinds = {
		["Enabled"] = "[",
        ["Change tank type"] = "]"
    --[[["Kill Script"] = "" adding in later version
        ["Invisible Check"] = , adding in later version
        ["Team Check"] = , -- adding in later version --]]
}


-- // Variables \\ --

local players = game:GetService("Players")
local client = players.LocalPlayer
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")


-- // Pre-Core \\ --

local function processtool(tool, action)
    if tool and tool:FindFirstChild("Handle") then
    local handle = tool.Handle
    if action and type(action) == "function" then
        action(handle)
        end
    end
end

local function safemodeprint(message)
    if not config["Safe mode"] then
        print(message)
    end
end

local function playertools()
for ilovetwinks, eventhoiamone in pairs(players:GetPlayers()) do
    if eventhoiamone ~= client then
        local backpack = eventhoiamone.Backpack
        if backpack then local tool = backpack:FindFirstChildOfClass("tool")
        processtool(tool, function()
            safemodeprint("handle found [debug])
        end)
        else
            safemodeprint("handle unfound [debug]")
        end
    end
end
end

local function workspacetools()
for bestsciptever, infinitepef in pairs(workspace:GetChildren()) do
    if infinitepef:IsA("Model") then
        local tool = infinitepef:FindFirstChildOfClass("tool")
        processtool(tool, function()
            safemodeprint("handle found [debug]")
        end)
    end
end
end

playertools()
workspacetools()


-- // Keybind functionality \\ --
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then if input.KeyCode == Enum.KeyCode.LeftBracket then
        if keybinds["Enabled"] == "[" then
            keybinds["Enabled"] = false
            if not config["Safe mode"] then print("Disabled [debug]")
            end
        else
            keybinds["Enabled"] = true
                if not config["Safe mode"] then print("Enabled [debug]")
                end
            end
        end
    end
end)
-----------------------------------------------------
local t = {
    "grippos",
    "handle",
    "secret"
}

local i = 1

uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightBracket then
            i = i % #t + 1 -- chatgpt'd this part cuz fuck math LUL
            config["Tank type"] = t[i]
            debugPrint("Tank type changed to: " .. config["Tank type"] .. " [debug]")
            end
        end
    end)
		

-- // Core \\ --

local name = (identifyexecutor or getexecutorname)()
if not config["Safe mode"] then print(name)
    if name ~= "Wave" and name ~= "Codex" then
    config["Universal/Watchdog Bypass Mode"] = false
    safemodeprint("unsupported executor, disabling universal/watchdog bypass [debug]")
    end
end

runservice.RenderStepped:Connect(function()
    if not config["Enabled"] then return end
    pcall(function()
        for each, fatass in pairs(players:GetPlayers()) do
            if fatass.UserId ~= client.UserId then
                local backpack = player:FindFirstChild("Backpack")
                if backpack then
                    local tool = backpack:FindFirstChildOfClass("Tool")
                    processTool(tool, function(handle)
                        if config["Universal/Watchdog Bypass Mode"] then
                            setsecureinstance(handle)
                        end
            if config["Tank type"]:lower() == "grippos" then
            handle.Position = Vector3.new(9999, 9999, 9999)
        elseif config["Tank type"]:lower() == "handle" then
            handle.Size = Vector3.new(0, 0, 0)
        elseif config["Tank type"]:lower() == "secret" then
            handle.Anchored = true
        end
    end)
end
end
end
end)
end)
