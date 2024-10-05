FUNCTION OAuth_Access( o )

	local hData 			:= UGet()		
	local hCredentials 	:= OAuth_Credentials()
	local hRes, cAccessToken, hUser

	if  USessionReady()
		URedirect( '/' )
		retu nil
	endif
   
	if hb_HHasKey( hData, 'code' )
		hRes := hb_jsonDecode( gGetAccessToken( hData[ 'code' ], hCredentials ) )
		cAccessToken := hb_HGetDef( hRes, "access_token", "" ) 
		hUser := hb_jsonDecode( gGetUserData( cAccessToken ) ) 

		USessionStart()
		
		hUser[ 'access_token' ] := cAccessToken
	
		Usession( 'user', hUser )		
		
	endif 
	
RETURN URedirect( '/' )


