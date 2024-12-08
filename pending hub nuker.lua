--[[ 
nukes pending hubs of games with infinite rejoins lol 
set in autoexec and use multi-instance for stronger nuking
ratelimits their webhook after a while meaning noone can join the event W
--]]


local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local JobId = game.JobId
local player = Players.LocalPlayer

while true do
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
