Hooks:PostHook(NetworkPeer, "set_ip_verified", "cheaterz_go_to_hell_haha", function(self, state)

	if not Network:is_server() then
		return
	end

	DelayedCalls:Add( "cheaterz_go_to_hell_d", 2, function()
		local user = Steam:user(self:ip())
		if user and user:rich_presence("is_modded") == "1" or self:is_modded() then
			managers.chat:feed_system_message(1, self:name() .. " HAS MODS! Checking...")
			for i, mod in ipairs(self:synced_mods()) do
				local mod_mini = string.lower(mod.name)	
				local kick_on = {}
				local potential_hax = {}
				local prob_not_clean = nil

				kick_on = {
					"pirate perfection",
					"p3dhack",
					"p3dhack free",
					"p3dunlocker",
					"arsium's weapons rebalance recoil",
					"overkill mod",
					"selective dlc unlocker",
					"the great skin unlock",
					"beyond cheats"
				}

				for _, v in pairs(kick_on) do
					if mod_mini == v then
						local identifier = "cheater_banned_" .. tostring(self:id())
						managers.ban_list:ban(identifier, self:name())
						managers.chat:feed_system_message(1, self:name() .. " has been kicked because of using the mod: " .. mod.name)
						local message_id = 0
						message_id = 6
						managers.network:session():send_to_peers("kick_peer", self:id(), message_id)
						managers.network:session():on_peer_kicked(self, self:id(), message_id)
						return
					end
				end

				potential_hax = {
					"pirate",
					"p3d",
					"hack",
					"cheat",
					"unlocker",
					"unlock",
					"dlc",
					"trainer",
					"silent assassin",
					"carry stacker",
					"god",
					"x-ray",
					"dlc unlocker",
					"skin unlocker",
					"mvp"
				}

				for k, pc in pairs(potential_hax) do
					if string.find(mod_mini, pc) then
						log("found something!")
						managers.chat:feed_system_message(1, self:name() .. " is using a mod that can be a potential cheating mod: " .. mod.name)
						prob_not_clean = 1
					end
				end
			end

			if prob_not_clean then
				managers.chat:feed_system_message(1, self:name() .. " has a warning... Check his mods/profile manually to be sure.")
			else
				managers.chat:feed_system_message(1, self:name() .. " seems to be clean.")
			end
		else
			managers.chat:feed_system_message(1, self:name() .. " doesn't seem to have mods.")
		end
	end)
end)