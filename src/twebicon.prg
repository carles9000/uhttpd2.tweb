//	-------------------------------------------------------------

CLASS TWebIcon FROM TWebControl

	DATA cLink 						INIT '' 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cSrc, nGrid, cAlign, cClass, cFont, cLink, cStyle ) CLASS TWebIcon

	DEFAULT cId TO ::GetId()
	DEFAULT cSrc TO ''
	DEFAULT nGrid TO 1
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''	
	DEFAULT cFont TO ''
	DEFAULT cLink TO ''
	DEFAULT cStyle TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::cSrc			:= cSrc
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::cFont 		:= cFont
	::cLink 		:= cLink
	::cStyle 		:= cStyle

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebIcon

	LOCAL cHtml
	LOCAL cSize 	:= ''
	local cIdPrefix
	
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ;	cSize 		:= 'form-control-sm'			
		CASE upper(::oParent:cSizing) == 'LG' ;	cSize 		:= 'form-control-lg'			
	ENDCASE	
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif	

	cHtml := '<div id="' + cIdPrefix + ::cId + '" class="col-' + ltrim(str(::nGrid)) 
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_icon' 
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif		
	
	cHtml += '" '
	
	//cHtml += IF( ::oParent:lDessign, 'style="border:1px solid brown;"', '' )
	IF ::oParent:lDessign 
		::cStyle += "border:1px solid brown;"
	ENDIF

	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	

	cHtml += ' data-group="' + cIdPrefix + ::cId   + '" >'

	
	if !empty( ::cLink )
		cHtml += '<a href="' + ::cLink + '">'
	endif
	
	//cHtml += '<span id="' + ::cId + '">' + ::uValue + '</span>'
	cHtml += ::cSrc
	
	if !empty( ::cLink )
		cHtml += '</a>'
	endif	

	cHtml += '</div>'

RETU cHtml