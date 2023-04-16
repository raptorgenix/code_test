local paycheckMachinesFolder = workspace.PaycheckMachines
local paycheckMachines = paycheckMachinesFolder:GetChildren()


local RequestPaycheck: RemoteFunction = game.ReplicatedStorage.Remotes.RequestPaycheck
local UpdatePaycheckMachines: RemoteEvent = game.ReplicatedStorage.Remotes.UpdatePaycheckMachines

local nextPaymentValue = 0

-- Fixed Deboouncer - Server invocations take a little time, so reaching the debouncer reset AFTER invocation allowed for multiple .Touched calls before the debouncer could be reset. 
local debouncer  = os.time()

for _, paycheckMachine in paycheckMachines do
	local pad: BasePart = paycheckMachine.PadComponents.Pad
	pad.Touched:Connect(function(hit)
		local now = os.time()
		if now - debouncer > 1 then
			print("Paycheck pad touched")
			debouncer = os.time()
			local paycheck = RequestPaycheck:InvokeServer(nextPaymentValue)
		end
	
	end)
end

UpdatePaycheckMachines.OnClientEvent:Connect(function(amount, rate)
	nextPaymentValue = amount
	for _, paycheckMachine in paycheckMachines do
		--Changed this to not use recursion for performance - direct reference should be faster (obviously not important at small scale)
		local moneyLabel = paycheckMachine.Money_Info_Text.SurfaceGui.MoneyLabel
		local incomeRate = paycheckMachine.Money_Rate_Text.SurfaceGui.RateLabel
		moneyLabel.Text = tostring(amount)
		incomeRate.Text = tostring(rate)
	end
end)
