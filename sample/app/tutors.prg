#include "../lib/tweb/tweb.ch" 

#define IS_DESSIGN 	.T.

// -------------------------------------------------- //

function Tutor1()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor1' 
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			o:lFluid 	:= .T.
			
		INIT FORM o
		
			ROW o
				SAY VALUE 'Hello' ALIGN 'right' OF o
			ENDROW o
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN 
	
retu nil

// -------------------------------------------------- //

function Tutor2()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor2' 
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			o:lFluid 	:= .T.
			
		INIT FORM o
		
			ROW o
				SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF o
				SAY VALUE 'Hello' GRID 4 OF o
				SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF o
			ENDROW o
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN

retu nil 

// -------------------------------------------------- //

function Tutor3()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor3' 
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			
		INIT FORM o  		
			
			ROWGROUP o 
				SAY VALUE 'Id:' ALIGN 'right' OF o
				GET VALUE '123' OF o
			ENDROW o	

			ROWGROUP o 
				SAY VALUE 'Phone:' ALIGN 'right' OF o
				GET VALUE '' OF o
			ENDROW o		
			
		ENDFORM o		
	
	INIT WEB oWeb RETURN

retu nil 

// -------------------------------------------------- //

function Tutor4()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor4'
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			
			HTML o INLINE '<h3>Test Html</h3><hr>'	
			
			INIT FORM o
			
				HTML o
					<div class="row alert alert-dark form_title" role="alert">
						<h5 style="margin:0px;">
							<i class="far fa-share-square"></i>
							Form example
						</h5>
					</div>
				ENDTEXT		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN

retu nil 

// -------------------------------------------------- //

function Tutor5()

    local o, oWeb
	local cLoren := "<h2>Why do we use it?</h2>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
	
	DEFINE WEB oWeb TITLE 'Tutor5' 
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			o:lFluid  	:= .f.
				
			HTML o INLINE '<h3>Test Form</h3><hr>'	
			
			INIT FORM o  	
			
				HTML o
					<div class="row alert alert-dark form_title" role="alert">
						<h5 style="margin:0px;">
							<i class="far fa-share-square"></i>
							Form example
						</h5>
					</div>
				ENDTEXT		
				
				ROWGROUP o  
					SAY VALUE 'Id:' ALIGN 'right' OF o
					GET VALUE '' OF o
				ENDROW o

				ROWGROUP o  
					SAY VALUE 'Phone:' ALIGN 'right' OF o
					GET VALUE '' PLACEHOLDER "Enter phone number" OF o
				ENDROW o
				
				ROWGROUP o			
					BUTTON LABEL ' Test Button' ACTION "alert( 'Hi!' )" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o				
				ENDROW o			

				ROWGROUP o
					SAY VALUE cLoren GRID 12 OF o			
				ENDROW o		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN


retu nil 

// -------------------------------------------------- //

function Tutor6()

    LOCAL o, oWeb
	local cLoren := "<h2>Why do we use it?</h2>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
	local cIpsum := "<h5>Align top</h5>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."

	
	DEFINE WEB oWeb TITLE 'Tutor 6' 
	
		DEFINE FORM o OF oWeb
			o:ldessign 	:= IS_DESSIGN
			o:lFluid  	:= .f.		

			//HTML o FILE hb_dirbase() + 'html/tpl/header.tpl' PARAMS '<i class="far fa-share-square"></i>', 'Form example...'
			
			INIT FORM o  	
			
				ROW o VALIGN 'top'
					COL o GRID 8 
					
						ROWGROUP o
							SAY VALUE 'Id:' ALIGN 'right' OF o
							GET VALUE '' OF o
						ENDROW o

						ROWGROUP o
							SAY VALUE 'Phone:' ALIGN 'right' OF o
							GET VALUE '' PLACEHOLDER "Enter phone number" OF o
						ENDROW o
						
						ROWGROUP o	
							BUTTON LABEL ' Test Button' ACTION "alert( 'Hi!' )" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o
						ENDROW o		

					ENDCOL o			
					
					COL o GRID 4						

						ROWGROUP o 
							SAY VALUE cIpsum GRID 12 OF o			
						ENDROW o		
						
					ENDCOL o

				ENDROW o
				
			
				ROWGROUP o 
					SAY VALUE cLoren GRID 12 OF o			
				ENDROW o						
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN 

retu nil 

// -------------------------------------------------- //

function Tutor7()

    LOCAL o, oWeb, oSelect
	LOCAL aTxt := { 'Volvo', 'Seat', 'Renault' }
	LOCAL aKey := { 'V', 'S', 'R' }

	DEFINE WEB oWeb TITLE 'Tutor 7' 

		DEFINE FORM o OF oWeb
			o:lDessign := IS_DESSIGN
			o:cSizing   := 'sm'       	//  SM/LG
			
		INIT FORM o               
			
			ROWGROUP o VALIGN 'top'		//	Default
				SEPARATOR o LABEL 'Align top'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o            
			ENDROW o
			
			ROWGROUP o VALIGN 'center'
				SEPARATOR o LABEL 'Align center'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o             
			ENDROW o		
			
			ROWGROUP o VALIGN 'bottom'
				SEPARATOR o LABEL 'Test bottom'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o              
			ENDROW o		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN


retu nil 

// -------------------------------------------------- //

function Tutor8()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor 8' 
	
		DEFINE FORM o OF oWeb 
			o:lDessign 	:= IS_DESSIGN
			o:lFluid 	:= .T.
			
		INIT FORM o
		
			ROW o HALIGN 'center'
				SAY VALUE 'Hello' GRID 4 ALIGN 'right' OF o
				SAY VALUE 'Bye'   GRID 2 OF o			
			ENDROW o
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN

retu nil 

// -------------------------------------------------- //

function Tutor9()

    LOCAL o, oWeb
	
	DEFINE WEB oWeb TITLE 'Tutor 9'
		
		DEFINE FORM o OF oWeb 
			o:lDessign 	:= IS_DESSIGN
			o:cSizing 	:= 'sm'       	//  SM/LG  (small/large)
			
		INIT FORM o  		
			
			ROWGROUP o VALIGN 'bottom'
				GET VALUE '123' LABEL 'Id' OF o
				SELECT LABEL 'Cars' PROMPT 'Volvo', 'Renault' VALUES 'V', 'R' GRID 6  OF o
			ENDROW o		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN
	
retu nil

// -------------------------------------------------- //

function Tutor10()

    LOCAL o, oWeb, oGet
	LOCAL cTxt := ''

	DEFINE WEB oWeb TITLE 'Tutor10' 

		DEFINE FORM o ID 'demo' OF oWeb
			o:lDessign  := .F.
			o:cType     := 'md'    //  xs,sm,md,lg
			o:cSizing   := 'sm'     //  sm,lg

		HTML o
			<div class="alert alert-dark form_title" role="alert">
				<h5 style="margin:0px;">
					<i class="far fa-share-square"></i>
					Test Memo (Resizing screen...)
				</h5>
			</div>
		ENDTEXT
		
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
			
				COL o GRID 6
				
					SEPARATOR o LABEL 'Col 1'
					
					GET oGet MEMO LABEL 'Text Area...' VALUE cTxt GRID 12 OF o
					
				ENDCOL o
				
				COL o GRID 6
			
					SEPARATOR o LABEL 'Col 2'
					
					 SMALL o  LABEL cTxt GRID 12
					
				ENDCOL o
			
			ENDROW o
		
		ENDFORM o    
		
	INIT WEB oWeb RETURN 

retu nil 

// -------------------------------------------------- //

function Tutor11()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Get' 

		DEFINE FORM o OF oWeb	

		INIT FORM o  		
		   
			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 4 LABEL 'Id.' ;
					PLACEHOLDER 'User Id.' ;
					BUTTON 'GetId' ACTION 'GetId()' OF o
			
			ENDROW o		
			
			ROWGROUP o
				BUTTON ID 'mybtn'	LABEL 'Test' GRID 4 ACTION 'TestBtn()' OF o        
			ENDROW o		
			
			HTML o
				<script>
				
					function GetId() {
					
						var cId = $('#myid').val() 
					
						MsgInfo( cId )
					}
					
					function TestBtn() {
					
						alert( 'Button...' )
					}				
					
				</script>		
			ENDTEXT
			
		ENDFORM o

	INIT WEB oWeb RETURN


retu nil 

// -------------------------------------------------- //

function Tutor12()

    LOCAL o, oWeb, oFld, oGet

	DEFINE WEB oWeb TITLE 'Tutor12' 

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
					TABS 'menu1', 'admin' ;
					PROMPT 'Menu 1', '<i class="fas fa-tv"></i> Admin' ;
					OPTION 'admin' OF o

					DEFINE TAB 'menu1' OF oFld

						GET oGet ID 'myid' VALUE '' LABEL 'Id. User' BUTTON 'Hello' ACTION "alert('hola')" OF oFld
						
					ENDTAB oFld	
					
					DEFINE TAB 'admin' OF oFld
					
						HTML oFld
						
							<div class="alert alert-primary form_title row" role="alert">
								<h5 style="margin:0px;">
									<i class="fas fa-users-cog"></i>
									Administracion Usuarios
								</h5>
							</div>
							
						ENDTEXT						
						
					
						ROWGROUP oFld
							GET oGet ID 'aaa' VALUE 'aaa' GRID 4 PLACEHOLDER 'Test aaa' BUTTON '<i class="fas fa-search"></i>'  ACTION "alert(1)"  OF oFld
							GET oGet ID 'bbb' VALUE 'bbb' GRID 8 PLACEHOLDER 'Test bbb' BUTTON '<i class="fas fa-search"></i>'  ACTION "alert(2)"  OF oFld                             
						ENDROW oFld									
						
					ENDTAB oFld					
					
				ENDFOLDER oFld
				
			ENDROW o
		
		ENDFORM o    
	
	INIT WEB oWeb RETURN


retu nil 

// -------------------------------------------------- //

function Tutor13()

    LOCAL o, oWeb, oGet, oFld

	DEFINE WEB oWeb TITLE 'Tutor13' 

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

// -------------------------------------------------- //