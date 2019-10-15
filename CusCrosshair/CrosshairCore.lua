if not _G.CusCrosshair then
	_G.CusCrosshair = {}
	CusCrosshair.loaded_options = {}
	CusCrosshair.mod_path = ModPath
	CusCrosshair.save_path = SavePath
	CusCrosshair.menu_name = "CusCrosshair_options"
	CusCrosshair.write_options = CusCrosshair.write_options or {}
end

CusCrosshair.dofiles = {
	"CusCrosshairLua/Options.lua",
	"CusCrosshairLua/WriteOptions.lua"
}

CusCrosshair.hook_files = {
	--["lib/managers/menumanager"] = "CusCrosshairLua/MenuManager.lua",
	["lib/managers/hudmanager"] = "CusCrosshairLua/HudManager.lua",
	["lib/managers/hud/hudhitconfirm"] = "CusCrosshairLua/HudHitConfirm.lua"
}

if not CusCrosshair.setup then
	for p, d in pairs(CusCrosshair.dofiles) do
		dofile(ModPath .. d)
	end
	CusCrosshair:Load_options()
	CusCrosshair.setup = true
end

if RequiredScript then
	local requiredScript = RequiredScript:lower()
	if CusCrosshair.hook_files[requiredScript] then
		dofile( ModPath .. CusCrosshair.hook_files[requiredScript] )
	end
end

if Hooks then
	if HUDHitConfirm then
		Hooks:PostHook( HUDHitConfirm, "init", "Crosshair_define", function(self)
			local main_size = CusCrosshair.loaded_options.HUD.dot_length
			self._crosshair_main = self._hud_panel:bitmap({
				--[[valign = "center",
				halign = "center",
				align = "center",
				vertical = "center",]]--
				visible = CusCrosshair.loaded_options.HUD.Dot,
				name = "_crosshair_main",
				--texture = "guis/textures/pd2/hitconfirm_crit",
				color = Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA),
				layer = 0,
				w = main_size,
				h = main_size,
				blend_mode = "add"
			})
			self._crosshair_main:set_center(self._hud_panel:center())
			
			self._crosshair_left = self._hud_panel:bitmap({
				--[[valign = "center",
				halign = "center",
				align = "center",
				vertical = "center",]]--
				visible = true,
				name = "_crosshair_left",
				--texture = "guis/textures/pd2/hitconfirm_crit",
				color = Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA),
				layer = 0,
				w = CusCrosshair.loaded_options.HUD.cross_length or 5,
				h = CusCrosshair.loaded_options.HUD.cross_width or 4,
				blend_mode = "add"
			})
			self._crosshair_left:set_center(self._hud_panel:center())
			self._crosshair_left:set_right(self._crosshair_main:left())
			
			self._crosshair_right = self._hud_panel:bitmap({
				--[[valign = "center",
				halign = "center",
				align = "center",
				vertical = "center",]]--
				visible = true,
				name = "_crosshair_right",
				--texture = "guis/textures/pd2/hitconfirm_crit",
				color = Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA),
				layer = 0,
				w = CusCrosshair.loaded_options.HUD.cross_length or 5,
				h = CusCrosshair.loaded_options.HUD.cross_width or 4,
				blend_mode = "add"
			})
			self._crosshair_right:set_center(self._hud_panel:center())
			self._crosshair_right:set_left(self._crosshair_main:right())
			
			self._crosshair_above = self._hud_panel:bitmap({
				--[[valign = "center",
				halign = "center",
				align = "center",
				vertical = "center",]]--
				visible = true,
				name = "_crosshair_above",
				--texture = "guis/textures/pd2/hitconfirm_crit",
				color = Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA),
				layer = 0,
				w = CusCrosshair.loaded_options.HUD.cross_width_tb or 4,
				h = CusCrosshair.loaded_options.HUD.cross_length_tb or 5,
				blend_mode = "add"
			})
			self._crosshair_above:set_center(self._hud_panel:center())
			self._crosshair_above:set_bottom(self._crosshair_main:top())
			
			self._crosshair_below = self._hud_panel:bitmap({
				--[[valign = "center",
				halign = "center",
				align = "center",
				vertical = "center",]]--
				visible = true,
				name = "_crosshair_below",
				--texture = "guis/textures/pd2/hitconfirm_crit",
				color = Color(CusCrosshair.loaded_options.HUD.RGB_R, CusCrosshair.loaded_options.HUD.RGB_G, CusCrosshair.loaded_options.HUD.RGB_B):with_alpha(CusCrosshair.loaded_options.HUD.RGB_ALPHA),
				layer = 0,
				w = CusCrosshair.loaded_options.HUD.cross_width_tb or 4,
				h = CusCrosshair.loaded_options.HUD.cross_length_tb or 5,
				blend_mode = "add"
			})
			self._crosshair_below:set_center(self._hud_panel:center())
			self._crosshair_below:set_top(self._crosshair_main:bottom())
			managers.hud:add_updator("CrosshairUpdater", callback(self, self, "tick"))
		end)
	end
	Hooks:Add("LocalizationManagerPostInit", "CusCrosshair_Localization", function(loc)
		LocalizationManager:add_localized_strings({
			["cuscrosshair_menu_title"] = "Crosshair Customizer",
			["cuscrosshair_menu_help"] = "Customize your crosshair",
			["crosshair_hide_zoom_title"] = "Hide Crosshair on Zoom",
			["crosshair_hide_zoom_help"] = "Choose wether the crosshair should be hidden on zoom in",
			["Crosshair_RGB_R_title"] = "Crosshair Colour Red",
			["Crosshair_RGB_R_help"] = "Choose the Red variation for the colour of the crosshair",
			["Crosshair_RGB_G_title"] = "Crosshair Colour Green",
			["Crosshair_RGB_G_help"] = "Choose the Green variation for the colour of the crosshair",
			["Crosshair_RGB_B_title"] = "Crosshair Colour Blue",
			["Crosshair_RGB_B_help"] = "Choose the Blue variation for the colour of the crosshair",
			["Crosshair_RGB_ALPHA_title"] = "Crosshair Colour Alpha",
			["Crosshair_RGB_ALPHA_help"] = "Choose the Alpha variation for the colour of the crosshair",
			["Crosshair_cross_length_title"] = "Crosshair Cross (Left + Right) Length",
			["Crosshair_cross_length_help"] = "Choose the Length of the (Left + Right) cross' on the crosshair",
			["Crosshair_cross_length_tb_title"] = "Crosshair Cross (Top + Bottom) Length",
			["Crosshair_cross_length_tb_help"] = "Choose the Length of the (Top + Bottom) cross' on the crosshair",
			
			["Crosshair_cross_width_title"] = "Crosshair Cross (Left + Right) width",
			["Crosshair_cross_width_help"] = "Choose the width of the (Left + Right) cross' on the crosshair",
			["Crosshair_cross_width_tb_title"] = "Crosshair Cross (Top + Bottom) width",
			["Crosshair_cross_width_tb_help"] = "Choose the width of the (Top + Bottom) cross' on the crosshair",
			
			["Crosshair_dot_length_title"] = "Crosshair Dot Length",
			["Crosshair_dot_length_help"] = "Choose the Length of the dot at the center on the crosshair",
			
			["Crosshair_toggle_dot_title"] = "Visible Center dot",
			["Crosshair_toggle_dot_help"] = "Toggles the visibility of the center dot.",
			
		})
	end)

	Hooks:Add("MenuManagerSetupCustomMenus", "Base_SetupCusCrosshairMenu", function( menu_manager, nodes )
		MenuHelper:NewMenu( CusCrosshair.menu_name )
	end)
	 
	Hooks:Add("MenuManagerPopulateCustomMenus", "Base_PopulateCusCrosshairMenu", function( menu_manager, nodes )
		--[[MenuCallbackHandler. = function(this, item)

		end
		MenuHelper:AddButton({
			id = "",
			title = "",
			desc = "",
			callback = "",
			--back_callback = ,
			--next_node = ,
			menu_id = CusCrosshair.menu_name,
			priority = 1
		})]]--
		MenuCallbackHandler.crosshair_hide_zoom = function(this, item)
			CusCrosshair.loaded_options.HUD.Hide_on_zoom = item:value() == "on" and true or false
			CusCrosshair:Save()
		end
		MenuHelper:AddToggle({
			id = "CrosshairHide",
			title = "crosshair_hide_zoom_title",
			desc = "crosshair_hide_zoom_help",
			callback = "crosshair_hide_zoom",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.Hide_on_zoom,
			priority = 1001
			--priority = 3
		})
		MenuCallbackHandler.crosshair_rgb_r_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.RGB_R = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 1,
			step = 0.01,
			show_value = true,
			id = "CrosshairRGB-R",
			title = "Crosshair_RGB_R_title",
			desc = "Crosshair_RGB_R_help",
			callback = "crosshair_rgb_r_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.RGB_R or 1,
			priority = 1005
		})
		
		MenuCallbackHandler.crosshair_rgb_g_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.RGB_G = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 1,
			step = 0.01,
			show_value = true,
			id = "CrosshairRGB-G",
			title = "Crosshair_RGB_G_title",
			desc = "Crosshair_RGB_G_help",
			callback = "crosshair_rgb_g_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.RGB_G or 1,
			priority = 1004
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_rgb_b_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.RGB_B = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 1,
			step = 0.01,
			show_value = true,
			id = "CrosshairRGB-B",
			title = "Crosshair_RGB_B_title",
			desc = "Crosshair_RGB_B_help",
			callback = "crosshair_rgb_b_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.RGB_B or 1,
			priority = 1003
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_rgb_alpha_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.RGB_ALPHA = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 1,
			step = 0.01,
			show_value = true,
			id = "CrosshairRGB-ALPHA",
			title = "Crosshair_RGB_ALPHA_title",
			desc = "Crosshair_RGB_ALPHA_help",
			callback = "crosshair_rgb_alpha_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.RGB_ALPHA or 1,
			priority = 1002
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_cross_length_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.cross_length = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 25,
			step = 0.5,
			show_value = true,
			id = "Crosshaircross_length",
			title = "Crosshair_cross_length_title",
			desc = "Crosshair_cross_length_help",
			callback = "crosshair_cross_length_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.cross_length or 5
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_cross_length_tb_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.cross_length_tb = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 25,
			step = 0.5,
			show_value = true,
			id = "Crosshaircross_length_tb",
			title = "Crosshair_cross_length_tb_title",
			desc = "Crosshair_cross_length_tb_help",
			callback = "crosshair_cross_length_tb_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.cross_length_tb or 5
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_cross_width_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.cross_width = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 25,
			step = 0.5,
			show_value = true,
			id = "Crosshaircross_width",
			title = "Crosshair_cross_width_title",
			desc = "Crosshair_cross_width_help",
			callback = "crosshair_cross_width_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.cross_width or 4
			--priority = 
		})
		
		MenuCallbackHandler.crosshair_cross_width_tb_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.cross_width_tb = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 25,
			step = 0.5,
			show_value = true,
			id = "Crosshaircross_width_tb",
			title = "Crosshair_cross_width_tb_title",
			desc = "Crosshair_cross_width_tb_help",
			callback = "crosshair_cross_width_tb_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.cross_width_tb or 4
			--priority = 
		})
		
		MenuCallbackHandler.Crosshair_dot_length_clbk = function(this, item)
			CusCrosshair.loaded_options.HUD.dot_length = item:value()
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddSlider({
			min = 0,
			max = 25,
			step = 0.5,
			show_value = true,
			id = "Crosshairdot_length",
			title = "Crosshair_dot_length_title",
			desc = "Crosshair_dot_length_help",
			callback = "Crosshair_dot_length_clbk",
			--disabled_color = ,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.dot_length or 4
			--priority = 
		})
		
		MenuCallbackHandler.Crosshair_toggle_dot = function(this, item)
			CusCrosshair.loaded_options.HUD.Dot = item:value() == "on" and true or false
			if managers.hud then
				managers.hud._hud_hit_confirm:update_crosshair()
			end
			CusCrosshair:Save()
		end
		MenuHelper:AddToggle({
			id = "CrosshairDotVis",
			title = "Crosshair_toggle_dot_title",
			desc = "Crosshair_toggle_dot_help",
			callback = "Crosshair_toggle_dot",
			--disabled_color = ,
			icon_by_text = false,
			menu_id = CusCrosshair.menu_name,
			value = CusCrosshair.loaded_options.HUD.Dot
			--priority = 4
		})
	end)
	 
	Hooks:Add("MenuManagerBuildCustomMenus", "Base_BuildCusCrosshairMenu", function( menu_manager, nodes )
		nodes[CusCrosshair.menu_name] = MenuHelper:BuildMenu(CusCrosshair.menu_name)
		MenuHelper:AddMenuItem( nodes["blt_options"], CusCrosshair.menu_name, "cuscrosshair_menu_title", "cuscrosshair_menu_help", 1 )
	end)
end