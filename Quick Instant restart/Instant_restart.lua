if Network:is_server() and Utils:IsInHeist() and Utils:IsInGameState() and not managers.job:is_current_job_professional() and not in_chat then
	local all_synced = true
	for k,v in pairs(managers.network:session():peers()) do
		if not v:synched() then
			all_synced = false
		end
	end
	if all_synced == true then
		managers.game_play_central:restart_the_game()
	else
		managers.chat:_receive_message(1, "[Instant Restart]", "Cannot restart, a player may be loading.", Color.red)
	end
end