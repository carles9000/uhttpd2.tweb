function myapi( oDom )

	
	do case
		case oDom:GetProc() == 'hello' 	; DoHello( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 


function DoHello( oDom )

	oDom:Console( 'Hello !' )

return nil 