thread static nInd := 0

function web_brw( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; SetData( oDom )						
		case oDom:GetProc() == 'adddata'	; AddData( oDom )						
		case oDom:GetProc() == 'clean'		; DoClean( oDom )						
		case oDom:GetProc() == 'error'		; oDom:SetTable( 'mytable', 'dummy' )
		case oDom:GetProc() == 'searchrows'; oDom:SetTable( 'mytable', 'searchData', { 'a'=>'FIRST', 'b' => '=', 'c'=>'Frank'} )
		case oDom:GetProc() == 'print'		; oDom:TablePrint( 'mytable' )
		
					
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function SetData( oDom )

	local cAlias 	:= OpenDbf()
	local aRows  	:= GetRows( cAlias, 1, 20 )
	
	
	oDom:Console( { 'rows' => aRows } )		
	

	//oDom:TableReset( 'mytable' )
	oDom:TableSetData( 'mytable', aRows )	

	
	//oDom:SetAlert( time() )		
	
retu nil

// -------------------------------------------------- //

static function AddData( oDom )

	local cAlias 	:= OpenDbf()
	local aReg  	:= { 'id' => ++nInd, 'FIRST' => 'Charly', 'LAST' => time(), 'STREET' => 'ABC' }
		
	oDom:TableAddData( 'mytable', aReg, nil, .T.  )	
	
retu nil

// -------------------------------------------------- //

static function DoClean( oDom )

	oDom:TableClean( 'mytable' )
	
retu nil

// -------------------------------------------------- //

static function OpenDbf( cFile )

	static n := 1
	
	local cAlias 		:= 'ALIAS' + ltrim(str(++n))
	local cPathFile 	
	
	hb_default( @cFile, 'test.dbf ')

	cPathFile 	:= AppPathData() + cFile	
	

	use ( cPathFile ) shared new alias (cAlias) VIA 'DBFCDX' 
	cAlias := alias()

retu cAlias

static function GetRows( cAlias, nRecno, nTotal )

	local aRows := {}
	local aReg 
	local n 	:= 0
	local aStr  	:= (cAlias)->( DbStruct() )
	local nFields	:= len( aStr )	// (cAlias)->( FCount() )
	local j		
	
	
	
	
	(cAlias)->( DbGoto( nRecno ) )	
	
		while n < nTotal .and. (cAlias)->( !eof() ) 
				
			aReg := {=>}
			
			HB_HSet( aReg, 'id' 		, ++nInd )
			HB_HSet( aReg, '_recno' 	, (cAlias)->( Recno() ) )
			HB_HSet( aReg, '_del' 		, (cAlias)->( Deleted() ) )
			
			for j := 1 to nFields

				do case
					case aStr[j][2] == 'D'							
						HB_HSet( aReg, (cAlias)->( FieldName( j ) ), DTOC( (cAlias)->( FieldGet( j ) ) ) ) 
					case aStr[j][2] == 'C'							
						HB_HSet( aReg, (cAlias)->( FieldName( j ) ), Alltrim((cAlias)->( FieldGet( j ) ) ) ) 
					otherwise				
						HB_HSet( aReg, (cAlias)->( FieldName( j ) ), (cAlias)->( FieldGet( j ) ) ) 
				endcase
			
			next
			
			Aadd( aRows, aReg ) 
		
			(cAlias)->( DbSkip() )
			n++
		end 			
	
retu aRows 