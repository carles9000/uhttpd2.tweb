#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Combo' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o ID 'demo' API 'api_controls' OF oWeb       
			o:lDessign  := .F.
			o:cSizing   := ''     //  SM/LG

		HTML o
			<div class="alert alert-dark form_title" role="alert">
				<h5 style="margin:0px;">
					<i class="far fa-share-square"></i>
					Test Combobox
				</h5>
			</div>
		ENDTEXT

		INIT FORM o  
	   
			ROWGROUP o
			   
				SEPARATOR o LABEL 'Select car...'

				SELECT oSelect  ID 'cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  ONCHANGE 'Select()' OF o
				
			ENDROW o
			
			ROWGROUP o
			
				DEFINE BUTTON GROUP OF o
					BUTTON GROUP ID 'mybtn1' PROMPT 'Load Hash'  ACTION 'set_combo_hash'  CLASS "btn-outline-secondary" OF o				
					BUTTON GROUP ID 'mybtn2' PROMPT 'Load Array' ACTION 'set_combo_array' CLASS "btn-outline-secondary" OF o				
				ENDGROUP OF o 
				
			ENDROW o			

			HTML o
			
				<script>
					
					function Select() {
						
						alert( $('#demo-cars').val() )
					}				
					
				</script>	
			ENDTEXT		        
		
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil