--!strict

local PlayerLifecycleService = {}

local function createService(players: any)
    local started = false
    local initializedPlayers: { [any]: boolean } = {}
    local playerAddedConnection: RBXScriptConnection? = nil
    local playerRemovingConnection: RBXScriptConnection? = nil

    local function onPlayerAdded(player: Player)
        if initializedPlayers[player] then
            return
        end
        initializedPlayers[player] = true

        -- This attribute only indicates that the basic server session hook ran.
        -- It does not mean character data has been loaded or persisted.
        player:SetAttribute("SessionInitialized", true)
        print(`[Aethermoor] Player joined: {player.UserId}`)
    end

    local function onPlayerRemoving(player: Player)
        if not initializedPlayers[player] then
            return
        end
        initializedPlayers[player] = nil
        player:SetAttribute("SessionInitialized", false)
        print(`[Aethermoor] Player leaving: {player.UserId}`)
    end

    local service = {}

    function service.Start()
        if started then
            return
        end

        started = true
        playerAddedConnection = players.PlayerAdded:Connect(onPlayerAdded)
        playerRemovingConnection = players.PlayerRemoving:Connect(onPlayerRemoving)

        -- Connecting before enumerating closes the join/enumeration race;
        -- onPlayerAdded makes the two paths idempotent for the same Player.
        for _, player in ipairs(players:GetPlayers()) do
            onPlayerAdded(player)
        end
    end

    function service.Stop()
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

        table.clear(initializedPlayers)
    end

    return service
end

-- A factory lets automated tests exercise lifecycle behavior with isolated Players signals.
function PlayerLifecycleService.new(players: any)
    return createService(players)
end

local defaultService: any = nil

function PlayerLifecycleService.Start()
    if defaultService == nil then
        defaultService = createService(game:GetService("Players"))
    end
    defaultService.Start()
end

function PlayerLifecycleService.Stop()
    if defaultService ~= nil then
        defaultService.Stop()
    end
end

return table.freeze(PlayerLifecycleService)
