#include "../lib/uhttpd2/uhttpd2.ch"

//	Public Functions 

thread static nInd := 1000

// -------------------------------------------------- //

function OpenDbf( cFile, cCdx, cTag )

	static n := 1
	
	local cAlias 		:= 'ALIAS' + ltrim(str(++n))
	local cPathFile, oError	
	
	hb_default( @cFile, 'test.dbf')
	hb_default( @cCdx, '')
	hb_default( @cTag, '')

	cPathFile 	:= AppPathData() + cFile	
	
	TRY

		use ( cPathFile ) shared new alias (cAlias) VIA 'DBFCDX' 
		
		cAlias := alias()
		
		if !empty( cCdx )
		
			SET INDEX TO ( AppPathData() + cCdx )
			
			if !empty( cTag )			
				(cAlias)->( OrdSetFocus( cTag ) )
				
				if (cAlias)->( IndexOrd() ) == 0
					UDo_Error( "Tag doesn't exist " + cTag )
				endif
				
			endif
		endif 
		
	
	CATCH oError 

		Eval( ErrorBlock(), oError )
	
	END

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



