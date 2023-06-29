
CLASS TWebAccordion FROM TWebForm

	DATA aSections 					INIT {}
	DATA cId_Dialog					INIT ''
	DATA cClass_Section 				INIT ''
	DATA lUnique		 				INIT .F.


	METHOD New( oParent, cId, cClass, cStyle, lUnique ) 		CONSTRUCTOR	

	METHOD AddSection( cId_Header, cId_Body, cClass )	
	
	METHOD Activate()	
	
	METHOD End()						INLINE ::oParent:Html( '</div>' + CRLF )
	//METHOD EndAccordion()				INLINE NIL
	
ENDCLASS 

METHOD New( oParent, cId, cClass, cStyle, lUnique ) CLASS TWebAccordion	

	local oForm

	
	//hb_default( @cId, ltrim(str(hb_milliseconds())) )
	hb_default( @cId, '' )
	hb_default( @cClass, 'accordion' )
	hb_default( @cStyle, '' )
	hb_default( @lUnique, .F.  )
	
	::oParent 		:= oParent
	::cId	 		:= cId	
	::cClass 		:= cClass
	::cStyle		:= cStyle
	::lUnique 		:= lUnique
	

	if ::lUnique .and. empty( ::cId )	
		UDo_ErrorMsg( 'TAccordion: Clausule UNIQUE need ID', 'TWeb' )
		return nil
	endif
	


	IF Valtype( oParent ) == 'O'
	
		oParent:AddControl( SELF )	
		
		::lDessign := oParent:lDessign
		::cSizing  := oParent:cSizing
		::cType    := oParent:cType
		
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


METHOD Activate() CLASS TWebAccordion

	LOCAL cHtml := ''
	LOCAL nI
	
	cHtml += CRLF
	cHtml += '<div ' 
	
	if !empty( ::cId )
		cHtml += 'id="' + ::cId + '" '
	endif	
	
	if !empty( ::cClass )
		cHtml += 'class="' + ::cClass + '" '
	endif		
	
	if !empty( ::cStyle )	
		cHtml += 'style="' + ::cStyle + '" '
	endif	
	
	cHtml += '>'	+ CRLF + CRLF 
	

	FOR nI := 1 To len( ::aSections )

		cHtml += ::aSections[nI]:Activate()
		
	NEXT	


	
	//	Este ultimo div, es lo que hace::EndAccordion()
	//	cHtml += '</div><!-- ENDACORDION -->'  + CRLF 
	//	Pero, es mejor que cierren el accordion con comando

RETU cHtml

METHOD AddSection( cId_Header, cId_Body, cClass ) CLASS TWebAccordion
	
	local oSection	:= nil 
	
	hb_default( @cClass, '' )
	
	::cClass_Section := cClass
	
	oSection := TAccordionSection():New( SELF, cId_Header, cId_Body )
	
	Aadd( ::aSections, oSection )					

RETU oSection 

//	---------------------------------------------------	//

CLASS TAccordionSection FROM TWebControl

	DATA oHeader 
	DATA oBody
	DATA cId_Dialog						INIT ''
	DATA cId_Header
	DATA cId_Body
	DATA lShow 								INIT .F. 

	METHOD New( oParent, cId_Header, cId_Body ) 			CONSTRUCTOR	
	
	METHOD Header()
	METHOD Body()
	
	METHOD Activate()
	
	METHOD End()				INLINE  ::Html( '</div>' + CRLF )
	
ENDCLASS 

METHOD New( oParent, cId_Header, cId_Body ) CLASS TAccordionSection	


	hb_default( @cId_Header , '')	
	hb_default( @cId_Body , '')	

	::oParent 		:= oParent
	::cId_Header 	:= cId_Header
	::cId_Body 	:= cId_Body

	
	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
		
		::lDessign 	:= oParent:lDessign
		::cSizing  		:= oParent:cSizing
		::cType    		:= oParent:cType
		
		::cId_Dialog 	:= UIdFormParent( oParent )		
		
	ENDIF

RETU SELF

METHOD Header( cCode, cClass ) CLASS TAccordionSection	

	local cHtml 	:= ''
	local oHeader
	
	
	hb_default( @cCode, '' )
	hb_default( @cClass, '' )
	
	cHtml += '<div ' 
	
	if !empty( ::cId_Header )
		cHtml += 'id="' + ::cId_Header + '" '
	endif
	
	cHtml += 'class="card-header p-0 '

	if !empty( cClass )
		cHtml += cClass
	endif
	
	cHtml += '" >' 	+ CRLF
	
    
	//cHtml += '<button class="btn btn-block text-left header_title" type="button" data-toggle="collapse" data-target="#collapseOne" >'
	cHtml += '<button class="btn btn-block text-left " type="button" data-toggle="collapse" '
	cHtml += 'data-target="#' + ::cId_Body + '" >' + CRLF
	

	
	if !empty( cCode )
	
		cHtml += cCode + CRLF
		cHtml += '</button>'   + CRLF      			
		cHtml += '</div>' + CRLF
	
		::Html( cHtml )
		
	else

		::Html( cHtml )
		
		oHeader := TContainer():New( ::oParent )	
		//oHeader := TWebPanel():New( ::oParent )	
	
		oHeader:cHtml_End  := '</button></div>' + CRLF 			
		
		::Html( oHeader )
	
	endif

RETU oHeader

METHOD Body( cCode, cClass, cStyle, lShow ) CLASS TAccordionSection	

	local cHtml 	:= ''
	local oBody
	
	hb_default( @cCode, '' )
	hb_default( @cClass, '' )
	hb_default( @cStyle, '' )
	hb_default( @lShow, .F. )
	
	
	cHtml += '<div id="' + ::cId_Body + '" class="collapse ' 
	
	if lShow 
		cHtml += ' show ' 
	endif 

	
	cHtml += '" aria-labelledby="' + ::cId_Header   + '" '
	
	if ::oParent:lUnique 
		cHtml += ' data-parent="#' + ::oParent:cId + '" '
	endif
	
	cHtml += '>' + CRLF  
	

	//---------------------------
	
	cHtml += '  <div class="card-body"> ' + CRLF 
	
	if !empty( cCode )
	
		cHtml += cCode + CRLF
 			
		cHtml += '  </div>' + CRLF 
		cHtml += '</div>' + CRLF
		
	
		::Html( cHtml )

		
	else

		::Html( cHtml )
		
		oBody := TContainer():New( ::oParent )	
		//oBody := TWebPanel():New( ::oParent )	
	
		
		oBody:cHtml_End  := '</div>' + CRLF 				
		
		::Html( oBody )
		
		cHtml := '  </div>' + CRLF 
			
		::Html( cHtml )
	
	endif
	
	
RETU oBody


METHOD Activate() CLASS TAccordionSection

	LOCAL cHtml := ''
	LOCAL nI

	cHtml += '<div class="card ' 
	

	if !empty( ::oParent:cClass_Section )
		cHtml += ::oParent:cClass_Section
	endif
	
	/*
	cHtml += '" '
	
	if !empty( ::cStyle )	
		cHtml += 'style="' + ::cStyle + '" '
	endif	
	
*/	
	
	cHtml += '">' + CRLF
	
	

	
	FOR nI := 1 To len( ::aControls )

	
		IF Valtype( ::aControls[nI] ) == 'O'
		

			cHtml += ::aControls[nI]:Activate()			
			
		ELSE	
		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT	



RETU cHtml

//	---------------------------------------------------	//

CLASS TContainer FROM TWebForm

	DATA cHtml_End					INIT '</div>' + CRLF
	
	DATA cSizing					INIT ''
	DATA cId_Dialog					INIT ''
	DATA lFluid						INIT .F.


	METHOD New( oParent ) 			CONSTRUCTOR	

	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	
	
	METHOD End() 					INLINE ::Html( ::cHtml_End )
	
	METHOD Activate()

ENDCLASS 

METHOD New( oParent ) CLASS TContainer	
	
	::oParent 		:= oParent
	
	::cId_Dialog 	:= UIdFormParent( oParent )
	
	::lFluid		:= .f.
	
RETU SELF

METHOD Activate() CLASS TContainer

	LOCAL cHtml := ''
	LOCAL nI
		

	FOR nI := 1 To len( ::aControls )
		
		IF Valtype( ::aControls[nI] ) == 'O'
	
			cHtml += ::aControls[nI]:Activate()			
		ELSE	
			
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT			

RETU cHtml

