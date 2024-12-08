--[[
nukes pending hubs to ratelimit and ruin events
put in autoexec
if you're on codex i wouldnt use this if i were u cuz youll get in a infinite rejoin loop if u put this in autoexec
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
