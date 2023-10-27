#include 'lib/uhttpd2/uhttpd2.ch'

#define VK_ESCAPE	27

request DBFCDX
request TWEB

function main()

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
	oServer:SetDirFiles( 'data' )
    oServer:bInit := {|hInfo| ShowInfo( hInfo ) }
	
	//	Routing...			

		oServer:Route( '/'		, 'index.html' )  												
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//

function ShowInfo( hInfo ) 

	HB_HCaseMatch( hInfo, .f. )

	Console  '---------------------------------'	
	Console  'Server Harbour9000 was started...'
	Console  '---------------------------------'
	Console  'Version httpd2...: ' + hInfo[ 'version' ]
	Console  'Start............: ' + hInfo[ 'start' ]
	Console  'Port.............: ' + ltrim(str(hInfo[ 'port' ]))
	Console  'OS...............: ' + OS()
	Console  'Harbour..........: ' + VERSION()
	Console  'Build date.......: ' + HB_BUILDDATE()
	Console  'Compiler.........: ' + HB_COMPILER()
	Console  'SSL..............: ' + if( hInfo[ 'ssl' ], 'Yes', 'No' )
	Console  'Trace............: ' + if( hInfo[ 'debug' ], 'Yes', 'No' )
	Console  'Codepage.........: ' + hb_SetCodePage() + '/' + hb_cdpUniID( hb_SetCodePage() )
	Console  'UTF8 (actived)...: ' + if( hInfo[ 'utf8' ], 'Yes', 'No' )     
	Console  '---------------------------------'
	Console  'Escape for exit...' 		
  
return nil 