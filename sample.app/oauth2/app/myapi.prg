function myapi( oDom )
	
	do case		
		case oDom:GetProc() == 'login' 	; DoLogin( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoLogin( oDom )

	local cParameters := oDom:Get( 'user' ) + '-' + oDom:Get( 'psw' )

	oDom:SetMsg( 'Check the API. You should check the authentication =>' + cParameters )

return nil  