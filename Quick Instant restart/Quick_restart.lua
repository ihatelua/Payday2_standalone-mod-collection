function Restart()
	local all_synced = true
	for k,v in pairs(managers.network:session():peers()) do
		if not v:synched() then
			all_synced = false
		end
	end
	if all_synced == true then
		managers.game_play_central:restart_the_game()
	else
		managers.chat:_receive_message(1, "[Quick Restart]", "Cannot restart, a player may be loading.", Color.red)
	end
end

if Network:is_server() and Utils:IsInHeist() and Utils:IsInGameState() and not managers.job:is_current_job_professional() and not in_chat then
	local menu_title = managers.localization:text("dialog_warning_title")
	local menu_message = managers.localization:text("dialog_show_restart_game_message")
	local menu_options = {
		[1] = {
			text = managers.localization:text("dialog_no"),
			is_cancel_button = true,
		},
		[2] = {
			text = managers.localization:text("dialog_yes"),
			callback = Restart,
		},
	}
	local menu = QuickMenu:new(menu_title, menu_message, menu_options)
	menu:Show()
end