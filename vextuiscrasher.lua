local args = {
    [1] = false,
    [2] = game:GetService('Players').LocalPlayer.Character.Humanoid:FindFirstChildOfClass('Tool')
}

game:GetService("ReplicatedStorage"):WaitForChild("HotbarRemotes"):WaitForChild("ToolEvent"):FireServer(unpack(args))
