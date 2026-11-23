--!strict

export type MapDefinition = {
	Id: number,
	Name: string,
	MinLevel: number,
	MaxLevel: number,
}

local maps: { MapDefinition } = {
	{ Id = 1, Name = "Arvandill", MinLevel = 1, MaxLevel = 10 },
	{ Id = 2, Name = "Sandquill", MinLevel = 10, MaxLevel = 18 },
	{ Id = 3, Name = "Starkrock", MinLevel = 18, MaxLevel = 26 },
	{ Id = 4, Name = "Western Glades", MinLevel = 26, MaxLevel = 34 },
	{ Id = 5, Name = "Dar'Hanok", MinLevel = 34, MaxLevel = 42 },
	{ Id = 6, Name = "Vornstead", MinLevel = 42, MaxLevel = 50 },
	{ Id = 7, Name = "West Land", MinLevel = 50, MaxLevel = 65 },
}

local byId: { [number]: MapDefinition } = {}

for _, map in ipairs(maps) do
	assert(byId[map.Id] == nil, `Duplicate map ID: {map.Id}`)
	byId[map.Id] = table.freeze(map)
end

local MapRegistry = {}

function MapRegistry.GetById(mapId: number): MapDefinition?
	return byId[mapId]
end

function MapRegistry.GetAll(): { MapDefinition }
	local result: { MapDefinition } = {}
	for index, map in ipairs(maps) do
		result[index] = map
	end
	return result
end

function MapRegistry.GetCount(): number
	return #maps
end

function MapRegistry.IsValidId(mapId: number): boolean
	return byId[mapId] ~= nil
end

return table.freeze(MapRegistry)
