local ServerScriptService = game:GetService("ServerScriptService")


local UpdateUI: RemoteEvent = game.ReplicatedStorage.Remotes.UpdateUI

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("MoneyGui")
local HUD = ScreenGui:WaitForChild("MoneyFrame")

local moneyLabel = HUD:WaitForChild("MoneyLabel")
local moneyAddedLabel = HUD:WaitForChild("MoneyChangeLabel")

UpdateUI.OnClientEvent:Connect(function(amount)
	local prevMoney = tonumber(moneyLabel.Text)
	moneyLabel.Text = tostring(amount)
	
	local change = amount - prevMoney
	if change > 0 then
		moneyAddedLabel.TextColor3 = Color3.fromRGB(128, 235, 78)
		moneyAddedLabel.Text = ("+ " .. change)
	else
		moneyAddedLabel.TextColor3 = Color3.fromRGB(235, 81, 81)
		moneyAddedLabel.Text = ("- " .. math.abs(change))
	end
	moneyAddedLabel.TextTransparency = .9
	moneyAddedLabel.Visible = true
	
	while(moneyAddedLabel.TextTransparency > 0) do
		moneyAddedLabel.TextTransparency -= .15
		task.wait(.01)
	end
	task.wait(2)
	while(moneyAddedLabel.TextTransparency < 1) do
		moneyAddedLabel.TextTransparency += .15
		task.wait(.01)
	end
	moneyAddedLabel.Visible = false

end)
