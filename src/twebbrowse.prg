//	-------------------------------------------------------------

CLASS TWebBrowse FROM TWebControl

	DATA aCols 						INIT {}
	DATA aData 						INIT {}
	DATA aEvents					INIT {}
	DATA aFilter					INIT {}
	DATA cFilter_Id				INIT ''
	DATA hOptions					INIT {=>}
	DATA cLabel						INIT ''
	DATA lAll						INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	
	METHOD AddCol( h )
	METHOD SetOptions( h )		INLINE ::hOptions :=  h 
	METHOD Init( aData ) 


ENDCLASS 

METHOD New( oParent, cId, hOptions, aEvents, aFilter, cFilter_Id, cLabel, lAll, cClass, cStyle, lHidden ) CLASS TWebBrowse

	DEFAULT cId TO ''	
	DEFAULT hOptions TO {=>}
	DEFAULT aFilter TO {}
	DEFAULT cFilter_Id TO ''	
	DEFAULT cLabel TO ''
	DEFAULT lAll TO .F.
	DEFAULT cClass TO ''
	DEFAULT cStyle TO ''
	DEFAULT lHidden TO .F.

	::oParent		:= oParent
	::cId			:= cId	
	::hOptions		:= hOptions
	::aEvents		:= aEvents
	::aFilter		:= aFilter
	::cFilter_Id	:= cFilter_Id
	::cLabel 		:= cLabel		
	::lAll 			:= lAll
	::cClass 		:= cClass
	::cStyle 		:= cStyle
	::lHidden 		:= lHidden 
	
	IF Valtype( oParent ) == 'O'
	
		oParent:AddControl( SELF )
	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebBrowse

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	local cIdPrefix, n, nPos 
	LOCAL aNewFilter := {}
	local cSt 		:= ''

	//	Check Filter...
	
		for n := 1 to len( ::aFilter )
		
			// Podemos tener una columna sin field p.e.
			// 	COL oCol TO oBrw CONFIG { 'formatter' => "rowSelection", 'align' => "center", 'headerSort' => .F. }			

			nPos := Ascan( ::aCols, {|x| hb_hhaskey(x, 'field' ) .and. x[ 'field' ] == ::aFilter[n] } )
			
			if nPos > 0
			
				Aadd( aNewFilter, { ::aFilter[n],  ::aCols[nPos][ 'title'] } )
			
			endif
			
		next

	//	--------------------
	
	if !empty( ::oParent:cId_Dialog )
		cIdPrefix :=  ::oParent:cId_Dialog + '-'
	else
		cIdPrefix :=  ''
	endif

	cHtml := '<div class="card '
	
	if !empty( ::cClass )	
		cHtml += ::cClass
	endif		
	
	cHtml += '" ' 
	
	cSt := 'style="' 
	IF ::lHidden
		cSt += 'display:none;'
	ENDIF		
	
	IF ::oParent:lDessign
		cSt += "border:1px solid blue;"
	ENDIF
	
	cHtml += cSt + '" >'
	
	if !empty( ::cLabel )
		cHtml += '<div id="' + cIdPrefix + ::cId + '_title' + '" class="card-header">' + ::cLabel + '</div>'
	endif

	
	if !empty( aNewFilter ) .and. empty( ::cFilter_Id )	
		::cFilter_Id := '_filter'
		cHtml += '  <div id="' + cIdPrefix + ::cFilter_Id + '" class="card-header"></div>'
	
	endif		
	
	cHtml += '  <div id="' + cIdPrefix + ::cId + '" data-live class="card-body--- tabulator" '
	
	if ::lAll
		cHtml += '  data-all '
	endif
	cHtml += '>'
	
	cHtml += ' </div>'
	
	cHtml += '</div>'
	


	
	cHtml += '<script>'
	cHtml += '$( document ).ready(function() {'
	
	//cHtml += ' console.log( ' + hb_jsonEncode( ::aCols, .T. ) + '); '		
	
	cHtml += ' var aCols =  ' + hb_jsonEncode( ::aCols, .T. ) + "; "		
	cHtml += ' var Options =  ' + hb_jsonEncode( ::hOptions, .T. ) + "; "	
	
	cHtml += " Options[ 'columns' ] = aCols;  "
	cHtml += ' UTabulatorValidOptions( Options ); '
	
	if !empty( ::aEvents )
		cHtml += ' var aEvents =  ' + hb_jsonEncode( ::aEvents, .T. ) + "; "
	else
		cHtml += " var aEvents = null; "
	endif	
	
	
	if !empty( ::aData )
		cHtml += ' var aData =  ' + hb_jsonEncode( ::aData, .T. ) + "; "			
		cHtml += " Options[ 'data' ] = aData;  "
	endif
	
	if !empty( aNewFilter ) .and. !empty( ::cFilter_Id )				
		cHtml += ' var oFilter = new Object(); '
		cHtml += " oFilter[ 'id']     = '" + cIdPrefix + ::cFilter_Id  + "'; "
		cHtml += " oFilter[ 'fields'] = " + hb_jsonEncode( aNewFilter, .T. ) + "; "	
	else
		cHtml += ' var oFilter =  null; '	
	endif 
	
	cHtml += " var o = new UTabulator( '" + cIdPrefix + ::cId  + "' ); "	
	cHtml += " o.Init( Options, aEvents, oFilter ); "
	
	cHtml += '}) '
	cHtml += '</script>'				
	

RETU cHtml

METHOD AddCol( h ) CLASS TWebBrowse

	Aadd( ::aCols, h )

RETU NIL

METHOD Init( aData ) CLASS TWebBrowse

	hb_default( @aData, {} )
	
	if !empty( aData )
		::aData := aData 
	endif


RETU NIL 