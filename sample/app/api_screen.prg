#include "../lib/tweb/tweb.ch" 

#define IS_DESSIGN 	.T.

// -------------------------------------------------- //

function Api_Screen( oDom )

	do case	
		
		case oDom:GetProc() == 'clean-1'		; oDom:SetPanel( 'mycontainer'  , '' )							
		case oDom:GetProc() == 'clean-2'		; oDom:SetPanel( 'mycontainer-2', '' )							
		case oDom:GetProc() == 'panel-1'		; DoPanel1( oDom )								
		case oDom:GetProc() == 'panel-2'		; DoPanel2( oDom )								
		case oDom:GetProc() == 'panel-3'		; DoPanel3( oDom )								
		case oDom:GetProc() == 'panel-4'		; DoPanel4( oDom )	
		
		case oDom:GetProc() == 'dialog-1'		; DoDialog1( oDom )								
		case oDom:GetProc() == 'dialog-2'		; DoDialog2( oDom )								
		
		case oDom:GetProc() == 'window-1'		; DoWindow1( oDom )								
		case oDom:GetProc() == 'window-2'		; DoWindow2( oDom )								
		case oDom:GetProc() == 'window-3'		; DoWindow3( oDom )								
		case oDom:GetProc() == 'window-4'		; DoWindow4( oDom )								
		
		
		
		
		case oDom:GetProc() == 'testpanel2'	; DoTestPanel2( oDom )								
		case oDom:GetProc() == 'testpanel3'	; DoTestPanel3( oDom )								
		
		case oDom:GetProc() == 'testwindowblank'	; DoTestWindowBlank( oDom )								
		case oDom:GetProc() == 'testwindowself'	; DoTestWindowSelf( oDom )								
		case oDom:GetProc() == 'testwindowname'	; DoTestWindowName( oDom )								
		case oDom:GetProc() == 'ping'			; oDom:SetMsg( 'Pong' )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function DoPanel1( oDom )	//	Screen Embedded

	local cHtml := MyScreen2()
	
	oDom:SetPanel( 'mycontainer', cHtml )

retu nil 

// -------------------------------------------------- //

static function DoPanel2( oDom )	//	Screen Embedded

	local cHtml := MyScreen5()
	
	oDom:SetPanel( 'mycontainer-2', cHtml )

retu nil 

// -------------------------------------------------- //

static function DoPanel3( oDom )	//	Load Screen from file

	local cHtml := ULoadHtml( 'flow_screen\hello.html'  )
	
	oDom:SetPanel( 'mycontainer', cHtml )

retu nil 

// -------------------------------------------------- //

static function DoPanel4( oDom )	//	Load Screen from file

	local cHtml := ULoadHtml( 'flow_screen\hello.html', 'MyDlg'  )
	
	oDom:SetPanel( 'mycontainer-2', cHtml )

retu nil 

// -------------------------------------------------- //

static function DoDialog1( oDom )	//	Screen Embedded

	local cHtml := MyScreen5( 'BBB' )
	
	oDom:SetDialog( 'mydlg', cHtml, 'Tutor 5' )
	
retu nil 

// -------------------------------------------------- //

static function DoDialog2( oDom )	//	Load Screen from file

	local cHtml := ULoadHtml( 'flow_screen\hello.html' )
	
	oDom:SetDialog( 'mydlg', cHtml, 'Tutor 5' )
	
retu nil 

// -------------------------------------------------- //

static function DoWindow1( oDom )		//	New TAB	
	
	oDom:SetWindow( 'wndhello', '_blank' )
	
retu nil 

// -------------------------------------------------- //

static function DoWindow2( oDom )		// Same Tab	

	oDom:SetWindow( 'wndhello', '_self')
	
retu nil 

// -------------------------------------------------- //

static function DoWindow3( oDom )		//	Float Window. Fixed ID		
	
	// https://www.w3schools.com/jsref/met_win_open.asp
	// oDom:SetWindow( cUrl, cTarget, cSpecs )
	oDom:SetWindow( 'wndhello', 'MYWND', "width=600,height=500,menubar=no,titlebar=no" )
	
retu nil 

// -------------------------------------------------- //

static function DoWindow4( oDom )		//	Window	

	local cId := 'wnd' + ltrim(str(hb_milliseconds() ))
	
	oDom:SetWindow( 'wndhello', cId, "width=600,height=500,menubar=no,titlebar=no"  )
	
retu nil 


// -------------------------------------------------- //
// -------------------------------------------------- //
// -------------------------------------------------- //

// -------------------------------------------------- //

static function DoTestPanel2( oDom )

	local cHtml := MyScreen5( 'AAA' )

	//oDom:SetScreen( nil , '_container' , 'mycontainer', cHtml )
	
	oDom:SetPanel( 'mycontainer', cHtml )

retu nil 

// -------------------------------------------------- //

static function DoTestPanel3( oDom )

	local cHtml := MyScreen5( 'BBB' )
	
	oDom:SetDialog( 'zzz', cHtml, 'Tutor 5' )
	
retu nil 


// -------------------------------------------------- //

static function DoTestWindowBlank( oDom )		//	Nou TAB
	
	//oDom:SetUrl( 'testwindow', '_blank' )
	oDom:SetWindow( 'testwindow', '_blank' )
	
retu nil 

// -------------------------------------------------- //

static function DoTestWindowSelf( oDom )		// Mateix Tab
	
	//oDom:SetUrl( 'testwindow', '_self')
	oDom:SetWindow( 'testwindow', '_self')
	
retu nil 

// -------------------------------------------------- //

static function DoTestWindowName( oDom )		//	Nova Window

	
	//oDom:SetUrl( 'testwindow', 'MYWND', "width=600,height=500,menubar=no,titlebar=no" )
	
	// https://www.w3schools.com/jsref/met_win_open.asp
	// oDom:SetWindow( cUrl, cTarget, cSpecs )
	oDom:SetWindow( 'testwindow', 'MYWND', "width=600,height=500,menubar=no,titlebar=no" )
	
retu nil 

// -------------------------------------------------- //


function MyScreen2()

	
    LOCAL o, oWeb
	
	DEFINE DIALOG oWeb 
	
		DEFINE FORM o OF oWeb
			o:lDessign 	:= IS_DESSIGN
			o:lFluid 	:= .T.
			
		INIT FORM o
		
			ROW o
				SAY VALUE 'Hello' GRID 6 ALIGN 'right' OF o
				SAY VALUE 'Hello' GRID 4 OF o
				SAY VALUE 'Hello' GRID 2 ALIGN 'center' OF o
			ENDROW o
			
		ENDFORM o	
	
	INIT DIALOG oWeb RETURN	
		
retu nil

// -------------------------------------------------- //

function MyScreen5( cId )

    local o, oWeb
	local cLoren := "<h2>Why do we use it?</h2>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
	
	hb_default( @cId, 'zzz' )
	
	DEFINE DIALOG oWeb 
	
		DEFINE FORM o  ID cId API 'api_functional' OF oWeb
			o:lDessign 	:= IS_DESSIGN
			o:lFluid  	:= .f.
				
			HTML o INLINE '<h3>Test Form</h3><hr>'	
			
			INIT FORM o  	
			
				HTML o
					<div class="row alert alert-dark form_title" role="alert">
						<h5 style="margin:0px;">
							<i class="far fa-share-square"></i>
							Form example
						</h5>
					</div>
				ENDTEXT		
				
				ROWGROUP o  
					SAY VALUE 'Id:' ALIGN 'right' OF o
					GET VALUE '' OF o
				ENDROW o

				ROWGROUP o  
					SAY VALUE 'Phone:' ALIGN 'right' OF o
					GET VALUE '' PLACEHOLDER "Enter phone number" OF o
				ENDROW o
				
				ROWGROUP o			
					//BUTTON LABEL ' Test Button' ACTION "alert( 'Hi!' )" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o				
					BUTTON LABEL ' Ping' ACTION "ping" GRID 8  ALIGN 'right' ICON '<i class="fas fa-clipboard-check"></i>' CLASS 'btn-danger btnticket' OF o				
				ENDROW o			

				ROWGROUP o
					SAY VALUE cLoren GRID 12 OF o			
				ENDROW o		
			
		ENDFORM o	
	
	INIT DIALOG oWeb RETURN


retu nil 
// -------------------------------------------------- //

function MyScreen7()

    LOCAL o, oWeb, oSelect
	LOCAL aTxt := { 'Volvo', 'Seat', 'Renault' }
	LOCAL aKey := { 'V', 'S', 'R' }

	DEFINE WEB oWeb TITLE 'Tutor 7' 

		DEFINE FORM o OF oWeb
			o:lDessign := IS_DESSIGN
			o:cSizing   := 'sm'       	//  SM/LG
			
		INIT FORM o               
			
			ROWGROUP o VALIGN 'top'		//	Default
				SEPARATOR o LABEL 'Align top'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o            
			ENDROW o
			
			ROWGROUP o VALIGN 'center'
				SEPARATOR o LABEL 'Align center'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o             
			ENDROW o		
			
			ROWGROUP o VALIGN 'bottom'
				SEPARATOR o LABEL 'Test bottom'
				SELECT oSelect  LABEL 'Cars' PROMPT aTxt VALUES aKey  GRID 6  OF o
				SELECT oSelect               PROMPT aTxt VALUES aKey  GRID 6  OF o              
			ENDROW o		
			
		ENDFORM o	
	
	INIT WEB oWeb RETURN


retu nil 

