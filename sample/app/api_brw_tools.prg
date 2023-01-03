//	Public Functions 

thread static nInd := 1000

// -------------------------------------------------- //

function OpenDbf( cFile, cCdx )

	static n := 1
	
	local cAlias 		:= 'ALIAS' + ltrim(str(++n))
	local cPathFile 	
	
	hb_default( @cFile, 'test.dbf')
	hb_default( @cCdx, '')

	cPathFile 	:= AppPathData() + cFile	
	
_d( 'CDX', cCdx )
	use ( cPathFile ) shared new alias (cAlias) VIA 'DBFCDX' 
	
	if !empty( cCdx )
		SET INDEX TO ( AppPathData() + cCdx )
	endif 
	
	cAlias := alias()

retu cAlias

// -------------------------------------------------- //

function LoadStates() 

	LOCAL hStates := {=>}
	LOCAL cAlias  := OpenDbf( 'states.dbf' )
	
	while (cAlias)->( !Eof() )
	
		hStates[ (cAlias)->CODE ] := (cAlias)->NAME
	
		(cAlias)->( DbSkip() )
	
	end 						
	
	(cAlias)->( DbCloseArea() )	

retu hStates 

// -------------------------------------------------- //

function GetRows( cAlias, nRecno, nTotal )

	local aRows 	:= {}
	local n 		:= 0
	local aStr  	:= (cAlias)->( DbStruct() )
	local nFields	:= len( aStr )	// (cAlias)->( FCount() )
	local aReg, j					
	
	
	
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



