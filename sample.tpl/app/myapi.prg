function myapi( oDom )

	
	do case
		case oDom:GetProc() == 'hello' 	; DoHello( oDom )
		case oDom:GetProc() == 'clickme' 	; DoButton( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoHello( oDom )

	oDom:Console( 'Hello !' )

return nil 

// --------------------------------------------------------- //

function DoButton( oDom )

	oDom:SetMsg( 'Hello from server Harbour at ' + time() )
	oDom:Set( 'btn', 'Done !' )

return nil  