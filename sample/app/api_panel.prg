
function Api_Panel( oDom )


	do case			
		
		case oDom:GetProc() == 'panel'	; DoPanel( oDom )																	
		case oDom:GetProc() == 'hello'	; oDom:SetMsg( 'Hello' )
		case oDom:GetProc() == 'bye'	; oDom:SetMsg( 'Bye bye...' )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPanel( oDom )

	local cId := oDom:GetTrigger()
	local cValue := oDom:Get( cId )	
	
	do case 
		case cValue == 'list'
			oDom:Show( 'list' )
			oDom:Hide( 'detail' )
			
		case cValue == 'detail'
			oDom:Show( 'detail' )
			oDom:Hide( 'list' )
			
		case cValue == 'closeall'
			oDom:Hide( 'detail' )
			oDom:Hide( 'list' )			
	endcase
		
	
retu nil

// -------------------------------------------------- //
