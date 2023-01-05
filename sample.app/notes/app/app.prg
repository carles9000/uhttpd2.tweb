#define VK_ESCAPE	27

REQUEST DBFCDX

function main()

	InitServer() 	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 
		
function InitServer()	
	
	SET DATE TO ITALIAN
	SET DATE FORMAT TO 'DD/MM/YYYY'

	hb_threadStart( @WebServer() )
		
retu nil 


function WebServer()

	local oServer 	:= UHttpd2New()
	
	oServer:SetPort( 81 )
	oServer:lDebug := .t.
	
	//	Routing...		
				
		oServer:Route( '/'			, 'splash.html') 
		oServer:Route( 'notes'		, 'notes.html' ) 
		//oServer:Route( 'list'		, 'list.html'  ) 
		oServer:Route( 'list'		, 'dolist'  ) 
			
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//