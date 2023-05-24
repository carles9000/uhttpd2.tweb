#include 'hbclass.ch'	
#include 'common.ch'
#include 'error.ch'

//	----------------------------------------------------------



CLASS TWebDialog

	DATA cTitle						INIT ''
	DATA cRootRelative				INIT '' 	
	DATA aInclude					INIT {}
	DATA aControls					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	
	METHOD AddJs( cFile, lAbsolute ) 	
	METHOD AddCss( cFile, lAbsolute ) 	
	
ENDCLASS 

METHOD New( cTitle ) CLASS TWebDialog

	DEFAULT cTitle 			TO 'Dialog'
		
	::cTitle 	:= cTitle
	
RETU SELF

METHOD Activate() CLASS TWebDialog

	local cHtml 	:= ''
	local nI
	
	hb_SetEnv( "ROOTRELATIVE", ::cRootRelative )	
	
	FOR nI := 1 To len( ::aInclude )	
		cHtml += ::aInclude[ nI ] + CRLF 
	next	
	
	FOR nI := 1 To len( ::aControls )	
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()						
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT	
	
	UReplaceBlocks( @cHtml, "{{", "}}" )	
	

RETU cHtml

METHOD AddJs( cFile, lAbsolute ) CLASS TWebDialog

	hb_default( @lAbsolute, .f. )
	
	if lAbsolute
		Aadd( ::aInclude, '<script src="' + cFile + '"></script>')		
	else 		
		Aadd( ::aInclude, '<script src="{{ hb_GetEnv( "ROOTRELATIVE") }}' + cFile + '"></script>' )		
	endif
	
RETU NIL

METHOD AddCss( cFile, lAbsolute ) CLASS TWebDialog

	hb_default( @lAbsolute, .f. )
	
	if lAbsolute
		Aadd( ::aInclude, '<link rel="stylesheet" href="' + cFile + '">' )		
	else 
		Aadd( ::aInclude, '<link rel="stylesheet" href="{{ hb_GetEnv( "ROOTRELATIVE") }}' + cFile + '">' )		
	endif
	
RETU NIL

