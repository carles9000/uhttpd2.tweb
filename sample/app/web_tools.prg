/*
function web_tools( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; SetData( oDom )												
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	
*/

// -------------------------------------------------- //

function getDogs()

	local a := UGet()
	
	_d( a )
	
return time() 
