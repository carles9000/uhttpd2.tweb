#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Test Say Class' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= .t.		
			
			CSS o		
			
				.MySay {
					background-color: #607D8B;
					color: #FFEB3B;
				}

				.MySayItalic {
					font-style: italic;
					font-family: auto;
					font-weight: bold;								
				}
				
			ENDTEXT
		
			
		INIT FORM o
		
			ROW o
				SAY VALUE 'Hello' GRID 6 ALIGN 'right'  CLASS 'MySay' OF o
				SAY VALUE 'Hello' GRID 4 OF o
				SAY VALUE 'Hello' GRID 2 ALIGN 'center' CLASS 'MySay MySayItalic' OF o
			ENDROW o
			
		ENDFORM o	
		
	INIT WEB oWeb RETURN
	
retu nil