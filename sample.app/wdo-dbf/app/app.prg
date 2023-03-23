#define VK_ESCAPE	27

request DBFCDX
request TWEB
request WDO_DBF

function main()	
	
	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
	
		oServer:SetDirFiles( 'data/sales/images' )
		
	//	Routing...			

		oServer:Route( '/'		, 'index.html' ) 
		oServer:Route( 'dbf'	, 'dbf.html' ) 	
		oServer:Route( 'dbf0'	, 'dbf0.html' ) 	
		oServer:Route( 'dbf1'	, 'dbf1.html' ) 	
		oServer:Route( 'dbf2'	, 'dbf2.html' ) 	
		oServer:Route( 'dbf3'	, 'dbf3.html' ) 	
		oServer:Route( 'dbf4'	, 'dbf4.html' ) 	
		oServer:Route( 'dbf5'	, 'dbf5.html' ) 	
		oServer:Route( 'dbf6'	, 'dbf6.html' ) 	
 	
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
	
RETURN 0

//----------------------------------------------------------------------------//
