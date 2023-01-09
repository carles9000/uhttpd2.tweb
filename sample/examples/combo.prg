#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Combo' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o ID 'demo' OF oWeb       
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
			   
				SEPARATOR o LABEL 'Datos de Salida'

				SELECT oSelect  ID 'cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  ONCHANGE 'Select()' OF o
				
			ENDROW o

			HTML o
			
				<script>
					
					function Select() {
						
						alert( $('#cars').val() )
					}				
					
				</script>	
			ENDTEXT		        
		
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil