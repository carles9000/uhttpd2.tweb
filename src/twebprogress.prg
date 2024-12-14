//	-------------------------------------------------------------

CLASS TWebProgress FROM TWebControl

	DATA lPercentage 				INIT .t.
	DATA nHeight	 				INIT 0

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New(  oParent, cId, nValue, cLabel, lPercentage, nGrid, cClass, cFont, cStyle, cProp, lHidden, nHeight ) CLASS TWebProgress

	DEFAULT cId TO ::GetId()
	DEFAULT nValue TO 0
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''	
	DEFAULT lPercentage TO .f.
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lHidden TO .f.
	DEFAULT nHeight TO 0
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue 		:= nValue
	::cLabel 		:= cLabel
	::lPercentage	:= lPercentage
	::nGrid			:= nGrid	
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cStyle 		:= cStyle
	::cProp 		:= cProp	
	::lHidden		:= lHidden
	::nHeight		:= nHeight

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebProgress

	LOCAL cHtml 	:= ''
	local cIdPrefix
	local cSt := ''	


	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	

	
	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' tweb_progress" '  
	
	

	IF  ::oParent:lDessign
		cSt += 'border:1px solid blue;'
	ENDIF

	IF ::lHidden
		cSt += 'display:none;'
	ENDIF	
	
	if !empty( cSt )
		cHtml += ' style="' + cSt + '" ' 
	endif
	
	cHtml += '>'	

	
		IF !empty( ::cLabel )
			cHtml += '<label id="' + cIdPrefix + ::cId + '_label"' + ' class="col-form-label  ' 
			
			//if !empty( ::cClass )	
			//	cHtml += ' ' + ::cClass
			//endif
			
			if !empty( ::cFont )	
				cHtml += ' ' + ::cFont
			endif
			
			cHtml += '" >' + ::cLabel + '</label>'
		ENDIF
	
		cHtml += '<div class="progress " '
		
		cHtml += ' style="'
		if ::nHeight > 0
			cHtml += 'height: ' + ltrim(str(::nHeight)) + 'px;'
		endif
		
		if !empty( ::cStyle )			
			cHtml += ::cStyle 
		endif				
		
		cHtml += '" >'
		
			cHtml += '<div id="' + cIdPrefix + ::cId + '" '  + 'class="progress-bar ' + ::cClass + ' "' 			
			cHtml += 'role="progressbar" '
			cHtml += 'style="width: ' + ltrim(str( ::uValue )) + '%;"' 												
			cHtml += ' data-percentage="'  + if( ::lPercentage,'yes','no' ) + '" '
			cHtml += ' >' 
			
			if ::lPercentage 
				cHtml += ltrim(str(::uValue)) + '%'
			endif
			
			cHtml += '</div>'

	/*
		if !empty( ::cProp )	
			cHtml += ' ' + ::cProp + ' ' 
		endif
	
		cHtml += ' data-live '
	*/						

	
	//if !empty( ::cStyle )
	//	cHtml += '</div>'
	//endif

	cHtml += '  </div>'
	cHtml += '</div>'

RETU cHtml