#include "lib/tweb/tweb.ch"

function main()

    LOCAL o
	
	DEFINE WEB oWeb TITLE 'GET - ONCHANGE/VALID' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o ID 'demo' OF oWeb	

		INIT FORM o  		
		   
			ROWGROUP o
			
				GET ID 'total' VALUE '' GRID 6 LABEL 'Total' VALID 'Test(this)' PLACEHOLDER "Value < 100" OF o		
				GET ID 'id'    VALUE '' GRID 6 LABEL 'Id.'   OF o		
			
			ENDROW o		
			
			HTML o
			
				<script>
				
					function Test() {
					
						console.log( 'test' )
						var uValue = $('#total').val() 						
					
						if ( uValue >= 100 ) {		
							MsgInfo( uValue, 'Value', null, function() { $('#total').focus()  }  )						
						}
					}
					
				</script>	
				
			ENDTEXT
			
		ENDFORM o 

	INIT WEB oWeb RETURN	
	
retu nil