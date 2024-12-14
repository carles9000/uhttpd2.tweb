#include 'hbsocket.ch' 

function Api_Chat( oDom )
	
	do case

		case oDom:GetProc() == 'send_msg' 	; DoMy_Send_Msg( oDom )								
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

//	--------------------------------------------------------- //

static function DoMy_Send_Msg( oDom )

	local cAlias 	:= oDom:Get( 'myalias' )
	local cMsg 	:= oDom:Get( 'mymsg' )
	
	if empty( cMsg )
		retu nil 
	endif
	
	cAlias := if( empty( cAlias), 'Guest', cAlias )
	
	cMsg := '[' + cAlias + '] ' + cMsg 

	oDom:SendSocketJS( 'ListenMsg', { 'msg' => cMsg, 'time' => time()}, 'CHAT' )	//	Look at 3º parameter !
	
	oDom:Set( 'mymsg', '' )
	oDom:Focus( 'mymsg', '' )

retu nil 

//	--------------------------------------------------------- //