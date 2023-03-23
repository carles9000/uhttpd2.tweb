function Api_Dbf( oDom )	


	do case
		
		case oDom:GetProc() == 'open'		; DoOpen( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	


// -------------------------------------------------- //

static function DoOpen( oDom )
/*
	local oWDO := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	local cMsg := ''
	
	IF ! oWDO:lConnect

		oDom:SetError( oWDO:cError )
		retu nil
		
	ENDIF
	
	cMsg += 'MySql connected !' 
	cMsg += '<br>Version RDBMS MySql: ' + oWDO:VersionName() + ' - ' + oWDO:Version() 
	
	oDom:SetMsg( cMsg )
*/	
	
retu nil 

// -------------------------------------------------- //
