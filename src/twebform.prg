//	-------------------------------------------------------------

/*
	The Bootstrap grid system has four classes:

		xs (for phones - screens less than 768px wide)
		sm (for tablets - screens equal to or greater than 768px wide)
		md (for small laptops - screens equal to or greater than 992px wide)
		lg (for laptops and desktops - screens equal to or greater than 1200px wide)

	Controls
		form-group-sm/lg 	(get,select)
		btn-sm/lg			(button)	
*/



CLASS TWebForm FROM TWebControl


	DATA oWeb						INIT {}
//	DATA aControls					INIT {}
	DATA cId						INIT ''		
	DATA cId_Dialog				INIT ''		
	DATA cAction					INIT ''		
	DATA cMethod					INIT 'POST'
	DATA cApi						INIT ''
	DATA cProc						INIT ''
	DATA cType						INIT ''		//	sm, md, lg, xl, xs
	DATA cSizing					INIT ''		//	sm, lg
	DATA lFluid						INIT .F. 
	DATA lHttpd2Api				INIT .F. 
	DATA lActivated 				INIT .F. 

	METHOD New() 					CONSTRUCTOR	

	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD Html( cCode ) 			INLINE Aadd( ::aControls, cCode )
	METHOD Caption()
	METHOD Separator()
	METHOD Small()
	METHOD InitForm() 					
	METHOD Div() 					
	METHOD Col() 					
	METHOD Row() 					
	METHOD RowGroup() 					
	METHOD End() 					INLINE ::Html( '</div>' + CRLF  )				
	METHOD Activate()

	METHOD Echo()
	
	
ENDCLASS 

METHOD New( oWeb, cId, cAction, cMethod, cApi, cProc ) CLASS TWebForm		

	DEFAULT cId 	TO ''
	DEFAULT cAction TO ''
	DEFAULT cMethod TO 'POST'
	DEFAULT cApi TO ''
	DEFAULT cProc TO ''
	
	::oWeb 			:= oWeb
	::cId	 		:= cId
	::cId_Dialog	:= cId
	::cAction 		:= cAction
	::cMethod 		:= cMethod
	::cApi 			:= cApi
	::cProc 		:= cProc
	
	::oWeb:AddControl( SELF )

RETU SELF

METHOD InitForm( cClass ) CLASS TWebForm

	LOCAL cClassForm := IF( ::lFluid, 'container-fluid', 'container' )
	
	DEFAULT cClass TO ''

	::Html( '<div class="' + cClassForm + ' ' + cClass + '" ' + ;
			IF( ::lDessign, 'style="border:2px solid green;"', '' ) + ;
			IF( !empty( ::cId )  , ' id="' + ::cId + '" ', '' ) + ;
			IF( !empty( ::cApi ) , ' data-dialog data-api="' + ::cApi + '" ', '' ) + ;
			IF( !empty( ::cProc ), ' data-oninit="' + ::cProc + '" ', '' ) + ;
			'>' + CRLF   )
			
	if !empty( ::cId ) .and. !empty( ::cApi ) 
		::lHttpd2Api := .t.
	endif
	
	IF !empty( ::cAction )
	
		::Html( '<form action="' + ::cAction + '" method="' + ::cMethod + '">'  + CRLF  )
	
	ENDIF

	
RETU NIL

METHOD Col( nCol, cType, cClass ) CLASS TWebForm

	local cHtml := ''
	local cPrefix := IF( empty(::cType), '', ::cType + '-' )
	
	
	DEFAULT cType TO ''
	DEFAULT cClass TO ''	
	
	IF !Empty( cType )
		cPrefix := cType + '-' 	
	ELSE
		cPrefix := IF( empty(::cType), '', ::cType + '-' )
	ENDIF		
	
	DEFAULT nCol TO 12

	//	Si ponemos e- -sm, responsive y pone 1 debajo de otro...
	//::Html ( '<div class="col-sm-' + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )	
	
	cHtml := '<div class="col-' + cPrefix + ltrim(str(nCol)) 
	
	if !empty( cClass )
		cHtml += ' ' + cClass
	endif	
	
	cHtml += '" ' + IF( ::lDessign, 'style="border:1px solid blue;"', '' )
	
	cHtml += '>' + CRLF 
	
	//::Html ( '<div class="col-' + cPrefix + ltrim(str(nCol)) + '"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' ) + '>' )
	::Html ( cHtml )
	
RETU NIL

METHOD Div( cId, cClass ) CLASS TWebForm

	local cHtml := ''

	DEFAULT cId TO ''
	DEFAULT cClass TO ''

	cHtml += '<div id="' + cId + '" '
	
	if !empty( cClass )
		cHtml += ' class="' + cClass + '" '
	endif	
	
	if ::lDessign
		cHtml += ' style="border:1px solid red;" '
	endif
	
	cHtml += '>'  + CRLF 
	
	::Html( cHtml )
	
RETU NIL

METHOD Row( cId, cVAlign, cHAlign, cClass, cTop, cBottom ) CLASS TWebForm

	local cHtml := ''

	DEFAULT cId TO ''
	DEFAULT cVAlign TO 'center'
	DEFAULT cHAlign TO 'left'
	DEFAULT cClass TO ''
	DEFAULT cTop TO ''
	DEFAULT cBottom TO ''
	
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


METHOD RowGroup( cVAlign, cHAlign, cClass ) CLASS TWebForm

	local cHtml := ''

	DEFAULT cVAlign TO 'center'
	DEFAULT cHAlign TO 'left'
	DEFAULT cClass TO ''
	
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


	cHtml += '<div class="form-group row ' + cVAlign + ' ' + cHAlign 
	
	if !empty( cClass )
		cHtml += ' ' + cClass
	endif
	
	cHtml += '" ' + IF( ::lDessign, 'style="border:1px solid red;"', '' ) + ' >'  + CRLF 
	
	::Html( cHtml )
	
	
	
RETU NIL


METHOD Activate( fOnInit ) CLASS TWebForm

	LOCAL cHtml := ''
	LOCAL nI, c

	
	DEFAULT fOnInit TO ''
	
	IF !empty( ::cAction )
	
		::Html( '</form>' + CRLF)
	
	ENDIF	
	
	::Html( '</div>' + CRLF )

	if !empty( fOnInit ) 

		::Html( JSReady( fOnInit ) )	
	
	endif
	
	if ::lHttpd2API	
		/*
		cHtml += '<script>'
		cHtml += '$( document ).ready(function() {'		
		cHtml += '  UInitDialog("' + ::cId + '");'
		cHtml += '}); '
		*/
		c := 'UInitDialog("' + ::cId + '");'
		::Html( JSReady( c ) )
	endif 
	
	
	
	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()			
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT	
	
	


RETU cHtml



METHOD Caption( cTitle, nGrid, cClass ) CLASS TWebForm

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


METHOD Separator( cId , cTitle, cClass ) CLASS TWebForm

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

METHOD Small( cId, cText, nGrid, cClass ) CLASS TWebForm
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

METHOD Echo() CLASS TWebForm

RETU ''