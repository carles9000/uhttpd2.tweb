function MyApi( oDom )
	
	do case
		case oDom:GetProc() == 'MyUpdated'	; UpdateRow( oDom )	
	otherwise
		oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

static function updateRow( oDom )

	local hCell  	:= oDom:Get( 'cell' )
	local hRow 	:= hCell[ 'row' ]
	local cId 		:= hRow[ 'id' ]
	
	if hCell[ 'field' ] == 'type'	//	If row edited == 'type'
	
		do case
			case hRow[ 'type' ] == 'Hotel'		; hRow[ 'cargo' ] := LoadHashHotels()
			case hRow[ 'type' ] == 'Theater'	; hRow[ 'cargo' ] := LoadHashTheaters()
			otherwise 
				hRow[ 'cargo' ] := {}
		endcase	
	
		oDom:TableUpdateRow( 'mytable', cId, hRow )
	endif			

retu nil 

// --------------------------------------------------------- //

static function LoadHashHotels() 
retu { 'Hotel H1' => 'Hotel H1' , 'Hotel H2' => 'Hotel H2'}

// --------------------------------------------------------- //

static function LoadHashTheaters() 
retu { 'T1' => 'Theater T1' , 'T2' => 'Theater T2', 'T3' => 'Theater T3' }

// --------------------------------------------------------- //