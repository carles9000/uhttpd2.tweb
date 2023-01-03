/*
	|				|	Tabulator	|  API 	| Selected | Updated
	| Init			|				| 		|			|
	| setdata		|	addData		|	X	|			|
	| delete		|	deleteRow	|   X 	| 	  X		|
	| Clean			|	setData		|	X	|			|
	| Save			|	MySave		|		|			|    X
	| UpdateRow	|	updateData	|	X	|			|
	| MyProc		|	MyProc		|		|	  X		|
	| ClearEdited	|	ClearEdited|	X	|	  		|

*/

thread static nInd := 1

function Api_Brw_Crud( oDom )

	do case
		case oDom:GetProc() == 'setdata'	; DoData( oDom )								
		case oDom:GetProc() == 'clean'		; DoClean( oDom )						
		case oDom:GetProc() == 'delete'		; DoDelete( oDom )						
		case oDom:GetProc() == 'add'		; DoAdd( oDom )						
		case oDom:GetProc() == 'save'		; DoSave( oDom )						
		case oDom:GetProc() == 'myproc'		; DoMyProc( oDom )						
						
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoData( oDom )

	local cAlias 	:= OpenDbf()
	local aRows  	:= GetRows( cAlias, 1, 20 )			
	
	oDom:TableSetData( 'mytable', aRows )			
	
retu nil

// -------------------------------------------------- //

static function DoClean( oDom )
	
	oDom:Trace()
	oDom:TableClean( 'mytable' )
	
retu nil


// -------------------------------------------------- //

static function NewId()	
	
	nInd++
	
return 'ID' + ltrim(str(nInd))
	
	

// -------------------------------------------------- //

static function DoAdd( oDom )

	local aRows := {}
	local cId 
	
	cId := NewId()
	Aadd( aRows, { 'id' => cId, 'FIRST' => 'Duck Donald ' + cId } )
	
	
	cId := NewId()
	Aadd( aRows, { 'id' => cId, 'FIRST' => 'Duck Lucas ' + cId } )
	

	//TableAddData( cId, aData, lTop, nIndex ) 
	oDom:TableAddData( 'mytable', aRows, .T. )
	
retu nil

// -------------------------------------------------- //

static function DoDelete( oDom )

	local hBrowse 	:= oDom:Get( 'mytable' )
	local aSelected	:= hBrowse[ 'selected' ]	
	local nLen 		:= len( aSelected )	
	local n, nId  
	
	for n := 1 to nLen 
	
		nId := aSelected[ n ][ 'id' ]	

		//	Delete (if ok) from backend + delete for client						
		
		oDom:TableDelete( 'mytable', nId )
	
	next 
	
retu nil

// -------------------------------------------------- //

static function DoMyProc( oDom )

	local hBrowse 	:= oDom:Get( 'mytable' )
	local aSelected	:= hBrowse[ 'selected' ]	
	local nLen 		:= len( aSelected )	
	local n, nId  
	
	for n := 1 to nLen 
	
		nId := aSelected[ n ][ 'id' ]	

		//	Process registers Id...		

		//	Simulate -> change FIRST field, and update table, and ...
		
			aSelected[ n ][ 'FIRST' ] := aSelected[ n ][ 'FIRST' ] + ' (' + time() + ')'

		//	
	
	next 
	
	oDom:Console( aSelected, 'Registers Proccess...'  )
	
	oDom:TableUpdate( 'mytable', aSelected )
	
	oDom:SetAlert( 'Process num registers ' + str(nLen) + '. Check console' )
	
	
retu nil

// -------------------------------------------------- //

static function DoSave( oDom )

	local hBrowse 	:= oDom:Get( 'mytable' )
	local aUpdated	:= hBrowse[ 'updated' ]	
	local nLen 		:= len( aUpdated )	
	local n, nId, aPair 
	local aTrace 	:= {}
	
	for n := 1 to nLen 	

		aPair := HB_HPairAt( aUpdated, n ) 
		
		Aadd( aTrace, aPair[2][ 'id' ] )

		//	Process registers Id...									

	next 

	oDom:TableClearEdited( 'mytable' )
	oDom:Console( aTrace, 'IDs procesed' )
	
	if len( aTrace ) > 0
		oDom:SetAlert( 'Save total ID ' + ltrim(str(nLen)) )
	else
		oDom:SetAlert( 'No data' )
	endif
	
retu nil 



// -------------------------------------------------- //