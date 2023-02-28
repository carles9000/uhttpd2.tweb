#define VK_ESCAPE	27

request DBFCDX
request DBSKIP
request TWEB

function main()

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 443 )
	
	oServer:SetCertificate( 'privatekey.pem', 'certificate.pem' )
	oServer:SetSSL( .T. )
	
	
	oServer:SetDirFiles( 'data' )
	
	//	Routing...			

		oServer:Route( '/'		, 'index.html' )  												

		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//