local Players = game:GetService("Players")
local PlayerData = require(script.Parent.PlayerData)
local soundsFolder = game.ReplicatedStorage.Assets.Sounds

local RequestPaycheck: RemoteFunction = game.ReplicatedStorage.Remotes.RequestPaycheck
local UpdatePaycheckMachines: RemoteEvent = game.ReplicatedStorage.Remotes.UpdatePaycheckMachines

local PAYCHECK_UPDATE_INTERVAL = 1
local PAYCHECK_BASE_VALUE = 25
local INCOME_PER_PAD = 10
local addedIncome = 0

local function onPlayerAdded(player)
	task.wait(3)

	while true do
		addedIncome = (PlayerData:GetNumberOfPads(player) * INCOME_PER_PAD)
		local incomeRate = addedIncome + PAYCHECK_BASE_VALUE
		--If player has gamepass for autocollect, this will run instead of updating the machine
		if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, 162566444) then
			PlayerData:SetMoney(player, PlayerData:GetMoney(player) + PAYCHECK_BASE_VALUE + addedIncome)
			UpdatePaycheckMachines:FireClient(player, 0, incomeRate)
		else
			PlayerData:SetPaycheckWithdrawAmount(player, PlayerData:GetPaycheckWithdrawAmount(player) + PAYCHECK_BASE_VALUE + addedIncome)
			UpdatePaycheckMachines:FireClient(player, PlayerData:GetPaycheckWithdrawAmount(player), incomeRate)
		end
		
		task.wait(PAYCHECK_UPDATE_INTERVAL)
		
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

RequestPaycheck.OnServerInvoke = function(player, amount)	
	--Sanity check to avoid money deposits from exploits - money added has to match machine's current withdrawal amount
	if(amount ~= PlayerData:GetPaycheckWithdrawAmount(player)) then 
		print("Money not added - does not pass verification")
		return
	end
	local incomeRate = addedIncome + PAYCHECK_BASE_VALUE
	PlayerData:AddMoney(player, amount)
	soundsFolder.UpgradePadPurchase.Sound:Play()
	
	local paycheck = PlayerData:SetPaycheckWithdrawAmount(player, 0)
	UpdatePaycheckMachines:FireClient(player, PlayerData:GetPaycheckWithdrawAmount(player), incomeRate)
	
	return amount
end
