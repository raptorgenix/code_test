local player = game.Players.LocalPlayer
local rootPart = player.Character:WaitForChild("HumanoidRootPart")
local button = script.Parent

local debounce = os.time()

local teleportLocations = {
	Vector3.new(280.636, 174.212, -543.756),
	Vector3.new(-229.364, 175.598, 601.76)
}

button.MouseButton1Click:Connect(function()
	local now = os.time()
	if now - debounce > 1 then
		debounce = os.time()
		local chooseTeleport = math.random(1, 2)
		rootPart.CFrame = CFrame.new(teleportLocations[chooseTeleport])
			
	end
end)

