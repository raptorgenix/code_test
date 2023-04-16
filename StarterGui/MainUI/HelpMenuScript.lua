local helpButton = script.Parent
local help = script.Parent.Parent.Parent.HelpMenu
local tweenToLoc = UDim2.new(0.25, 0, 0.275, 0)
local tweenOutLoc = UDim2.new(0.25, 0, -.6, 0)

helpButton.MouseButton1Down:connect(function()
	if(help.Visible == false) then

		help.Visible = true
		help:TweenPosition(tweenToLoc, Enum.EasingDirection.In, Enum.EasingStyle.Sine, .5, true, nil)
		task.wait(.5)
		helpButton.Text = "Close"

	else
		help:TweenPosition(tweenOutLoc, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, .5, true, nil)
		task.wait(.5)
		help.Visible = false
		helpButton.Text = "Help"
	end
end)
