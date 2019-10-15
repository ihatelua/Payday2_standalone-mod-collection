Hooks:PreHook( CopLogicTrade , "hostage_trade" , "PreCopLogicTradeHostageTrade" , function( unit , enable , trade_success )

	if enable then
	
		--unit:contour():remove( "friendly" , true )
		
	else
	
		if not managers.enemy:all_civilians()[unit:key()] then
			unit:contour():add( "friendly" , true , 1 )
		end
		
	end

end )