--!strict

local Players = game:GetService("Players")

local PlayerLifecycleService = {}

local started = false
local playerAddedConnection: RBXScriptConnection? = nil
local playerRemovingConnection: RBXScriptConnection? = nil

local function onPlayerAdded(player: Player)
	-- This attribute only indicates that the basic server session hook ran.
	-- It does not mean character data has been loaded or persisted.
	player:SetAttribute("SessionInitialized", true)
	print(`[Aethermoor] Player joined: {player.UserId}`)
end

local function onPlayerRemoving(player: Player)
	player:SetAttribute("SessionInitialized", false)
	print(`[Aethermoor] Player leaving: {player.UserId}`)
end

function PlayerLifecycleService.Start()
	if started then
		return
	end

	started = true
	playerAddedConnection = Players.PlayerAdded:Connect(onPlayerAdded)
	playerRemovingConnection = Players.PlayerRemoving:Connect(onPlayerRemoving)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(onPlayerAdded, player)
	end
end

function PlayerLifecycleService.Stop()
	if not started then
		return
	end

	started = false

	if playerAddedConnection then
		playerAddedConnection:Disconnect()
		playerAddedConnection = nil
	end

	if playerRemovingConnection then
		playerRemovingConnection:Disconnect()
		playerRemovingConnection = nil
	end
end

return PlayerLifecycleService
