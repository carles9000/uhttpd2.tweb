#define VK_ESCAPE	27

request DBFCDX
request TWEB

function main()

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 80 )
	oServer:SetDirFiles( 'data' )
	
	//	Routing...			

		oServer:Route( '/'			, 'goauth/appmain.prg' )  												
		oServer:Route( 'oauth_access'	, 'goauth/oauth_access.prg' )  																
		oServer:Route( 'login'		, 'goauth/login.html' )  														
		oServer:Route( 'logout'		, 'goauth/logout.prg' )  														
 
		//
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//