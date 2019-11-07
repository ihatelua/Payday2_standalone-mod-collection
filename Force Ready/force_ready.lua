local prefix = "[Force Ready]"
local red = Color.red
local green = Color.green


local function say(str, colour)
	managers.chat:_receive_message(1, prefix, str, colour)
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
	
	local session = managers.network and managers.network:session()
	local local_peer = session and session:local_peer()
	local time_elapsed = managers.game_play_central and managers.game_play_central:get_heist_timer() or 0
	
	local enough_wait_time = (time_elapsed > 90)
	local friends_list = not enough_wait_time and Steam:logged_on() and Steam:friends() or {}
	local abort = false
	
	for _, peer in ipairs(session:peers()) do
		local is_friend = false
		for _, friend in ipairs(friends_list) do
			if friend:id() == peer:user_id() then
				is_friend = true
				break
			end
		end
		if not (enough_wait_time or is_friend) or not (peer:synced() or peer:id() == local_peer:id()) then
			abort = true
			break
		end
	end
	
	
	say("Starting", green)
	game_state_machine:current_state():start_game_intro()
end

tryStart()
