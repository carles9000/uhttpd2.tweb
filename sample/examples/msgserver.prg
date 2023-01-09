#include "lib/tweb/tweb.ch"

function main()

    local o, oWeb, oBrw, oCol, oCheck
    local cHtml := ''	

	DEFINE WEB oWeb TITLE 'MsgServer()' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		DEFINE FORM o OF oWeb 
			
			HTML o INLINE '<h3>MsgServer() - AJAX request</h3><hr>'	

			INIT FORM o
			
				ROW o
				
					COL o GRID 12
				
						ROWGROUP o                        
							GET ID 'mytext' VALUE 'James Brown...'   GRID 6 LABEL 'String' BUTTON 'Test String' ACTION 'TestString()' OF o             
						ENDROW o
						
						ROWGROUP o                        
							GET ID 'mynumber' VALUE '1234.56'   GRID 6 LABEL 'Number' BUTTON 'Test Number' ACTION 'TestNumber()' OF o             
						ENDROW o    

						ROWGROUP o                                                
							SWITCH ID 'mylogic' LABEL 'OnOff'  ACTION 'TestLogic()' GRID 6 OF o						
						ENDROW o  					
						
						ROWGROUP o
							BUTTON ID 'btn'  LABEL 'Send All' GRID 0 ACTION 'TestAll()' OF o    
						ENDROW o 				
					
					ENDCOL o
				
				ENDROW o        
		
			HTML o
			
				<script>
				
					function TestString() {
						
						var cValue = $('#mytext').val()

						MsgServer( 'srv_test.prg', cValue, PostView )
					}
					
					function TestNumber() {
						
						var cValue = parseFloat( $('#mynumber').val() )         // Check parseInt() also...

						MsgServer( 'srv_test.prg', cValue, PostView )
					}   
					
					function TestLogic() {
						
						var cValue = $('#mylogic').prop('checked' )

						MsgServer( 'srv_test.prg', cValue, PostView )
					}  
					
					function TestAll() {
						
						var oParam = new Object()
							oParam[ 'mytext'    ] = $('#mytext').val()
							oParam[ 'mynumber'  ] = parseFloat( $('#mynumber').val() )
							oParam[ 'mylogic'   ] = $('#mylogic').prop('checked' )
							
							MsgServer( 'srv_test.prg', oParam, PostView )
					}
					
					
					//  Funcion Callback que se ejecutará cuando el servidor devuelva
					//  un resultado.
					
					function PostView( dat ) {
					
						MsgInfo( dat )
						console.log( dat )
					}	
					
				</script>	
				
			ENDTEXT
			
		ENDFORM o

	INIT WEB oWeb RETURN
	
retu nil