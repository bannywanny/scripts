--[[ 
nukes pending hubs of games with infinite rejoins lol 
set in autoexec and use multi-instance for stronger nuking
ratelimits their webhook after a while meaning noone can join the event W
press q to stop rejoining
--]]


local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local PlaceId = game.PlaceId
local JobId = game.JobId
local player = Players.LocalPlayer
local rejoining = true

local function oninput(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Q then
        rejoining = false
    end
end

UserInputService.InputBegan:Connect(oninput)

while true do
    if not rejoining then
        break
    end
    
    local g = Players:GetChildren()
    if #g >= 1 then
        player:Kick("v64")
        wait()
        TeleportService:Teleport(PlaceId, player)
    else
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, player)
    end
    
    wait(0.5)
end
