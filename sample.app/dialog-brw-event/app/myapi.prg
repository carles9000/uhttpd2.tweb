#xcommand TRY  => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS

/*
* myapi
*/
function myapi( oDom )	
	
	do case
		case oDom:GetProc() == 'dlg'  ; DoDialogo( oDom )
		case oDom:GetProc() == 'test' ; UIsMobile( oDom )
		case oDom:GetProc() == 'testpdto' ; testpdto( oDom )
				
		otherwise
			oDom:SetError( 'Proc no existe: ' + oDom:GetProc() )
	endcase

return oDom:Send()
/*********/

/*
* DoDialogAdd
*/
function DoDialogo( oDom )
	local cHtml
	local o 	:= {=>}
	local hParams := {=>}	

	o[ 'backdrop' ] 	:= .f.	// .f. el usuario no podrá cerrarla haciendo clic fuera de la misma	
	o[ 'className' ] 	:= 'no-animation' // quitar la animación
	o[ 'onEscape' ] 	:= .f. 	// .t. permite cerrar la ventana modal con tecla esc
	o[ 'title' ] 			:= 'Buscar clientes'
	o[ 'size' ] 			:= '50%'
	
	cHtml := ULoadHtml( 'search.html' )	
	oDom:SetDialog( 'dlgsearchcustomer', cHtml, nil, o)
	
return nil
/*********/

/*
* UIsMobile
*/
function UIsMobile( oDom )
	local cHtml
	local c := UServer()['HTTP_USER_AGENT']
  local s := '/Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/'
		
	if len( HB_RegEx( s, c ) ) > 0
		//oDom:Console( 'Estás en un dispositivo móvil')
		//cHtml := ULoadHtml( 'mobile.html' )
			URedirect( 'mobile' )
	else
		//oDom:Console( 'NO estás en un dispositivo móvil')
		//cHtml := ULoadHtml( 'desktop.html' )
		URedirect( 'desktop' )
	endif

return nil
/*********/

/*
* testpdto
*/
function testpdto( oDom )
	oDom:Console('estoy en función testpdto')
return nil
/*********/