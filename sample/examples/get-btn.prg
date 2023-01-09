#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Get Button' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

    DEFINE FORM o API 'api_test.prg' OF oWeb
		o:lDessign 	:= .T.	

		INIT FORM o  	

			ROWGROUP o
			
				GET VALUE '123' GRID 12 OF o
			
			ENDROW o	
		   
			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
					BUTTON 'GetId' ACTION 'GetId()' OF o
			
			ENDROW o	

			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
					BUTTON 'GetId', 'Test' ACTION 'GetId()', 'TestBtn()' OF o
			
			ENDROW o	

			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id.' ;				
					BUTTON 'GetId', 'Test', '<i class="fas fa-search"></i>' ;
					ACTION 'GetId()', 'TestBtn()', "MsgInfo(' Search...')" OF o
			
			ENDROW o		

			ROWGROUP o
			
				GET ID 'charly' 		VALUE '123' GRID 12 LABEL 'Id.' ;	
					BTNIDS 'btn-a', 'btn-b', 'btn-c' ;
					BUTTON 'GetId', 'Test', '<i class="fas fa-search"></i>' ;
					ACTION 'GetId()', 'TestBtn()', "MsgInfo(' Search...')" OF o
			
			ENDROW o				
			
			HTML o
				<script>
				
					function GetId() {
					
						var cId = $('#myid').val() 
					
						MsgInfo( cId )
					}
					
					function TestBtn() {
					
						alert( 'Button...' )
					}				
					
				</script>		
			ENDTEXT
			
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil