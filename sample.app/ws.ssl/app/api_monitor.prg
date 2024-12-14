//	--------------------------------------------------------- //

function Api_Monitor( oDom )
	
	do case
							
		case oDom:GetProc() == 'start' 		; DoStart( oDom )						
		case oDom:GetProc() == 'stop' 			; DoStop( oDom )										
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

//	--------------------------------------------------------- //

function DoStart( oDom )

	LOCAL aInfo 		:= UWS_GetInfoSockets()
	LOCAL nLen 		:= len( aInfo )
	LOCAL cHeader		:= ''	
	LOCAL cHtml 		:= ''	
	LOCAL cData 		:= ''	
	LOCAL n
	
	oDom:WSSetCargo(.T. )	
	
	
	cHeader := '<h4>Active connections...</h4><hr>'
	cHeader += '<table border="1">'
	cHeader += '<tr>'
	cHeader += '<th>Token</th>'
	cHeader += '<th>IP</th>'	
	cHeader += '<th>Scope</th>'	
	cHeader += '<th>In</th>'	
	cHeader += '</tr>'
	
	oDom:WSSetCargo(.T. )	
	
	while oDom:WSGetCargo() == .T.	
	
		aInfo 		:= UWS_GetInfoSockets()
		nLen 		:= len( aInfo )
		cData 		:= ''
	
		for n := 1 to nLen 
			cData += '<tr>'
			
			cData += '<td>' + aInfo[n]['token'] + '</td>'
			cData += '<td>' + aInfo[n]['ip'] + '</td>'
			cData += '<td>' + aInfo[n]['scope'] + '</td>'
			cData += '<td>' + aInfo[n]['in'] + '</td>'
            
			cData += '</tr>'	
		next		

		cHtml := cHeader + cData + '</table>'
		cHtml += '<h5> Resume at ' + time() + '</h5><hr>'
		
		//	Response...
	
	
		oDom:SendSocketJS( 'MyListen', cHtml )	
		
		//SecondsSleep( 1 )
		hb_idleSleep( 1 )
		
	end 

retu ''

//	--------------------------------------------------------- //

function DoStop( oDom )
	
	oDom:WSSetCargo( .F. )

	oDom:SendSocketJS( 'MyListen', '' )

retu nil 

//	--------------------------------------------------------- //
