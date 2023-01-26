#include "../lib/tweb/tweb.ch" 

function Api_Dialog( oDom )

	do case
		case oDom:GetProc() == 'dlg0'		; DoDlg0( oDom )						
		case oDom:GetProc() == 'dlg1'		; DoDlg1( oDom )						
		case oDom:GetProc() == 'dlg2'		; DoDlg2( oDom )						
		case oDom:GetProc() == 'dlg3'		; DoDlg3( oDom )						
		case oDom:GetProc() == 'dlg4'		; DoDlg4( oDom )						
		
		case oDom:GetProc() == 'hello'		; oDom:SetAlert( 'Hello at ' + time() )
		case oDom:GetProc() == 'getValues'	; ( oDom:SetAlert( 'Check console!' ), oDom:Console( oDom:GetList(.f.) ) )
		case oDom:GetProc() == 'search'	    ; DoSearch( oDom )						

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
	
	//o[ 'title' ] 		:= 'My Title...'	
	//o[ 'backdrop' ] 	:= .t.
	//o[ 'onEscape' ] 	:= .f.
	o[ 'closeButton' ]:= .f.
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
// API Listeners	
// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetAlert( _w( oDom:GetAll() ) )				
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