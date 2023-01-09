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
	
		HTML o FILE 'tpl/title_test.tpl' PARAMS 'Test Buttons'	

	INIT FORM o  
	
		ROWGROUP o
			BUTTON LABEL 'Test 1' GRID 4 ACTION 'alert(123)' OF o        			
		ENDROW o
		
		ROWGROUP o
			BUTTON LABEL 'Test 2' GRID 4 CLASS 'btn-outline-danger' ACTION 'Test()' OF o        			
		ENDROW o
		
		HTML o
			<script>
			
				function Test() {
				
					alert( 'Hello world' )						
				}			
				
			</script>		
		ENDTEXT	
			
    ENDFORM o
	
	INIT WEB oWeb RETURN
	
	
retu nil