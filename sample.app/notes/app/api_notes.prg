function api_notes( oDom )	

	do case		
		
		case oDom:GetProc() == 'exe_note'		; DoNotes( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc() )
	endcase	

retu oDom:Send()	

// ----------------------------------------------------------------------- //

static function DoNotes( oDom )

	local cName 	:= oDom:Get( 'name' )
	local cText  	:= oDom:Get( 'text' )
	local cKey  	:= oDom:Get( 'key' )
	local lTerms	:= oDom:Get( 'terms' )
	
_d( oDom:GetAll() )
	if empty( cName )
		oDom:SetAlert( 'Write alias please...')
		oDom:Focus( 'name' )
		retu nil
	endif
	
	if empty( cText )
		oDom:SetAlert( 'Write your note please...')
		oDom:Focus( 'text' )
		retu nil
	endif	
	
	if empty( cKey )
		oDom:SetAlert( 'Write key please...')
		oDom:Focus( 'key' )
		retu nil
	endif
	
	if upper( cKey ) != 'MAGIC'
		oDom:SetAlert( 'Magic key is wrong!')
		oDom:Focus( 'key' )
		retu nil
	endif	

	if	! lTerms
		oDom:SetAlert( 'Accept terms please...')
		oDom:Focus( 'terms' )
		retu nil
	endif		
	
	use ( 'data\notes.dbf' ) shared new via 'DBFCDX'
	
	dbappend()
	
	field->ip 		:= UGetIp()
	field->date	:= dtoc( date() ) + ' ' + time()
	field->alias	:= cName
	field->note	:= cText
		
	oDom:SetAlert( 'Welcome to new concept ' + cName )	

retu nil

// ----------------------------------------------------------------------- //