-- Tests for the shared immutable project configuration.
return function(t)
    local expect = t.expect
    local config = t.modules.ProjectConfig

    -- The shared config exposes the Foundation 0.1 identity and map count.
    t.test("contains the canonical project identity", function()
        expect.equal(config.ProjectName, "Aethermoor")
        expect.equal(config.Version, "0.1.0")
        expect.equal(config.Environment, "Development")
        expect.equal(config.MapCount, 7)
    end)

    -- Consumers cannot mutate the shared configuration table.
    t.test("is immutable", function()
        expect.truthy(table.isfrozen(config))
    end)
end
