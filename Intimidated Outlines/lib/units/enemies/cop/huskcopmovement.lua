Hooks:PostHook( HuskCopMovement , "action_request" , "PostHuskCopMovementActionRequest" , function( self , action_desc )

	if self._unit:base().mic_is_being_moved then
		return
	end
	
	if managers.enemy:is_civilian( self._unit ) then
		return
	end
	
	local anim_data = self._unit:anim_data()

	if action_desc.variant == "hands_up" or action_desc.variant == "hands_back" or managers.groupai:state():whisper_mode() and action_desc.variant == "tied_all_in_one" then
	
		self._unit:contour():remove( "mark_enemy" , true )
		self._unit:contour():remove( "mark_enemy_damage_bonus" , true )
		
		self._unit:contour():add( "highlight_character" , true , 1 )
		
	elseif action_desc.variant == "tied" then
	
		self._unit:contour():add( "friendly" , true , 1 )
		self._unit:contour():remove( "highlight_character" , true )
		
	else
	
		self._unit:contour():remove( "highlight_character" , true )
		if not managers.groupai:state():is_enemy_converted_to_criminal(self._unit) then
			self._unit:contour():remove( "friendly" , true )
		end
		
	end

end )