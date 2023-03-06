#include "lib/tweb/tweb.ch"

function main()

    LOCAL oWeb, o

	DEFINE WEB oWeb TITLE 'Get Button Link' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o OF oWeb		

		INIT FORM o  	
		   
			ROWGROUP o
			
				SAY LABEL "CAIXABANK" LINK "http://portal.lacaixa.es/home/particulars_ca.html" GRID 12 OF o
				SAY LABEL "ING"       LINK "https://ing.ingdirect.es/app-login/" GRID 12 OF o		
			
			ENDROW o	
		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil