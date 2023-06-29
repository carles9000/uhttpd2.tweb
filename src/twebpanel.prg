CLASS TWebPanel FROM TWebForm 

	DATA cSizing				INIT ''
	DATA cId_Dialog			INIT ''
	DATA lFluid					INIT ''
	DATA cHtml_End				INIT '</div>' + CRLF	


	METHOD New() 				CONSTRUCTOR	

	METHOD End() 				INLINE ::Html( ::cHtml_End )
	
	METHOD Activate()

ENDCLASS 

METHOD New( oParent, cId, cClass, cStyle, cProp, lHidden ) CLASS TWebPanel	

	local lFound := .f.
	local oForm 
	
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
		
		oForm 	:= UOFormParent( oParent )			
		
		if valtype( oForm ) == 'O' .and. oForm:ClassName() == 'TWEBFORM'
			::lDessign := oForm:lDessign
			::cSizing  := oForm:cSizing
			::cType    := oForm:cType		
			::lFluid   := oForm:lFluid			
		endif
	
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