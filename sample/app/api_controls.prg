function Api_Controls( oDom )

	do case
		case oDom:GetProc() == 'ping'	; DoPing( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetAlert( oDom:GetList(.t.) , 'Parameteres received' )				
	oDom:Console( oDom:GetList(.f.), 'Parameteres received' )				
	
retu nil

// -------------------------------------------------- //
