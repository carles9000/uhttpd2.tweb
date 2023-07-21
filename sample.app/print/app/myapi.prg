#include 'harupdf.ch'

function myapi( oDom )

	
	do case

		case oDom:GetProc() == 'original' 	; DoOriginal( oDom )
		case oDom:GetProc() == 'rpt-1' 	; DoRpt1( oDom )
		case oDom:GetProc() == 'rpt-2' 	; DoRpt2( oDom )
				
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoOriginal( oDom )

	local cName 	:= 'original_' + ltrim(str( hb_milliseconds() ) ) + '.pdf'
	local cFile	:= AppPathReport() + cName
	local cUrlFile	:= AppUrlReport()  + cName	

    DesignHaruPDF( oDom, cFile )   

	if file( cFile )
		oDom:SetUrl( cUrlFile, '_blank' ) 
	else
		oDom:SetMsg( "Some problems in creating the PDF!" )
	endif	
	
retu nil 	

// --------------------------------------------------------- //

function DoRpt1( oDom )

	local oPrn 	:= InitPrn()
	local cName 	:= 'rpt1-' + ltrim(str( hb_milliseconds() ) ) + '.pdf'
	local cFile	:= AppPathReport() + cName
	local cUrlFile	:= AppUrlReport()  + cName
	local cLogo 	:= AppPathImages() + 'logo_report.png'	
	
	oPrn:StartPage()
		oPrn:CmSayBitmap( 0.5, 0.5, cLogo, 2.8, 2 )		
		oPrn:CmSay( 0.7 ,3.5, "Charly's motorcycle " + time(), oPrn:hFont[ 'title_logo' ] )
		oPrn:CmLine( 3,  0.5, 3, 20.5, 1 )
	oPrn:EndPage()
  
	oPrn:Save( cFile )
	oPrn:End()		

	oDom:SetUrl( cUrlFile, '_blank' ) 	

return nil  

// --------------------------------------------------------- //

function DoRpt2( oDom )

	local oPrn 		:= InitPrn()
	local cName 		:= 'rpt2-' + ltrim(str( hb_milliseconds() ) ) + '.pdf'
	local cFile		:= AppPathReport() + cName
	local cUrlFile		:= AppUrlReport()  + cName
	local cBackground 	:= AppPathImages() + 'template-1.png'	
	local cId 			:= oDom:Get( 'myid' )
	local lRules 		:= oDom:Get( 'rules' )
	local n, cAlias
	
	if val( cId ) == 0
		oDom:SetMsg( 'Id not valid' )
		retu nil
	endif
	
	USE 'data\cliente.dbf' SHARED NEW 
	cAlias := ALias()
	
	(cAlias)->( OrdSetFocus( 'ID_CLI' ) )
	
	if (cAlias)->( ! DbSeek( Val(cId), .F. ) )
		oDom:SetMsg( 'Id not found: ' +  cId )
		retu nil 
	endif
	
	
	oPrn:StartPage()
	
		oPrn:CmSayBitmap( 0.0, 0.0, cBackground, 21.3, 29.7 )

		if lRules
		
			for n := 1 to 29
				oPrn:CmLine( n, 0, n, 21 )
			next
			
			for n := 1 to 21
				oPrn:CmLine( 0, n, 29.7, n )
			next
			
		endif

		oPrn:CmSay( 8.5 	, 1 , "Id. " , oPrn:hFont[ 'helvetica16-bold' ] )		
		oPrn:CmSay( 9.5  	, 1 , "Name " , oPrn:hFont[ 'helvetica16-bold' ] )		
		oPrn:CmSay( 10.5 	, 1 , "Direction" , oPrn:hFont[ 'helvetica16-bold' ] )		
		
		oPrn:CmSay( 8.5 	, 4 , cId 					, oPrn:hFont[ 'helvetica16' ] )		
		oPrn:CmSay( 9.5 	, 4 , (cAlias)->nom_cli 	, oPrn:hFont[ 'helvetica16' ] )		
		oPrn:CmSay( 10.5   , 4 , (cAlias)->dir1 	  	, oPrn:hFont[ 'helvetica16' ] )
		
	oPrn:EndPage()
  
	oPrn:Save( cFile )
	oPrn:End()		

	oDom:SetUrl( cUrlFile, '_blank' ) 
	
	(cAlias)->( DbCloseArea() )
	

return nil  


// --------------------------------------------------------- //

function InitPrn()   

	local oPrn := TPdf():New()
   
	oPrn:LoadedFonts := { "Verdana" }
   
    oPrn:hFont[ 'helvetica24' ] 		:= oPrn:DefineFont( 'Helvetica', 24 )
    oPrn:hFont[ 'helvetica16' ] 		:= oPrn:DefineFont( 'Helvetica', 16 ) 
    oPrn:hFont[ 'helvetica16-bold' ] 	:= oPrn:DefineFont( 'Helvetica-Bold', 16 ) 
	
    oPrn:hFont[ 'helvetica12' ] 		:= oPrn:DefineFont( 'Helvetica', 12 )  
    oPrn:hFont[ 'helvetica12-bold' ] 	:= oPrn:DefineFont( 'Helvetica-Bold', 12 )  
	
    oPrn:hFont[ 'helvetica10' ] 		:= oPrn:DefineFont( 'Helvetica', 10 )  
    oPrn:hFont[ 'helvetica10-bold' ] 	:= oPrn:DefineFont( 'Helvetica-Bold', 10 ) 	
    
	oPrn:hFont[ 'times-bolditalic'] 	:= oPrn:DefineFont( 'Times-BoldItalic', 10 ) 
	
    oPrn:hFont[ 'helvetica08' ] 		:= oPrn:DefineFont( 'Helvetica', 8 )  
    oPrn:hFont[ 'helvetica08-bold' ] 	:= oPrn:DefineFont( 'Helvetica-Bold', 8 ) 	
 
    oPrn:hFont[ 'title_logo' ] 		:= oPrn:DefineFont( 'Times-Bold', 32 )  
    oPrn:hFont[ 'title_sublogo' ] 		:= oPrn:DefineFont( 'Times-BoldItalic', 16 )	
   
retu oPrn 

#include 'harupdf.prg'