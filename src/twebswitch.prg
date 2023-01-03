//	-------------------------------------------------------------

CLASS TWebSwitch FROM TWebControl

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, lValue, cLabel, nGrid, cAction  ) CLASS TWebSwitch

	DEFAULT cId TO ''
	DEFAULT lValue TO .F.
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	
	::oParent		:= oParent
	::cId			:= cId
	::uValue 		:= IF( lValue, .T., .F. )
	::cLabel 		:= cLabel
	::nGrid			:= nGrid
	::cAction		:= cAction

	IF Valtype( oParent ) == 'O'
	
		oParent:AddControl( SELF )
	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebSwitch

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	local cIdPrefix
	
	IF ::uValue
		cChecked := 'checked'
	ENDIF	
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' custom-control custom-switch tweb_switch' + IF( ::oParent:lDessign, ' tweb_dessign', '')  + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	cHtml += '<input type="checkbox" class="custom-control-input" id="' + cIdPrefix + ::cId + '" name="' + cIdPrefix + ::cId + '" ' + cChecked 
	
	cHtml += ' data-live '
	
	IF !empty( ::cAction )
		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += ' onchange="' + ::cAction + '" '
		else
			cHtml += ' data-onchange="' + ::cAction + '" '
		endif 
		
	ENDIF
	
	//cHtml += ' onclick="' + ::cAction + '" ' 
	
	cHtml += '>' 
	
	
	
	IF empty( ::cLabel )
		::cLabel := '&nbsp;'
	endif
	
	cHtml += '<label class="custom-control-label" for="' + cIdPrefix + ::cId + '">' + ::cLabel + '</label>'
	


	cHtml += '</div>'

RETU cHtml