function Api_Folder( oDom )

	do case
		case oDom:GetProc() == 'ping'			; DoPing( oDom )						
		case oDom:GetProc() == 'gettime'		; oDom:Set( 'myid', ltrim(str(hb_milliseconds())) )
		case oDom:GetProc() == 'getid'			; DoGetId( oDom )
		case oDom:GetProc() == 'getvalues'		; DoGetValues( oDom )
		

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


static function DoGetId( oDom )

	local cId := oDom:GetTrigger()
	
	_d( cId )

	oDom:Set( cId, 'Trigger: ' + cId + ' at ' + time() )							
	
retu nil

// -------------------------------------------------- //


static function DoGetValues( oDom )

	local cId := oDom:GetTrigger()	
		
	do case
		case cId == 'btn_action_1'
			oDom:Set( 'btn2', ltrim(str(hb_milliseconds())) )
			oDom:Set( 'btn3', dtoc(date()) + ' ' + time() )
			oDom:Set( 'btn4', 'John')
			
		case cId == 'btn_action_2'
			oDom:Set( 'btn2', ltrim(str(hb_milliseconds())) )
			oDom:Set( 'btn3', dtoc(date()) + ' ' + time() )
			oDom:Set( 'btn4', 'Rambo')		
	endcase	
	
retu nil

