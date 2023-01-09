#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb, oFont
	
	DEFINE WEB oWeb TITLE 'Test Say Link' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb	
			o:lDessign 	:= .T.
			
		INIT FORM o
		
			ROW o
				SAY VALUE 'Say-Font example' LINK 'https://google.es' GRID 6  OF o
			ENDROW o
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil