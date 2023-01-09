#include "lib/tweb/tweb.ch"

function main()

    LOCAL oWeb, o

	DEFINE WEB oWeb TITLE 'Get Number Button'
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

    DEFINE FORM o OF oWeb
		o:lDessign 	:= .t.	
	
		DEFINE FONT NAME 'MyFontGet' COLOR 'green' ITALIC BOLD SIZE 38 OF o

		INIT FORM o 
		

			ROWGROUP o
				SAY LABEL 'Default' OF o
				GETNUMBER ID 'qty' VALUE '123' OF o		
			ENDROW o	
			
			ROWGROUP o
			
				SAY VALUE 'Test ONCHANGE' OF o
				GETNUMBER ID 'qty2' VALUE '123' ONCHANGE 'Notify()' OF o		
			ENDROW o

			ROWGROUP o
				SAY LABEL 'Test FONT' OF o
				GETNUMBER ID 'qty3' VALUE '123' FONT 'MyFontGet' OF o		
			ENDROW o		

			HTML o
				<script>
				
					function Notify() {
					
						var cId = $('#qty2').val() 
					
						alert( cId )
					}				
					
				</script>		
			ENDTEXT
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN 
	
retu nil