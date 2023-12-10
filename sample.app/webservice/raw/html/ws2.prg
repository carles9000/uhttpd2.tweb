function ws2()

	local hRow 		:= UPost()
	local hData 	:= {=>}
	local hParams 	:= UGetParams()	

	if HB_HHasKey( hRow, 'RAW' ) .and. HB_HHasKey( hParams, 'CONTENT_TYPE' )
	
		cType 	:= hParams[ 'CONTENT_TYPE' ]		
		
		do case
			case cType == 'text/plain'
				hData := hb_jsonDecode( hRow[ 'RAW' ] )
				
			case cType == 'application/json'
			case cType == 'text/html'
			case cType == 'application/xml'
			case cType == 'application/javascript'
		endcase
		
	endif	

	UAddHeader("Content-Type", "application/json")
	
retu hb_jsonEncode( hData )
