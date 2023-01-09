#include "lib/tweb/tweb.ch"

function main()

    local o, oWeb
	
	DEFINE WEB oWeb TITLE 'Get Font Label' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb
				
			HTML o INLINE '<h3>Test Get Font Label</h3><hr>'	
			
			DEFINE FONT NAME 'MyFontSay' COLOR 'blue'  FAMILY 'Impact' SIZE 18 OF o
			DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC SIZE 18 OF o
			
			
		INIT FORM o  		
			
			ROWGROUP o  
				GET VALUE 'ABC-3546' LABEL 'Identifica' FONT 'MyFontGet' FONTLABEL 'MyFontSay' OF o
			ENDROW o		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil