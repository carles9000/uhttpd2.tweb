function myapi( oDom )

	
	do case
		case oDom:GetProc() == 'hide' ; oDom:Hide( 'mytree' )
		case oDom:GetProc() == 'show' 	; oDom:Show( 'mytree' )	
		case oDom:GetProc() == 'clean'	; DoClean( oDom )
		case oDom:GetProc() == 'load'	; DoLoad( oDom )
		
		case oDom:GetProc() == 'init'	; DoInit( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoClean( oDom )

	oDom:SetJs( 'tree_clean', { 'myform-mytree', array() } )

return nil 

// --------------------------------------------------------- //

function DoLoad( oDom )

	local aData := LoadData()

	//oDom:SetJs( 'tree_clean', { 'myform-mytree', { 'Charles...', 'Pol...' } } )
	oDom:SetJs( 'tree_clean', { 'myform-mytree', aData } )

return nil 


// --------------------------------------------------------- //

function LoadData()

	local aData := {}
	
	Aadd( aData,  { "id" => "0"	, "parent" => "#"  , "text" => "UT Project", "icon" => "files/images/mini_world.png", "state" => { "opened" => .t. } } )
	Aadd( aData,  { "id" => "2"	, "parent" => "#"  , "text" => "Ejemplos"  , "icon" => "files/images/people.png", "state" => { "opened" => .f. } } )
	
	Aadd( aData,  { "id" => "10"	, "parent" => "0"  , "text" => "Test 0-a"    , "icon" => "files/images/clip.png", "data" => "id-10" } )
	Aadd( aData,  { "id" => "11"	, "parent" => "0"  , "text" => "Test 0-b"    , "icon" => "files/images/clip.png", "data" => "id-11" } )
	Aadd( aData,  { "id" => "12"	, "parent" => "0"  , "text" => "Test 0-c"    , "icon" => "files/images/clip.png", "data" => "id-12" } )
	
	Aadd( aData,  { "id" => "20"	, "parent" => "2"  , "text" => "Test 2-a"  , "icon" => "files/images/clip.png", "data" => "id-20" } )
  
 
   
retu aData

// --------------------------------------------------------- //

function DoInit( oDom )

	
_d( oDom:GetAll() )
_d( UGet() )
_d( UPost() )
_d( UServer() )
	
	

return nil 

// --------------------------------------------------------- //
