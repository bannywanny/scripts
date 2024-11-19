local args = {
    [1] = false,
    [2] = game:GetService("Players").LocalPlayer:WaitForChild("Linked Sword")
}

game:GetService("ReplicatedStorage"):WaitForChild("HotbarRemotes"):WaitForChild("ToolEvent"):FireServer(unpack(args))
