#define VK_ESCAPE	27

#include "hbthread.ch"

request DBFCDX
request TWEB
request hb_threadid

static o,o2,o3, m


function main()

	HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp.64/htdocs/" )

	
	hb_threadStart( @WebServer() )	
	
	Init_WDO()
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
		
	//	Routing...			

		oServer:Route( '/'		, 'index.html' ) 
		oServer:Route( 'mysql1', 'mysql1.html' ) 	
		oServer:Route( 'mysql2', 'mysql2.html' ) 	
		oServer:Route( 'mysql3', 'mysql3.html' ) 	
		
		oServer:Route( 'sql'	, 'sql.html' ) 	
		oServer:Route( 'sql0'	, 'sql0.html' ) 	
		oServer:Route( 'sql1'	, 'sql1.html' ) 	
		oServer:Route( 'sql2'	, 'sql2.html' ) 	
		oServer:Route( 'sql3'	, 'sql3.html' ) 	
		oServer:Route( 'sql4'	, 'sql4.html' ) 	
		oServer:Route( 'sql5'	, 'sql5.html' ) 	
		oServer:Route( 'sql6'	, 'sql6.html' ) 	
		oServer:Route( 'sql7'	, 'sql7.html' ) 	
		oServer:Route( 'sql8'	, 'sql8.html' ) 	
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
	
RETURN 0

//----------------------------------------------------------------------------//


function Init_WDO()

	//LOCAL o	
	LOCAL 	nIni, hRes, a 
	LOCAL aThreads := {}
	local lIsRunning
		
	o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	
	IF o:lConnect
	
		_d( 'Connected !' )
		_d( 'Version RDBMS MySql', o:VersionName(), o:Version() )
		
	ELSE 
	
		_d( 'Error : ' + o:cError )
		
	ENDIF
	
	o2 := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	IF o2:lConnect
	
		_d( 'Connected !' )
		_d( 'Version RDBMS MySql', o2:VersionName(), o2:Version() )
		
	ELSE 
	
		_d( 'Error : ' + o2:cError )
		
	ENDIF
	
		o3 := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
		
	IF o3:lConnect
	
		_d( 'Connected !' )
		_d( 'Version RDBMS MySql', o3:VersionName(), o3:Version() )
		
	ELSE 
	
		_d( 'Error : ' + o3:cError )
		
	ENDIF	
	
	//pThreadWait := hb_threadStart( @mh_RequestMaxTime(), hb_threadSelf(), ts_hConfig[ 'timeout' ] )
//	hb_threadStart( @DoSql(),  o, 'WDO-1' , hb_threadSelf(), "select * from customer "  )
//	hb_threadStart( @DoSql(), o2, 'WDO-2' , hb_threadSelf(), 'select * from states' )
//	hb_threadStart( @DoSql(), o3, 'WDO-3' , hb_threadSelf(), "select * from customer "  )	

	_d( 'INICI--------------------')
	
	AAdd( aThreads,  hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoMsg() ) )
	AAdd( aThreads,  hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoSql(),    o, 'WDO-1' , hb_threadSelf(), "select * from customer "  ) )
	AAdd( aThreads,  hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoSql(),   o2, 'WDO-2' , hb_threadSelf(), 'select * from states'     ) ) 
	AAdd( aThreads,  hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoSql(),   o3, 'WDO-3' , hb_threadSelf(), "select * from customer "  ) )
	AAdd( aThreads,  hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoMsg() ) )
	
	
	_d( 'CHECK 1-------------------' )
	//lIsRunning := hb_ThreadWait( m, 0.1, .T. ) != 1
	//_d( lIsRunning)
	
	AEval( aThreads, {| h | hb_threadJoin( h ) } )	
	//hb_threadWait( aThreads )
	//hb_threadWaitForAll() 
	_d( 'FINAL-------------------' )
	
	
	_d( 'CHECK 2-------------------' )
	
	lIsRunning := hb_ThreadWait( m, 0.1, .T. ) != 1
	_d( lIsRunning)
	_d( 'CHECK 3-------------------' )
	
	/*
    if hb_threadWait( pThread, 15 ) != 1
         hb_threadQuitRequest( pThread )
	endif
	*/
	
retu nil



//----------------------------------------------------------------------------//

function DoMsg() ; retu _d( 'DOMSG! ', hb_threadID() )

function DoSql( oWDO, cStatus, oThread, cSql ) 

	local nIni, hRes, a 
	local p := hb_threadSelf()
	local lIsRunning
	
	if cStatus == 'WDO-2' 
		m := p 
		lIsRunning := hb_ThreadWait( m, 0.1, .T. ) != 1
		_d( 'WDO ACCTIVAT' )
		_d( lIsRunning)
	endif
	
	//_d( hb_threadID(), hb_threadSelf() )
	_d(  p )
	_d(  hb_threadID( p ) )
	_d( 'DoSql: ' +  cStatus + ' => ' + cSql )
	
	
	nIni := hb_milliseconds() 

	IF !empty( hRes := oWDO:Query( cSql ) )

		
		while ( !empty( a := oWDO:Fetch_Assoc( hRes ) ) )
		end	
		
		_d( 'TOTAL ' + cStatus + ': ' + str(hb_milliseconds() - nIni ) )
		
		oWDO:Free_Result( hRes )
	
	ENDIF
	
RETU NIL 




