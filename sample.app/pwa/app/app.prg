#include "lib/uhttpd2/uhttpd2.ch"

#define VK_ESCAPE	27

REQUEST HB_CODEPAGE_ES850  
REQUEST HB_CODEPAGE_ESWIN 	
REQUEST HB_LANG_ES
request DBFCDX
request DBSKIP
request TWEB

function main()

	RddSetDefault( 'DBFCDX' )	
	HB_LANGSELECT('ES')        	
    HB_SetCodePage ( "ESWIN" )

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetSSL( .T. )
	oServer:SetPort( 443 )
	
	oServer:SetCertificate( 'cert/privatekey.pem', 'cert/certificate.pem' )
	oServer:bInit:={|hInfo| ShowInfo( hInfo ) }	
	
	oServer:SetDirFiles( 'data' )
	oServer:SetDirFiles( 'html' )
	
	//	Routing...			

		oServer:Route( '/'					, 'index.html' )
		oServer:Route( '/index.html'		, 'index.html' ) 												

		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//

Static Function ShowInfo( hInfo )

	local cLang := hb_oemtoansi(hb_langName())

	HB_HCaseMatch( hInfo, .f. )

	CConsole '---------------------------------'	
	Console  'Server Harbour9000 was started...'
	Console  '---------------------------------'
	Console  'Version httpd2..: ' + hInfo[ 'version' ]
	Console  'Start...........: ' + hInfo[ 'start' ]
	Console  'Port............: ' + ltrim(str(hInfo[ 'port' ]))
	Console  'OS..............: ' + OS()
	Console  'Harbour.........: ' + VERSION()
	Console  'Build date......: ' + HB_BUILDDATE()
	Console  'Compiler........: ' + HB_COMPILER()
	Console  'Trace...........: ' + if( hInfo[ 'debug' ], 'Yes', 'No' )
	Console  'Codepage........: ' + hb_SetCodePage() + '/' + hb_cdpUniID( hb_SetCodePage() )
	Console  'UTF8 (actived)..: ' + if( hInfo[ 'utf8' ], 'Yes', 'No' )
	Console  'TWeb Version....: ' + TWebVersion()

	Console  'SSL.............: ' + if( hInfo[ 'ssl' ], 'Yes', 'No' )
	Console  'OpenSSL.........: ' + OpenSSL_version()
	Console  'Version Curl....: ' + Curl_version()

	Console  Replicate( '-', len( cLang ) )
	Console  cLang
	Console  Replicate( '-', len( cLang ) )
	Console  'Escape for exit...' 		

Return .T.

//----------------------------------------------------------------------------//