#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	LOCAL hKeyValue := {=>}

	hKeyValue[ 'V' ] := 'Volvo'
	hKeyValue[ 'R' ] := 'Renault'
	hKeyValue[ 'M' ] := 'Mercedes'
	
	DEFINE WEB oWeb TITLE 'Combobox' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o OF oWeb
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

				SELECT oSelect  ID 'cars' KEYVALUE hKeyValue GRID 6  ONCHANGE 'Select()' OF o
				
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