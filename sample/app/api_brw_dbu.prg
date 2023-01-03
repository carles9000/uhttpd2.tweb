thread static nInd := 1

function Api_Brw_Dbu( oDom )

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
	
	Aadd( aRows, { 'id' => NewId(), 'FIRST' => '', 'STATE'=> '', 'AGE' => 0, 'MARRIED' => .F., 'HIREDATE' => '' } )

	oDom:TableAddData( 'mytable', aRows, .T. )
	
retu nil

// -------------------------------------------------- //

static function DoDelete( oDom )

	local hBrowse 		:= oDom:Get( 'mytable' )
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

	local hBrowse 		:= oDom:Get( 'mytable' )
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
// Please, you can review example 2-Dbu and you can see other way 
// to edit field on-fly 

static function DoSave( oDom )

	local cAlias 	:= OpenDbf( 'test.dbf' )
	local hBrowse 	:= oDom:Get( 'mytable' )
	local hUpdated	:= hBrowse[ 'updated' ]	
	local hCell  	:= oDom:Get( 'cell' ) 
	local hRow, lLock, nRecno, cMsg, nIndex
	
	
	//	Only will receive one record (in this case...)
	
		if len( hUpdated )	 != 1 
			oDom:Console( 'Error param...')
			retu nil
		endif
		
	//	Recover parameters
	
		nIndex	:= HB_HKeyAt( hUpdated, 1 )
		hRow	:= HB_HValueAt( hUpdated, 1 )
		nRecno	:= hRow[ '_recno' ]	
	
	//	Go to Recno	
	
		if nRecno == 0		//	New record...
		
			(cAlias)->( dbAppend() )
			
			lLock := .t. 
			
		else 
		
			(cAlias)->( DbGoto( nRecno ) )
			
			lLock := (cAlias)->( Rlock() )
		
		endif
		
		if lLock 
		
			(cAlias)->first   	:= hRow[ 'FIRST' ]
			(cAlias)->state   	:= hRow[ 'STATE' ]
			(cAlias)->age   	:= hRow[ 'AGE' ]
			(cAlias)->married 	:= hRow[ 'MARRIED' ]
			(cAlias)->hiredate	:= CTOD( hRow[ 'HIREDATE' ] )						
			
			//	...		
			
			(cAlias)->( DbUnlock())
			(cAlias)->( DbCommit())

			cMsg := 'Row updated'

			oDom:TableClearEdited( 'mytable', nIndex )	//	Very Important !
			
		else
		
			cMsg := 'Lock error!'
		
		endif				
	
		oDom:Console( nRecno, cMsg )
		
retu nil 



// -------------------------------------------------- //