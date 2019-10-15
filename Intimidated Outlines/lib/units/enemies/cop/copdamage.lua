Hooks:PostHook( CopDamage , "die" , "PostCopDamageDie" , function( self , attack_data )

	self._unit:contour():remove( "friendly" , true )
	self._unit:contour():remove( "highlight_character" , true )

		
end )
