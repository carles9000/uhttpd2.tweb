#define VK_ESCAPE	27

request DBFCDX
request TWEB

function main()

	local aRpt := Directory( 'output\*.*' )
	
	RddSetDefault( 'DBFCDX' )
	
	//	Delete files test...
		Aeval( aRpt, {|u,n| fErase( hb_dirbase() + 'output\' + u[1] ) } )

	hb_threadStart( @WebServer() )	
	
	while inkey(0) != VK_ESCAPE
	end

retu nil 

//----------------------------------------------------------------------------//

function WebServer()

	local oServer 	:= Httpd2()
	
	oServer:SetPort( 81 )
	
	oServer:SetDirFiles( 'data' )
	oServer:SetDirFiles( 'output' )
	
	//	Routing...			

		oServer:Route( '/'		, 'index.html' )  														
		
	//	-----------------------------------------------------------------------//	
	
	IF ! oServer:Run()
	
		? "=> Server error:", oServer:cError

		RETU 1
	ENDIF
	
RETURN 0

//----------------------------------------------------------------------------//

function AppPathReport();	retu HB_DirBase() + 'output\'
function AppPathImages();	retu HB_DirBase() + 'files\images\'
function AppUrlReport();	retu 'output/'