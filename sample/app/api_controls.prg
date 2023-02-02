function Api_Controls( oDom )

	do case
		case oDom:GetProc() == 'ping'		; DoPing( oDom )						
		
		case oDom:GetProc() == 'enable'	; DoEnable( oDom )						
		case oDom:GetProc() == 'disable'	; DoDisable( oDom )						
		case oDom:GetProc() == 'show'		; DoShow( oDom )						
		case oDom:GetProc() == 'hide'		; DoHide( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPing( oDom )

	oDom:SetAlert( oDom:GetList(.t.) , 'Parameteres received' )				
	oDom:Console( oDom:GetList(.f.), 'Parameteres received' )				
	
retu nil

// -------------------------------------------------- //

static function DoDisable( oDom )

	oDom:Disable( 'myget'   )
	oDom:Disable( 'mymemo'  )
	oDom:Disable( 'mybtn'   )
	oDom:Disable( 'mycheck' )
	oDom:Disable( 'mycombo' )
	oDom:Disable( 'myradio' )	
	
retu nil

// -------------------------------------------------- //

static function DoEnable( oDom )

	oDom:Enable( 'myget'   )
	oDom:Enable( 'mymemo'  )
	oDom:Enable( 'mybtn'   )
	oDom:Enable( 'mycheck' )
	oDom:Enable( 'mycombo' )
	oDom:Enable( 'myradio' )	
	
retu nil

// -------------------------------------------------- //

static function DoShow( oDom )

	oDom:Show( 'mysay'   )
	oDom:Show( 'myget'   )
	oDom:Show( 'mymemo'  )
	oDom:Show( 'mybtn'   )
	oDom:Show( 'mycheck' )
	oDom:Show( 'mycombo' )
	oDom:Show( 'myradio' )	

	
	oDom:Show( 'myrowgroup' )	
	oDom:Show( 'mycol' )	
	
retu nil

// -------------------------------------------------- //

static function DoHide( oDom )

	oDom:Hide( 'mysay'   )
	oDom:Hide( 'myget'   )
	oDom:Hide( 'mymemo'  )
	oDom:Hide( 'mybtn'   )
	oDom:Hide( 'mycheck' )
	oDom:Hide( 'mycombo' )
	oDom:Hide( 'myradio' )	
	
	oDom:Hide( 'myrowgroup'   )
	oDom:Hide( 'mycol'   )
retu nil

// -------------------------------------------------- //
