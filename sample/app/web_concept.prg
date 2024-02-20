#include "../lib/tweb/tweb.ch" 

thread static nCount := 0

// -------------------------------------------------- //
//	1.- Dessign screen !
// -------------------------------------------------- //

function Concept()

    LOCAL o, oWeb, oCheck, oRadio, oMemo, oSelect, oNav
	LOCAL cTxt 		:= ''
	local hGet 		:= UGet()
	local lDessign		:= if( HB_HHasKey( hGet, 'dessign' ), if( hGet[ 'dessign' ] == 'true', .t., .f. ), .t. )
	local cRoute 		:= if( lDessign, 'screen2?dessign=false', 'screen2?dessign=true')

	
	TEXT TO cTxt
Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
It has survived not only five centuries, but also the leap into electronic typesetting, 
remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets 
containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker 
including versions of Lorem Ipsum.
	ENDTEXT

	DEFINE WEB oWeb TITLE 'Get Button' 
	
		NAV oNav ID 'nav' TITLE '&nbsp;Test Controls' LOGO "files/images/tweb_white.png" ;
			ROUTE '/' WIDTH 60 HEIGHT 30 OF oWeb

			MENUITEM 'Home' 	ICON '<i class="fa fa-home" aria-hidden="true"></i>' ROUTE 'screens'	OF oNav
			MENUITEM 'List' 	ICON '<i class="fa fa-list" aria-hidden="true"></i>' ROUTE 'brw' 			OF oNav
			MENUITEM 'Reload Dessign (on/off)'	ICON '<i class="fa fa-retweet" aria-hidden="true"></i>' ROUTE cRoute	OF oNav

    DEFINE FORM o ID 'concept' API 'api_concept' ON INIT 'hello' OF oWeb
		o:lDessign 	:= lDessign

		INIT FORM o  
		
			ROWGROUP o			
				GET ID 'dni' LABEL 'D.N.I.' VALUE '3' ONCHANGE 'showdni' GRID 4 OF o	
				
				GETNUMBER ID 'qty' LABEL 'Qty' VALUE '123' ONCHANGE 'showqty' GRID 4 OF o						
				
				GET ID 'sp1' VALUE '' BUTTON 'Test' ACTION "testspan"  LABEL 'Span' SPAN '0' SPANID 'myspan' GRID 4 OF o
			ENDROW o	

			ROWGROUP o
			
				GET ID 'myid' 		VALUE '123' GRID 12 LABEL 'Id...' ;	
					BTNIDS 'btn-a', 'btn-b', 'btn-c' ;
					BUTTON 'GetId', 'Test', '<i class="fas fa-search"></i>' ;
					ACTION 'showid', 'TestBtn()', "search" OF o
			
			ENDROW o
			
			ROWGROUP o
			   
				//SEPARATOR o LABEL 'Datos de Salida'

				RADIO    oRadio  ID 'status' PROMPT 'Soltero', 'Casado' VALUES  'S', 'C'  GRID 6  INLINE ONCHANGE 'status' OF o
				//CHECKBOX oCheck  ID 'active' LABEL 'Is Active ?' GRID 3 ON ACTION 'active' OF o				
				CHECKBOX oCheck  ID 'active' LABEL 'Is Active ?' GRID 3 ACTION 'active' OF o
				SWITCH ID 'power' VALUE .F. LABEL 'Power' ONCHANGE 'power' GRID 3 OF o
			ENDROW o
			
			ROWGROUP o
				SELECT oSelect  ID 'cars' PROMPT 'Volvo', 'Seat', 'Renault' VALUES  'V', 'S', 'R'  GRID 6  LABEL 'Cars' ONCHANGE 'combo' OF o				
			ENDROW o

			ROWGROUP o
				
				SEPARATOR o LABEL 'Test memo...'
					
				GET oMemo MEMO ID 'memo' LABEL 'Loren Ipsum' VALUE cTxt ROWS 5 GRID 12 ONCHANGE 'showmemo' OF o
			
			ENDROW o
	

			ROWGROUP o
				BUTTON LABEL 'Send' GRID 12 WIDTH '100%' ACTION 'send' OF o        			
			ENDROW o			
			
			HTML o
				<script>
					
					function TestBtn() {
					
						alert( 'Button...' )
					}

				</script>		
			ENDTEXT
			
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil 

// -------------------------------------------------- //
//	2.- We define screen life... :-)
// -------------------------------------------------- //

function Api_Concept( oDom ) 

	do case
		case oDom:GetProc() == 'showid' 	; ShowId( oDOm )
		case oDom:GetProc() == 'showdni' 	; oDom:SetMsg( oDom:Get( 'dni' ), 'Answer from server' )
		case oDom:GetProc() == 'send' 		; MySend( oDom )
		case oDom:GetProc() == 'active'	; oDom:SetMsg( if( oDom:Get( 'active' ) == .t., 'Si','No'), , 'Answer from server')
		case oDom:GetProc() == 'status'	; oDom:SetMsg( oDom:Get( 'status' ), 'Answer from server' )
		case oDom:GetProc() == 'showmemo'	; oDom:SetMsg( oDom:Get( 'memo' ), 'Answer from server' )
		case oDom:GetProc() == 'showqty'	; oDom:SetMsg( oDom:Get( 'qty' ), 'Answer from server' )
		case oDom:GetProc() == 'power'		; oDom:SetMsg( if( oDom:Get( 'power' ) == .t., 'Si','No'), 'Answer from server' )
		case oDom:GetProc() == 'combo'		; oDom:SetMsg( oDom:Get( 'cars' ), 'Answer from server' )
		case oDom:GetProc() == 'hello' 	; oDom:SetMsg( 'Hello friend!', 'Event oninit' )
		case oDom:GetProc() == 'testspan'	
			nCount++
			oDom:Set( 'myspan', ltrim(str(nCount)) )
			
					
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase


retu oDom:Send()

//	------------------------------------------------ //

function ShowId( oDOm )

	local cId := oDom:Get( 'myid' )
	
	oDom:SetMsg( '<b>Id: </b>' + cId, 'Answer from server' )

retu nil 

//	------------------------------------------------ //

function MySend( oDom )
	local a := oDom:Get( 'dni' )
	local b := oDom:Get( 'myid' )

	oDom:SetMsg( '<b>Dni: </b>' + a + '<br>' + '<b>Id: </b>' + b, 'Send' )

retu nil
