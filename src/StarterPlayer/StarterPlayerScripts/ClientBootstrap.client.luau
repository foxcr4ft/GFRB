--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local sharedFolder = ReplicatedStorage:WaitForChild("Shared")

local ProjectConfig = require(sharedFolder:WaitForChild("ProjectConfig"))
local MapRegistry = require(sharedFolder:WaitForChild("MapRegistry"))

assert(MapRegistry.GetCount() == ProjectConfig.MapCount, "Map registry count does not match ProjectConfig.")

for mapId = 1, ProjectConfig.MapCount do
	assert(MapRegistry.IsValidId(mapId), `Missing canonical map ID: {mapId}`)
end

print(`[Aethermoor] Client initialized. Version {ProjectConfig.Version}`)
