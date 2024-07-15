//	-------------------------------------------------------------



CLASS TWebImage FROM TWebControl

	DATA cSrc						INIT ''
	DATA cBigSrc					INIT ''
	DATA cGallery					INIT ''
	DATA lZoom						INIT .t.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cSrc, cBigSrc, nGrid, cAlign, cClass, nWidth, cGallery, lNoZoom, cStyle, cProp, lHidden ) CLASS TWebImage

	DEFAULT cId TO ::GetId()
	DEFAULT cSrc TO ''
	DEFAULT cBigSrc TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''
	DEFAULT nWidth TO 0
	DEFAULT cGallery TO ''
	DEFAULT lNoZoom TO .F.
	DEFAULT cStyle TO ''
	DEFAULT cProp TO ''
	DEFAULT lHidden TO .F.
	
	::oParent 		:= oParent
	::cId			:= cId
	::cSrc			:= cSrc
	::cBigSrc		:= cBigSrc
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::nWidth 		:= nWidth
	::cGallery		:= cGallery
	::lZoom			:= !lNoZoom
	::cStyle 		:= cStyle 
	::cProp 		:= cProp 
	::lHidden 		:= lHidden


	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebImage

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

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) 
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_image' 

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif

	
	
	cHtml += '" '
	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid black;"', '' ) 		
	cHtml += ' data-group="' + cIdPrefix + ::cId   + '" >'
	
	cHtml += '<div class="input-group" '
	/*
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	
	*/
	
	cHtml += '>'
	
	if ( !empty( ::cBigSrc ) .or. ::lZoom  )
	
		if empty( ::cBigSrc ) 
			::cBigSrc = ::cSrc
		endif
		
		cHtml += '<a id="twebimg_' + ::cId + '" href="' + ::cBigSrc + '" '
		
		if  empty( ::cGallery ) 				
			cHtml += 'data-lightbox="twebimg_' + cIdPrefix + ::cId + '" '
		else 
			cHtml += 'data-lightbox="' + ::cGallery + '" '
		endif
		
		if !empty( ::uValue )
			cHtml += 'data-title="' + ::cCaption + '" '
		endif
		
		do case
			case ::cAlign == 'center' ; cHtml += ' style="margin:auto;" '
			case ::cAlign == 'right'  ; cHtml += ' style="margin-left:auto;" '
		endcase		
		
		cHtml += ' >'		
	
	endif

	
	cHtml += '<img id="' + cIdPrefix + ::cId + '" src="' + ::cSrc + '" class="rounded " '
	
	if !empty( ::nWidth )
	
		if valtype( ::nWidth ) == 'N'
			if ::nWidth > 0
				//cHtml += ' style="width:' + ltrim(str(::nWidth)) + 'px; '
				::cStyle += ';width:' + ltrim(str(::nWidth)) + 'px; '
			endif
		else
			::cStyle += ';width:' + ::nWidth + '; '
		endif
		
	endif
	
	IF ::lHidden
		::cStyle += 'display:none;'
	ENDIF		
	
	if !empty( ::cStyle )	
		cHtml += ' style="' + ::cStyle + '" '
	endif	

	if !empty( ::cProp )	
		cHtml += ' ' + ::cProp + ' ' 
	endif
		
	cHtml += ' alt="...">'
	
	if ( !empty( ::cBigSrc ) .or.  ::lZoom  )			
		cHtml += '</a>'
	endif	

	cHtml += '</div>'
	cHtml += '</div>'

RETU cHtml