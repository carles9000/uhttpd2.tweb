#include 'hbsocket.ch' 

#xcommand TRY  => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS

//	--------------------------------------------------------- //

function Api_Basic( oDom )
	
	do case

		case oDom:GetProc() == 'info_ssl' 	; DoMy_InfoSSL( oDom )								
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

//	--------------------------------------------------------- //

static function DoMy_InfoSSL( oDom )
	
	local cHtml 	:= '<h5>SSL Information !</h5><hr>'
	local hInfo	:= UWS_InfoSSL() 	 
	local nLen 	:= len( hInfo )
	local n, aPair

	cHtml += '<table border="1">'
	cHtml += '<tr>'
	cHtml += '<th>Description</th>'
	cHtml += '<th>Value</th>'	
	cHtml += '</tr>'

	for n := 1 to nLen 
		cHtml += '<tr>'
		
		aPair := HB_HPairAt( hInfo, n )		
		
		cHtml += '<td>' + hb_CStr( aPair[1] ) + '</td>'
		cHtml += '<td>' + hb_CStr( aPair[2] ) + '</td>'

		cHtml += '</tr>'	
	next	

	cHtml 	+= '</table>'	
	
	oDom:SetJS( 'MyListenHtml', cHtml )

retu nil 

//	---------------------------------------------------------------- //
//	These functions are not part of the API but part of the process.
//	Look in app.prg and you will see how it is configured
//	---------------------------------------------------------------- //

function Basic( cSocket, cReq )

	do case 
		case cReq == '/test' ;	MyTest( cSocket, cReq )
		case cReq == '/info' ;	MyInfo( cSocket )
		case cReq == '/time' ;	UWS_Send( cSocket, time(),nil, '*') 
		otherwise
			MyRunner( cSocket, cReq )
	endcase	

retu nil 

//----------------------------------------------------------------------------//

function MyTest( cSocket, cReq )

	local n 
	
	//	Test standard message -> UWS_Send()
		UWS_Send( cSocket, 'Init Test. Standard message !' ) 

	//	Test message to our functions -> UWS_SendJS()
	//	---------------------------------------------
	
	//	This is a error -> MyListenXXX() javascript function doesn't exist
	
		UWS_SendJS( cSocket, 'MyListenXXX', 'Message is ' + cReq ) 
		
	//	This is a error -> Socket doesn't exist
	
		if ! UWS_SendJS( '1234567', 'MyListen', 'Message...' ) 
			UWS_SendJS( cSocket, 'Error witch invalid socket...' ) 
		endif				
	
	//	Test Send hash data to 'MyListen' function 
		UWS_SendJS( cSocket, 'MyListen', { 'a' => time(), 'b' => date(), 'c' => .t. })		
	
	//	Test Send message Request	
		UWS_SendJS( cSocket, 'MyListen', 'Your Request => ' + cReq ) 		
		UWS_SendJS( cSocket, 'MyListen', 'Wait 3 seconds...' ) 		
		SecondsSleep( 3 )
		
	//	Test Send message to all clients. Third parameter is module name or * for all
	//	Module name is defined with WEBSOCKETS parameter
	//	I you open diferent tabs, this message will be show....
	
		UWS_SendJS( cSocket, 'MyListen', 'Message for all => Alarm !', '*') 		
	
	//	Test loop 10 times message
		for n := 1 to 10
			UWS_SendJS( cSocket, 'MyListen', 'Message => ' +  ltrim(str(hb_milliseconds())) ) 
			SecondsSleep( 0.1 )
		next	

		UWS_SendJS( cSocket, 'MyListen', 'End websockets test !' ) 		
		
retu nil

//	----------------------------------------------------------------------------//

function MyInfo( cSocket )

	local aInfo 	:= UWS_GetInfoSockets()
	local nLen		:= len( aInfo ) 
	local cHtml 	:= '<h5>Active connections !</h5><hr>'
	local n 

	cHtml += '<table border="1">'
	cHtml += '<tr>'
	cHtml += '<th>Socket</th>'
	cHtml += '<th>Ip</th>'
	cHtml += '<th>Scope</th>'
	cHtml += '<th>In</th>'
	cHtml += '</tr>'

	for n := 1 to nLen 
		cHtml += '<tr>'
		cHtml += '<td>' + aInfo[n][ 'token' ] + '</td>'
		cHtml += '<td>' + aInfo[n][ 'ip' ] + '</td>'
		cHtml += '<td>' + aInfo[n][ 'scope' ] + '</td>'
		cHtml += '<td>' + aInfo[n][ 'in' ] + '</td>'
		cHtml += '</tr>'	
	next	

	cHtml 	+= '</table>'

	UWS_SendJS( cSocket, 'MyListenHtml', cHtml )
	
retu nil 

//	----------------------------------------------------------------------------//

function MyRunner( cSocket, cReq )

	local uResponse 	:= ''
	local lError		:= .F.
	local oError, cCmd	
	
	try 

		cCmd := "{|| " + cReq + " }"
		uResponse := eval( &( cCmd ) )

	catch oError 	
	
		lError :=.T.
		uResponse := UWS_ErrorHandler( oError )
		
	end 		
	
	If lError
		UWS_SendJS( cSocket, 'MyListenTable', uResponse )		
	else
		UWS_SendJS( cSocket, 'MyListen', uResponse )		
	endif

retu nil 

//	----------------------------------------------------------------------------//