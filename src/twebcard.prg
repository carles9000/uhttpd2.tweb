
CLASS TWebCard FROM TWebForm

	DATA lFluid 					INIT .f.


	METHOD New( oParent, cId, cClass, cStyle ) 		CONSTRUCTOR	

	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD Html( cCode ) 			INLINE Aadd( ::aControls, cCode )
	
	METHOD AddHeader( cCode ) 
	METHOD EndHeader()		 		INLINE ::Html( '</div>'  + CRLF)
	
	METHOD AddBody( cCode ) 
	METHOD EndBody()		 		INLINE ::Html( '</div>'  + CRLF)
	
	
	METHOD AddFooter( cCode )	
	
	METHOD EndCard()				INLINE ::Html( '</div>'  + CRLF ) 		//	::Html( '</div></div>' )
			
	METHOD Activate()	
	
	
ENDCLASS 

METHOD New( oParent, cId, cClass, cStyle) CLASS TWebCard		

	
	hb_default( @cId, '' )
	hb_default( @cClass, '' )
	hb_default( @cStyle, '' )
	
	::oParent 		:= oParent
	::cId	 		:= cId	
	::cClass 		:= cClass
	::cStyle		:= cStyle
	

	
	IF Valtype( oParent ) == 'O'
	
		oParent:AddControl( SELF )	
		
		::lDessign := oParent:lDessign
		::cSizing  := oParent:cSizing
		::cType    := oParent:cType
		::lFluid   := oParent:lFluid
		
	//	We're looking for a TWEBFORM. We need cId_Dialog
		::cId_Dialog 	:= UIdFormParent( oParent )		
		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebCard

	LOCAL cHtml := ''
	LOCAL nI
	
	//cHtml += '<div class="card-deck" >'	
	
	cHtml += '<div class="card ' 
	
	if !empty( ::cClass )
		cHtml += ::cClass
	endif
	
	cHtml += '" '
	
	if !empty( ::cStyle )	
		cHtml += 'style="' + ::cStyle + '" '
	endif	
	
	
	cHtml += '>' + CRLF
		
	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'

			cHtml += ::aControls[nI]:Activate()			
		ELSE	
		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT			

RETU cHtml

METHOD AddHeader( cCode, cClass, cStyle ) CLASS TWebCard

	local cHtml, oHeader	

	hb_default( @cCode, '' )
	hb_default( @cClass, '' )
	hb_default( @cStyle, '' )	
	
	cHtml := '<div class="card-header ' + cClass + '" '
	
	if !empty( cStyle )
		cHtml += 'style="' + cStyle + '" >' 	
	endif	
	
	cHtml += '>' + CRLF		
	
	if !empty( cCode )
	
		cHtml += cCode + '</div>' + CRLF
	
		::Html( cHtml )
		
	else
	
		oHeader := TCardContainer():New( SELF )		
	
		oHeader:Html( cHtml )	
		
	endif 

RETU oHeader 

METHOD AddBody( cCode, cClass, cStyle ) CLASS TWebCard

	local cHtml, oBody 
	
	hb_default( @cCode, '' )	
	hb_default( @cClass, '' )
	hb_default( @cStyle, '' )
	
	cHtml := '<div class="card-body ' + cClass + '" '
	
	if !empty( cStyle )
		cHtml += 'style="' + cStyle + '" >' 	
	endif	
	
	cHtml += '>' + CRLF	
	
	if !empty( cCode )
	
		cHtml += cCode	+ '</div>' + CRLF
	
		::Html( cHtml )
		
	else

		oBody := TCardContainer():New( SELF )		
	
		oBody:Html( cHtml )	
		
	endif 				
	
RETU oBody 


METHOD AddFooter( cCode, cClass, cStyle ) CLASS TWebCard

	local cHtml, oFooter 	

	hb_default( @cCode, '' )
	hb_default( @cClass, '' )
	hb_default( @cStyle, '' )

	cHtml := '<div class="card-footer ' + cClass + '" '
	
	if !empty( cStyle )
		cHtml += 'style="' + cStyle + '" >' 	
	endif	
	
	cHtml += '>' + CRLF		
	
	if !empty( cCode )
	
		cHtml += '<small class="text-muted">' + cCode + '</small></div>' + CRLF		
	
		::Html( cHtml )
		
	else
	
		oFooter := TCardContainer():New( SELF )		
	
		oFooter:Html( cHtml )	
		
	endif 	

RETU oFooter 


//	---------------------------------------------------	//

CLASS TCardContainer FROM TWebForm

	DATA cSizing					INIT ''
	DATA cId_Dialog				INIT ''
	DATA lFluid					INIT ''


	METHOD New( oParent ) 		CONSTRUCTOR	

	METHOD End() 					INLINE ::Html( '</div>' )
	
	METHOD Activate()

ENDCLASS 

METHOD New( oParent ) CLASS TCardContainer	

	local lFound := .f.
	
	::oParent 		:= oParent
	
	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
		
		::lDessign 	:= oParent:lDessign
		::cSizing  		:= oParent:cSizing
		::cType    		:= oParent:cType
		::lFluid    		:= oParent:lFluid
		
	//	We're looking for a TWEBFORM. We need cId_Dialog
		::cId_Dialog 	:= UIdFormParent( oParent )
	
	ENDIF

RETU SELF

METHOD Activate() CLASS TCardContainer

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
