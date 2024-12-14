#define VK_ESCAPE	 27
#define IS_SSL  	.T.

request DBFCDX
request TWEB

//	----------------------------------------------------------------------------//
//	Recuerda:
//		Si compilas en modo no seguro:						--> go_msvc64.bat
//			Canvia IS_SSL  to .F. y recompila  
//			Start app con localhost:81    (o el puerto que configures)
//
//		Si compilas en modo seguro SSL con dominio			--> go_msvc64_ssl.bat
//			Canvia IS_SSL  to .T. 
//			Pon el certificado correcto de tu dominio en /cert
//			Start app con https://<tu_dominio>
//
//			Si testeas en localhost 	--> go_msvc64_ssl.bat//			 
//			Pon el certificado correcto de tu dominio localhost en /cert
//			Start app con localhost:443
//	----------------------------------------------------------------------------//

function main()

	hb_threadStart( @WebServer() )		
	hb_threadStart( @WebServerSocket() )

	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//	----------------------------------------------------------------------------//
//	Config UT Server
//	----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()	
	
	if IS_SSL

		oServer:SetPort( 443 )
		oServer:SetCertificate( 'cert/privatekey.pem', 'cert/certificate.pem' )
		oServer:SetSSL( .T. )		

	else
		oServer:SetPort( 81 )
	endif

	//	Define Routes...			

		oServer:Route( '/'		, 'index.html' )  												
		oServer:Route( 'basic'	, 'basic.html' )  												
		oServer:Route( 'error'	, 'error_connecting.html' )  												
		oServer:Route( 'progress'	, 'progress.html' )  												
		oServer:Route( 'chat'		, 'chat.html' )  												
		oServer:Route( 'dashboard', 'dashboard.html' )  												
		oServer:Route( 'monitor'  , 'monitor.html' )  												
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0




//	----------------------------------------------------------------------------//
//	Config WebSockets Server
//	----------------------------------------------------------------------------//

function WebServerSocket()

	local oServer := UWebSocket()	

	if IS_SSL	
	
		oServer:SetSSL( .T. )	
		oServer:SetCertificate( 'cert/privatekey.pem', 'cert/certificate.pem' )
		oServer:SetPort( 8883 )						
		
		//	You must specify the domain or localhost
		//	oServer:SetAddress( 'mydomain.com' )	
		//	oServer:SetAddress( 'localhost' )	
			
			oServer:SetAddress( 'localhost' )	

	else
	
		oServer:SetSSL( .F. )	
		oServer:SetPort( 9000 )
		
	endif

	oServer:bValidate := {|hParam| MyValidate(hParam) }
	oServer:bMessage  := {|cSocket, cReq, hParam| MyDispatcher( cSocket, cReq, hParam ) }
	
	//	-----------------------------------------------------------------------//	

	IF ! oServer:Run()
	
		? "=> WebServerSockets error:", oServer:cError

		RETU 1
	ENDIF	
	
RETURN 0


//	----------------------------------------------------------------------------//
//	SECURITY: 
//	This is where you can configure your security based on the token received.
//	----------------------------------------------------------------------------//
//	hParam -> Hash 
//	hParam[ 'scope' ]
//	hParam[ 'token' ]
//	----------------------------------------------------------------------------//

function MyValidate( hParam )
	
	if ! (  hParam[ 'token' ] == 'ABC-1234' )
		retu .f.
	endif	

retu .t. 


//	----------------------------------------------------------------------------//
//	DISPATCHER
//	Look in api_basic.prg and you will see how it is configured
//	----------------------------------------------------------------------------//
//	hParam -> Hash 
//	hParam[ 'scope' ]
//	hParam[ 'token' ]
//	----------------------------------------------------------------------------//

function MyDispatcher( cSocket, cReq, hParam )

	local n 			
	
	do case
		case hParam[ 'scope' ] == 'basic' ; Basic( cSocket, cReq )				
	endcase	
	
retu nil 

//----------------------------------------------------------------------------//
