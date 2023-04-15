function Api_Msg( oDom )

	do case
		case oDom:GetProc() == 'hello'		; oDom:SetMsg( 'Hello at ' + time() )
		case oDom:GetProc() == 'clickme'	; oDom:SetMsg( 'Click !' )
		
		case oDom:GetProc() == 'ping'		; DoPing( oDom )						
		case oDom:GetProc() == 'testpbs'	; DoPBS( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetMsg( _w( oDom:GetAll() ) )				
	oDom:Console( oDom:GetAll(), 'Parameteres received' )				
	
retu nil

// -------------------------------------------------- //

static function DoPBS( oDom )

	//	We simulate long proccess 
		hb_IdleSleep(3)
	
	oDom:Console( oDom:GetAll() )
	
	//	Call MsgLoading(.f.) --> Close loading dialog...
		oDom:SetJs( 'MsgLoading', { .f. } )
	
	oDom:SetMsg( 'Process finished at '  + time() )
	
retu nil

// -------------------------------------------------- //
