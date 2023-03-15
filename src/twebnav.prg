//	-------------------------------------------------------------

CLASS TWebNav FROM TWebControl

	DATA cTitle						INIT 'App'
	DATA cLogo 						INIT '' 
	DATA cRoute						INIT '' 
	DATA nLogoWidth 				INIT 30
	DATA nLogoHeight				INIT 30 
	DATA aMenuItem 				INIT {}
	DATA lBurguerLeft				INIT .T.
	DATA lSideBar					INIT .F.
	DATA cSideBarCode				INIT ''
	DATA cSide						INIT 'left'

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	METHOD AddMenuItem( cItem, cLink, cAction, cIcon  )
	METHOD AddMenuItemSeparator()
	METHOD DrawMenuItem()
	

	METHOD SideBar( cCode )		INLINE  ( ::lSideBar := .t., ::cSideBarCode += cCode )


ENDCLASS 

METHOD New( oParent, cId, cCaption, cLogo, nLogoWidth, nLogoHeight, cRoute, lBurguerLeft, lSidebar, cSide ) CLASS TWebNav

	DEFAULT cId TO ''
	DEFAULT cCaption TO ''
	DEFAULT cLogo TO ''
	DEFAULT nLogoWidth TO 30
	DEFAULT nLogoHeight TO 30
	DEFAULT cRoute TO ''
	DEFAULT lBurguerLeft TO .F.
	DEFAULT lSideBar TO .F.
	DEFAULT cSide TO 'left'
	
	::oParent 		:= oParent
	::cId			:= cId
	::cTitle		:= cCaption
	::cLogo			:= cLogo
	::nLogoWidth	:= nLogoWidth
	::nLogoHeight	:= nLogoHeight
	::cRoute		:= cRoute
	::lBurguerLeft := lBurguerLeft 
	::lSideBar 		:= lSideBar
	::cSide 		:= lower(cSide)
	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebNav

	LOCAL cHtml := ''
	local  nLen 
	
	
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

	nLen := len( ::aMenuItem ) 

	cHtml := '<nav class="navbar navbar-dark bg-dark ">'
	
	IF ::lBurguerLeft .and. ::lSideBar
		cHtml += '<button class="navbar-toggler btnsidebar" type="button" style="margin-right: 10px;" data-action="toggle" data-side="' + ::cSide + '" >'
		cHtml += ' <span class="navbar-toggler-icon"></span>'
		cHtml += '</button>'
	ELSEIF ::lBurguerLeft .and. nLen > 0
		cHtml += '<button class="navbar-toggler" type="button" style="margin-right: 10px;" data-toggle="collapse" data-target="#navbar-list" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">'
		cHtml += ' <span class="navbar-toggler-icon"></span>'
		cHtml += '</button>'
	ENDIF
	
	
	cHtml += '<a class="navbar-brand mr-auto" href="' + ::cRoute + '">'
	
	if !empty( ::cLogo ) 
		cHtml += '<img src="' + ::cLogo + '" width="' + ltrim(str(::nLogoWidth)) + '" height="' + ltrim(str(::nLogoHeight)) + '" alt="logo">'
	endif
	
	cHtml += '<span id="nav_title" style="vertical-align: middle;" >' + ::cTitle + '</span>'
	cHtml += '</a>'
	
	
		IF ! ::lBurguerLeft .and. ::lSideBar
			cHtml += '<button class="navbar-toggler btnsidebar" type="button" data-action="toggle" data-side="' + ::cSide + '" >'
			cHtml += ' <span class="navbar-toggler-icon"></span>'
			cHtml += '</button>'
		ELSEIF 	! ::lBurguerLeft .and. nLen > 0			
			cHtml += '<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-list" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">'
			cHtml += ' <span class="navbar-toggler-icon"></span>'
			cHtml += '</button>'
		ENDIF
	
	IF ::lSideBar
	
		cHtml += '<div class="sidebars">' 
		
		do case
			case ::cSide == 'left'
				cHtml += '  <div class="sidebar left" style="left: -99999px;">' 
			case ::cSide == 'right'
				cHtml += '  <div class="sidebar right" style="right: -99999px;">' 				
			otherwise
				cHtml += '  <div class="sidebar left" style="left: -99999px;">' 
		endcase
		
		
		cHtml += ::cSideBarCode
		
		cHtml += '<div class="menu-items">'
		cHtml += '<ul>'
		cHtml += ::DrawMenuItem()	
		cHtml += '</ul>'
		cHtml += '</div>'
		
		cHtml += '  </div>'
		cHtml += '</div>'
		
	ELSE  
	
		cHtml += '<div class="collapse navbar-collapse" id="navbar-list">'
		cHtml += '<ul class="navbar-nav">'		
		cHtml += ::DrawMenuItem()	
		cHtml += '</ul>'
		cHtml += '</div>'		
		
		
		
	ENDIF
	
	

	cHtml += '</nav>'
	
	IF ::lSideBar

		cHtml += '</div>'
	ENDIF

RETU cHtml


METHOD DrawMenuItem() CLASS TWebNav

	local nLen 	:= len( ::aMenuItem )
	local cHtml 	:= ''
	local oItem, n  
	local lMenu	:= .f.


	if nLen == 0
		retu ''
	endif
			
				
	for n := 1 to nLen 	
	
		oItem := ::aMenuItem[n]
		

		
		do case
		
			case oItem[ 'separator' ]
			
				cHtml += '<div class="dropdown-divider"></div>'	

			case oItem[ 'endmenu' ]
			
				lMenu := .f.
			
				cHtml += '	</div>'
				cHtml += '</li>'				
		
			case !oItem[ 'menu' ] .and. !oItem[ 'group' ] .and. !lMenu
			
				cHtml += '<li class="nav-item">'
				cHtml += '	<a class="nav-link '
				cHtml += if( oItem[ 'active'], 'item-active', '') + '" '
				cHtml += '	href="'
				
							if !empty( oItem[ 'link' ] )
								cHtml += oItem[ 'link' ]
							else
								cHtml += '#'
							endif
							
							cHtml += '" ' 
/*
							if ! empty( oItem[ 'action' ] ) 
					
								if AT( '(', oItem[ 'action' ] ) >  0 		//	Exist function ?
									cHtml += 'onclick="' + oItem[ 'action' ] + '" '				
								else
									cHtml += ' data-live data-globalonclick="' + oItem[ 'action' ] + '" '
								endif								
							endif 
*/
											
							cHtml += '>' 
							
							if !empty( oItem[ 'icon' ])
								cHtml += oItem[ 'icon' ] + '&nbsp;'
							endif 
							
				cHtml += oItem[ 'item' ] 
				cHtml += '  </a>'

				cHtml += '</li>'	

			case !oItem[ 'menu' ] .and. !oItem[ 'group' ] .and. lMenu		
				
				cHtml += '<a class="dropdown-item" href="'
				
					if !empty( oItem[ 'link' ] )
						cHtml += oItem[ 'link' ]
					else
						cHtml += '#'
					endif
				
				cHtml += '" >' 
				
				if !empty( oItem[ 'icon' ])
					cHtml += oItem[ 'icon' ] + '&nbsp;'
				endif 				
				
				cHtml += oItem[ 'item' ] 												
				cHtml += '</a>'
				
			
			case oItem[ 'menu' ] .and. !oItem[ 'group' ]
			
				lMenu := .t.
			
				cHtml += '<li class="nav-item dropdown">'
				cHtml += '  <a class="nav-link dropdown-toggle ' 
				cHtml += if( oItem[ 'active'], 'item-active', '') + '" '
				cHtml += '  href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
				
							if !empty( oItem[ 'icon' ])
								cHtml += oItem[ 'icon' ] + '&nbsp;'
							endif 
							
				cHtml += oItem[ 'item' ] 						
							
				cHtml += '  </a>'						 
				cHtml += '<div class="dropdown-menu tweb_submenu" aria-labelledby="navbarDropdown">'
				

			
			
			case !oItem[ 'menu' ] .and. oItem[ 'group' ]
			
				cHtml += '<li class="header-menu"><span>' + oItem[ 'item' ] + '</span></li>'

			
		endcase	
	
	next


RETU cHtml 

METHOD AddMenuItem( cMenu, cLink, cIcon, cAction, lMenu, lEndMenu, lGroup, lSeparator, lActive ) CLASS TWebNav

	hb_default( @cMenu, '' )
	hb_default( @cLink, '' )
	hb_default( @cIcon, '' )
	hb_default( @cAction, '' )
	hb_default( @lMenu, .F. )
	hb_default( @lEndMenu, .F. )
	hb_default( @lGroup, .F. )	
	hb_default( @lSeparator, .F. )	
	hb_default( @lActive, .f. )	

	Aadd( ::aMenuItem, { 'item' => cMenu, 'link' => cLink, 'action' => cAction, 'icon' => cIcon, 'menu' => lMenu, 'endmenu' => lEndMenu, 'group' => lGroup, 'separator' => lSeparator, 'active' => lActive } )
	
RETU NIL 

METHOD AddMenuItemSeparator() CLASS TWebNav	

	Aadd( ::aMenuItem, { 'item' => '', 'link' => '', 'action' => '', 'icon' => '', 'menu' => .f., 'endmenu' => .f., 'group' => .f., 'separator' => .T., 'active' => .f. } )
	
RETU NIL 