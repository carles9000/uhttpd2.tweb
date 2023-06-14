function Api_Card( oDom )

	do case
		case oDom:GetProc() == 'ping'			; DoPing( oDom )						
		case oDom:GetProc() == 'send_qm'		; DoQm( oDom )
		case oDom:GetProc() == 'gettrigger'	; DoGetTrigger( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //


static function DoPing( oDom )

	oDom:SetMsg( oDom:GetList(.t.), 'Parameteres received' )				
	oDom:Console( oDom:GetAll(), 'Parameteres received' )				
	oDom:Console( 'Trigger: ' + oDom:GetTrigger() )				
	oDom:Console( 'Value Trigger: ' + oDom:Get( oDom:GetTrigger() ) )				
	
retu nil

// -------------------------------------------------- //

static function DoQm( oDom )
	
	oDom:SetMsg( 'Backend procces: ' + oDom:Get( 'qm' ) )
	
retu nil

// -------------------------------------------------- //

static function DoGetTrigger( oDom )

	local cId_Trigger := oDom:GetTrigger()
	
	oDom:SetMsg( 'Value Control Trigger: ' + oDom:Get( cId_Trigger ) )				
	
	
retu nil
// -------------------------------------------------- //


