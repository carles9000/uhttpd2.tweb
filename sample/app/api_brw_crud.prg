/*
	|				|	Tabulator	|  API 	| Selected | Updated
	| Init			|				| 		|			|
	| setdata		|	addData	|	X	|			|
	| delete		|	deleteRow	|   X 	| 	  X		|
	| Clean		|	setData	|	X	|			|
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
// Aqui llenamos la tabla de datos
//

static function DoData( oDom )

	local cAlias 	:= OpenDbf()
	local aRows  	:= GetRows( cAlias, 1, 20 )			
	
	oDom:TableSetData( 'mytable', aRows )			
	
retu nil

// -------------------------------------------------- //
// Vaciamos toda la tabla. Reset, clean 
//

static function DoClean( oDom )
	
	oDom:Trace()
	oDom:TableClean( 'mytable' )
	
retu nil


// -------------------------------------------------- //

static function NewId()	
	
	nInd++
	
return 'ID' + ltrim(str(nInd))
	
	

// -------------------------------------------------- //
// Aqui simulamos añadir tantas rows como necesitemos
// 

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
// Aqui simulamos eliminar
// oDom:TableDelete() manda eliminar una row del cliente
// 		aRows := oDom:Get( 'mytable' )[ 'selected' ]
// 

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
// Aqui simulamos hacer alguna cosa con los registros seleccionados
// 		aRows := oDom:Get( 'mytable' )[ 'selected' ]
//

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
	
	oDom:SetMsg( 'Process num registers ' + str(nLen) + '. Check console' )
	
	
retu nil

// -------------------------------------------------- //
// Aqui simulamos salvar los datos (No lo hacemos)
// 		aRows := oDom:Get( 'mytable' )[ 'updated' ]
// Recordad que este proceso tiene que tener si ok, 
// oDom:TableClearEdited() para decirle al browse del cliente
// que todo se ha procesado y no volverlo a enviar
//

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
		oDom:SetMsg( 'We pretended to save: ' + ltrim(str(nLen)) + '. Check console' )
	else
		oDom:SetMsg( 'No data to save' )
	endif
	
retu nil 



// -------------------------------------------------- //