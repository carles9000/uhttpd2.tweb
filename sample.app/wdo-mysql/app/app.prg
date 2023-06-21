#define VK_ESCAPE	27

request DBFCDX
request TWEB

function main()


	HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" )
	
	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
		
	//	Routing...			

		oServer:Route( '/'		, 'index.html' ) 
		oServer:Route( 'mysql1', 'mysql1.html' ) 	
		oServer:Route( 'mysql2', 'mysql2.html' ) 	
		oServer:Route( 'mysql3', 'mysql3.html' ) 	
		
		oServer:Route( 'sql'	, 'sql.html' ) 	
		oServer:Route( 'sql0'	, 'sql0.html' ) 	
		oServer:Route( 'sql1'	, 'sql1.html' ) 	
		oServer:Route( 'sql2'	, 'sql2.html' ) 	
		oServer:Route( 'sql3'	, 'sql3.html' ) 	
		oServer:Route( 'sql4'	, 'sql4.html' ) 	
		oServer:Route( 'sql5'	, 'sql5.html' ) 	
		oServer:Route( 'sql6'	, 'sql6.html' ) 	
		oServer:Route( 'sql7'	, 'sql7.html' ) 	
		oServer:Route( 'sql8'	, 'sql8.html' ) 	
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
	
RETURN 0

//----------------------------------------------------------------------------//
