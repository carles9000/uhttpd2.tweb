//	-------------------------------------------------------------

CLASS TWebSelect FROM TWebControl

	
	DATA aItems						INIT {}
	DATA aValues					INIT {}
	DATA lParKeyValue				INIT .F. 
	DATA cWidth 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, aItems, aValues, aKeyValue, nGrid, cAction, cLabel, cClass, cFont, cGroup, cStyle, cProp, lReadOnly, lHidden, cWidth ) CLASS TWebSelect

	DEFAULT cId TO ::GetId()
	DEFAULT aItems TO {}
	DEFAULT aValues TO {}
	DEFAULT aKeyValue TO NIL
	DEFAULT nGrid TO 4
	DEFAULT cAction TO ''
	DEFAULT cLabel TO ''
	DEFAULT uValue TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''	
	DEFAULT cGroup TO ''	
	DEFAULT cStyle TO ''	
	DEFAULT cProp TO ''	
	DEFAULT lReadonly TO .F.
	DEFAULT lHidden TO .F.
	DEFAULT cWidth TO ''
	

	::oParent 		:= oParent	
	::cId			:= cId
	
	::aValues		:= aValues 	//	IF( valtype( aValues ) == 'A' .AND. len( aValues ) == len( aItems ), aValues, aItems )
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cLabel		:= cLabel
	::uValue		:= uValue
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cGroup 		:= cGroup
	::cStyle 		:= cStyle
	::cProp 		:= cProp
	::lReadOnly		:= lReadOnly
	::lHidden 		:= lHidden
	::cWidth 		:= cWidth 

	
	if valtype( aKeyValue ) == 'H' 
		::lParKeyValue 	:= .t.
		::aValues 		:= aKeyValue		
		
	else	
	
		if valtype( aItems ) == 'A' .and. len( aItems ) > 0

			if valtype( aItems[1] ) == 'A'
				::aItems := aItems[1]		
			else
				::aItems := aItems		
			endif
		
		else
				
			::aItems := {}
		endif
		
		if valtype( aValues ) == 'A' .and. len( aValues ) > 0

			if valtype( aValues[1] ) == 'A'					
				::aValues := aValues[1]	
			else
				::aValues := aValues
			endif
		
		else
			::aValues := {}
		endif		
		
		if len( ::aItems ) <> len( ::aValues )
			::aValues := ::aItems
		endif
	
	endif

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebSelect

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	LOCAL nI
	LOCAL cSize := ''
	LOCAL cSizeLabel := ''
	local aPar
	local lArrayPar := .f.
	local cIdPrefix
	local cSt := ''
	local cGrid := ''
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' 
			cSize := 'form-control-sm'
			cSizeLabel	:= 'col-form-label-sm'
		CASE upper(::oParent:cSizing) == 'LG' 
			cSize := 'form-control-lg'
			cSizeLabel	:= 'col-form-label-lg'
	ENDCASE	

	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	

	if valtype( ::nGrid ) == 'N'
		cGrid := ltrim(str(::nGrid))
	else
		cGrid := ::nGrid	
	endif
	
	if !empty( ::cWidth )
		cGrid := '0'
		cSt += 'width:' + ::cWidth + ';'
	endif
	
	cHtml := '<div class="col-' + cGrid + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) 
	
	IF  ::oParent:lDessign
		cSt += 'border:1px solid blue;'
	ENDIF

	IF ::lHidden
		cSt += 'display:none;'
	ENDIF	
	
	if !empty( cSt )
		cHtml += ' style="' + cSt + '" '
	endif	
	
	cHtml += ' data-group="' + cIdPrefix + ::cId   + '" >'
	

	IF !empty( ::cLabel )
	
		//cHtml += '<label for="' + ::cId + '">' + ::cLabel + '</label>'
		cHtml += '<label class="' + cSizeLabel + ' ' + ::cFontLabel + ' "for="' + cIdPrefix + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	cHtml += '<div class="input-group">'		
	
	
	cHtml += '<select data-control="tcombobox" '
	
	/*
	if !empty( ::cGroup )
		cHtml += 'data-group="' + ::cGroup + '" '
	endif
	*/
		
		
	cHtml += 'class="col-12 form-control ' + cSize + IF( ::oParent:lDessign, ' tweb_dessign', '') 

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	

	
	cHtml += '" ' 

	if ::oParent:lDessign 
		::cStyle += "border:1px solid blue;" 
	endif
	
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif

	if !empty( ::cProp )	
		cHtml += ' ' + ::cProp + ' ' 
	endif	
	
	
	
	cHtml += 'id="' + cIdPrefix + ::cId + '" name="' + cIdPrefix + ::cId + '" '
	
	cHtml += ' data-live '
	
	IF !empty( ::cAction )
		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += ' onchange="' + ::cAction + '" '
		else
			cHtml += ' data-onchange="' + ::cAction + '" '
		endif 
		
	ENDIF	
	
	IF ::lReadOnly
		cHtml += ' disabled '
	ENDIF		
	
	
	cHtml += '>'


	FOR nI := 1 TO len( ::aValues )
	
		if ::lParKeyValue 
			aPar := HB_HPairAt( ::aValues, nI ) 
		else
			aPar := { ::aValues[nI], ::aItems[nI] }

		endif

		cHtml += '<option value="' + aPar[1] + '" ' 			
		
		IF ::uValue == aPar[1]
			cHtml += ' selected '					
		ENDIF
		
		cHtml += '>' + aPar[2]		
		cHtml += '</option>'			
		
	NEXT	

	cHtml += '</select>' 
	
	cHtml += '	</div>'
	cHtml += '</div>'	
	
	//cHtml += ::Properties( cIdPrefix + ::cId, ::hProp )	
	

RETU cHtml