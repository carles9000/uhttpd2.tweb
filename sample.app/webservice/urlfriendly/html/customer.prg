function Customer()
	
	local aInfo 		:= {=>}	
	
	aInfo[ 'service' ] 		:= 'customer'
	aInfo[ 'method' ] 		:= UGetParams()[ 'REQUEST_METHOD'] 
	aInfo[ 'parameters' ]	:= UGet()

    UAddHeader("Content-Type", "application/json")
    
retu hb_jsonEncode( aInfo )

