//	-------------------------------------------------------------

CLASS TWebGetMemo FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA cBtnLabel 					INIT ''
	DATA cBtnAction 				INIT ''
	DATA nRows						INIT 3


	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, nGrid, cLabel, cAlign, lReadOnly, nRows, cClass, cFont, cChange  ) CLASS TWebGetMemo

	DEFAULT cId TO ''
	DEFAULT uValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAlign TO ''
	DEFAULT lReadOnly TO .F.
	DEFAULT nRows TO 3
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cChange TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= uValue
	::nGrid			:= nGrid
	::cLabel 		:= cLabel
	::cAlign 		:= cAlign
	::lReadOnly		:= lReadOnly
	::nRows 		:= nRows
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cChange 		:= cChange	
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebGetMemo

	LOCAL cHtml
	LOCAL cSize := ''
	local cIdPrefix
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'form-control-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'form-control-lg'
	ENDCASE	

	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif
	
	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	
	IF !empty( ::cLabel )
	
		cHtml += '<label for="' + cIdPrefix + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	cHtml += '<textarea class="form-control ' 	
	
		if !empty( ::cClass )	
			cHtml += ' ' + ::cClass
		endif
		
		if !empty( ::cFont )	
			cHtml += ' ' + ::cFont
		endif					
	
	cHtml += '" rows="' + ltrim(str(::nRows)) + '" '
	cHtml += 'id="' + cIdPrefix + ::cId + '"	 name="' + cIdPrefix + ::cId + '" ' 
	//cHtml += 'placeholder="' + ::cPlaceHolder + '" ' 
	
	IF ::lReadOnly
		cHtml += ' readonly '
	ENDIF
	
	cHtml += ' data-control="tgetmemo" '
	cHtml += ' data-live '

	IF !empty( ::cChange )
		if AT( '(', ::cChange ) >  0 		//	Exist function ?
			cHtml += ' onchange="' + ::cChange + '" '
		else
			cHtml += ' data-onchange="' + ::cChange + '" '
		endif 
		
	ENDIF
	
	
	//cHtml += ' value="' + ::uValue + '">'
	cHtml += ' >'
	cHtml += ::uValue

	cHtml += '</textarea>'

	cHtml += '</div>'

RETU cHtml