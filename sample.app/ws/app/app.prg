#define VK_ESCAPE	27

request DBFCDX
request TWEB

/* WebSockets --------------------------------------------

	Funciona correcto bajo protocolo ws:// y se ha conseguido que su maneja sea muy sencillo, 
	tan solo una linea para inicializar y una para enviar mensajes. Todavia no funciona para smartphone
	
	It works correctly under the ws:// protocol and its handling has been made very simple,
	just one line to initialize and one to send messages. It still doesn't work for smartphone
*/

function main()

	hb_threadStart( @WebServer() )
	hb_threadStart( @UWebSocket() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )

	//	Routing...			

		oServer:Route( '/'		, 'index.html' )  												
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//