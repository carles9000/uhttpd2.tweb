//	-------------------------------------------------------------

CLASS TWebCheckbox FROM TWebControl

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New(  oParent, cId, lValue, cLabel, nGrid, cAction, cClass, cFont, cStyle, cProp, lReadonly, lHidden ) CLASS TWebCheckbox

	DEFAULT cId TO ::GetId()
	DEFAULT lValue TO .F.
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lReadonly TO .f.
	DEFAULT lHidden TO .f.
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue 		:= lValue
	::cLabel 		:= cLabel
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cStyle 		:= cStyle
	::cProp 		:= cProp
	::lReadOnly 	:= lReadOnly 
	::lHidden		:= lHidden

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebCheckbox

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	local cIdPrefix
	local cSt := ''
	
	IF ::uValue
		cChecked := 'checked="checked"'
	ENDIF

	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	

	
	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' tweb_checkbox" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) 
	

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
	
	if !empty( ::cStyle )
		cHtml += '<div  style="' + ::cStyle + '" >'
	endif
	
	
	
	cHtml += '<div class="custom-control custom-checkbox " >'
	cHtml += '<input type="checkbox" class="custom-control-input tweb_pointer" id="' + cIdPrefix + ::cId + '" ' 

	
	if !empty( ::cProp )	
		cHtml += ' ' + ::cProp + ' ' 
	endif
	
	cHtml += ' data-live '
	
	IF !empty( ::cAction )
		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += ' onchange="' + ::cAction + '" '
		else
			cHtml += ' data-onchange="' + ::cAction + '" '
		endif 
		
	ENDIF	
	
	cHtml += cChecked

	IF ::lReadOnly
		cHtml += ' disabled '
	ENDIF	
	
	cHtml += '> '
	
	IF !empty( ::cLabel )
	
		cHtml += '<label class="custom-control-label tweb_pointer '
		
		if !empty( ::cClass )	
			cHtml += ' ' + ::cClass
		endif
		
		if !empty( ::cFont )	
			cHtml += ' ' + ::cFont
		endif

		cHtml += '" '

		
		cHtml += 'for="' + cIdPrefix + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	if !empty( ::cStyle )
		cHtml += '</div>'
	endif

	cHtml += '</div>'
	cHtml += '</div>'
	
	//cHtml += ::Properties( cIdPrefix + ::cId, ::hProp )	

RETU cHtml