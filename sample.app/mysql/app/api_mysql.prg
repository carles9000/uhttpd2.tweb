
thread static hConn

function Api_Mysql( oDom )	


	do case
		
		case oDom:GetProc() == 'connect'		; DoConnect( oDom )
		case oDom:GetProc() == 'persistence'	; DoPersistence( oDom )
		
		case oDom:GetProc() == 'execute'		; DoExecute( oDom )
		case oDom:GetProc() == 'brwclean'		; DoBrwClean( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	


// -------------------------------------------------- //

static function DoConnect( oDom )

	local oWDO := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	local cMsg := ''
	
	IF ! oWDO:lConnect

		oDom:SetError( oWDO:cError )
		retu nil
		
	ENDIF
	
	cMsg += 'MySql connected !' 
	cMsg += '<br>Version RDBMS MySql: ' + oWDO:VersionName() + ' - ' + oWDO:Version() 
	
	oDom:SetMsg( cMsg )
	
retu nil 

// -------------------------------------------------- //

static function DoExecute( oDom )

	local aRows 	:= {}
	local aCols 	:= {}
	local cSql 		:= oDom:Get( 'sql' )
	local lError 	:= .f.
	local oWDO 		:= WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	local hRes, a, n, hConfig, aStruct 
	
	IF ! oWDO:lConnect

		oDom:SetError( oWDO:cError )
		retu nil
		
	ENDIF
	
	IF oWDO:lConnect
	
		IF !empty( hRes := oWDO:Query( cSql, @lError  ) )
		
			while ( !empty( a := oWDO:Fetch_Assoc( hRes ) ) )
				Aadd( aRows, a )
			end				
			
			oWDO:Free_Result( hRes )
		
		ENDIF			
		
	ENDIF	
	
	if lError	
		oDom:SetError( oWDO:cError )
		
		hConfig := { 'columns' => {}, 'data' => {}	}						
		oDom:TableInit( 'mytable', hConfig )			
		oDom:TableTitle( 'mytable', '' )
	else
		aStruct := oWDO:DbStruct()
		
		for n := 1 to len( aStruct )
			Aadd( aCols, { 'field' => aStruct[n][1], 'title' => aStruct[n][1]} )
		next 
		
		hConfig := { ;
				'columns' => aCols, ;
				'data' => aRows;				
			}		
		
		oDom:TableTitle( 'mytable', '<h5>Coincidencias: ' + str(len(aRows )) + '</h5>' )
		oDom:TableInit( 'mytable', hConfig )
		
	endif

retu nil 


// -------------------------------------------------- //
/*
static function DoPersistence( oDom )

	
	local cMsg := ''
	local nIni := hb_milliseconds()
	
	if hConn == nil 
	
		hConn := {=>}
	
		hConn[ 'wdo' ] := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
		hConn[ 'id'  ] := hb_threadId() 
	
		IF ! hConn[ 'wdo' ]:lConnect

			oDom:SetError( hConn[ 'wdo' ]:cError )
			retu nil
			
		ENDIF
		
		cMsg += 'MySql new connexion !' 
		cMsg += '<br>Version RDBMS MySql: ' + hConn[ 'wdo' ]:VersionName() + ' - ' + hConn[ 'wdo' ]:Version() 
		cMsg += '<br>Elapsed: ' + ltrim(str( hb_milliseconds() - nIni ))
		
	else
	
		cMsg += 'WDO persistence !' 
		cMsg += '<br>Version RDBMS MySql: ' + hConn[ 'wdo' ]:VersionName() + ' - ' + hConn[ 'wdo' ]:Version()	
		cMsg += '<br>Elapsed: ' + ltrim(str( hb_milliseconds() - nIni ))
		
	endif
	
	oDom:SetMsg( cMsg )

retu nil 
*/

static function DoPersistence( oDom )

	local nIni 	:= hb_milliseconds()
	local o 	:= WDO_Pool( 'mysql_dbharbour', {|| MyOpen() } )
	local cMsg 	:= ''
	
	cMsg += 'WDO persistence !' 
	cMsg += '<br>Version RDBMS MySql: ' + o:VersionName() + ' - ' + o:Version()	
	cMsg += '<br>Elapsed: ' + ltrim(str( hb_milliseconds() - nIni ))	
	
	oDom:SetMsg( cMsg )	

retu nil 

static function MyOpen() 

	local oConn := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
_d( 'MyOpen()....')	
	IF ! oConn:lConnect
		? 'Error: ', oConn:mysql_error()		
		retu nil
	ENDIF			
	
retu oConn  


// -------------------------------------------------- //

static function DoBrwClean( oDom )	

	local hConfig := { 'columns' => {}, 'data' => {}	}					
	
	oDom:TableInit( 'mytable', hConfig )
	oDom:TableTitle( 'mytable', '' )	
	
retu nil