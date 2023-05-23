function Api_Error( oDom )

	do case
		case oDom:GetProc() == 'error_1'		; DoError_1( oDom )
		case oDom:GetProc() == 'error_2'		; DoError_2( oDom )
		
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoError_1( oDom )

	local a := 'a'
	
	a := a / 0

	
	
retu nil

// -------------------------------------------------- //

static function DoError_2( oDom )


	USE 'zzz.dbf' 
	
	
retu nil
// -------------------------------------------------- //
