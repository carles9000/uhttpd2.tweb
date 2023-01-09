#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb, oBox
	local c := ''
	
	DEFINE WEB oWeb TITLE 'Box example II' 	
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------
	
		HTML oWeb
		
			<style>
				.MyBox {
					background-color:lightgray;	
					box-shadow: 5px 5px 10px 0px #888888;					
				}
			</style>		
		
		ENDTEXT
		
		DEFINE FORM o OF oWeb
			o:lDessign 	:= .T.
			o:lFluid 	:= .T.
			o:cType 	:= 'lg'		 //  xs,sm,md,lg		
		
			
		INIT FORM o	
		
			ROW o HALIGN 'center'
			
				COL o GRID 8
				
					ROWGROUP o 

						BOX oBox ID 'AA' GRID 6 HEIGHT 180 CLASS 'MyBox' OF o
						
							ROW oBox
							
								SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF oBox
								SAY VALUE 'Hello' GRID 4 OF oBox
								SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF oBox
							
							ENDROW oBox	

							ROW oBox
							
								SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF oBox
								SAY VALUE 'Hello' GRID 4 OF oBox
								SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF oBox
							
							ENDROW oBox						
						
						ENDBOX oBox
						
						BOX oBox ID 'BB' GRID 4 CLASS 'MyBox' OF o
						
							ROW oBox
							
								SAY VALUE 'Bye' GRID 4 ALIGN 'right' OF oBox
								SAY VALUE 'Bye' GRID 8 OF oBox						
							
							ENDROW oBox						
						
						ENDBOX oBox
					
					ENDROW o
					
				ENDCOL o		
			
			ENDROW o
		
		ENDFORM o
	
	INIT WEB oWeb RETURN 
	
		
	
retu nil