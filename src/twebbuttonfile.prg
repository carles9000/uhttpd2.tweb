//	-------------------------------------------------------------

CLASS TWebButtonFile FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA cConfirm	 				INIT ''
	DATA lOutline 					INIT .T.
	DATA lSubmit					INIT .F.

	DATA lMultiple					INIT .F.
	

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cLabel, cName, cAction, cValue, nGrid, cAlign, cIcon, lDisabled, lSubmit, cClass, cFont, nWidth, cConfirm, cStyle, cProp, lMultiple ) CLASS TWebButtonFile

	DEFAULT cId TO ::GetId()
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''	
	DEFAULT cName TO ''
	DEFAULT cValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cIcon TO ''		// '<i class="fas fa-check"></i>'
	DEFAULT cClass TO 'btn-warning'				
	DEFAULT lDisabled TO .F.				
	DEFAULT lSubmit TO .F.				

	DEFAULT cClass TO ''
	DEFAULT cFont TO ''		
	
	DEFAULT nWidth TO ''
	DEFAULT cConfirm TO ''
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lMultiple TO .f.
	
	
	if empty( cClass ) 
		cClass := if( ::lOutline, 'btn btn-warning' , 'btn-primary')	
	endif
	

	::oParent 		:= oParent
	::cId			:= cId
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cLabel 		:= cLabel
	::cAction 		:= cAction
	
	::cName			:= cName
	::uValue		:= cValue
	::cClass		:= cClass
	::cIcon			:= cIcon
	::lDisabled	:= lDisabled
	::lSubmit		:= lSubmit

	::cClass 		:= cClass
	::cFont 		:= cFont	
	
	::nWidth 		:= nWidth
	::cConfirm 		:= cConfirm
	::cStyle 		:= cStyle
	::cProp			:= cProp 
	::lMultiple		:= lMultiple

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebButtonFile

	LOCAL cHtml := ''
	LOCAL cSize := ''
	LOCAL cType := 'button'
	LOCAL cIdPrefix
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'btn-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'btn-lg'
	ENDCASE
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif
	
	IF ::lSubmit
		cType := 'submit'
	ENDIF	


	IF empty( ::cName )
		::cName := ::cId
	ENDIF


	cHtml += '<div class="col-' + ltrim(str(::nGrid)) 
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '')  
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase	
	
		
	cHtml += '" ' 

	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )
	cHtml += '>'
	
	cHtml += '<input type="file" id="_' + cIdPrefix + ::cId + '" style="display:none;" '
	
	IF !empty( ::cAction )

		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += 'onchange="' + ::cAction + '" '				
		else
			cHtml += ' data-onchange="' + ::cAction + '" '					
		endif	
	ENDIF
	
	cHtml += IF( ::lMultiple, ' multiple ', '')
	
	//cHtml += ' data-live '
	cHtml += ' data-live >'

	cHtml += '<button type="' + cType + '" '
	
	cHtml += 'id="' + cIdPrefix + ::cId + '" name="' + ::cName + '" value="' + ::uValue + '" ' 
	
	cHtml += 'class="btn ' + cSize 
	
	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	

	
	cHtml += '" ' 
	
	if !empty( ::nWidth )		
		::cStyle += 'width: '  + ::nWidth + '; '
	endif
	
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	

	if !empty( ::cProp )	
		cHtml += ' ' + ::cProp + ' ' 
	endif
		
	cHtml += ' data-live '
	
	if !empty( ::cConfirm )
		cHtml += ' data-confirm="' + ::cConfirm + '" '
	endif 
	

	
	cHtml += ' onclick="TDoClick(' + "'_" + cIdPrefix + ::cId + "' )" + '" ' 

	cHtml += IF( ::lDisabled, 'disabled', '' ) + ' >' 
	cHtml += ::cIcon + ::cLabel
	cHtml += '</button>'
	cHtml += '</div>'
	

RETU cHtml