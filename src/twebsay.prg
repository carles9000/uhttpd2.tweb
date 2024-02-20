//	-------------------------------------------------------------

CLASS TWebSay FROM TWebControl

	DATA cLink 						INIT '' 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cCaption, nGrid, cAlign, cClass, cFont, cLink, cStyle, cAction ) CLASS TWebSay

	DEFAULT cId TO ::GetId()
	DEFAULT cCaption TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cLink TO ''
	DEFAULT cStyle TO ''
	DEFAULT cAction TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= cCaption
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::cFont 		:= cFont
	::cLink 		:= cLink
	::cStyle		:= cStyle
	::cAction		:= cAction

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebSay

	LOCAL cHtml
	LOCAL cSize 	:= ''
	local cIdPrefix	
	local cGrid 

	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ;	cSize 		:= 'form-control-sm'			
		CASE upper(::oParent:cSizing) == 'LG' ;	cSize 		:= 'form-control-lg'			
	ENDCASE	
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif		

	//cHtml := '<div class="col-' + ltrim(str(::nGrid)) 
	
	if valtype( ::nGrid ) == 'N'
		cGrid := ltrim(str(::nGrid))
	else
		cGrid := ::nGrid	
	endif
	
	cHtml := '<div class="col-' + cGrid
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_say' 
	
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
	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid brown;"', '' ) 
	cHtml += ' data-group="' + cIdPrefix + ::cId   + '" >'	
	
	
	if !empty( ::cLink )
		cHtml += '<a href="' + ::cLink + '">'
		
	endif

	
	cHtml += '<span id="' + cIdPrefix + ::cId + '" '
	
	
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	
	
	if !empty( ::cAction )		
		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += 'onclick="' + ::cAction + '" '				
		else
			cHtml += ' data-onclick="' + ::cAction + '" '					
		endif
	endif 
	
	cHtml += ' data-live '
	
	cHtml += '>' + ::uValue + '</span>'
	
	if !empty( ::cLink )
		cHtml += '</a>'
	endif	

	cHtml += '</div>'

RETU cHtml