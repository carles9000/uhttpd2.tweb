//	-------------------------------------------------------------

CLASS TWebControl

	DATA oParent					
	DATA aControls					INIT {}
	DATA aHtml						INIT {}
	DATA cId						INIT ''
	DATA cName						INIT ''
	DATA uValue						INIT ''
	DATA cLabel						INIT ''
	DATA lDessign					INIT .F.
	DATA lFluid						INIT .F.
	DATA lHidden					INIT .F.
	DATA lBorder					INIT .F.
	DATA nGrid						INIT 4
	DATA lReadOnly					INIT .F.
	DATA lDisabled					INIT .F.
	DATA lRequired					INIT .F.
	DATA cAlign						INIT 'left'
	DATA cAction					INIT ''
	DATA cDblClick					INIT ''
	DATA cClass						INIT ''	
	DATA cSrc						INIT ''	
	DATA cIcon						INIT ''
	DATA cChange					INIT ''
	DATA cGroup						INIT ''
	DATA cDefault					INIT ''
	DATA cFont						INIT ''
	DATA cFontLabel					INIT ''
	DATA nHeight					INIT 0
	DATA nWidth						INIT 0
	DATA cStyle						INIT ''
	DATA cProp						INIT ''
	
	CLASSDATA cType					INIT ''		//	sm, md, lg, xl, xs
	CLASSDATA cSizing				INIT ''		//	sm, lg
	
	DATA hProp						INIT {=>}	//ELIMINAR!
	
	CLASSDATA nId					INIT 0 
		
    METHOD New()					CONSTRUCTOR
	
	METHOD Html( cCode ) 			INLINE Aadd( ::aControls, cCode )
	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD GetId() 					INLINE ( ::nId++, 'id' + ltrim(str(::nId)) )
	
	//METHOD Div()
	
	//METHOD Row()
	//METHOD RowGroup()
	//METHOD Col()

	METHOD Caption()
	METHOD Separator()
	METHOD Small()	
	METHOD Echo()
	
	METHOD End() 					INLINE ::Html( '</div>' + CRLF  )
	
	
	
ENDCLASS

METHOD New() CLASS TWebControl

RETU SELF

/*
METHOD Properties( cId, hProp ) CLASS TWebControl

	local cHtml := ''
	local hSource

	IF !Empty( hProp )
	
		hSource := hb_jsonencode( hProp )
		
		cHtml += '<script>'
		cHtml += "  UtoProp( '" + hSource + "', '" + cId  + "' );"		
		cHtml += '</script>'		

	
	ENDIF

RETU cHtml
*/

/*
METHOD Row( cId, cVAlign, cHAlign, cClass, cTop, cBottom, lHidden ) CLASS TWebControl

	local cHtml := ''

	DEFAULT cId TO ''
	DEFAULT cVAlign TO 'center'
	DEFAULT cHAlign TO 'left'
	DEFAULT cClass TO ''
	DEFAULT cTop TO ''
	DEFAULT cBottom TO ''
	DEFAULT lHidden TO .f.
	
	cVAlign 	:= lower( cVAlign )
	cHAlign 	:= lower( cHAlign )
	
	do case
		case cVAlign == 'top' 		;	cVAlign := 'align-items-start'
		case cVAlign == 'center' 	;	cVAlign := 'align-items-center'
		case cVAlign == 'bottom' 	;	cVAlign := 'align-items-end'
	endcase
	
	do case
		case cHAlign == 'left' 		;	cHAlign := 'justify-content-start'
		case cHAlign == 'center'	;	cHAlign := 'justify-content-center'
		case cHAlign == 'right' 	;	cHAlign := 'justify-content-end'
	endcase	
	
	
	
	
	cHtml += '<div id="' + cId + '" class="row ' + cVAlign + ' ' + cHAlign  
	
	if !empty( cClass )
		cHtml += ' ' + cClass
	endif	
	
	cHtml += '" ' 	//	End class
	
	cHtml += ' style="'
	
	cHtml += IF( ::lDessign, 'border:1px solid red;', '' )  
	
	IF lHidden
		cHtml +=  'display:none;'
	ENDIF		

	if !empty( cTop )
		cTop := mh_valtochar( cTop )
		cTop := 'margin-top: ' + cTop + ';'		
	endif	

	if !empty( cBottom )
		cBottom := mh_valtochar( cBottom )
		cBottom := 'margin-bottom: ' + cBottom + ';'		
	endif		
	
	cHtml += cTop + cBottom + '" ' 	//	End Style 
	
	cHtml += '>'  + CRLF 
	
	::Html( cHtml )
	
RETU NIL
*/
/*
METHOD Col( cId, nCol, cType, cClass, cStyle, lHidden ) CLASS TWebControl

	local cHtml := ''
	local cPrefix := IF( empty(::cType), '', ::cType + '-' )
	
	
	DEFAULT nCol TO 12
	DEFAULT cType TO ''
	DEFAULT cClass TO ''	
	DEFAULT cId TO ''	
	DEFAULT cStyle TO ''	
	DEFAULT lHidden TO .f.
	
	IF !Empty( cType )
		cPrefix := cType + '-' 	
	ELSE
		cPrefix := IF( empty(::cType), '', ::cType + '-' )
	ENDIF		
	

	//	Si ponemos e- -sm, responsive y pone 1 debajo de otro...
	//::Html ( '<div class="col-sm-' + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )	
	
	cHtml := '<div '
	
	if !empty( cId )
		cHtml += 'id="' + ::cId_Dialog +'-' + cId + '" '
	endif
	
	
	cHtml += ' class="col-' + cPrefix + ltrim(str(nCol)) 
	
	if !empty( cClass )
		cHtml += ' ' + cClass
	endif	
	
	cHtml += '" ' 
	
	IF ::lDessign 
		cStyle +=  ';border:1px solid blue;'
	ENDIF
	
	IF lHidden
		cStyle +=  'display:none;'
	ENDIF
	
	IF !empty(cStyle)
		cHtml += ' style="' + cStyle + '" '
	endif	

	cHtml += '>' + CRLF 
	
	//::Html ( '<div class="col-' + cPrefix + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )
	::Html ( cHtml )
	
RETU NIL
*/
/*
METHOD RowGroup( cId, cVAlign, cHAlign, cClass, cStyle, lHidden ) CLASS TWebControl

	local cHtml := ''

	DEFAULT cId  TO ''
	DEFAULT cVAlign TO 'center'
	DEFAULT cHAlign TO 'left'
	DEFAULT cClass TO ''
	DEFAULT cStyle TO ''
	DEFAULT lHidden TO .f.
	
	cVAlign 	:= lower( cVAlign )
	cHAlign 	:= lower( cHAlign )
	
	do case
		case cVAlign == 'top' 		;	cVAlign := 'align-items-start'
		case cVAlign == 'center' 	;	cVAlign := 'align-items-center'
		case cVAlign == 'bottom' 	;	cVAlign := 'align-items-end'
	endcase
	
	do case
		case cHAlign == 'left' 		;	cHAlign := 'justify-content-start'
		case cHAlign == 'center'	;	cHAlign := 'justify-content-center'
		case cHAlign == 'right' 	;	cHAlign := 'justify-content-end'
	endcase	


	cHtml += '<div '
	
	if !empty( cId )
		cHtml += 'id="' + ::cId_Dialog +'-' + cId + '" '
	endif
	
	cHtml += ' class="form-group row ' + cVAlign + ' ' + cHAlign 
	
	if !empty( cClass )
		cHtml += ' ' + cClass
	endif
	
	cHtml += '" ' 
	
	IF ::lDessign 
		cStyle +=  ';border:1px solid red;'
	ENDIF
	
	IF lHidden
		cStyle +=  'display:none;'
	ENDIF		
	
	IF !empty(cStyle)
		cHtml += ' style="' + cStyle + '" '
	endif
		
	cHtml += ' >'  + CRLF 
	
	::Html( cHtml )
	
	
	
RETU NIL
*/

/*
METHOD Div( cId, cClass, cStyle, cProp, lHidden ) CLASS TWebControl

	local cHtml := ''
	

	DEFAULT cId TO ''
	DEFAULT cClass TO ''
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lHidden TO .f.

	cHtml += '<div id="' + ::cId_Dialog + '-' + cId + '" '
	
	if !empty( cClass )
		cHtml += ' class="' + cClass + '" '
	endif	
	
	if ::lDessign
		cStyle += ";border:1px solid red;" 
	endif
	
	IF lHidden
		cStyle +=  'display:none;'
	ENDIF	
	
	if !empty( cStyle )	
		cHtml += ' style="' + cStyle + '" '
	endif	

	if !empty( cProp )	
		cHtml += ' ' + cProp + ' ' 
	endif	
	
	
	cHtml += '>'  + CRLF 
	
	::Html( cHtml )
	
RETU NIL
*/

METHOD Caption( cTitle, nGrid, cClass ) CLASS TWebControl

	LOCAL cHtml := ''		
	
	DEFAULT cTitle TO ''
	DEFAULT nGrid TO 12
	DEFAULT cClass TO ''
	
	cHtml := '<div class="col-' + ltrim(str(nGrid)) + ' '
	
	if !empty( cClass )
		cHtml += cClass 
	endif
	
	cHtml += '">' + CRLF 
	
	
	cHtml += '<small>' + cTitle + '</small>' + CRLF 
	cHtml += '</div>' + CRLF 
	
	::Html( cHtml )

RETU NIL


METHOD Separator( cId , cTitle, cClass ) CLASS TWebControl

	LOCAL cHtml 
	
	DEFAULT cId TO ''
	DEFAULT cClass TO ''
	
	cHtml := '<div '
	
	if !empty( cId )	
		cHtml += ' id="' + cId + '" ' 
	endif
	
	cHtml += 'class="col-12 form_separator '
	
	if !empty( cClass)
		cHtml += cClass 
	endif
	
	cHtml += '" ' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' + CRLF 
	
	
	DEFAULT cTitle TO ''
	
	cHtml += '<small>' + cTitle + '</small>' + CRLF 
	cHtml += '</div>' + CRLF 
	
	::Html( cHtml )

RETU NIL

METHOD Small( cId, cText, nGrid, cClass ) CLASS TWebControl
	LOCAL cHtml := ''
	local cIdPrefix
	
	DEFAULT cId	TO ''
	DEFAULT cText 	TO ''
	DEFAULT nGrid 	TO 6
	DEFAULT cClass 	TO ''
	
	if !empty( ::cId_Dialog )
		cIdPrefix :=  ::cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	
	
	cHtml := '<div class="col-' + ltrim(str(nGrid)) + IF( ::lDessign, ' tweb_dessign', '')  + ' '
	
	if !empty( cClass )
		cHtml += cClass 
	endif
	
	cHtml += '" ' + IF( ::lDessign, 'style="border:1px solid blue;"', '' )   + ' >' + CRLF 
	
	cHtml += '<small id="' + cIdPrefix + cId + '" class="text-muted" data-live >'	
	
	cHtml += cText
	cHtml += '</small>' + CRLF 
	cHtml += '</div>' + CRLF 	

	::Html( cHtml )		

RETU NIL

METHOD Echo() CLASS TWebControl

RETU ''