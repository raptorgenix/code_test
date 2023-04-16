local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
 
local player = Players.LocalPlayer 
local playerGui = player:WaitForChild("PlayerGui")
 
-- Creating a basic loading screen - pulling assets from my other games
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
local loadframe = Instance.new("Frame")
loadframe.Size = UDim2.new(1,0,1,0)
loadframe.Parent = screenGui
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
textLabel.Font = Enum.Font.GothamSemibold
textLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
textLabel.Text = "Loading"
textLabel.TextSize = 28
textLabel.Parent = loadframe
local loadingRing = Instance.new("ImageLabel")
loadingRing.Size = UDim2.new(0, 115, 0, 175)
loadingRing.BackgroundTransparency = 1
loadingRing.Image = "http://www.roblox.com/asset/?id=5208964067"
loadingRing.AnchorPoint = Vector2.new(0.5, 0.5)
loadingRing.Position = UDim2.new(0.5, 0, 0.7, 0)
loadingRing.Parent = loadframe

local watermark = Instance.new("ImageLabel")
watermark.Size = UDim2.new(0, 300, 0, 50)
watermark.BackgroundTransparency = 1

watermark.Image = "http://www.roblox.com/asset/?id=5209015616"
watermark.AnchorPoint = Vector2.new(0.5, 0.5)
watermark.Position = UDim2.new(0.5, 0, 0.9, 0)
watermark.Parent = loadframe



screenGui.DisplayOrder = 5
-- Parent entire screen GUI to player GUI
screenGui.Parent = playerGui
game.StarterGui:setCoreGuiEnabled("Chat",false)
 
-- Remove the default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()
 
local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
local tween = TweenService:Create(loadingRing, tweenInfo, {Rotation=360})
tween:Play()

task.wait(3)  -- this is minimum loading screen time

if not game:IsLoaded() then
	game.Loaded:Wait()
end
object = loadframe
object.AnchorPoint = Vector2.new(0.5, 0.5)
object.Position = UDim2.new(.5, 0, .5, 0)
 
task.wait(2)
game.StarterGui:setCoreGuiEnabled("Chat",true)
 
object:TweenPosition(UDim2.new(.5, 0, -1, 0))
task.wait(2)
tween:Destroy()
loadframe:Destroy()
screenGui:Destroy()
