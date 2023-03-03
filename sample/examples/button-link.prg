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
	
		HTML o FILE 'tpl/title_test.tpl' PARAMS 'Test Button Link'	

	INIT FORM o  		

		BUTTON LABEL 'Link to Google' GRID 4 LINK 'https://google.com' OF o        					

	ENDFORM o
	
	INIT WEB oWeb RETURN	
	
retu nil