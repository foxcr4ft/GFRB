--!strict

local ServerStorage = game:GetService("ServerStorage")
local totals = require(ServerStorage:WaitForChild("UnitTest"):WaitForChild("RunUnitTest"))()
assert(totals.failed == 0, string.format("%d Foundation unit test(s) failed.", totals.failed))
