local prefix = "[Force Ready]"
local red = Color.red
local green = Color.green


local function say(str, colour)
	managers.chat:_receive_message(1, prefix, str, colour)
end

local function isSynced()
	for _, peer in pairs(LuaNetworking:GetPeers()) do
		if not peer:synched() then
			return false
		end
	end
	
	return true
end

local function tryStart()
	if not LuaNetworking:IsMultiplayer() then
		say("Not multiplayer", red)
		return false
	end
	
	if not LuaNetworking:IsHost() then
		say("Not host", red)
		return false
	end
	
	if Utils:IsInHeist() or not Utils:IsInGameState() then
		say("Not in loudout", red)
		return false
	end
	
	if not isSynced() then
		say("Not all players synched, some one may be joining", red)
		return false
	end
	
	say("Starting", green)
	game_state_machine:current_state():start_game_intro()
end

tryStart()