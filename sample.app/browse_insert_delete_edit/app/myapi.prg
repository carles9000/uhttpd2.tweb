function myapi( oDom )
	do case
		
		case oDom:GetProc() == 'loaddata'	; DoLoadData( oDom )
		case oDom:GetProc() == 'new_row'	; DoNew( oDom )
		case oDom:GetProc() == 'del_row'	; DoDel( oDom )
		case oDom:GetProc() == 'upd_row'	; DOUpd( oDom )

		otherwise
			oDom:SetError( 'Proc no existe: ' + oDom:GetProc() )
	endcase

return oDom:Send()

//	--------------------------------------------------------

static function DoNew( oDom )

	local hBrowse 	:= oDom:Get( 'tableOrder' )  
	local aRows 	:= {}
	local hData, nTotal

	//	Recover rows data
	
		hData := hBrowse[ 'data' ]
		
	//	Hash to Array
		
		aRows := HashToArray( hData )
		
	//	Insert new row			
		
		Aadd( aRows, InsRow() )

	//	Calculate new total 	

		nTotal := GetTotal( aRows )
		
	//	Set data... Chimpum	
		
		oDom:TableSetData( 'tableOrder', aRows )
		oDom:Set( 'total', nTotal )	
		
retu nil 

//	--------------------------------------------------------

static function DoDel( oDom )

	local hBrowse 			:= oDom:Get( 'tableOrder' )
	local aSelected		:= hBrowse[ 'selected' ]
	local nLenSelected 	:= Len( aSelected )
	local nId, hData, n, aRows, nTotal
	
	//	If not selected ciao

		if nLenSelected == 0
			retu nil
		endif
	
	//	Recover rows data
	
		hData := hBrowse[ 'data' ]	

	//	Del row for id 
	
		for n := 1 to nLenSelected
			
			nId := aSelected[n][ 'id' ]
			
			HB_HDel( hData, nId )
			
		next

	//	Hash to Array
		
		aRows := HashToArray( hData )	
	
	//	Calculate new total 	

		nTotal := GetTotal( aRows )
		
	//	Set data... Chimpum	
		
		oDom:TableSetData( 'tableOrder', aRows )
		oDom:Set( 'total', nTotal )		
		
retu nil 

//	--------------------------------------------------------

static function DOUpd( oDom )

	local hBrowse 		:= oDom:Get( 'tableOrder' )
	local hData 		:= hBrowse[ 'data' ]	
	local oCell 		:= oDom:Get( 'cell' )	
	local aRows 		:= {}
	local cId

	//	Cell will be validated ? 
	
		if  oCell[ 'field' ] == 'cantidad' .or. ;
			oCell[ 'field' ] == 'comment'
			
			cId := oCell[ 'row' ][ 'id' ]

			if HB_HHasKey( hData, cId )
			
				do case
					case oCell[ 'field' ] == 'cantidad' 	
					
						hData[ cId ][ 'importe' ] := oCell[ 'row' ][ 'cantidad' ] * oCell[ 'row' ][ 'precio' ]
						
					
					case oCell[ 'field' ] == 'comment' 		
					
						hData[ cId ][ 'comment' ] := Upper( Substr( oCell[ 'row' ][ 'comment' ],1,1) ) + ;
						                              lower( Substr( oCell[ 'row' ][ 'comment' ],2) )
						
				endcase			
				
				aRows := HashToArray( hData )				
				
				oDom:Set( 'total', GetTotal( aRows ) )
					
				oDom:TableSetData( 'tableOrder', aRows )
				
			endif 						
			
		endif	

return nil

//	--------------------------------------------------------

static function DoLoadData( oDom )
	
	local aRows 	:= {}
	local nLen 	:= hb_RandomInt(1, 3)
	local n
	
	for n := 1 to nLen 
		Aadd( aRows, InsRow() )
		hb_idleSleep( 0.01 )
	next 		
	
	oDom:Set( 'total', GetTotal( aRows ) )
	oDom:TableSetData( 'tableOrder', aRows )

retu nil 

//	--------------------------------------------------------

static function GetTotal( aRows )

	local nLen 	:= len( aRows )
	local nTotal 	:= 0
	local n 

	for n := 1 to nLen 			
		nTotal += aRows[n]['importe']			
	next 
		
retu nTotal

//	--------------------------------------------------------

static function InsRow()


	local codigo 	 	:= hb_RandomInt(1000, 9999)	
	local cantidad 	:= hb_RandomInt(1, 5)	
	local precio	 	:= hb_Random() * 1000.0
	local hRow := 	{ ;
						'id' => Ltrim(Str(hb_milliseconds() )), ;
						'codigo' => codigo, ;
						'producto' => 'nombre producto ' + Ltrim(Str(hb_RandomInt(10, 99))) , ;
						'cantidad' => cantidad, ;
						'precio' => precio, ;
						'importe' => (cantidad * precio),;
						'comment' => '' ;
					}	
return hRow 

//	--------------------------------------------------------

static function HashToArray( hData )

	local nLen 	:= len( hData )		
	local aRows 	:= {}
	local n
	
	//	Copy hash data to array		
		
		for n := 1 to nLen 
			Aadd( aRows, hb_HValueAt( hData, n ) )
		next 
		
retu aRows

//	--------------------------------------------------------