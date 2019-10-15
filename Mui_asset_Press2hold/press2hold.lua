if RequiredScript == "lib/units/beings/player/states/playerstandard" then

	--Settings for different interaction types. If an interaction id is present, the entry is used primarily else the "default" entry is used
	--A false value indicates the interaction will never lock, a true value indicates the interaction is always locked, and a numeric value indicates delay from the interaction start for the lock to take effect
	PlayerStandard.INTERACTION_LOCK_SETTINGS = {
		default = true,	--Must be defined
		
		--Fill in interaction IDs, e.g. "corpse_alarm_pager", that should differ from default behavior here
	}
	PlayerStandard.EQUIPMENT_PRESS_INTERRUPT = true --Use the equipment key (default 'G') to toggle off active interactions
	PlayerStandard.VISUAL_LOCK = false	--Show interaction lock on HUD

	local _check_action_interact_original = PlayerStandard._check_action_interact
	local _start_action_interact_original = PlayerStandard._start_action_interact
	local _update_interaction_timers_original = PlayerStandard._update_interaction_timers

	function PlayerStandard:_check_action_interact(t, input, ...)
		self:_check_interaction_input(input)
		return _check_action_interact_original(self, t, input, ...)
	end

	function PlayerStandard:_start_action_interact(t, ...)
		_start_action_interact_original(self, t, ...)
		self:_check_interaction_locked_data(t)
	end

	function PlayerStandard:_update_interaction_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_interaction_timers_original(self, t, ...)
	end

	--Shared with subclasses
	function PlayerStandard:_check_interaction_input(input)
		if self._interact_params and self._interact_params.locked then
			if input[PlayerStandard.EQUIPMENT_PRESS_INTERRUPT and "btn_use_item_press" or "btn_interact_press"] then
				input.btn_interact_press = nil
				input.btn_interact_release = true
			elseif input.btn_interact_release then
				input.btn_interact_release = nil
			end
		end
	end

	function PlayerStandard:_check_interaction_locked_data(t)
		local locked = false
		local lock_data = PlayerStandard.INTERACTION_LOCK_SETTINGS.default
		
		if PlayerStandard.INTERACTION_LOCK_SETTINGS[self._interact_params.tweak_data] ~= nil then
			lock_data = PlayerStandard.INTERACTION_LOCK_SETTINGS[self._interact_params.tweak_data]
		end
		
		if lock_data ~= false then
			local lock_delay = type(lock_data) == "number" and lock_data or 0
			self._interact_params.lock_t = t + lock_delay
			locked = lock_delay <= 0
		end
		
		self:_set_interaction_locked(locked)
	end

	function PlayerStandard:_check_interaction_locked(t)
		if self._interact_params and self._interact_params.lock_t and not self._interact_params.locked then
			if t >= self._interact_params.lock_t then
				self:_set_interaction_locked(true)
			end
		end
	end

	function PlayerStandard:_set_interaction_locked(status)
		self._interact_params.locked = status
		
		if PlayerStandard.VISUAL_LOCK then
			managers.hud:set_interaction_locked(status)
		end
	end
	
elseif RequiredScript == "lib/units/beings/player/states/playercivilian" then

	local _check_action_interact_original = PlayerCivilian._check_action_interact
	local _start_action_interact_original = PlayerCivilian._start_action_interact
	local _update_interaction_timers_original = PlayerCivilian._update_interaction_timers

	function PlayerCivilian:_check_action_interact(t, input, ...)
		self:_check_interaction_input(input)
		return _check_action_interact_original(self, t, input, ...)
	end

	function PlayerCivilian:_start_action_interact(t, ...)
		_start_action_interact_original(self, t, ...)
		self:_check_interaction_locked_data(t)
	end

	function PlayerCivilian:_update_interaction_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_interaction_timers_original(self, t, ...)
	end
	
elseif RequiredScript == "lib/units/beings/player/states/playermaskoff" then

	local _check_action_interact_original = PlayerMaskOff._check_action_interact
	local _start_action_interact_original = PlayerMaskOff._start_action_interact

	function PlayerMaskOff:_check_action_interact(t, input, ...)
		self:_check_interaction_input(input)
		return _check_action_interact_original(self, t, input, ...)
	end

	function PlayerMaskOff:_start_action_interact(t, ...)
		_start_action_interact_original(self, t, ...)
		self:_check_interaction_locked_data(t)
	end
end