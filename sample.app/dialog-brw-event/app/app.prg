#include 'lib/uhttpd2/uhttpd2.ch'

#define VK_ESCAPE	27


REQUEST HB_CODEPAGE_UTF8
REQUEST HB_LANG_ES
REQUEST TWEB

function main()


	hb_cdpSelect("UTF8")
  hb_LangSelect('ES')

	Set( _SET_DATEFORMAT, 'YYYY-MM-DD' )
	_d( get_list_of_real_codepages() )
	
	hb_threadStart( @WebServer() )
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 


function WebServer()
	local oServer 	:= Httpd2()

	// test Charset UTF8
	oServer:lUtf8 := .t.
	oServer:SetPort( 81 )
	oServer:SetDirFiles( 'data' )
	//oServer:nSessionDuration	:=	3600			//	Default duration session time 3600	
	oServer:bInit := {|hInfo| ShowInfo( hInfo ) }
	
	// Routing...
	oServer:Route( '/'							, 'main.html' )
	oServer:Route( 'getcustomerapi'	, 'getcustomerapi')
	oServer:Route( 'getcustomer'	, 'getcustomer')
	
	oServer:Route( 'mobile'							, 'mobile.html' )
	oServer:Route( 'desktop'						, 'desktop.html' )
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0


function ShowInfo( hInfo ) 

	HB_HCaseMatch( hInfo, .f. )

	CConsole '---------------------------------'	
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

retu nil

FUNCTION get_list_of_real_codepages()
	LOCAL s_uni := { => }
	LOCAL cdp
	s_uni := { => }
	FOR EACH cdp IN hb_cdpList()
		 s_uni[ hb_cdpUniID( cdp ) ] := cdp
	NEXT
	RETURN s_uni