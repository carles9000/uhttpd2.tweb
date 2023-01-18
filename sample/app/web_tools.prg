/*
function web_tools( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; SetData( oDom )												
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	
*/

// -------------------------------------------------- //

function getDogs()

	//local cAlias := OpenDbf( 'test.dbf', 'test.cdx' )		
	local cDbf := AppPathData() + 'test.dbf'
	local cCdx := AppPathData() + 'test.cdx'
	local cAlias
	local b := { ;
				{ 'value' => '1', 'label' => 'casa' },;
				{ 'value' => '2', 'label' => 'perro' },;
				{ 'value' => '3', 'label' => 'gato' } ;
				}

	
	_d( cDbf )
	_d( cCdx )
	
	USE (cDbf) shared new VIA 'DBFCDX'
	SET INDEX TO (cCdx)
	
	cAlias := Alias()
	
	_d( 'ALIAS:' + cAlias )
	_d( UGet() )
	_d( UPost() )
	
	UAddHeader("Content-Type", "application/json")

	UWrite( hb_jsonencode( b ) )
	
return nil
