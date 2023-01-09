#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Button Font' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o OF oWeb
			o:lDessign := .t.		

			DEFINE FONT oFont NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o

		INIT FORM o  	
			
			BUTTON ID 'mybtn'	LABEL 'Test' GRID 4 FONT 'MyFont' CLASS 'btn-outline-danger' OF o        			
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil