local songFolder = game.ReplicatedStorage.Assets.Songs

song = songFolder:WaitForChild("General")

print("now playing song")
song:Play()
