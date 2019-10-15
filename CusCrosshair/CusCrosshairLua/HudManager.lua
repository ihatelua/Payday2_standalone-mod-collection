--[[function HUDManager:update(t, dt)
	for _, cb in pairs(self._updators) do
		cb(t, dt)
	end
	self:_update_name_labels(t, dt)
	self:_update_waypoints(t, dt)
	if self._debug then
		local cam_pos = managers.viewport:get_current_camera_position()
		if cam_pos then
			self._debug.coord:set_text(string.format("Cam pos:   \"%.0f %.0f %.0f\" [cm]", cam_pos.x, cam_pos.y, cam_pos.z))
		end
	end
	self._hud_hit_confirm:tick(t, dt)
end]]--