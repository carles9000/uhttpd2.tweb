//	-------------------------------------------------------------

CLASS TWebButton FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA cConfirm	 				INIT ''
	DATA lOutline 					INIT .T.
	DATA lSubmit					INIT .F.
	DATA cLink						INIT ''
	DATA lFiles						INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cLabel, cAction , cName, cValue, nGrid, cAlign, cIcon, lDisabled, lSubmit, cLink, cClass, cFont, lFiles, nWidth, cConfirm, cStyle ) CLASS TWebButton

	DEFAULT cId TO ::GetId()
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	DEFAULT cName TO ''
	DEFAULT cValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cIcon TO ''		// '<i class="fas fa-check"></i>'
	DEFAULT cClass TO 'btn-primary'				
	DEFAULT lDisabled TO .F.				
	DEFAULT lSubmit TO .F.				
	DEFAULT cLink TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''		
	DEFAULT lFiles TO .F.
	DEFAULT nWidth TO ''
	DEFAULT cConfirm TO ''
	DEFAULT cStyle TO ''
	
	if empty( cClass ) 
		cClass := if( ::lOutline, 'btn-outline-primary' , 'btn-primary')	
	endif
	

	::oParent 		:= oParent
	::cId			:= cId
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cLabel 		:= cLabel
	::cAction		:= cAction	
	::cName			:= cName
	::uValue		:= cValue
	::cClass		:= cClass
	::cIcon			:= cIcon
	::lDisabled		:= lDisabled
	::lSubmit		:= lSubmit
	::cLink			:= cLink
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::lFiles 		:= lFiles
	::nWidth 		:= nWidth
	::cConfirm 		:= cConfirm
	::cStyle 		:= cStyle

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )		
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebButton

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

	IF !empty( ::cLink )
		::cAction := "location.href='" + ::cLink + "' "
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
	
	if ::lFiles 
	
		cHtml += '<input type="file" id="' + cIdPrefix + ::cId + '" style="display:none;" />'
	
	endif
	
	
	
	cHtml += '<button type="' + cType + '" '
	//cHtml += 'id="' + cIdPrefix + ::cId + '" '  
	cHtml += 'class="btn ' + cSize 
	
	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	

	/*
	if ::nGrid > 0
		cHtml += ' col-' + ltrim(str(::nGrid))
	endif
	*/
	
	cHtml += '" ' 
	
	if !empty( ::nWidth )
		// cHtml += 'style="width: '  + ::nWidth + '; " '
		::cStyle += 'width: '  + ::nWidth + '; '
	endif
	
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	
		
	cHtml += ' data-live '
	
	if !empty( ::cConfirm )
		cHtml += ' data-confirm="' + ::cConfirm + '" '
	endif 
	
	IF !empty( ::cAction )

		if AT( '(', ::cAction ) >  0 		//	Exist function ?
			cHtml += 'onclick="' + ::cAction + '" '				
		else
			cHtml += ' data-onclick="' + ::cAction + '" '					
		endif	
	ENDIF
		
	if ::lFiles
		cHtml += 'id="_' + cIdPrefix + ::cId + '" name="_' + ::cName + '" value="' + ::uValue + '" ' 
	else
		cHtml += 'id="' + cIdPrefix + ::cId + '" name="' + ::cName + '" value="' + ::uValue + '" ' 
	endif
	
	cHtml += IF( ::lDisabled, 'disabled', '' ) + ' >' 
	cHtml += ::cIcon + ::cLabel
	cHtml += '</button>'
	cHtml += '</div>'

	

RETU cHtml