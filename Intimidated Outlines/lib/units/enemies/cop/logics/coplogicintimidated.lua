--[[Hooks:PreHook( CopLogicIntimidated , "on_intimidated" , "PreCopLogicIntimidatedOnIntimidated" , function( data , amount , aggressor_unit )

	if not data.internal_data.tied then
	
		local anim_data = data.unit:anim_data()
		
		if anim_data.hands_up or anim_data.surrender then
		
			data.unit:contour():add( "highlight_character" , true , 1 )
			
		elseif anim_data.hands_back then
		
			data.unit:contour():remove( "highlight_character" , true )
			data.unit:contour():add( "friendly" , true , 1 )
		
		else
		
			data.unit:contour():remove( "mark_enemy" , true )
			data.unit:contour():remove( "mark_enemy_damage_bonus" , true )
			
			if managers.groupai:state():whisper_mode() then
				data.unit:contour():add( "friendly" , true , 1 )
			else
				data.unit:contour():add( "highlight_character" , true , 1 )
			end
			
		end
		
	end
	
end )

Hooks:PostHook( CopLogicIntimidated , "death_clbk" , "PostCopLogicIntimidatedDeathClbk" , function( data , damage_info )

	data.unit:contour():remove( "highlight_character" , true )
	data.unit:contour():remove( "friendly" , true )

end )]]