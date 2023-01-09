#include "lib/tweb/tweb.ch"

function main()

    LOCAL oWeb, o
	
	DEFINE WEB oWeb TITLE 'Test Image' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb
			o:lDessign := .t.

		INIT FORM o  		
		   
			ROWGROUP o
			
				IMAGE ID 'img_a' FILE '../files/images/tokyo.jpg' BIGFILE '../files/images/tokyo_big.jpg' ALIGN 'center' GRID 6  OF o
				IMAGE ID 'img_b' FILE '../files/images/tokyo.jpg' ALIGN 'center' GRID 6  OF o
			
			ENDROW o	

			ROWGROUP o        

				IMAGE ID 'img_b' FILE '../files/images/tokyo.jpg' GRID 6 NOZOOM OF o
			
			ENDROW o			
				
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil