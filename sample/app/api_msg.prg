function Api_Msg( oDom )

	do case
		case oDom:GetProc() == 'ping'	; DoPing( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetAlert( _w( oDom:GetAll() ) )				
	oDom:Console( oDom:GetAll(), 'Parameteres received' )				
	
retu nil

// -------------------------------------------------- //
