#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	LOCAL cTxt := ''

	DEFINE WEB oWeb TITLE 'Memo' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

		DEFINE FORM o ID 'demo' OF oWeb
			o:lDessign  := .T.		

			DEFINE FONT oFont NAME 'MyFont' COLOR 'green' ITALIC BOLD SIZE 20 OF o		

		
		TEXT TO cTxt
Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
It has survived not only five centuries, but also the leap into electronic typesetting, 
remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets 
containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker 
including versions of Lorem Ipsum.
		ENDTEXT

		INIT FORM o  
		
			ROW o VALIGN 'top'
				
				SEPARATOR o LABEL 'Test memo...'
					
				GET oGet MEMO LABEL 'Loren Ipsum' VALUE cTxt ROWS 5 GRID 6 FONT 'MyFont' OF o
			
			ENDROW o
		
		ENDFORM o    
	
	INIT WEB oWeb RETURN
	
retu nil