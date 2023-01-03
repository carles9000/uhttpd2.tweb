//	-------------------------------------------------------------

CLASS TWebCheckbox FROM TWebControl

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New(  oParent, cId, lValue, cLabel, nGrid, cAction, cClass, cFont     ) CLASS TWebCheckbox

	DEFAULT cId TO ''
	DEFAULT lValue TO .F.
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue 		:= lValue
	::cLabel 		:= cLabel
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cClass 		:= cClass
	::cFont 		:= cFont	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebCheckbox

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	local cIdPrefix
	
	IF ::uValue
		cChecked := 'checked="checked"'
	ENDIF

	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' tweb_checkbox" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) + '>'
	cHtml += '<div class="custom-control custom-checkbox " >'
	cHtml += '<input type="checkbox" class="custom-control-input tweb_pointer" id="' + cIdPrefix + ::cId + '" ' 
	
	IF !empty( ::cAction )
		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += ' onchange="' + ::cAction + '" '
		else
			cHtml += ' data-live data-onchange="' + ::cAction + '" '
		endif 
		
	ENDIF
	
	cHtml += cChecked
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

	cHtml += '</div>'
	cHtml += '</div>'

RETU cHtml