#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Test Icon' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o	OF oWeb
			o:lDessign = .t.

		INIT FORM o  	
		
			DEFINE FONT NAME 'MyFont' COLOR 'red' BOLD SIZE 10 OF o
		   
			ROWGROUP o VALIGN 'center'	
						
				ICON ID 'myicon' SRC '<i class="fas fa-recycle"></i>' ALIGN 'right' OF o
				
				SAY ID 'myid' VALUE '123' GRID 8 OF o	
				
				ICON SRC '<i class="fas fa-ban"></i>' ALIGN 'center' FONT 'MyFont'  OF o
				ICON SRC '<i class="far fa-trash-alt"></i>' LINK 'https://google.es' OF o			
			
			ENDROW o

			ROWGROUP o  HALIGN 'center'	
						
				BUTTON LABEL 'Icon Toggle' ACTION 'IconOnOff()' ALIGN 'center' OF o	
			
			ENDROW o	

			HTML o 
			
				<script>
					
					function IconOnOff() {

						//$('#myicon').toggle()
						
						if($('#myicon').css('display') == 'none'){ 
						   $('#myicon').show('slow'); 
						} else { 
						   $('#myicon').hide('slow'); 
						}					
					}
					
				</script>
			
			ENDTEXT 				
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil