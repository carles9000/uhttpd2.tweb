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
					PROMPT 'General', 'Admin' ;
					OPTION 'admin' OF o
					
					oFld:lBorder := .t.
				
					DEFINE TAB 'general' OF oFld

					
					ENDTAB oFld
					
					DEFINE TAB 'admin' CLASS 'p-5' OF oFld 

						GET oGet ID 'myid' VALUE '' LABEL 'Id. User' GRID 12 BUTTON 'Hello' ACTION "alert('hola')" OF oFld
						
					ENDTAB oFld			
				
				ENDFOLDER oFld

			ENDROW o
			
		ENDFORM o    
	
	INIT WEB oWeb RETURN
	
retu nil