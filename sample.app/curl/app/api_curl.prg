#include "hbcurl.ch"

function Api_Curl( oDom )	

	do case
		case oDom:GetProc() == 'getip'			; GetIp( oDom )								
		case oDom:GetProc() == 'clean'			; oDom:Set( 'getip', '')
		
		case oDom:GetProc() == 'brwsetdata'		; DoBrwSetData( oDom )
		case oDom:GetProc() == 'brwclean'		; DoBrwClean( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //
// https://ifconfig.me/all.json
// https://ifconfig.me
// ipinfo.io/ip
// -------------------------------------------------- //

static function GetIp( oDom )

	local uValue 	:= ''
	local cUrl 		:= "https://ifconfig.me"			
	local hCurl, n		
	
	if ! empty( hCurl := curl_easy_init() )		
		
        curl_easy_setopt( hCurl, HB_CURLOPT_URL, cUrl )
        curl_easy_setopt( hCurl, HB_CURLOPT_TIMEOUT, 10 )			
        curl_easy_setopt( hCurl, HB_CURLOPT_DL_BUFF_SETUP )

		n := curl_easy_perform( hCurl ) 

        if n == 0
		
			uValue 	:= curl_easy_dl_buff_get( hCurl )						
			
		else
		
			uValue	:= curl_easy_strerror( n )			
			
        endif
		
		curl_easy_cleanup(hCurl) 		
		
    endif

	oDom:Set( 'getip', uValue )
	
retu nil

// -------------------------------------------------- //

static function DoBrwSetData( oDom )

	local cPage 		:= oDom:Get( 'mypage' )		
	local h				:= {=>}
	local aRows 		:= {}
	local cUrl, uValue, hCurl, n, cError
	
	cUrl  		:= "https://picsum.photos/v2/list?page=" + cPage + "&limit=10"		

	if ! empty( hCurl := curl_easy_init() )		
	
        curl_easy_setopt( hCurl, HB_CURLOPT_URL, cUrl )
        curl_easy_setopt( hCurl, HB_CURLOPT_TIMEOUT, 10 )			
        curl_easy_setopt( hCurl, HB_CURLOPT_DL_BUFF_SETUP )	        
		
		// https://stackoverflow.com/questions/65426618/curl-1020-error-when-trying-to-scrape-page-using-bash-script
        curl_easy_setopt( hCurl, HB_CURLOPT_USERAGENT, 'Chrome/79' )				        		
        
        curl_easy_setopt( hCurl, HB_CURLOPT_DL_BUFF_SETUP )

		curl_easy_setopt( hCurl, HB_CURLOPT_SSL_VERIFYPEER, .f. )
		curl_easy_setopt( hCurl, HB_CURLOPT_SSL_VERIFYHOST, .f. )
		curl_easy_setopt( hCurl, HB_CURLOPT_NOPROGRESS, .t. )
		//curl_easy_setopt( hCurl, HB_CURLOPT_VERBOSE, .t. )								
		curl_easy_setopt( hCurl, HB_CURLOPT_FOLLOWLOCATION )        // Necesario para aquellos sitios que nos redirigen a otros


		n := curl_easy_perform( hCurl ) 
		

        if n == 0
		
			uValue 	:= curl_easy_dl_buff_get( hCurl )	
		
			aRows	:= hb_jsonDecode( uvalue )
			
			_d( 'Respuesta: ', aRows )								
			
		else		
		
			uValue := curl_easy_strerror( n )						
			
			oDom:SetError( uValue )
			
        endif
		
		curl_easy_cleanup(hCurl) 		
		
    endif	

	oDom:TableSetData( 'mytable', aRows )

retu nil 


// -------------------------------------------------- //

static function DoBrwClean( oDom )	

	oDom:TableClean( 'mytable' )
	
retu nil