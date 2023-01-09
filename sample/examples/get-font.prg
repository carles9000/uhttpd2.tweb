#include "lib/tweb/tweb.ch"

function main()

    local o, oWeb
	
	DEFINE WEB oWeb TITLE 'Get Font' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= .f.
			o:cSizing   	:= 'sm'
				
			HTML o INLINE '<h3>Test Get Font</h3><hr>'	
			
			DEFINE FONT NAME 'MyFontSay' COLOR 'blue' BOLD SIZE 18 OF o
			DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC SIZE 18 OF o
			
			
		INIT FORM o  		
		
			ROWGROUP o  
				SAY VALUE 'Id' ALIGN 'right' OF o
				GET VALUE 'ABC-3546' OF o
			ENDROW o
			
			ROWGROUP o  
				SAY VALUE 'Id' ALIGN 'right' FONT 'MyFontSay' OF o
				GET VALUE 'ABC-3546' FONT 'MyFontGet' OF o
			ENDROW o		
			
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil