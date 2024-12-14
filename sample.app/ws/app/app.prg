#define VK_ESCAPE	 27

request DBFCDX
request TWEB

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

		oServer:SetPort( 81 )

	//	Define Routes...			

		oServer:Route( '/'		, 'index.html' ) 																																	
		oServer:Route( 'progress'	, 'progress.html' )  												 												
		
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
	
	oServer:SetSSL( .F. )	
	oServer:SetPort( 9000 )

	oServer:bValidate := {|hParam| MyValidate(hParam) }
	
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

//----------------------------------------------------------------------------//
