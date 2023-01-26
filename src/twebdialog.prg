#include 'hbclass.ch'	
#include 'common.ch'
#include 'error.ch'

//	----------------------------------------------------------



CLASS TWebDialog

	DATA cTitle						INIT ''
	DATA aInclude					INIT {}
	DATA aControls					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	
ENDCLASS 

METHOD New( cTitle ) CLASS TWebDialog

	DEFAULT cTitle 			TO 'Dialog'
		
	::cTitle 	:= cTitle
	
RETU SELF

METHOD Activate() CLASS TWebDialog

	local cHtml 	:= ''
	local nI
	
	FOR nI := 1 To len( ::aControls )	
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()						
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT		

	//UReplaceBlocks( @cHtml, "{{", "}}" )
	

RETU cHtml

