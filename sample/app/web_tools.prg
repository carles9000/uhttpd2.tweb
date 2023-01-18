// -------------------------------------------------- //
// For autocomplete examples...
// -------------------------------------------------- //

function getidcustomer()
	
	local cDbf 		:= AppPathData() + 'test.dbf'
	local cCdx 		:= AppPathData() + 'test.cdx'
	local cSearch 	:= lower( UGet()[ 'term' ] )
	local aRows 	:= {}
	local cAlias
	
	USE (cDbf) shared new VIA 'DBFCDX'
	SET INDEX TO (cCdx)
	
	cAlias := Alias()
	
	(cAlias)->( OrdSetFocus( 'FIRST' ) )
	(cAlias)->( DbSeek( cSearch, .t. ) )	

	(cAlias)->( OrdScope(0, cSearch ) )
	(cAlias)->( OrdScope(1, cSearch ) )
	(cAlias)->( DbGotop() )
	
	while (cAlias)->( !eof() ) 			
	
		Aadd( aRows, { 'value' => (cAlias)->( Recno() ), ;
						'label' => alltrim( (cAlias)->first ) + ', ' + alltrim((cAlias)->last ) ;						
					})	
	
		(cAlias)->( dbskip() )					
	
	end 		
	
	UAddHeader("Content-Type", "application/json")
	UWrite( hb_jsonencode( aRows ) )
	
return nil 