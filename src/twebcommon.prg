//	----------------------------------------------------------------

function GetMsgServer()

	local hParam 	:= UPost()
	local uValue 
	

	if HB_HHasKey( hParam, 'type' ) 
	
		do case
			case hParam[ 'type' ] == 'C'; 	uValue := hParam[ 'value' ]
			case hParam[ 'type' ] == 'H'; 	uValue := hb_jsonDecode( hParam[ 'value' ] ) 
			case hParam[ 'type' ] == 'N'; 	uValue := Val( hParam[ 'value' ] )
			case hParam[ 'type' ] == 'L';	uValue := if( hParam[ 'value' ] == 'true', .t., .f.  )
			otherwise
				uValue := hParam[ 'value' ]
		endcase	
		
	else 
	
		uValue := hParam
	
	endif

retu uValue