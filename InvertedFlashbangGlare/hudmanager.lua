
local previous_value = 0

local update_actual = HUDManager.update
function HUDManager:update(...)
	update_actual(self, ...)

	local managers = _G.managers
	if managers.environment_controller == nil then
		return
	end

	local alive = _G.alive
	local math = _G.math
	local max = math.max
	local alpha = managers.environment_controller._current_flashbang
	if alpha == 0 and alpha == previous_value then
		-- Optimization: Don't execute the following code when no flashbang is active (previous_value allows the code to be
		-- executed at least once when alpha is 0, otherwise it would never be run)
		return
	end
	previous_value = alpha
	alpha = 1 - math.clamp(alpha, 0, 1)

	-- Waypoints
	for id, data in pairs(self._hud.waypoints) do
		if alive(data.bitmap) then
			-- Critical state waypoint textures have thin black borders around them that make them somewhat visible with
			-- normal flashbang glare, simulate this by clamping the minimum alpha to 0.1 so it remains visible
			if data.init_data.icon == "wp_revive" or data.init_data.icon == "wp_rescue" then
				data.bitmap:set_alpha(max(0.1, alpha))
			else
				data.bitmap:set_alpha(alpha)
			end
		end
		if alive(data.arrow) then
			-- There is no need to worry about HUDManager:add_waypoint() using a default color of Color.white:with_alpha(0.75)
			-- since setting the bitmap's alpha will cause it to scale the color's alpha value accordingly (i.e. when the
			-- bitmap's alpha is set to 1, the color's alpha will correctly return to 0.75)
			data.arrow:set_alpha(alpha)
		end
		if alive(data.distance) then
			data.distance:set_alpha(alpha)
		end
		if alive(data.text) then
			data.text:set_alpha(alpha)
		end
		if alive(data.timer_gui) then
			data.timer_gui:set_alpha(alpha)
		end
	end

	-- Interaction hints
	local hud_interaction = self._hud_interaction
	if hud_interaction ~= nil then
		local hud_panel = hud_interaction._hud_panel
		if alive(hud_panel) then
			if hud_interaction._child_name_text then
				local panel = hud_panel:child(hud_interaction._child_name_text)
				if alive(panel) then
					panel:set_alpha(alpha)
				end
			end
			if hud_interaction._child_ivalid_name_text then
				local panel = hud_panel:child(hud_interaction._child_ivalid_name_text)
				if alive(panel) then
					panel:set_alpha(alpha)
				end
			end
		end
		if hud_interaction._interact_circle ~= nil and hud_interaction._interact_circle.set_alpha ~= nil then
			hud_interaction._interact_circle:set_alpha(max(0.1, alpha))
		end
	end
end
