function myapi( oDom )

	//_d( oDom:getall() ) 
	//oDom:SetAlert( oDom:getproc() )	
	//oDom:SetAlert( oDom:get( 'myid' ) )	

	do case		
		
		case oDom:GetProc() == 'getid'	; DoGetId( oDom )
		case oDom:GetProc() == 'info'	; DoInfo( oDom )
		case oDom:GetProc() == 'about'	; DoAbout( oDom )
		case oDom:GetProc() == 'accept'	; DoAccept( oDom )

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc() )
	endcase				

retu oDom:Send() 

function DoGetId( oDom )

	//	oDom:SetAlert( oDom:get( 'myid' ) )
	
	local nId 	:= Val( oDom:Get( 'myid' ))
	local cDbf	:= AppPathData() + 'products.dbf'
	local cCdx	:= AppPathData() + 'products.cdx'
	local hRow	:= {=>}
	local cAlias
	

	use ( cDbf ) shared new via 'DBFCDX'
	SET INDEX TO (cCdx)
	
	cAlias := Alias()
	
	if (cAlias)->( DbSeek( nId ) )
	
		//oDom:SetAlert( 'Si')
		
		
		hRow[ 'name' ] 	:= alltrim((cAlias)->name)
		hRow[ 'image' ] := AppPathImages() + alltrim((cAlias)->image)
		hRow[ 'type' ] 	:= alltrim((cAlias)->type)
		hRow[ 'pvp' ] 	:= (cAlias)->pvp
		hRow[ 'active' ]:= (cAlias)->active
		
		oDom:Set( 'mymsg', '' )
	
	else 
	
		
		hRow[ 'name' ] 	:= ''
		hRow[ 'image' ] := ''
		hRow[ 'type' ] 	:= ''
		hRow[ 'pvp' ] 	:= 0
		hRow[ 'active' ]:= .f.
	
		//oDom:SetAlert( 'No')
		oDom:Set( 'mymsg', "<b>Error</b><br>Code doesn't exist!" )		
	
	endif 
	
	oDom:Set( 'name', hRow[ 'name' ] )
	oDom:Set( 'image', hRow[ 'image' ] )
	oDom:Set( 'type', hRow[ 'type' ] )
	oDom:Set( 'pvp', hRow[ 'pvp' ] )
	oDom:Set( 'active', hRow[ 'active' ] )

	oDom:Console( hRow )

retu nil 

function DoInfo( oDom )

	local cId 	:= oDom:Get( 'myid' )
	local cInfo	:= "<b>" + cId + "</b> es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen."
	
	
	oDom:SetAlert( cInfo, 'Product Info' )

retu nil 


function DoAbout( oDom )

	local cInfo := '<b>Version</b> 1.0'
	
	cInfo += '<br><b>Uhttpd2</b> ' + UVersion()
	cInfo += '<br><b>TWeb</b> ' + Twebversion()

	oDom:SetAlert( cInfo, 'About' )
	
retu nil 

function DoAccept( oDom )


	oDom:SetUrl( 'screen2' )
	//oDom:SetUrl( 'https://google.com' )
	
retu nil 