//	-------------------------------------------------------------

CLASS TWebRadio FROM TWebControl

	DATA lInline					INIT .F.
	DATA aItems						INIT {}
	DATA aValues					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, aItems, aValues, nGrid, cAction, lInline, cClass, cFont   ) CLASS TWebRadio

	DEFAULT cId TO ''
	DEFAULT uValue TO ''	
	DEFAULT aItems TO {}
	DEFAULT aValues TO {}
	DEFAULT nGrid TO 4
	DEFAULT cAction TO ''
	DEFAULT lInline TO .F.
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''	

	::oParent 		:= oParent	
	::cId			:= cId
	::uValue		:= uValue	
	::aItems 		:= aItems	//IF( valtype( aItems ) == 'A', aItems, {} )
	::aValues		:= aValues	//IF( valtype( aValues ) == 'A' .AND. len( aValues ) == len( aItems ), aValues, aItems )
	::nGrid			:= nGrid
	::cAction		:= cAction
	::lInline		:= lInline
	::cClass 		:= cClass
	::cFont 		:= cFont	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebRadio

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	LOCAL nI, cIdPrefix	
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif
	
	//IF lValue
		//cChecked := 'checked=false'
		cChecked := ''
	//ENDIF	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' custom-control " ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	
	FOR nI := 1 TO len( ::aItems )
	
		cHtml += '<div class="custom-control custom-radio ' + IF( ::lInline, 'custom-control-inline', '' ) + '">'
		cHtml += '	<input type="radio" class="custom-control-input tweb_pointer" id="' + cIdPrefix + ::cId + '_' + ltrim(str(ni)) + '" name="' +  cIdPrefix + ::cId  + '" value="' +  ::aValues[nI] + '" ' + IF( ::lDisabled, 'disabled', '' )
		
		IF !empty( ::cAction )
			if AT( '(', ::cAction ) >  0 		//	Exist function ?
				cHtml += ' onchange="' + ::cAction + '" '
			else
				cHtml += ' data-live data-onchange="' + ::cAction + '" '
			endif 
			
		ENDIF		
		//cHtml += ' 	onchange="' + ::cAction + '" ' 
		
		IF ::uValue == ::aValues[nI] 
			cHtml += ' checked '					
		ENDIF		
		
		
		cHtml += '  >' 
		cHtml += '	<label class="custom-control-label tweb_pointer '
		
			if !empty( ::cClass )	
				cHtml += ' ' + ::cClass
			endif
			
			if !empty( ::cFont )	
				cHtml += ' ' + ::cFont
			endif

			cHtml += '" '		

		cHtml += '	for="'  + cIdPrefix + ::cId + '_' + ltrim(str(ni)) + '" >' + ::aItems[nI] + '</label>' 
		cHtml += '</div>' 
		
	NEXT	

	cHtml += '</div>'

RETU cHtml