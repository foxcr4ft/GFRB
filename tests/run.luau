-- Runs the shared contract cases in Lune for GitHub Actions.
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local function compileLuauFiles(directory)
    for _, entryName in fs.readDir(directory) do
        local path = directory .. "/" .. entryName
        if fs.isDir(path) then
            compileLuauFiles(path)
        elseif string.sub(entryName, -5) == ".luau" then
            luau.compile(fs.readFile(path))
            print("[COMPILE] " .. path)
        end
    end
end

compileLuauFiles("src")
compileLuauFiles("tests")

local modules = {
    ProjectConfig = require("../src/ReplicatedStorage/Shared/ProjectConfig"),
    MapRegistry = require("../src/ReplicatedStorage/Shared/MapRegistry"),
    PlayerLifecycleService = require("../src/ServerScriptService/Services/PlayerLifecycleService"),
}

local expect = {}
function expect.equal(actual, expected)
    assert(actual == expected, string.format("expected %s, got %s", tostring(expected), tostring(actual)))
end
function expect.truthy(value)
    assert(value, "expected a truthy value")
end
function expect.falsy(value)
    assert(not value, "expected a falsy value")
end

local totals = { run = 0, passed = 0, failed = 0 }

local function runCase(name, fn)
    totals.run += 1
    local startedAt = os.clock()
    local ok, err = pcall(fn)
    local elapsed = os.clock() - startedAt
    if ok then
        totals.passed += 1
        print(string.format("[PASS] %s (%.3fs)", name, elapsed))
    else
        totals.failed += 1
        warn(string.format("[FAIL] %s (%.3fs): %s", name, elapsed, tostring(err)))
    end
end

for _, caseName in ipairs({
    "ProjectConfig_Test",
    "MapRegistry_Test",
    "PlayerLifecycleService_Test",
}) do
    local caseModule = require("./roblox/UnitTest/Cases/" .. caseName)
    local context = { expect = expect, modules = modules }
    context.test = function(name, fn)
        runCase(caseName .. " > " .. name, fn)
    end
    local ok, err = pcall(caseModule, context)
    if not ok then
        totals.run += 1
        totals.failed += 1
        warn("[FAIL] " .. caseName .. " | failed to build cases: " .. tostring(err))
    end
end

print(string.format("[SUMMARY] %d run, %d passed, %d failed", totals.run, totals.passed, totals.failed))
assert(totals.failed == 0, string.format("%d test(s) failed.", totals.failed))
