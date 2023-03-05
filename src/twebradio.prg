//	-------------------------------------------------------------

CLASS TWebRadio FROM TWebControl

	DATA lInline					INIT .F.
	DATA aItems						INIT {}
	DATA aValues					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cLabel, uValue, aItems, aValues, lReadOnly, nGrid, cAction, lInline, cClass, cFont, cStyle, cProp, lHidden ) CLASS TWebRadio

	DEFAULT cId TO ::GetId()
	DEFAULT cLabel TO ''	
	DEFAULT uValue TO ''	
	DEFAULT aItems TO {}
	DEFAULT aValues TO {}
	DEFAULT nGrid TO 4
	DEFAULT cAction TO ''
	DEFAULT lInline TO .F.
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''	
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lReadOnly TO .F.
	DEFAULT lHidden TO .F.
	

	::oParent 		:= oParent	
	::cId			:= cId
	::cLabel		:= cLabel	
	::uValue		:= uValue	
	::aItems 		:= aItems	//IF( valtype( aItems ) == 'A', aItems, {} )
	::aValues		:= aValues	//IF( valtype( aValues ) == 'A' .AND. len( aValues ) == len( aItems ), aValues, aItems )
	::nGrid			:= nGrid
	::cAction		:= cAction
	::lInline		:= lInline
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cStyle 		:= cStyle
	::cProp 		:= cProp
	::lReadOnly		:= lReadOnly
	::lHidden		:= lHidden

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebRadio

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	LOCAL cSt		:= ''
	LOCAL nI, cIdPrefix	
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif
	
	//IF lValue
		//cChecked := 'checked=false'
		cChecked := ''
	//ENDIF	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' custom-control " ' 
	
	if ::oParent:lDessign
		cSt += "border:1px solid blue;"
	endif
	
	IF ::lHidden
		cSt += 'display:none;'
	ENDIF		
	
		
	
	cSt += "padding-left: 15px;"
	
	cHtml += ' style="' + cSt + '" '

	cHtml += ' data-control="radio">'
	
	if !empty( ::cStyle )	
		cHtml += '<div style="' + ::cStyle + '" >'
	endif	

	IF !empty( ::cLabel )
	
		cHtml += '<label class="custom-control-label tweb_pointer '
		
		if !empty( ::cClass )	
			cHtml += ' ' + ::cClass
		endif
		
		if !empty( ::cFont )	
			cHtml += ' ' + ::cFont
		endif

		cHtml += '" '

		
		cHtml +=  '">' + ::cLabel + '&nbsp;</label> '
		
		IF ! ::lInline
			cHtml += '<br>'
		ENDIF
	
	ENDIF	
	
	FOR nI := 1 TO len( ::aItems )
	
		cHtml += '<div class="custom-control custom-radio ' + IF( ::lInline, 'custom-control-inline', '' ) + '">'
		cHtml += '	<input type="radio" class="custom-control-input tweb_pointer" id="' + cIdPrefix + ::cId + '_' + ltrim(str(ni)) + '" name="' +  cIdPrefix + ::cId  + '" value="' +  ::aValues[nI] + '" ' + IF( ::lDisabled, 'disabled', '' )
		cHtml += ' data-live '
	
		if !empty( ::cProp )	
			cHtml += ' ' + ::cProp + ' ' 
		endif
		
		IF !empty( ::cAction )
			if AT( '(', ::cAction ) >  0 		//	Exist function ?
				cHtml += ' onchange="' + ::cAction + '" '
			else
				cHtml += ' data-onchange="' + ::cAction + '" '
			endif 
			
		ENDIF		
		//cHtml += ' 	onchange="' + ::cAction + '" ' 
		
		IF ::uValue == ::aValues[nI] 
			cHtml += ' checked '					
		ENDIF

		IF ::lReadOnly
			cHtml += ' disabled '
		ENDIF					
	
	
		cHtml += '  >' 
		cHtml += '	<label class="custom-control-label tweb_pointer '
		
			if !empty( ::cClass )	
				cHtml += ' ' + ::cClass
			endif
			
			if !empty( ::cFont )	
				cHtml += ' ' + ::cFont
			endif

			cHtml += '" '		

		cHtml += '	for="'  + cIdPrefix + ::cId + '_' + ltrim(str(ni)) + '" >' + ::aItems[nI] + '</label>' 
		cHtml += '</div>' 
		
	NEXT	
	
	if !empty( ::cStyle )	
		cHtml += '</div>'
	endif		

	cHtml += '</div>'
	
	//cHtml += ::Properties( cIdPrefix + ::cId, ::hProp )	

RETU cHtml