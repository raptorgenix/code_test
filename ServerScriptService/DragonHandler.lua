local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dragonFolder = ReplicatedStorage.Dragons

local startingPositions = {
	Vector3.new(-2738.488, 380.689, 53.776),
	Vector3.new(-33.488, 380.689, 1592.776),
	Vector3.new(854.512, 380.689, -1519.224),
	Vector3.new(2729.512, 380.689, -323.224)
}
local targetPositions = {
	Vector3.new(405.512, 380.689, -1655.224),
	Vector3.new(-853.488, 380.689, 1607.776),
	Vector3.new(-1606.488, 380.689, 1180.776),
	Vector3.new(1843.512, 380.689, 912.776)
}

local DragonTween = TweenInfo.new(
	40, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.In, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local function MoveDragon(dragon, info, target)

	local targetCframe = CFrame.new(target)
	local dragonRoot = dragon.HumanoidRootPart
	
	local facing = CFrame.lookAt(dragonRoot.Position, target)
	local facingOrientation = facing-facing.Position
	local newTargetCframe = facingOrientation + targetCframe.Position

	dragon:PivotTo(facing)

	local cframe = Instance.new("CFrameValue") 
	cframe.Value = dragon:GetPrimaryPartCFrame() 
	cframe.Changed:Connect(function(value)
		dragon:SetPrimaryPartCFrame(value)
	end)

	local tween = TweenService:Create(cframe, DragonTween, {Value = newTargetCframe}) 
	tween:Play()

	tween.Completed:Connect(function()
		dragon:Destroy()
		cframe:Destroy()
	end)
end


while true do
	task.wait(7)
	--Random chance to spawn dragon every 7 seconds
	local spawnDragonChoice = math.random(1,4)

	
	if(spawnDragonChoice == 1) then 
		print("Spawning dragon")
		local dragon
		--Picking dragon type for rarity
		local chooseDragon = math.random(1,20)
		if(chooseDragon == 1) then
			dragon = dragonFolder.Dragon_1:Clone()
		elseif(chooseDragon == 2 or chooseDragon == 3) then
			dragon = dragonFolder.Dragon_2:Clone()
		elseif(chooseDragon < 9) then 
			dragon = dragonFolder.Dragon_3:Clone()
		elseif(chooseDragon < 16) then
			dragon = dragonFolder.Dragon_4:Clone()
		else
			dragon = dragonFolder.Dragon_5:Clone()
		end
		
		local chooseStart = math.random(1, 4)
		local start = startingPositions[chooseStart]
		local startCframe = CFrame.new(start)
		local chooseTarget = math.random(1, 4)
		local target = targetPositions[chooseTarget]
		dragon:PivotTo(startCframe)
		dragon.Parent = workspace

		MoveDragon(dragon, DragonTween, target)
	end
end
