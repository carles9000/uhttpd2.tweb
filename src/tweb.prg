/*
**  tweb.prg -- TWeb library form mod harbour
**
** (c) Carles Aubia, 2019-2024
** Developed by Carles Aubia Floresvi carles9000@gmail.com
** MIT license https://github.com/carles9000/tweb.uhttpd2/blob/master/LICENSE
*/

#define TWEB_VERSION 			'1.3'

#include 'hbclass.ch'	
#include 'common.ch'
#include 'error.ch'

//	----------------------------------------------------------


#define CRLF 					Chr(13)+Chr(10)

#xcommand TRY  => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS	

#xcommand DEFAULT <uVar1> := <uVal1> ;
               [, <uVarN> := <uValN> ] => ;
                  If( <uVar1> == nil, <uVar1> := <uVal1>, ) ;;
                [ If( <uVarN> == nil, <uVarN> := <uValN>, ); ]

//	----------------------------------------------------------
#include 'twebcontrol.prg'
#include 'twebform.prg'
#include 'twebsay.prg'
#include 'twebfont.prg'
#include 'twebget.prg'
#include 'twebgetnumber.prg'
#include 'twebgetmemo.prg'
#include 'twebimage.prg'
#include 'twebcheckbox.prg'
#include 'twebbutton.prg'
#include 'twebbuttonfile.prg'
#include 'twebswitch.prg'
#include 'twebradio.prg'
#include 'twebbox.prg'
#include 'twebselect.prg'
#include 'twebicon.prg'
#include 'twebfolder.prg'
#include 'twebnav.prg'
#include 'twebcommon.prg'
#include 'twebbrowse.prg'
#include 'twebdialog.prg'
#include 'twebunicode.prg'
#include 'twebcard.prg'
#include 'twebaccordion.prg'
#include 'twebpanel.prg'
#include 'twebprogress.prg'

//#include 'mc_prepro.prg'
//#include 'mh.prg'
//	----------------------------------------------------------


function TWebVersion() ; RETU TWEB_VERSION


CLASS TWeb

	DATA lTables					INIT .F.
	DATA cTitle		 			
	DATA cIcon 						
	DATA cLang						INIT 'en' 						
	DATA cPathTpl  				INIT '' 						
	DATA cRootRelative				INIT '' 	
	DATA cCharset					INIT 'UTF-8'	//	'ISO-8859-1'	
	DATA lActivated					INIT .F.
	DATA lHeader					INIT .T.
	DATA aInclude					INIT {}
	DATA aControls					INIT {}

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	METHOD AddControl( uValue )		INLINE Aadd( ::aControls, uValue )
	METHOD Html( cCode ) 				INLINE Aadd( ::aControls, cCode )
	METHOD AddJs( cFile, lAbsolute ) 	
	METHOD AddCss( cFile, lAbsolute ) 	

ENDCLASS 

METHOD New( cTitle, cIcon, lTables, cCharset,  cPathTpl ) CLASS TWeb

	DEFAULT cTitle 			TO 'TWeb'
	//DEFAULT cIcon 			TO __TWebGlobal[ 'url_tweb' ] + 'images/tweb.png'
	DEFAULT lTables			TO .F.
	DEFAULT cCharSet		TO 'UTF-8' 		//	'ISO-8859-1'
	
	//DEFAULT cIcon 			TO HB_Dirbase() + 'files\tweb\images\tweb.png'
	DEFAULT cIcon 			TO 'files/tweb/images/tweb.ico'
	DEFAULT cPathTpl 		TO HB_Dirbase() + 'files\tweb\tpl\'
	
	::cTitle 	:= cTitle
	::cIcon 	:= cIcon	
	::lTables	:= lTables
	::cCharSet	:= cCharset 
	::cPathTpl 	:= cPathTpl
	
RETU SELF

METHOD Activate() CLASS TWeb

	local cHtml 	:= ''
	local cTpl		:= ''
	local nI 
	
	IF ::lActivated
		retu nil
	ENDIF	
	
	if ::lHeader

		cHtml   := '<!DOCTYPE html>' + CRLF
		cHtml 	+= '<html lang="' + ::cLang + '">' + CRLF
		cHtml 	+= '<head>' + CRLF
		cHtml 	+= '<title>' + ::cTitle + '</title>' + CRLF
		cHtml	+= '<meta charset="' + ::cCharset + '">' + CRLF			
		cHtml 	+= '<meta http-equiv="X-UA-Compatible" content="IE=edge">' + CRLF
		cHtml 	+= '<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">' + CRLF	
		cHtml 	+= '<link rel="shortcut icon" type="image/png" href="{{ hb_GetEnv( "ROOTRELATIVE") }}' + ::cIcon + '"/>' + CRLF
		
		//cHtml   += hb_memoread( ::cPathTpl + 'libs.tpl' ) + CRLF 		

		cHtml 	+= hb_memoread( ::cPathTpl + 'libs.tpl' ) + CRLF 				
		
		FOR nI := 1 To len( ::aInclude )	
	
			cHtml += ::aInclude[ nI ] + CRLF 
		next				
		
		hb_SetEnv( "ROOTRELATIVE", ::cRootRelative )

		UReplaceBlocks( @cHtml, "{{", "}}" )
		
	endif
		
	
	::lActivated := .T.	
	
	FOR nI := 1 To len( ::aControls )	
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()						
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT		
	
	cHtml += JSReady( 'SetTWeb()' ) 

RETU cHtml

METHOD AddJs( cFile, lAbsolute ) CLASS TWeb

	hb_default( @lAbsolute, .f. )
	
	if lAbsolute
		Aadd( ::aInclude, '<script src="' + cFile + '"></script>')		
	else 		
		Aadd( ::aInclude, '<script src="{{ hb_GetEnv( "ROOTRELATIVE") }}' + cFile + '"></script>' )		
	endif
	
RETU NIL

METHOD AddCss( cFile, lAbsolute ) CLASS TWeb

	hb_default( @lAbsolute, .f. )
	
	if lAbsolute
		Aadd( ::aInclude, '<link rel="stylesheet" href="' + cFile + '">' )		
	else 
		Aadd( ::aInclude, '<link rel="stylesheet" href="{{ hb_GetEnv( "ROOTRELATIVE") }}' + cFile + '">' )		
	endif
	
RETU NIL


function JS( cCode ) 

	local cHtml := ''

	DEFAULT cCode TO ''

	cHtml 	+= "<script type='text/javascript'>"
	cHtml 	+= 		cCode	
	cHtml 	+= "</script>"
	
retu cHtml


function JSReady( cCode, cLog ) 

	local cEcho := ''

	DEFAULT cCode TO ''
	DEFAULT cLog TO ''

	cEcho  = "<script type='text/javascript'>"
	cEcho += "  $( document ).ready(function() {"
	
	if !empty( cLog )
		cEcho += "console.info( 'info', '" + cLog + "' );"
	endif
	
	cEcho += 		cCode  + ';'
	cEcho += "  })"
	cEcho += "</script>"
	
retu cEcho

//	------------------------------------------------------------------------------

function TWebHtmlInline( cFile, ... )

	local cCode := ''	

	cCode := ULoadHtml( cFile, ... )
	
retu cCode 



//	------------------------------------------------------------------------------

function TWebParameter( uValue )

	local cType := valtype( uValue )
	
	thread static aParam 
	
	DO CASE
	
		CASE cType == 'A'
		
			if valtype( uValue[1] ) == 'H'
				aParam := uValue[1]
			else
				aParam := uValue 
			endif				
			
		CASE cType == 'N'		//	Buscar elemento de array
		
			if valtype( aParam ) == 'A'
			
				if uValue > 0  .and. uValue <= len( aParam )
					retu aParam[ uValue ]
				else
					retu '*** Index error ' + ltrim(str(uValue)) + ' ***'
				endif
			
			endif

		CASE cType == 'C'		//	Buscar key in Hash
		
			HB_HCaseMatch( aParam, .F. ) 
		
			if HB_HHasKey( aParam, uValue ) 
				retu aParam[ uValue ]
			else
				retu '*** Index hash error: ' + uValue + ' ***'
			endif	

		otherwise 
		
			//retu _w( aParam )
			
	endcase
	
retu ''

//	------------------------------------------- //
// Get id FORM 

function UIdFormParent( oParent, lReturnObject )

	local cId_Dialog 	:= ''
	local lFound 		:= .f.
	local o
	
	hb_default( @lReturnObject, .f. )
	
	if valtype( oParent ) != 'O'
		if lReturnObject
			retu nil
		else
			retu cId_Dialog
		endif
	endif

	if oParent:classname() == 'TWEBFORM' 
		if lReturnObject
			retu oParent
		else
			retu oParent:cId_Dialog 
		endif
	endif

	
		//	aData := __objGetMsgList( o, .T. )
		
	//	We're looking for a TWEBFORM. We need cId_Dialog
							
		o := oParent
		
		while __objHasData( o, 'OPARENT' ) .and. !lFound 
		
			o := o:oParent
			
			if valtype( o ) == 'O' .and. o:ClassName() == 'TWEBFORM'
			
				lFound 			:= .t.
				cId_Dialog 	:= o:cId_Dialog
				
			endif	

		end 

		
retu if( lReturnObject, if( lFound, o, nil ), cId_Dialog )

//	------------------------------------------- //
//	Get Object FORM 
function UOFormParent( oParent ) 
retu UIdFormParent( oParent, .t. )



//	------------------------------------------------------------------------------

function mh_valtochar( u ) 
retu HB_VALTOSTR( u )
//retu _w( u )