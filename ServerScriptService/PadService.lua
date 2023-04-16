local PadPurchase: BindableEvent = game.ReplicatedStorage.PadPurchase
local PlayerData = require(script.Parent.PlayerData)
local MarketplaceService = game:GetService("MarketplaceService")
local padsFolder = workspace.Pads
local effectsFolder = workspace.Effects
local soundsFolder = game.ReplicatedStorage.Assets.Sounds
local pads = padsFolder:GetChildren()

local UpdatePaycheckMachines: RemoteEvent = game.ReplicatedStorage.Remotes.UpdatePaycheckMachines

local buildingsFolder = workspace.Buildings
buildingsFolder.Parent = game.ReplicatedStorage
padsFolder.Parent = game.ReplicatedStorage

local debouncer  = os.time()

local function triggerPurchaseEffect(player, pad)
	local effect = effectsFolder:FindFirstChild("PurchaseEffect")
	local effectClone = effect:Clone()
	effectClone.Parent = workspace
	local padPosition = pad.Pad.Position
	local effectPosition = Vector3.new(padPosition.X, padPosition.Y + 4, padPosition.Z)
	effectClone.Position = effectPosition
	soundsFolder.Money.Sound:Play()
	pad.Skin:Destroy()
	pad.Pad:Destroy()
	pad.BillboardGui:Destroy()
	task.wait(1)
	-- If you destroy the parent without disabling the emitter, all the particles are removed instantly without having a chance to fall first, this looks much smoother
	effectClone.CoinsEmitter.Enabled = false
	task.wait(1)
	effectClone:Destroy()
end

local function revealNextPad(player, pad)
	local allPads = padsFolder:GetChildren()
	for index, newPad in allPads do
		if (tostring(pad.Name) == tostring(newPad.Dependency.Value)) then
			newPad.Parent = workspace
		end
	end
end

local function onPadTouch(player, pad)
	--Debouncer to prevent multiple "not enough money" noises
	local now = os.time()
	if now - debouncer > 1 then
		debouncer = os.time()
		--Gamepass pad handling
		local gameProduct = pad:FindFirstChild("GameProduct")
		if gameProduct then
				MarketplaceService:PromptGamePassPurchase(player, 162566444)
			return
		end
		
		-- Need to verify if player has money to purchase pad (supposed to sound bad if you can't afford it; but none of the effects were very "bad")	
		local padPrice = pad:GetAttribute("Price")
		if(PlayerData:GetMoney(player) < padPrice) then 
			soundsFolder["screen-change"].Sound:Play()
			return
		end
		
		PlayerData:SubtractMoney(player, padPrice)
		local buildingClone = pad.Target.Value:Clone()
		buildingClone.Parent = workspace
		
		PadPurchase:Fire(pad)
		revealNextPad(player, pad)
		triggerPurchaseEffect(player, pad)
		
		--Modify number of pads to include new one
		PlayerData:SetNumberOfPads(player, PlayerData:GetNumberOfPads(player) + 1)
	end
	
end


for index, pad in pads do
	local dependency = pad.Dependency.Value
	local touchingArea: BasePart = pad.Pad
	
	if not dependency then
		pad.Parent = workspace
	end
	--No need to check other conditions if it's a gamepass pad, send it directly to the onPadTouch
	if pad:FindFirstChild("GameProduct") then
		touchingArea.Touched:Connect(function(hit)
			local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
			onPadTouch(player, pad)
		end)
	else
	--Logic for building pads
	if pad:GetAttribute("isFinished") then
		return
	end
	
	touchingArea.Touched:Connect(function(hit)
		if dependency then
			if not dependency:GetAttribute("isFinished") then				
				return
			end
		end
		
		pad:SetAttribute("isFinished", true)
		local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
			onPadTouch(player, pad)
			
		end)
	end
end

--Left this in, no functionality besides printing to console what's happening
local function onPadPurchased(pad)
	local message = ("Pad %s was purchased!"):format(pad.Name)
	print(message)
	
end

PadPurchase.Event:Connect(onPadPurchased)
