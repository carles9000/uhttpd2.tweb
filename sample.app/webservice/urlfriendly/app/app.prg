#define VK_ESCAPE	27

request DBFCDX
request TWEB

static oServer

function main()

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	//local oServer 	:= Httpd2()
	oServer 	:= Httpd2()
	
	
	oServer:SetPort( 81 )
	oServer:SetDirFiles( 'data' )
	
	//	Routing...			

		oServer:Route( '/'		, 'index.html' )  												

		//oServer:Route( '/ws2'	, 'ws2.prg' )  		// WebService
		//oServer:Route( '/ws3'	, 'ws3' )
		//oServer:Route( '/ws4'	, 'ws4' )
		oServer:Route( '/customer/([0-9]*)'		, 'customer.prg' )
		oServer:Route( '/customer1/([0-9]*)'	, 'customer.prg', 'POST' )
		oServer:Route( '/customer2/([0-9]{3})'	, 'customer.prg' )
		oServer:Route( '/customer3/([0-9]{1,3})', 'customer.prg' )
		oServer:Route( '/customer4/([a-z]+)'	, 'customer.prg' )
		oServer:Route( '/customer5/([a-z]{4})'	, 'customer.prg' )
		oServer:Route( '/customer6/([0-9]{1,4})/info/([A-Z]{3})'	, 'customer.prg' )
		
		
		//Aadd( aRoute, { '/ws3/([0-9]*)/([A-z]{3})'	, 'ws3f'	, 'GET, POST' , nil  } )
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//