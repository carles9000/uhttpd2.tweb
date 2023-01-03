thread static nInd := 0

function Api_Brw_Order( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; SetData( oDom )						
		case oDom:GetProc() == 'clean'		; DoClean( oDom )						
		case oDom:GetProc() == 'relation'	; DoRelation( oDom )						
		case oDom:GetProc() == 'dummy'		; oDom:console( oDom:Getall() )
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function SetData( oDom )

	local cAlias 	:= OpenDbf( 'order.dbf' )
	local aRows  	:= GetRows( cAlias, 1, 20 )	
	
	oDom:Console( { 'rows' => aRows } )			
	
	oDom:TableSetData( 'myorder', aRows )			
	
retu nil

// -------------------------------------------------- //

static function DoClean( oDom )

	oDom:TableClean( 'myorder' )
	oDom:TableClean( 'mydetail' )
	
retu nil

// -------------------------------------------------- //

static function DoRelation( oDom )

	local cId 			:= oDom:Get( 'ID_ORDER' )
	local cAlias 		:= OpenDbf( 'detail.dbf', 'detail.cdx')
	local cAliasProd 	:= OpenDbf( 'product.dbf', 'product.cdx')
	local aRows  		:= GetDetail( cAlias, cId, cAliasProd )
	
	
	oDom:console( oDom:GetAll(), 'GETALL' )
	oDom:console( aRows )
	
	oDom:Trace()
	oDom:TableSetData( 'mydetail', aRows )

retu nil

// -------------------------------------------------- //

function GetDetail( cAlias, cId, cAliasProd )

	local aRows 	:= {}
	local aReg
	
	_d( 'ID_ORDER', cId )
	(cAlias)->( DbSeek( cId ) ) 
	
	while (cAlias)->id_order == cId .and.  (cAlias)->( !eof() ) 
				
		aReg := {=>}
		
		HB_HSet( aReg, 'id' 		, ++nInd )
		
		HB_HSet( aReg, 'ID_PROD', (cAlias)->ID_PROD ) 
		HB_HSet( aReg, 'PRICE', (cAlias)->PRICE ) 
		HB_HSet( aReg, 'QTY', (cAlias)->QTY ) 

		
		if (cAliasProd)->( DbSeek( (cAlias)->ID_PROD ) )		
			HB_HSet( aReg, 'PROD_TXT', (cAliasProd)->NAME  ) 
			HB_HSet( aReg, 'PROD_CLASS', (cAliasProd)->CLASS ) 
			HB_HSet( aReg, 'PROD_SIZE', (cAliasProd)->SIZE ) 			
		else 		
			HB_HSet( aReg, 'PROD_TXT', '' )		
			HB_HSet( aReg, 'PROD_CLASS', '' )		
			HB_HSet( aReg, 'PROD_SIZE', '' )		
		endif
		
		
		Aadd( aRows, aReg ) 
	
		(cAlias)->( DbSkip() )
	
	end 			
	
retu aRows 

// -------------------------------------------------- //
