function Api_Examples( oDom )

	do case		
		case oDom:GetProc() == 'test1'		; DoTest1( oDom )						
								

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoTest1( oDom )
	
	local cHtml := 'Get 1 <input id="xxx"></input><br>Get 2 <input id="zzz"></input>'

	oDom:Set( 'myget', time() )
	
	//	Cas 1. Alert() syncrono y final focus
		//oDom:SetAlert( 'Ep' )
		//oDom:Focus( 'myget' )
	
	//	Cas 2. Simple message. No puedes meter foco fuera del dialogo
		//oDom:SetMsg( 'My message...')
	
	//	Cas 3. Dialog. Tampoco puedes meter foco fuera de dialogo, si dentro dialogo
		oDom:SetDialog( 'mydlg', cHtml, nil, { 'focus' => 'zzz' } )

	
retu nil

// -------------------------------------------------- //
