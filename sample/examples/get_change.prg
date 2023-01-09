#include "lib/tweb/tweb.ch"

function main()

    LOCAL oWeb, o
	
	DEFINE WEB oWeb TITLE 'Get Change' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
    DEFINE FORM o OF oWeb		

		INIT FORM o  		
		   
			ROWGROUP o
			
				GET ID 'myid' VALUE '' GRID 6 LABEL 'Id.' ONCHANGE 'MyValid()' OF o
			
			ENDROW o		
			
			HTML o
				<script>
				
					function MyValid() {
					
						var cId = $('#myid').val() 
					
						alert( cId )
					}
					
				</script>		
			ENDTEXT
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN

	
retu nil