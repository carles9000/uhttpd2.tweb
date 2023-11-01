function ws2()

	local hRow 		:= UPost()
	local hData 	:= {=>}
	local cType 	:= UGetParams()[ 'CONTENT_TYPE' ]		

	if HB_HHasKey( hRow, 'RAW' )	
	
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
