#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Tutor5' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------


		DEFINE FORM o OF oWeb 
			o:lDessign  := .T.

		HTML o
			<div class="alert alert-dark form_title" role="alert">
				<h5 style="margin:0px;">
					<i class="far fa-share-square"></i>
					Test Radio/Checkbox Font
				</h5>
			</div>
		ENDTEXT
		
		DEFINE FONT oFont NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o

		INIT FORM o         
	   
			ROWGROUP o
			   
				SEPARATOR o LABEL 'Datos de Salida'

				RADIO    oRadio  ID 'style1'  PROMPT 'Uno', 'Dos', 'Tres' VALUES  '1', '2', '3'  FONT 'MyFont' GRID 6  OF o
				CHECKBOX oCheck1 ID 'accept1' LABEL 'Accept'  GRID 6  FONT 'MyFont' OF o

			ENDROW o		
		
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil