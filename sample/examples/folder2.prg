#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Tutor9' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	

	DEFINE FORM o OF oWeb
		o:cSizing   := 'sm'

		HTML o
			<div class="alert alert-dark form_title" role="alert">
				<h5 style="margin:0px;">
					<i class="far fa-share-square"></i>
					Test Folder
				</h5>
			</div>
		ENDTEXT

		INIT FORM o  

			ROWGROUP o
			
				FOLDER oFld ID 'fld' ;
					TABS 'general', 'admin' ;
					PROMPT 'General', '<i class="fas fa-tv"></i> Admin' ;
					OPTION 'general' OF o
				
					DEFINE TAB 'general' OF oFld
						
						SEPARATOR oFld LABEL 'Auditor'
						
						ROWGROUP oFld  
							SAY VALUE 'Stock' GRID 5 ALIGN 'right' OF oFld
							GET ID 'xxx' VALUE '12,34' GRID 7 ALIGN 'center'  ;
								BUTTON '<i class="fas fa-wrench"></i>' ;
								ACTION "alert('modifica')" OF oFld
						ENDROW oFld
						
						ROWGROUP oFld  
							SAY VALUE 'Etiqueta' GRID 5 ALIGN 'right' OF oFld
							GET ID 'xxx' VALUE '9416015' GRID 7 ALIGN 'center' ;
								BUTTON '<i class="fas fa-wrench"></i>' ;
								ACTION "alert('etiqueta')" OF oFld
						ENDROW oFld

						ROWGROUP oFld  
							SAY VALUE 'Ubicacion' GRID 5 ALIGN 'right' OF oFld
							GET ID 'xxx' VALUE '1234567890' GRID 7 ALIGN 'center' ;
								BUTTON '<i class="fas fa-wrench"></i>' ;
								ACTION "alert('ubicacion')" OF oFld
						ENDROW oFld			
					
					ENDTAB oFld
					
					DEFINE TAB 'admin' OF oFld
					
						SEPARATOR oFld LABEL 'Others...'	

						GET oGet ID 'myid' VALUE '' LABEL 'Id. User' BUTTON 'Hello' ACTION "alert('hola')" OF oFld
						
					ENDTAB oFld			
				
				ENDFOLDER oFld

			ENDROW o
			
		ENDFORM o    
	
	INIT WEB oWeb RETURN
	
retu nil