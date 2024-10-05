#include "lib/tweb/tweb.ch" 

function AppMain() 

	local o, oWeb
	local cInfo := ''
		
	if ! USessionReady()
		URedirect( 'login' )
		retu nil
	endif

	hUser := USession( 'user' )

	cInfo := 'Id: ' + hUser[ 'id' ] + '<br>'
	cInfo += 'Name: ' + hUser[ 'name' ] + '<br>'
	cInfo += 'Mail: ' + hUser[ 'email' ] + '<br>'	
	cInfo += 'Access Token: ' + hUser[ 'access_token' ] 

	DEFINE WEB oWeb TITLE 'OAuth2 example' 			
		
		DEFINE FORM o ID 'myform' API 'myapi' OF oWeb							

		INIT FORM o					
			SAY VALUE '<h1>Main Screen' ALIGN 'center' GRID 12  OF o												
			SAY VALUE 'Logout' ALIGN 'center' LINK 'logout' GRID 12  OF o	

			IMAGE FILE hUser[ 'picture' ] CLASS 'mt-5' OF o
			
			SAY VALUE cInfo GRID 12 CLASS 'mt-2' STYLE 'word-wrap: break-word;' OF o 			
			
		ENDFORM o			
	
	INIT WEB oWeb RETURN 
	
retu nil 


