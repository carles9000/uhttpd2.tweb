function Api_Session( oDom )

	
	do case
		case oDom:GetProc() == 'session_init'	; DoSession_Init( oDom )	
		case oDom:GetProc() == 'session_end'	; DoSession_End( oDom )
		case oDom:GetProc() == 'session_exist'	; DoSession_Exist( oDom )								
		case oDom:GetProc() == 'session_load'	; DoSession_Load( oDom )			
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

static function DoSession_Init( oDom )

	local hData 			:= {=>}	
	local hSession

	USessionStart()

	hSession := UGetSession() 

	
	hData[ 'user'      ] := 'CHARLY'
	hData[ 'init_date' ] := date()
	hData[ 'init_time' ] := time()
	hData[ 'init_sid'  ] := hSession[ 'sid' ]
	
	Usession( 'data', hData )	
	
	oDom:SetMsg( 'Session created ! <br>Time session: ' + ltrim(str(hSession['duration'])) )
	
retu nil  

// --------------------------------------------------------- //

static function DoSession_End( oDom )

	USessionEnd()	

	oDom:SetMsg( 'Session was deleted !' )

retu nil 

// -------------------------------------------------- //

static function DoSession_Exist( oDom )

	local lExist := USessionReady() 

	oDom:SetMsg( 'Session ' + if( lExist, 'OK', 'KO') + Info() )
	
retu nil 

// -------------------------------------------------- //

static function DoSession_Load( oDom )

	local lExist	:= USessionReady()

	if lExist			
		oDom:SetMsg( 'Session OK. <br>' + _w( USessionAll() ) + Info() )
	else
		oDom:SetMsg( 'Session KO'  )
	endif
	
retu nil

// --------------------------------------------------------- //

static function Info()

	local cInfo 		:= '<hr>'
	local hSession		:= UGetSession()	
	
	if empty( hSession )
		retu cInfo 
	endif
	
	cInfo += 'Session duration: ' + ltrim(str(hSession[ 'duration' ])) 
	cInfo += '<br>Time now: ' + time()	
	cInfo += '<br>Will expire: ' +  SecToTime(hSession[ 'expired' ])
	cInfo += '<br>Time left: ' + SecToTime(hSession[ 'expired' ]  - Seconds() )	

retu cInfo 
