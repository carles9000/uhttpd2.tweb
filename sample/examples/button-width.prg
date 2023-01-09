#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Button' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o OF oWeb
			o:lDessign := .t.	
			
			HTML o FILE 'tpl/title_test.tpl' PARAMS 'Test Buttons - Width'			

		INIT FORM o  
		
			ROWGROUP o
				BUTTON LABEL 'MyButton' GRID 6 OF o        			
			ENDROW o
			
			ROWGROUP o
				BUTTON LABEL 'MyButton 100% grid' GRID 6 WIDTH '100%' OF o        			
			ENDROW o
			
			ROWGROUP o
				BUTTON LABEL 'MyButton 200px' GRID 6 WIDTH '200px' OF o        			
			ENDROW o		
				
		ENDFORM o		
	
	INIT WEB oWeb RETURN
	
retu nil