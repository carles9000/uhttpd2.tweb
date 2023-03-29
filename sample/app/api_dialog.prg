#include "../lib/tweb/tweb.ch" 

function Api_Dialog( oDom )

	do case
		case oDom:GetProc() == 'dlg0'		; DoDlg0( oDom )						
		case oDom:GetProc() == 'dlg1'		; DoDlg1( oDom )						
		case oDom:GetProc() == 'dlg2'		; DoDlg2( oDom )						
		case oDom:GetProc() == 'dlg3'		; DoDlg3( oDom )						
		case oDom:GetProc() == 'dlg4'		; DoDlg4( oDom )	
		case oDom:GetProc() == 'dlg5'		; DoDlg5( oDom )	

		//	2 ejemplos (iguales) que colocan datos en otro FORM
		
			case oDom:GetProc() == 'pagos'			; DoPagos( oDom )						
			case oDom:GetProc() == 'pagos_info'	; DoPagosInfo( oDom )						
			case oDom:GetProc() == 'pagos_close'	; DoPagosClose( oDom )	

			case oDom:GetProc() == 'policy'		; DoPolicy( oDom )						
			case oDom:GetProc() == 'policy_view'	; DoPolicyView( oDom )									
			case oDom:GetProc() == 'policy_accept'	; DoPolicyAccept( oDom )									

		//	-------------------------------------------------------------
		
		case oDom:GetProc() == 'hello'		; oDom:SetMsg( 'Hello at ' + time() )
		case oDom:GetProc() == 'getValues'	; ( oDom:SetMsg( 'Check console!' ), oDom:Console( oDom:GetList(.f.) ) )
		case oDom:GetProc() == 'search'	    ; DoSearch( oDom )		
		
		case oDom:GetProc() == 'testpbs'	    ; DoPBS( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //
// Screens 
// -------------------------------------------------- //

static function DoDlg0( oDom )

	local cHtml := MyScreen()
	
	oDom:SetDialog( 'xxx', cHtml )
	
retu nil

// -------------------------------------------------- //

static function DoDlg1( oDom )

	local cHtml := ULoadHtml( 'dialog\mini-dlg.html'  )
	local o 	:= {=>}	
	
	//	-------------------------------------------------------------------------------------
	//	TWeb usa el pluggin bootbox para creaar diálogos.
	//	Todos los paràmetros los puedes encontrar aqui -> http://bootboxjs.com/examples.html 
	//	-------------------------------------------------------------------------------------
	
	//o[ 'title' ] 		:= 'My Title...'	
	//o[ 'backdrop' ] 	:= .t.
	//o[ 'onEscape' ] 	:= .f.
	//o[ 'closeButton' ]:= .t.
	//o[ 'className' ] 	:= 'bounceIn fadeOutRight'
	
	oDom:SetDialog( 'xxx', cHtml, nil, o )
	
retu nil

// -------------------------------------------------- //

static function DoDlg2( oDom )

	local cHtml := ULoadHtml( 'dialog\brw.html'  )
	
	oDom:SetDialog( 'xxx', cHtml, 'My Browse' )
	
retu nil

// -------------------------------------------------- //

static function DoDlg3( oDom )

	local cHtml := ULoadHtml( 'dialog\screen1.html'  )
	local o 	:= {=>}	
	
	//o[ 'backdrop' ] 	:= .t.
	//o[ 'onEscape' ] 	:= .f.
	//o[ 'closeButton' ]:= .f.
	//o[ 'className' ] 	:= 'bounceIn fadeOutRight'	
	o[ 'title' ] 		:= 'Search customer'	
	o[ 'size' ] 		:= '90%'	
	
	oDom:SetDialog( 'xxx', cHtml, nil, o	)
	
retu nil

// -------------------------------------------------- //

static function DoDlg4( oDom )

	local cHtml := ULoadHtml( 'dialog\brw-select.html'  )
	
	oDom:SetDialog( 'xxx', cHtml, 'Search customer')
	
retu nil

// -------------------------------------------------- //

static function DoDlg5( oDom )

	local cHtml := ULoadHtml( 'dialog\brw-select.html'  )
	
	oDom:SetDialog( 'xxx', cHtml, 'Search customer', { 'focus' => 'seed-mysearch' } )
	
retu nil

// -------------------------------------------------- //

static function DoPagos( oDom )

	local o := {=>}

	local cHtml := ULoadHtml( 'dialog\pagos.html'  )
	
	o[ 'size' ] 		:= '400px'
	
	oDom:SetDialog( 'xxx', cHtml,nil , o )
	
retu nil

// -------------------------------------------------- //

static function DoPagosInfo( oDom )

	local cPago := oDom:Get( 'formaPago' )

	oDom:SetDlg( 'myform' )			//	We select scope (FORM)
	
	oDom:Set( 'info', 'Forma de pago: ' + cPago  )			
	oDom:DialogClose( 'xxx' )			

retu nil 

// -------------------------------------------------- //

static function DoPagosClose( oDom )
		
	oDom:DialogClose( 'xxx' )			

retu nil 

// -------------------------------------------------- //

static function DoPolicy( oDom )

	local cHtml := ULoadHtml( 'dialog\policy.html'  )
	local o 	 := {=>}
	
	o[ 'size' ] 		:= '450px'	

	oDom:SetDialog( 'mypolicy', cHtml, 'Select policy type' , o )
	
retu nil

// -------------------------------------------------- //

static function DoPolicyView( oDom )
	local cType := oDom:Get( 'type' )
	local cName, cDescription, cPrice 
	
	do case
		case cType = 'E'
			cName 			:= 'Economy'
			cDescription	:= 'Policy very economy'
			cPrice			:= '96€'
		case cType = 'C'
			cName 			:= 'Complete'
			cDescription	:= 'Complete services'
			cPrice			:= '228€'		
		case cType = 'P'
			cName 			:= 'Premium'
			cDescription	:= 'No limits'
			cPrice			:= '487€'		
	endcase	

	oDom:SetDlg( 'myform' )		//	We select scope (FORM)
	
	oDom:Set( 'name', cName )	
	oDom:Set( 'description', cDescription )	
	oDom:Set( 'price', cPrice )	
	
retu nil 

static function DoPolicyAccept( oDom )

	//	Do process...
	
	
	//	Finally Close dialog
	
	oDom:SetMsg( "You're accepted policy" )
	oDom:DialogClose( 'mypolicy' )			

retu nil 

// -------------------------------------------------- //
// API Listeners	
// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetMsg( _w( oDom:GetAll() ) )				
	oDom:Console( oDom:GetList( .f. ), 'Parameteres received' )				
	
retu nil

// -------------------------------------------------- //

static function DoSearch( oDom )

	local cSearch 	:= oDom:Get( 'mysearch' )
	local aRows 	:= {}
	local cAlias, aReg 
	
	if empty( cSearch )
		retu nil
	endif
	
	cSearch := upper( cSearch )
	
	use ( AppPathData() + 'test.dbf' ) shared new VIA 'DBFCDX' 	
	SET INDEX TO ( AppPathData() + 'test.cdx' )
	
	cAlias := Alias()	

	(cAlias)->( OrdSetFocus( 'STATE' ) )
	
	(cAlias)->( DbSeek( cSearch ) ) 
	
	while (cAlias)->state == cSearch .and.  (cAlias)->( !eof() ) 
				
		aReg := {=>}
		
		aReg[ '_recno' ]:= (cAlias)->( Recno() )
		aReg[ 'FIRST' ] := (cAlias)->first
		aReg[ 'LAST' ] 	:= (cAlias)->last
		aReg[ 'AGE' ] 	:= (cAlias)->age
		aReg[ 'STREET' ]:= (cAlias)->street	
		
		Aadd( aRows, aReg ) 
	
		(cAlias)->( DbSkip() )
	
	end 	
	
	oDom:TableSetData( 'mytable', aRows, .T. )
	
retu nil

// -------------------------------------------------- //

static function MyScreen()

	LOCAL o, oDlg			
	
	
	DEFINE DIALOG oDlg
		
		DEFINE FORM o ID 'abc' API 'api_dialog' OF oDlg							

		INIT FORM o					
			SAY VALUE '<h1>Welcome to Dialogs !' ALIGN 'center' GRID 12  OF o									
			SAY VALUE '<h4>Basic sample (compiled)<hr>' ALIGN 'center' GRID 12  OF o									
			
			BUTTON ID 'btn' LABEL 'Click me!' ALIGN 'center' GRID 12 ACTION 'hello' OF o
		ENDFORM o	

	
	INIT DIALOG oDlg RETURN 

retu nil 

// -------------------------------------------------- //

static function DoPBS( oDom )

	//	We simulate long proccess 
		hb_IdleSleep(3)
	
	oDom:Console( oDom:GetAll() )
	
	//	Call MsgLoading(.f.) --> Close loading dialog...
		oDom:SetJs( 'MsgLoading', { .f. } )
	
	oDom:SetMsg( 'Code processed: ' + oDom:Get( 'mycode' ) )
	
retu nil