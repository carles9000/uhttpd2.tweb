#include 'lib/uhttpd2/uhttpd2.ch'

REQUEST DBFCDX
 

#define VK_ESCAPE	27

request hb_threadId					//	for testing...
request __vmCountThreads				//	for testing...

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
	
	
	//	Routing...			

		oServer:Route( '/'			, 'index.html' )  										
		oServer:Route( 'readme'	, 'index_readme.html' )  	
		oServer:Route( 'tutor'		, 'index_tutor.html' )  	
		oServer:Route( 'screens'	, 'index_screens.html' )  	
		oServer:Route( 'msg'		, 'index_msg.html' )  	
		oServer:Route( 'tpl'		, 'index_tpl.html' )  	
		oServer:Route( 'pluggin'	, 'index_pluggin.html' )
		oServer:Route( 'security'	, 'index_security.html' )
		oServer:Route( 'controls'	, 'index_controls.html' ) 		
		oServer:Route( 'browse'	, 'index_brw.html' )  	
		oServer:Route( 'dialog'	, 'index_dialog.html' )  	
		oServer:Route( 'menu'		, 'index_menu.html' )  	
		oServer:Route( 'splash'	, 'index_splash.html' )  			
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

	//	Controls
	
		oServer:Route( 'get-types'		, 'controls/get-types.html' ) 		
		oServer:Route( 'styles'		, 'controls/styles.html' ) 		
		oServer:Route( 'properties'	, 'controls/properties.html' ) 		
		oServer:Route( 'upload'		, 'controls/upload.html' ) 		
		oServer:Route( 'upload_basic'	, 'controls/upload_basic.html' ) 		

	//	Browsers
	
		oServer:Route( 'brw'		, 'browser/brw.html' ) 
							
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
		
		
	//	Screens
	
		oServer:Route( 'screen1'	, 'screens/screen1.html' ) 		
		oServer:Route( 'screen2'	, 'concept' ) 					//	<<--- Function !
		
	//	Messages	
	
		oServer:Route( 'msginfo'	, 'msg/msginfo.html' ) 
		oServer:Route( 'msgget'	, 'msg/msgget.html' ) 
		oServer:Route( 'msgyesno'	, 'msg/msgyesno.html' ) 
		oServer:Route( 'msgerror'	, 'msg/msgerror.html' ) 
		oServer:Route( 'msgnotify'	, 'msg/msgnotify.html' ) 
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
	
		oServer:Route( 'token'	, 'security/token.html' ) 
		
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

function Config()

	SET DATE FORMAT TO 'DD/MM/YYYY'
	SET DELETE OFF 
	RddSetDefault( 'DBFCDX' )
	
retu nil 


//----------------------------------------------------------------------------//

function AppPathData() 		; retu HB_DIRBASE() + 'data\'
function AppPathRepository() 	; retu HB_DIRBASE() + 'data.repository\'

//----------------------------------------------------------------------------//