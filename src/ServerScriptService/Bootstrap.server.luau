--!strict

local ServerScriptService = game:GetService("ServerScriptService")
local servicesFolder = ServerScriptService:WaitForChild("Services")

local PlayerLifecycleService = require(servicesFolder:WaitForChild("PlayerLifecycleService"))

PlayerLifecycleService.Start()

print("[Aethermoor] Server bootstrap complete.")
