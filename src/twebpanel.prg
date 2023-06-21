CLASS TWebPanel FROM TWebControl

	DATA cSizing				INIT ''
	DATA cId_Dialog			INIT ''
	DATA lFluid					INIT ''


	METHOD New() 				CONSTRUCTOR	

	METHOD End() 				INLINE ::Html( '</div>' )
	
	METHOD Activate()

ENDCLASS 

METHOD New( oParent, cId, cClass, cStyle, cProp, lHidden ) CLASS TWebPanel	

	local lFound := .f.
	
	DEFAULT cId TO ::GetId()
	DEFAULT cClass TO ''
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lHidden TO .f.	
	
	::cId 			:= cId
	::cClass		:= cClass
	::cStyle		:= cStyle
	::cProp			:= cProp
	::lHidden		:= lHidden	
	
	::oParent 		:= oParent
	
	IF Valtype( oParent ) == 'O'	
	
		oParent:AddControl( SELF )	
		
		::lDessign 	:= oParent:lDessign
		::cSizing  	:= oParent:cSizing
		::cType    	:= oParent:cType
		::lFluid    := oParent:lFluid
		
	//	We're looking for a TWEBFORM. We need cId_Dialog
		::cId_Dialog 	:= UIdFormParent( oParent )
	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebPanel

	LOCAL cHtml  := ''
	LOCAL cStyle := ''
	LOCAL nI	
	
	cHtml += '<div id="' + ::cId_Dialog + '-' + ::cId + '" '
	
	if !empty( ::cClass )
		cHtml += ' class="' + ::cClass + '" '
	endif	
	
	if ::lDessign
		cStyle += ";border:1px solid red;" 
	endif
	
	IF ::lHidden
		cStyle +=  'display:none;'
	ENDIF	
	
	if !empty( ::cStyle )	
		cStyle += ::cStyle 
	endif		
	
	if !empty( cStyle )	
		cHtml += ' style="' + cStyle + '" '
	endif

	if !empty( ::cProp )	
		cHtml += ' ' + ::cProp + ' ' 
	endif	
	
	
	cHtml += '>'  + CRLF 
	
	//::Html( cHtml )	

	FOR nI := 1 To len( ::aControls )
		
		IF Valtype( ::aControls[nI] ) == 'O'	
			cHtml += ::aControls[nI]:Activate()			
		ELSE				
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT		

	//cHtml += '</div>' + CRLF 

RETU cHtml