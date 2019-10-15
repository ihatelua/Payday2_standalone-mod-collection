Hooks:PostHook( CrimeSpreeDetailsMenuComponent, "populate_tabs_data", "add_hide_tab", function(self, tabs_data)
	table.insert(tabs_data, {
		name_id = "menu_button_hide",
		page_class = "nothing",
		width_multiplier = 1
	})
end)