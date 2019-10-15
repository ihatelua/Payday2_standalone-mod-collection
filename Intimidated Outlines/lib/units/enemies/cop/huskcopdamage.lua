Hooks:PostHook( HuskCopDamage , "die" , "PostHuskCopDamageDie" , function( self , variant )

	self._unit:contour():remove( "friendly" , true )
	self._unit:contour():remove( "highlight_character" , true )

end )