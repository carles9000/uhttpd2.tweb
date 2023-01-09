#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb, oBox
	local c := ''
	
	DEFINE WEB oWeb TITLE 'Box example III' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
	
		HTML oWeb 
		
			<style>
			
				.MyRow {
					margin:0px;
				}
				.MyBox {
					background-color:lightgray;	
					box-shadow: 5px 5px 10px 0px #888888;
					height: 250px !important;
					margin-top: 100px;
					border-radius: 10px;					
					border:1px solid gray;
				}
			</style>		
		
		ENDTEXT			
	
		DEFINE FORM o OF oWeb
			o:cType 	:= 'lg'		 //  xs,sm,md,lg		
			
		INIT FORM o	
		
			ROW o HALIGN 'center'
			
				COL o GRID 8							
					
					ROWGROUP o CLASS 'MyRow'

						BOX oBox ID 'CC' GRID 12 HEIGHT 180 CLASS 'MyBox' OF o
						
							ROWGROUP oBox 
								SAY VALUE '<h3>Autentication</h3><hr>' GRID 12 ALIGN 'center' OF oBox
							ENDROW oBox
							
							ROWGROUP oBox  HALIGN 'center'
								SAY VALUE '<i class="fas fa-user"></i> User' ALIGN 'right' GRID 4 OF oBox
								GET VALUE '' GRID 6 OF oBox
							ENDROW oBox

							ROWGROUP oBox  HALIGN 'center'
								SAY VALUE '<i class="fas fa-key"></i> Password' GRID 4 ALIGN 'right' OF oBox
								GET VALUE '' TYPE 'password' GRID 6 OF oBox
							ENDROW oBox
							
							ROWGROUP oBox HALIGN 'center'
								BUTTON LABEL ' Login' ACTION "MsgInfo( 'Logged!')" GRID 8  ALIGN 'center' ICON '<i class="fas fa-sign-in-alt"></i>' CLASS 'btn-primary' OF oBox
							ENDROW oBox
						
						ENDBOX oBox

					ENDROW o
					
				ENDCOL o		
			
			ENDROW o
		
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
		
	
retu nil