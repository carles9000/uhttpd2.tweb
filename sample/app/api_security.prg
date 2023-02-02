function Api_Security( oDom )

	do case		
		case oDom:GetProc() == 'test1'		; DoTest1( oDom )						
		case oDom:GetProc() == 'test2'		; DoTest2( oDom )								
		
		case oDom:GetProc() == 'test3'		; DoTest3( oDom )								
		case oDom:GetProc() == 'test4'		; DoTest4( oDom )								

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoTest1( oDom )

	local cVar 	:= oDom:Get( 'myvar' )
	local cToken 	:= USetToken( cVar )
	
	local hData 	:= {=>}
	
	hData[ 'original' ] := cVar
	hData[ 'token' ] := cToken
	hData[ 'detoken' ] := UGetToken( cToken )

	oDom:Set( 'mytoken', cToken )
	oDom:Console( hData )
	
retu nil

// -------------------------------------------------- //

static function DoTest2( oDom )

	local cToken 	:= oDom:Get( 'mytoken' )
	local cVar 	:= UGetToken( cToken )					
	
	if cVar == nil 
		oDom:SetAlert( 'Error token !' )
	else
		oDom:SetAlert( cVar, 'Data value' )
	endif
		
retu nil

// -------------------------------------------------- //

static function DoTest3( oDom )
	local hData := {=>}
	local cToken 
	
	hData[ 'name' ] := oDom:Get( 'myname' )
	hData[ 'age'  ] := oDom:Get( 'myage' )
	hData[ 'date' ] := oDom:Get( 'mydate' )
	
	cToken := USetToken( hData )

	oDom:Set( 'mycrypt', cToken )
	oDom:Set( 'mydecrypt', '' )			
	
retu nil

// -------------------------------------------------- //

static function DoTest4( oDom )
	local cToken 	:= oDom:Get( 'mycrypt' )
	local hVar 	:= UGetToken( cToken )		
	local cData 	:= ''
	
	if hVar == nil 	
		cData := '<error token>'
	else
		cData += hVar[ 'name' ] + chr(10)
		cData += hVar[ 'age' ] + chr(10)
		cData += hVar[ 'date' ] 
	endif 
	
	oDom:Set( 'mydecrypt', cData )	
	oDom:Console( hVar )
	
retu nil

// -------------------------------------------------- //
