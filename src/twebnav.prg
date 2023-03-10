//	-------------------------------------------------------------

CLASS TWebNav FROM TWebControl

	DATA cTitle						INIT 'App'
	DATA cLogo 						INIT '' 
	DATA cRoute						INIT '' 
	DATA nLogoWidth 				INIT 30
	DATA nLogoHeight				INIT 30 
	DATA aMenuItem 				INIT {}
	DATA lBurguerLeft				INIT .T.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	METHOD AddMenuItem( cItem, cLink, cAction, cIcon  )


ENDCLASS 

METHOD New( oParent, cId, cCaption, cLogo, nLogoWidth, nLogoHeight, cRoute, lBurguerLeft ) CLASS TWebNav

	DEFAULT cId TO ''
	DEFAULT cCaption TO ''
	DEFAULT cLogo TO ''
	DEFAULT nLogoWidth TO 30
	DEFAULT nLogoHeight TO 30
	DEFAULT cRoute TO ''
	DEFAULT lBurguerLeft TO .F.
	
	::oParent 		:= oParent
	::cId			:= cId
	::cTitle		:= cCaption
	::cLogo			:= cLogo
	::nLogoWidth	:= nLogoWidth
	::nLogoHeight	:= nLogoHeight
	::cRoute		:= cRoute
	::lBurguerLeft := lBurguerLeft 
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebNav

	LOCAL cHtml := ''
	local n, nLen 
	
	
/*
	<nav class="navbar navbar-dark bg-dark ">
	  <a class="navbar-brand" href="#">
		<img src="files/images/mini-mercury.png" width="30" height="30" alt="logo">
		Notes
	  </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-list" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbar-list">
		<ul class="navbar-nav">
		  <li class="nav-item active">
			<a class="nav-link" href="/">Home</a>
			<a class="nav-link" href="list">List</a>
		  </li>

		</ul>
	  </div>
	</nav>
*/	

	cHtml := '<nav class="navbar navbar-dark bg-dark ">'
	
	if ::lBurguerLeft
		cHtml += '<button class="navbar-toggler" type="button" style="margin-right: 10px;" data-toggle="collapse" data-target="#navbar-list" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">'
		cHtml += ' <span class="navbar-toggler-icon"></span>'
		cHtml += '</button>'
	endif
	
	cHtml += '<a class="navbar-brand mr-auto" href="' + ::cRoute + '">'
	
	if !empty( ::cLogo ) 
		cHtml += '<img src="' + ::cLogo + '" width="' + ltrim(str(::nLogoWidth)) + '" height="' + ltrim(str(::nLogoHeight)) + '" alt="logo">'
	endif
	
	cHtml += '<span id="nav_title" style="vertical-align: middle;" >' + ::cTitle + '</span>'
	cHtml += '</a>'
		
	nLen := len( ::aMenuItem ) 
	
	if nLen > 0 
	
		if ! ::lBurguerLeft
		
			cHtml += '<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-list" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">'
			cHtml += ' <span class="navbar-toggler-icon"></span>'
			cHtml += '</button>'		
		
		endif
	
		cHtml += '<div class="collapse navbar-collapse" id="navbar-list">'
		cHtml += '<ul class="navbar-nav">'
		cHtml += ' <li class="nav-item active">'
		
		for n := 1 to nLen 		
			//cHtml += '<a class="nav-link" href="' + ::aMenuItem[n][ 'link' ] + '">' 
			cHtml += '<a id="dummy" 		class="nav-link" ' 
			
			if !empty( ::aMenuItem[n][ 'link' ] )
				cHtml += ' href="' + ::aMenuItem[n][ 'link' ] + '" '
			elseif !empty( ::aMenuItem[n][ 'action' ] ) 
			
				if AT( '(', ::aMenuItem[n][ 'action' ] ) >  0 		//	Exist function ?
					cHtml += 'onclick="' + ::aMenuItem[n][ 'action' ] + '" '				
				else
					cHtml += ' data-live data-globalonclick="' + ::aMenuItem[n][ 'action' ] + '" '					
				endif			
				
			endif
			
			cHtml += ' >' 
		
			if !empty( ::aMenuItem[n][ 'icon' ])
				cHtml += ::aMenuItem[n][ 'icon' ] + '&nbsp;'
			endif 
			
			cHtml += ::aMenuItem[n][ 'item' ] + '</a>'		
		next			
	
		cHtml += ' </li>'
		cHtml += '</ul>'
		cHtml += '</div>'
	
		//	Review https://stackblitz.com/edit/bootstrap-navbar-submenu?file=index.html for submenus...
	endif
	
	

	cHtml += '</nav>'

RETU cHtml


METHOD AddMenuItem( cMenu, cLink, cIcon ) CLASS TWebNav

	hb_default( @cLink, '' )
	hb_default( @cIcon, '' )
	

	Aadd( ::aMenuItem, { 'item' => cMenu, 'link' => cLink, 'icon' => cIcon } )
	
RETU NIL 