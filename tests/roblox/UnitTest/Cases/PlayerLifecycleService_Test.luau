-- Tests for the player lifecycle service using isolated fake Players signals.
return function(t)
    local expect = t.expect
    local factory = t.modules.PlayerLifecycleService

    local function newSignal()
        local signal = {
            listeners = {},
            connectionCount = 0,
            activeCount = 0,
            onConnect = nil,
        }

        function signal:Connect(callback)
            local connection = { connected = true, callback = callback }
            table.insert(self.listeners, connection)
            self.connectionCount += 1
            self.activeCount += 1

            function connection:Disconnect()
                if self.connected then
                    self.connected = false
                    signal.activeCount -= 1
                end
            end

            if self.onConnect then
                self.onConnect()
            end
            return connection
        end

        function signal:Fire(player)
            local listeners = table.clone(self.listeners)
            for _, connection in ipairs(listeners) do
                if connection.connected then
                    connection.callback(player)
                end
            end
        end

        return signal
    end

    local function newPlayer(userId)
        local player = {
            UserId = userId,
            attributes = {},
            writes = {},
        }

        function player:SetAttribute(name, value)
            self.attributes[name] = value
            self.writes[name] = self.writes[name] or {}
            table.insert(self.writes[name], value)
        end

        return player
    end

    local function newPlayers(initialPlayers)
        local players = {
            PlayerAdded = newSignal(),
            PlayerRemoving = newSignal(),
            current = initialPlayers or {},
        }

        function players:GetPlayers()
            return self.current
        end

        return players
    end

    -- A join event racing with the startup snapshot initializes that Player once.
    t.test("deduplicates a join during startup enumeration", function()
        local player = newPlayer(101)
        local players = newPlayers({ player })
        players.PlayerAdded.onConnect = function()
            players.PlayerAdded:Fire(player)
        end

        local service = factory.new(players)
        service.Start()

        expect.equal(player.attributes.SessionInitialized, true)
        expect.equal(#player.writes.SessionInitialized, 1)
        expect.equal(players.PlayerAdded.connectionCount, 1)
        expect.equal(players.PlayerRemoving.connectionCount, 1)
    end)

    -- Repeated Start calls keep one listener pair and duplicate joins are ignored.
    t.test("keeps one listener pair when Start is repeated", function()
        local players = newPlayers()
        local player = newPlayer(102)
        local service = factory.new(players)

        service.Start()
        service.Start()
        players.PlayerAdded:Fire(player)
        players.PlayerAdded:Fire(player)

        expect.equal(players.PlayerAdded.connectionCount, 1)
        expect.equal(players.PlayerRemoving.connectionCount, 1)
        expect.equal(player.attributes.SessionInitialized, true)
        expect.equal(#player.writes.SessionInitialized, 1)
    end)

    -- Each distinct player is initialized independently and only once.
    t.test("initializes each joining player once", function()
        local players = newPlayers()
        local first = newPlayer(103)
        local second = newPlayer(104)
        local service = factory.new(players)

        service.Start()
        players.PlayerAdded:Fire(first)
        players.PlayerAdded:Fire(second)

        expect.equal(first.attributes.SessionInitialized, true)
        expect.equal(second.attributes.SessionInitialized, true)
        expect.equal(#first.writes.SessionInitialized, 1)
        expect.equal(#second.writes.SessionInitialized, 1)
    end)

    -- Leaving resets the attribute and repeated removal notifications are harmless.
    t.test("resets SessionInitialized to false once on leave", function()
        local player = newPlayer(105)
        local players = newPlayers()
        local service = factory.new(players)

        service.Start()
        players.PlayerAdded:Fire(player)
        players.PlayerRemoving:Fire(player)
        players.PlayerRemoving:Fire(player)

        expect.equal(player.attributes.SessionInitialized, false)
        expect.equal(#player.writes.SessionInitialized, 2)
        expect.equal(player.writes.SessionInitialized[1], true)
        expect.equal(player.writes.SessionInitialized[2], false)
    end)

    -- Stop disconnects both listeners; restarting reconnects once and processes current players.
    t.test("disconnects on Stop and reconnects on restart", function()
        local player = newPlayer(106)
        local players = newPlayers({ player })
        local service = factory.new(players)

        service.Start()
        expect.equal(player.attributes.SessionInitialized, true)
        service.Stop()
        expect.equal(players.PlayerAdded.activeCount, 0)
        expect.equal(players.PlayerRemoving.activeCount, 0)

        local writesAfterStop = #player.writes.SessionInitialized
        players.PlayerAdded:Fire(newPlayer(107))
        expect.equal(#player.writes.SessionInitialized, writesAfterStop)

        service.Start()
        expect.equal(players.PlayerAdded.connectionCount, 2)
        expect.equal(players.PlayerRemoving.connectionCount, 2)
        expect.equal(players.PlayerAdded.activeCount, 1)
        expect.equal(players.PlayerRemoving.activeCount, 1)
        expect.equal(#player.writes.SessionInitialized, writesAfterStop + 1)
        service.Stop()
    end)
end
