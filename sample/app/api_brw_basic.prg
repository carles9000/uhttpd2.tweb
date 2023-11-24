thread static nInd := 0

function Api_Brw_Basic( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; SetData( oDom )						
		case oDom:GetProc() == 'adddata'	; AddData( oDom )						
		case oDom:GetProc() == 'updaterow'	; UpdateRow( oDom )						
		case oDom:GetProc() == 'clean'		; DoClean( oDom )				
		case oDom:GetProc() == 'print'		; oDom:TablePrint( 'mytable' )
		case oDom:GetProc() == 'dummy'		; oDom:console( oDom:Getall() )
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function SetData( oDom )

	local cAlias 	:= OpenDbf()
	local aRows  	:= GetRows( cAlias, 1, 20 )	
	
	oDom:Console( { 'rows' => aRows } )			
	
	oDom:TableSetData( 'mytable', aRows )			
	
retu nil

// -------------------------------------------------- //

static function AddData( oDom )

	local cAlias 	:= OpenDbf()
	local aReg  	:= { 'id' => ++nInd, 'FIRST' => 'Shawn', 'LAST' => time(), 'AGE' => nInd }
		
	oDom:TableAddData( 'mytable', aReg, nil, .T.  )		
	
retu nil

// -------------------------------------------------- //

static function UpdateRow( oDom )
	
	local hRow	:= { 'LAST' => time(), 'AGE' => hb_randint(2,99) }		
	
	oDom:TableUpdateRow( 'mytable', 2, hRow  )		
	
retu nil

// -------------------------------------------------- //

static function DoClean( oDom )

	oDom:TableClean( 'mytable' )
	
retu nil

// -------------------------------------------------- //
