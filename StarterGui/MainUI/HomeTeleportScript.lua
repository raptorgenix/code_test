local player = game.Players.LocalPlayer
local rootPart = player.Character:WaitForChild("HumanoidRootPart")
local button = script.Parent

local debounce = os.time()

button.MouseButton1Click:Connect(function()
	local now = os.time()
	if now - debounce > 1 then
		debounce = os.time()
		rootPart.CFrame = CFrame.new(-47.988, 21.689, -3.724)
			
	end
end)

