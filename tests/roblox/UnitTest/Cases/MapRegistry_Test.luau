-- Tests for the canonical map registry.
return function(t)
    local expect = t.expect
    local registry = t.modules.MapRegistry
    local expectedNames = {
        "Arvandill",
        "Sandquill",
        "Starkrock",
        "Western Glades",
        "Dar'Hanok",
        "Vornstead",
        "West Land",
    }

    -- The registry exposes exactly the seven canonical IDs and names.
    t.test("returns all canonical maps in permanent ID order", function()
        expect.equal(registry.GetCount(), 7)
        local maps = registry.GetAll()
        expect.equal(#maps, 7)
        for id, expectedName in ipairs(expectedNames) do
            local map = registry.GetById(id)
            expect.truthy(map ~= nil)
            expect.equal(map.Id, id)
            expect.equal(map.Name, expectedName)
            expect.truthy(table.isfrozen(map))
        end
    end)

    -- IDs outside the canonical range are rejected.
    t.test("rejects missing, zero, and out-of-range IDs", function()
        expect.falsy(registry.IsValidId(0))
        expect.falsy(registry.IsValidId(8))
        expect.equal(registry.GetById(0), nil)
        expect.equal(registry.GetById(8), nil)
    end)

    -- The returned array is a copy, so callers cannot reorder registry state.
    t.test("returns a fresh list from GetAll", function()
        local first = registry.GetAll()
        local second = registry.GetAll()
        expect.truthy(first ~= second)
        first[1] = nil
        expect.equal(registry.GetCount(), 7)
        expect.equal(registry.GetById(1).Name, "Arvandill")
    end)
end
