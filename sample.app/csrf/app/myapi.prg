function myapi( oDom )
	
	do case
		
		case oDom:GetProc() == 'set' 	; DoSet( oDom )
		case oDom:GetProc() == 'pay' 	; DoPay( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoSet( oDom )

	local nTotal 	:= hb_RandomInt(100000, 999999)
	local cTotal 	:= TRANSFORM( nTotal, "$99,999,999" )			

	oDom:Set( 'total_csrf', USetToken(nTotal) )
	oDom:Set( 'total', cTotal )

return nil 

// --------------------------------------------------------- //

function DoPay( oDom )

	local cTotal 	:= oDom:Get( 'total_csrf' )
	local nTotal	:= UGetToken( cTotal )					
	
	if nTotal == nil 
		oDom:SetMsg( 'Error token !' )
	else
		oDom:SetMsg( nTotal, 'Data value' )
	endif

return nil  