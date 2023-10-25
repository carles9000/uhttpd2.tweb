#include "../lib/tweb/tweb.ch" 

// -------------------------------------------------- //

function Api_Css( oDom )

	do case	
		
		case oDom:GetProc() == 'ping'			; oDom:SetMsg( 'Pong' )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //


