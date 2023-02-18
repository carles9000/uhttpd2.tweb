#include 'lib/uhttpd2/uhttpd2.ch'

thread static nInd := 0

function Api_Charset( oDom )

	do case
	
		case oDom:GetProc() == 'clean'			; DoClean( oDom )	
		
		//	Ansi Test
		case oDom:GetProc() == 'setdata'		; DoSetData( oDom )											
		case oDom:GetProc() == 'save'			; DoSave( oDom )		

		//	UTF8 Test
		case oDom:GetProc() == 'setdatautf8'	; DoSetDataUtf8( oDom )											
		case oDom:GetProc() == 'saveutf8'		; DoSaveUtf8( oDom )		
		
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoSetData( oDom )

	local cAlias 	:= OpenDbf()
	local aRows  	:= MyGetRows( cAlias, 1, 20 )

	oDom:Console( { 'rows' => aRows } )		

	oDom:TableSetData( 'mytable', aRows )		
	
retu nil

// -------------------------------------------------- //

static function DoSetDataUtf8( oDom )

	thread static nInd := 0

	local cFile	:= 'test_utf8.dbf'
	local aStruct 	:= {}
	local aRows 	:= {}
	local cp 		:= hb_SetCodePage( "UTF8EX" )
	local cAlias	
	
	if !File( AppPathData() + cFile )
	
		aStruct := { ;
			{ 'NICK', 'C', 20, 0 },;
			{ 'NAME', 'C', 20, 0 } ;
			}
			
		cAlias 		:= 'ALIAS' + ltrim(str(++nInd))
	
		dbcreate( AppPathData() + cFile, aStruct, 'DBFCDX', .T., cAlias, nil, 'UTF8EX' )
		
		(cAlias)->( DbAppend() )
		(cAlias)->nick := 'Charly'
		(cAlias)->name := 'English'   
		
		(cAlias)->( DbAppend() )
		(cAlias)->nick := 'カルロス'
		(cAlias)->name := 'Japones'
		
		(cAlias)->( DbAppend() )
		(cAlias)->nick := 'كارلوس'
		(cAlias)->name := 'Arabe'		
		
		(cAlias)->( DbAppend() )
		(cAlias)->nick := '카를로스'
		(cAlias)->name := 'Coreano'	

		(cAlias)->( DbAppend() )
		(cAlias)->nick := '卡洛斯'
		(cAlias)->name := 'Chino'	

		oDom:Console( 'Table UTF8 created!')
		
	else
		
		cAlias := OpenTableUTF8( cFile )
	endif
	
	aRows  	:= MyGetRowsUTF8( cAlias )
	
	oDom:Console( aRows )
	oDom:TableSetData( 'mytable', aRows )	
	
	hb_SetCodePage( cp )
	
	
retu nil
// -------------------------------------------------- //

static function DoClean( oDom )

	oDom:TableClean( 'mytable' )
	
retu nil

// -------------------------------------------------- //

static function DoSave( oDom )

	local cAlias 	:= OpenTable( 'test.dbf' )
	local hBrowse 	:= oDom:Get( 'mytable' )
	local hUpdated	:= hBrowse[ 'updated' ]	
	local hCell  	:= oDom:Get( 'cell' ) 
	local hRow, lLock, nRecno, cMsg, nIndex
	
	
	
	//	Only will receive one record (in this case...)
	
		if len( hUpdated )	 != 1 
			oDom:Console( 'Error param...')
			retu nil
		endif
		
	//	Recover parameters
	
		nIndex	:= HB_HKeyAt( hUpdated, 1 )
		hRow	:= HB_HValueAt( hUpdated, 1 )
		nRecno	:= hRow[ '_recno' ]	
	
	//	Go to Recno	
	
		if nRecno == 0		//	New record...
		
			(cAlias)->( dbAppend() )
			
			lLock := .t. 
			
		else 
		
			(cAlias)->( DbGoto( nRecno ) )
			
			lLock := (cAlias)->( Rlock() )
		
		endif
		
		if lLock 
	
			(cAlias)->first   	:= hRow[ 'FIRST' ]
			(cAlias)->last   	:= hRow[ 'LAST' ]
			
			(cAlias)->( DbUnlock())
			(cAlias)->( DbCommit())

			cMsg := 'Row updated'

			oDom:TableClearEdited( 'mytable', nIndex )	//	Very Important !
			
		else
		
			cMsg := 'Lock error!'
		
		endif				
	
		oDom:Console( nRecno, cMsg )
		
retu nil 

static function DoSaveUTF8( oDom )

	local cp 		:= hb_SetCodePage( "UTF8EX" )
	local cAlias 	:= OpenTableUTF8( 'test_utf8.dbf' )
	local hBrowse 	:= oDom:Get( 'mytable' )
	local hUpdated	:= hBrowse[ 'updated' ]	
	local hCell  	:= oDom:Get( 'cell' ) 
	local hRow, lLock, nRecno, cMsg, nIndex

	
	//	Only will receive one record (in this case...)
	
		if len( hUpdated )	 != 1 
			oDom:Console( 'Error param...')
			retu nil
		endif
		
	//	Recover parameters
	
		nIndex	:= HB_HKeyAt( hUpdated, 1 )
		hRow	:= HB_HValueAt( hUpdated, 1 )
		nRecno	:= hRow[ '_recno' ]	

	//	Go to Recno	
	
		if nRecno == 0		//	New record...
		
			(cAlias)->( dbAppend() )
			
			lLock := .t. 
			
		else 
		
			(cAlias)->( DbGoto( nRecno ) )
			
			lLock := (cAlias)->( Rlock() )
		
		endif
		
		if lLock 
		
			(cAlias)->nick   	:= hRow[ 'NICK' ]	//	'卡洛斯' a pelo se grava. Es decir el codepage funciona
			(cAlias)->name   	:= hRow[ 'NAME' ]
			
			(cAlias)->( DbUnlock())
			(cAlias)->( DbCommit())

			cMsg := 'Row updated'

			oDom:TableClearEdited( 'mytable', nIndex )	//	Very Important !
			
		else
		
			cMsg := 'Lock error!'
		
		endif				
		
		hb_SetCodePage( cp )
		
retu nil 

function OpenTable( cDbf )
	static n := 1
	
	local cAlias 		:= 'ALIAS' + ltrim(str(++n))
	local cPathFile 	:= AppPathData() + cDbf	
	local oError	
	
	TRY
	
//	CODEPAGE necesari

		use ( cPathFile ) shared new alias (cAlias) VIA 'DBFCDX' //CODEPAGE 'CP850'
		
		if NetErr() 
			UDo_Error( 'Error opertura' )		
		else		
		    cAlias := alias()	
		endif
	
	CATCH oError 

		Eval( ErrorBlock(), oError )
	
	END

retu cAlias

function OpenTableUTF8( cDbf )

	static n := 1
	
	local cAlias 		:= 'ALIAS' + ltrim(str(++n))
	local cPathFile 	:= AppPathData() + cDbf	
	local oError	
	local cp 			:= hb_SetCodePage( "UTF8EX" )
	
	//SET( _SET_DBCODEPAGE, 'UTF8EX' )
	
	TRY	

		use ( cPathFile ) shared new alias (cAlias) VIA 'DBFCDX' CODEPAGE 'UTF8EX'
		
		if NetErr() 
			UDo_Error( 'Error opertura' )		
		else		
		    cAlias := alias()	
		endif
	
	CATCH oError 

		Eval( ErrorBlock(), oError )
	
	END
	
	//hb_SetCodePage( cp )

retu cAlias


// -------------------------------------------------- //
//	UniToU8 en loop de 200000, tarda 3025ms.
//	hb_strtoUtf8 tarda 45ms
// -------------------------------------------------- //

static function MyGetRows( cAlias, nRecno, nTotal )

	local aRows 	:= {}
	local n 		:= 0
	local aStr  	:= (cAlias)->( DbStruct() )
	local nFields	:= len( aStr )	
	local aReg, j
	local uValue			

	(cAlias)->( DbGoto( nRecno ) )	
	
	//	Pillem SOLS el 1 registre 
	
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

						uValue := hb_strtoUtf8( Alltrim((cAlias)->( FieldGet( j ) )) , 1 )
	
					HB_HSet( aReg, (cAlias)->( FieldName( j ) ), uValue )  
					otherwise				
						HB_HSet( aReg, (cAlias)->( FieldName( j ) ), (cAlias)->( FieldGet( j ) ) ) 
				endcase
			
			next
			
			Aadd( aRows, aReg ) 
		
			(cAlias)->( DbSkip() )
			n++
		end 								
	
retu aRows 

// -------------------------------------------------- //

static function MyGetRowsUTF8( cAlias, nRecno, nTotal )

	local aRows 	:= {}			
	local cp 		:= hb_SetCodePage( "UTF8" )		
	local aReg	

	(cAlias)->( DbGotop() )		
	
		while (cAlias)->( !eof() ) 
				
			aReg := {=>}
			
			aReg[ 'id' ] := ++nInd
			aReg[ '_recno' ] := (cAlias)->( Recno() )
			aReg[ 'NICK' ] := alltrim( (cAlias)->nick )
			aReg[ 'NAME' ] := alltrim( (cAlias)->name	)
						
			Aadd( aRows, aReg ) 
		
			(cAlias)->( DbSkip() )
		
		end 	

	hb_SetCodePage( cp )		
	
	_d( aRows )
	
retu aRows 
