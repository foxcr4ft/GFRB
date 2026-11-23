--!strict

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local expect = {}

function expect.equal(actual: any, expected: any)
    if actual ~= expected then
        error(string.format("expected %s, got %s", tostring(expected), tostring(actual)), 2)
    end
end

function expect.truthy(value: any)
    if not value then
        error("expected a truthy value", 2)
    end
end

function expect.falsy(value: any)
    if value then
        error("expected a falsy value", 2)
    end
end

local modules = {
    ProjectConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ProjectConfig")),
    MapRegistry = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MapRegistry")),
    PlayerLifecycleService = require(ServerScriptService:WaitForChild("Services"):WaitForChild("PlayerLifecycleService")),
}

return function(filter: string?)
    local casesFolder = ServerStorage:WaitForChild("UnitTest"):WaitForChild("Cases")
    local totals = { run = 0, passed = 0, failed = 0 }
    local startedAt = os.clock()

    for _, caseModule in ipairs(casesFolder:GetChildren()) do
        if caseModule:IsA("ModuleScript") and (filter == nil or string.find(caseModule.Name, filter, 1, true)) then
            local okRequire, caseFn = pcall(require, caseModule)
            if not okRequire or type(caseFn) ~= "function" then
                totals.run += 1
                totals.failed += 1
                warn(string.format("[FAIL] %s | case did not return a function: %s", caseModule.Name, tostring(caseFn)))
            else
                local context = { expect = expect, modules = modules }
                function context.test(name: string, fn: () -> ())
                    totals.run += 1
                    local caseStartedAt = os.clock()
                    local ok, err = pcall(fn)
                    local elapsed = os.clock() - caseStartedAt
                    if ok then
                        totals.passed += 1
                        print(string.format("[PASS] %s > %s (%.3fs)", caseModule.Name, name, elapsed))
                    else
                        totals.failed += 1
                        warn(string.format("[FAIL] %s > %s (%.3fs) | %s", caseModule.Name, name, elapsed, tostring(err)))
                    end
                end

                local okRun, runErr = pcall(caseFn, context)
                if not okRun then
                    totals.run += 1
                    totals.failed += 1
                    warn(string.format("[FAIL] %s | error while building cases: %s", caseModule.Name, tostring(runErr)))
                end
            end
        end
    end

    print(string.format("[SUMMARY] %d run, %d passed, %d failed, %.3fs", totals.run, totals.passed, totals.failed, os.clock() - startedAt))
    return totals
end
