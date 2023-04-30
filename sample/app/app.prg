#include 'lib/uhttpd2/uhttpd2.ch'

REQUEST DBFCDX

//	-----------------------
REQUEST HB_CODEPAGE_ES850  	
REQUEST HB_LANG_ES
REQUEST HB_CODEPAGE_ESWIN  	
REQUEST HB_CODEPAGE_UTF8EX
//	-----------------------

#define VK_ESCAPE	27

function main()

	Config()

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
	oServer:SetDirFiles( 'examples', .T. )		//	.t. == Index list
	
	oServer:SetDirFiles( 'data.repository' )	
	oServer:bInit := {|hInfo| ShowInfo( hInfo ) }
	
	/*	Example Charset UTF8. Active to .T. Default .f.
		oServer:lUtf8 := .T.							
	*/
	
	/*	Config Sessions ! 
		-----------------
		oServer:cSessionPath		:=	'.sessions' 	//	Default path session ./sessions
		oServer:cSessionName		:=	'USESSID' 		//	Default session name USESSID
		oServer:cSessionPrefix	:=	'sess_'			//	Default prefix sess_
		oServer:cSessionSeed		:= 	'm!PaswORD@'	//	Password default ...
		
		oServer:nSessionDuration	:=	3600			//	Default duration session time 3600
		oServer:nSessionGarbage	:=	1000			//	Default totals sessions executed for garbage
		oServer:nSessionLifeDays	:=	3				//	Default days stored for garbage 3
		oServer:lSessionCrypt		:=	.F. 			//	Default crypt session .F.
	*/
	
	//	Routing...			

		oServer:Route( '/'			, 'index.html' )  										
		oServer:Route( 'readme'	, 'index_readme.html' )  	
		oServer:Route( 'tutor'		, 'index_tutor.html' )  	
		oServer:Route( 'screens'	, 'index_screens.html' )  	
		oServer:Route( 'msg'		, 'index_msg.html' )  	
		oServer:Route( 'tpl'		, 'index_tpl.html' )  	
		oServer:Route( 'pluggin'	, 'index_pluggin.html' )
		oServer:Route( 'security'	, 'index_security.html' )
		oServer:Route( 'macro'		, 'index_macro.html' )
		oServer:Route( 'controls'	, 'index_controls.html' ) 		
		oServer:Route( 'charset'	, 'index_charset.html' ) 		
		oServer:Route( 'browse'	, 'index_brw.html' )  	
		oServer:Route( 'dialog'	, 'index_dialog.html' )  	
		oServer:Route( 'flow_screen', 'index_flow_screen.html' )  	
		oServer:Route( 'flow'		, 'flow\flow.html' )  	
		oServer:Route( 'menu'		, 'index_menu.html' )  	
		oServer:Route( 'splash'	, 'index_splash.html' )  			
		oServer:Route( 'functional', 'index_functional.html' )  			
		oServer:Route( 'examples'	, 'examples/*' )  			
	


	//	TUTORS
			
		oServer:Route( 'tutor1'	, 'tutor1' )  										
		oServer:Route( 'tutor2'	, 'tutor2' )  										
		oServer:Route( 'tutor3'	, 'tutor3' )  										
		oServer:Route( 'tutor4'	, 'tutor4' )  										
		oServer:Route( 'tutor5'	, 'tutor5' )  										
		oServer:Route( 'tutor6'	, 'tutor6' )  										
		oServer:Route( 'tutor7'	, 'tutor7' )  										
		oServer:Route( 'tutor8'	, 'tutor8' )  										
		oServer:Route( 'tutor9'	, 'tutor9' )  										
		oServer:Route( 'tutor10'	, 'tutor10' )  										
		oServer:Route( 'tutor11'	, 'tutor11' ) 
		oServer:Route( 'tutor12'	, 'tutor12' ) 
		oServer:Route( 'tutor13'	, 'tutor13' ) 
		
		oServer:Route( 't0'		, 'tutors/tutor0.html' )  										
		oServer:Route( 't1'		, 'tutors/tutor1.html' ) 
		oServer:Route( 't2'		, 'tutors/tutor2.html' ) 
		oServer:Route( 't3'		, 'tutors/tutor3.html' ) 
		oServer:Route( 't4'		, 'tutors/tutor4.html' ) 
		oServer:Route( 't5'		, 'tutors/tutor5.html' ) 
		oServer:Route( 't6'		, 'tutors/tutor6.html' ) 
		oServer:Route( 't7'		, 'tutors/tutor7.html' ) 
		oServer:Route( 't8'		, 'tutors/tutor8.html' ) 
		oServer:Route( 't9'		, 'tutors/tutor9.html' ) 
		oServer:Route( 't10'		, 'tutors/tutor10.html' ) 
		oServer:Route( 't11'		, 'tutors/tutor11.html' ) 
		oServer:Route( 't12'		, 'tutors/tutor12.html' ) 
		oServer:Route( 't13'		, 'tutors/tutor13.html' )

	//	Menus			

		oServer:Route( 'menu1'		, 'menus/menu1.html' ) 	
		oServer:Route( 'menu2'		, 'menus/menu2.html' ) 	
		oServer:Route( 'menu3'		, 'menus/menu3.html' ) 	

	//	Controls
	
		oServer:Route( 'get-types'		, 'controls/get-types.html' ) 		
		oServer:Route( 'styles'		, 'controls/styles.html' ) 		
		oServer:Route( 'properties'	, 'controls/properties.html' ) 		
		oServer:Route( 'upload'		, 'controls/upload.html' ) 		
		oServer:Route( 'upload_basic'	, 'controls/upload_basic.html' ) 
		oServer:Route( 'disable'		, 'controls/disable.html' ) 
		oServer:Route( 'hide'			, 'controls/hide.html' ) 

	//	Charset
	
		oServer:Route( 'char-1'		, 'charset/char-1.html' ) 
		oServer:Route( 'char-2'		, 'charset/char-2.html' ) 
		oServer:Route( 'char-3'		, 'charset/char-3.html' ) 
		oServer:Route( 'char-4'		, 'charset/char-4.html' ) 
		oServer:Route( 'char-5'		, 'charset/char-5.html' ) 
		oServer:Route( 'char-6'		, 'charset/char-6.html' ) 
		oServer:Route( 'char-7'		, 'charset/char-7.html' ) 
	

	//	Browsers
	
		oServer:Route( 'brw'			, 'browser/brw.html' ) 
							
		oServer:Route( 'brw-0'		, 'browser/brw-0.html' ) 
		oServer:Route( 'brw-1'		, 'browser/brw-1.html' ) 
		oServer:Route( 'brw-2'		, 'browser/brw-2.html' ) 
		oServer:Route( 'brw-3'		, 'browser/brw-3.html' ) 
		oServer:Route( 'brw-4'		, 'browser/brw-4.html' ) 
		oServer:Route( 'brw-5'		, 'browser/brw-5.html' ) 
		oServer:Route( 'brw-6'		, 'browser/brw-6.html' ) 
		oServer:Route( 'brw-7'		, 'browser/brw-7.html' ) 
		oServer:Route( 'brw-10'	, 'browser/brw-10.html' ) 
		oServer:Route( 'brw-10b'	, 'browser/brw-10b.html' ) 
		oServer:Route( 'brw-11'	, 'browser/brw-11.html' ) 
		oServer:Route( 'brw-12'	, 'browser/brw-12.html' ) 
		
		oServer:Route( 'brw_ok'	, 'browser/brw_ok.html' ) 
		
	//	Dialogs			
		
		oServer:Route( 'dlg-1'		, 'dialog/dlg-1.html' ) 		
		oServer:Route( 'dlg-2'		, 'dialog/dlg-2.html' ) 		
		oServer:Route( 'dlg-3'		, 'dialog/dlg-3.html' )
 		
		oServer:Route( 'fscreen-1'	, 'flow_screen/fscreen-1.html' ) 		
		oServer:Route( 'fscreen-2'	, 'flow_screen/fscreen-2.html' ) 		
		oServer:Route( 'fscreen-3'	, 'flow_screen/fscreen-3.html' ) 		
		oServer:Route( 'hello'		, 'flow_screen/hello.html' ) 		
		oServer:Route( 'wndhello'	, 'flow_screen/wndhello.html' ) 		
		
		
	//	Screens
	
		oServer:Route( 'screen1'	, 'screens/screen1.html' ) 		
		oServer:Route( 'screen2'	, 'concept' ) 					//	<<--- Function !
		
	//	Functional (Mini App with security)
	
		oServer:Route( 'upd'		, 'functional/upd_splash.html' )
		oServer:Route( 'upd_login'	, 'functional/upd_login.html' )
		oServer:Route( 'upd_logout', 'upd_logout' )
		oServer:Route( 'upd_sec'	, 'functional/upd_sec.html' )
		oServer:Route( 'upd_info'	, 'upd_info' )

		
	//	Messages	
	
		oServer:Route( 'msginfo'	, 'msg/msginfo.html' ) 
		oServer:Route( 'msgget'	, 'msg/msgget.html' ) 
		oServer:Route( 'msgyesno'	, 'msg/msgyesno.html' ) 
		oServer:Route( 'msgerror'	, 'msg/msgerror.html' ) 
		oServer:Route( 'msgnotify'	, 'msg/msgnotify.html' ) 
		oServer:Route( 'msgloading', 'msg/msgloading.html' ) 
		oServer:Route( 'msgserver'	, 'msg/msgserver.html' ) 
		oServer:Route( 'msgserver2', 'msg/msgserver2.html' ) 
		oServer:Route( 'msgapi'	, 'msg/msgapi.html' ) 
		
		oServer:Route( 'ping_data'			, 'ping_data' ) 
		oServer:Route( 'ping_datarecno'	, 'ping_datarecno' ) 
		
	//	Templates
	
		oServer:Route( 'tpl1'		, 'templates/tpl-1.html' ) 
		oServer:Route( 'tpl2'		, 'templates/tpl-2.html' ) 
		oServer:Route( 'tpl3'		, 'templates/tpl-3.html' ) 
		oServer:Route( 'tpl4'		, 'templates/tpl-4.html' ) 
		
	//	Pluggin
	
		oServer:Route( 'plug1'		, 'pluggin/plug-1.html' ) 		
		
		//	autocomplete route. Alert! -> function
		
			oServer:Route( 'getidcustomer'	, 'getidcustomer' ) 		
		
	//	Security
	
		oServer:Route( 'token'	 , 'security/token.html' ) 
		oServer:Route( 'session', 'security/session.html' )	

	//	Macro 
	
		oServer:Route( 'macro_1' , 'macro/macro_1.html' ) 
		oServer:Route( 'macro_2' , 'macro/macro_2.html' ) 
		oServer:Route( 'macro_3' , 'macro/macro_3.html' ) 
		
		
	//	Testing
	
		oServer:Route( 'test-1'	, 'test/test-1.html' ) 
		oServer:Route( 'test-2'	, 'test/test-2.html' ) 
		oServer:Route( 'test-3'	, 'test/test-3.html' ) 
	
	//	Others...
		
		oServer:Route( 'splash1'	, 'splash/splash1.html' ) 
		oServer:Route( 'splash2'	, 'splash/splash2.html' ) 														
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//

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

//----------------------------------------------------------------------------//

function Config()
	local cdp				
	
	RddSetDefault( 'DBFCDX' )
	
	HB_LANGSELECT('ES')        
    HB_SetCodePage ( "ESWIN" )		
	
	SET( _SET_DBCODEPAGE, 'ESWIN' )		

	SET DATE FORMAT TO 'DD/MM/YYYY'
	SET DELETE OFF 

retu nil 

//----------------------------------------------------------------------------//

function AppPathData() 		; retu HB_DIRBASE() + 'data\'
function AppPathRepository() 	; retu HB_DIRBASE() + 'data.repository\'

//----------------------------------------------------------------------------//