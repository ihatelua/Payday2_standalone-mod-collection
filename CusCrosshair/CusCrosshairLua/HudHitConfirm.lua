CloneClass(HUDHitConfirm)

--[[function HUDHitConfirm.init(self, hud)
	self.orig.init(self, hud)
	self._hud_panel = hud.panel
	if self._hud_panel:child("hit_confirm") then
		self._hud_panel:remove(self._hud_panel:child("hit_confirm"))
	end
	if self._hud_panel:child("headshot_confirm") then
		self._hud_panel:remove(self._hud_panel:child("headshot_confirm"))
	end
	if self._hud_panel:child("crit_confirm") then
		self._hud_panel:remove(self._hud_panel:child("crit_confirm"))
	end
	self._hit_confirm = self._hud_panel:bitmap({
		valign = "center",
		halign = "center",
		visible = false,
		name = "hit_confirm",
		texture = "guis/textures/pd2/hitconfirm",
		color = Color.white,
		layer = 0,
		blend_mode = "add"
	})
	self._hit_confirm:set_center(self._hud_panel:w() / 2, self._hud_panel:h() / 2)
	self._crit_confirm = self._hud_panel:bitmap({
		valign = "center",
		halign = "center",
		visible = false,
		name = "crit_confirm",
		texture = "guis/textures/pd2/hitconfirm_crit",
		color = Color.white,
		layer = 0,
		blend_mode = "add"
	})
	self._crit_confirm:set_center(self._hud_panel:w() / 2, self._hud_panel:h() / 2)
	
	
end]]--

--[[function HUDHitConfirm:on_hit_confirmed()
	self._hit_confirm:stop()
	self._hit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:on_headshot_confirmed()
	self._hit_confirm:stop()
	self._hit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:on_crit_confirmed()
	self._crit_confirm:stop()
	self._crit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:_animate_show(hint_confirm, done_cb, seconds)
	hint_confirm:set_visible(true)
	hint_confirm:set_alpha(1)
	local t = seconds
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		hint_confirm:set_alpha(t / seconds)
	end
	hint_confirm:set_visible(false)
	done_cb()
end]]--

function HUDHitConfirm:update_crosshair()
	self._crosshair_main:set_color(Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA))
	self._crosshair_left:set_color(Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA))
	self._crosshair_right:set_color(Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA))
	self._crosshair_above:set_color(Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA))
	self._crosshair_below:set_color(Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA))

	self._crosshair_left:set_w(CusCrosshair.loaded_options.HUD.cross_length)
	self._crosshair_left:set_h(CusCrosshair.loaded_options.HUD.cross_width)
	self._crosshair_right:set_w(CusCrosshair.loaded_options.HUD.cross_length)
	self._crosshair_right:set_h(CusCrosshair.loaded_options.HUD.cross_width)
	self._crosshair_above:set_h(CusCrosshair.loaded_options.HUD.cross_length_tb)
	self._crosshair_above:set_w(CusCrosshair.loaded_options.HUD.cross_width_tb)
	self._crosshair_below:set_h(CusCrosshair.loaded_options.HUD.cross_length_tb)
	self._crosshair_below:set_w(CusCrosshair.loaded_options.HUD.cross_width_tb)
	self._crosshair_main:set_w(CusCrosshair.loaded_options.HUD.dot_length)
	self._crosshair_main:set_h(CusCrosshair.loaded_options.HUD.dot_length)
	
	self._crosshair_main:set_center(self._hud_panel:center())
	
	self._crosshair_left:set_center(self._hud_panel:center())
	self._crosshair_left:set_right(self._crosshair_main:left())
	
	self._crosshair_right:set_center(self._hud_panel:center())
	self._crosshair_right:set_left(self._crosshair_main:right())
	
	self._crosshair_above:set_center(self._hud_panel:center())
	self._crosshair_above:set_bottom(self._crosshair_main:top())
	
	self._crosshair_below:set_center(self._hud_panel:center())
	self._crosshair_below:set_top(self._crosshair_main:bottom())
	
	self._crosshair_main:set_visible(CusCrosshair.loaded_options.HUD.Dot)
end

function HUDHitConfirm:tick(t, dt)
	local player = managers.player:local_player()
	local in_steelsight = alive(player) and player:movement() and player:movement():current_state() and player:movement():current_state():in_steelsight() or false
	if in_steelsight and CusCrosshair.loaded_options.HUD.Hide_on_zoom then
		self._crosshair_main:set_visible(false)
		self._crosshair_left:set_visible(false)
		self._crosshair_right:set_visible(false)
		self._crosshair_above:set_visible(false)
		self._crosshair_below:set_visible(false)
	else
		self._crosshair_main:set_visible(CusCrosshair.loaded_options.HUD.Dot)
		self._crosshair_left:set_visible(true)
		self._crosshair_right:set_visible(true)
		self._crosshair_above:set_visible(true)
		self._crosshair_below:set_visible(true)
	end
end