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
			
				GET ID 'myid' VALUE '123' GRID 12 LABEL 'Id.' ;				
					BUTTON 'Go' LINK 'https://google.es'  OF o				
			
			ENDROW o	
		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil