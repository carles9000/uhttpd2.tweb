#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Test Switch' 	
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
    DEFINE FORM o OF oWeb			
		o:lDessign := .t.
		
		INIT FORM o

			ROW o TOP '40%'
				SWITCH ID 'myswitch' VALUE .F. LABEL 'Accept' ONCHANGE 'Test()'OF o
			ENDROW o 
			
		
		HTML o 
		
			<script>
			
				function Test() {

					console.log( $('#myswitch').prop( "checked" ) )
					console.log( $('#myswitch').is( ":checked" ) )
					
					var lChecked = $('#myswitch').is( ":checked" ) ? 'Accepted' : 'NO Accepted';
					
					MsgInfo( lChecked )			
				}		
			
			</script>	
		
		ENDTEXT
		
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil