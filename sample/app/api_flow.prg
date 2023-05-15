function Api_Flow( oDom )

	do case
		case oDom:GetProc() == 'hello'		; oDom:SetMsg( 'Hello at ' + time() )
		case oDom:GetProc() == 'mydata'	; DoData( oDom )
		case oDom:GetProc() == 'js'		; DoJS( oDom )				
		
		case oDom:GetProc() == 'redirect'	; DoRedirect( oDom )				

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoData( oDom )

	local cMsg := ''
	
	cMsg += '<b>Name: </b>' + oDom:Get( 'myname' )
	cMsg += '<br><b>CIF: </b>' + oDom:Get( 'mycif' )
	
	oDom:SetMsg( cMsg, '<h3>Data received</h3>' )
	
retu nil

// -------------------------------------------------- //

static function DoJS( oDom )

	local hData := {=>}
	
	hData[ 'name' ]		:= 'Johtn Kocinsky'
	hData[ 'age' ] 		:= 37
	hData[ 'in' ]		:= date() - 1000
	
	
	oDom:SetJS( 'myCollector', hData )
	
retu nil


// -------------------------------------------------- //

static function DoRedirect( oDom )

	URedirect( '/' )

retu nil 
