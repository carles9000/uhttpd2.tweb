#include "hbhrb.ch" 

function web_prg( oDom )

	do case
		case oDom:GetProc() == 'exe_prg'	; Exe_Prg( oDom )						
		case oDom:GetProc() == 'exe_clean' 	; oDom:Set('info','' )
					
		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function Exe_Prg( oDom )

	local cPrg 	:= oDom:Get( 'prg' )
	local cFile := hb_dirbase() + '/prgs/' + cPrg 
	local cInfo	:= ''	
	local uRet, cCode, oHrb, cExt, cHtml
	
_d( file( cFile ) )

	if file( cFile )
	
		cCode := hb_memoread( cFile )
		
		cExt 	:= lower( hb_fnameext( cFile ) )
		
		do case
			case cExt == '.prg'						
				
				oHrb := UCompile( cCode )
				
					IF ! Empty( oHrb )

					   //uRet := hb_hrbDo( hb_hrbLoad( HB_HRB_BIND_OVERLOAD, oHrb ), ap_Args()  )
						uRet := hb_hrbDo( hb_hrbLoad( HB_HRB_BIND_OVERLOAD, oHrb )  )
						_d( 'URET', uRet )
						
						
						if Valtype( uRet ) == 'C'
												
							cFile := hb_dirbase() + '/prgs/z.html' 
							hb_memowrit( cFile, uRet )
							oDom:SetUrl( '/prgs/z.html' )
							
						endif

					ENDIF		
	
			case cExt == '.html'															
				
				UReplaceBlocks( @cCode, "{{", "}}" )						
				
				cHtml := UInlinePrg( @cCode )					
												
					cFile := hb_dirbase() + '/prgs/z.html' 
					hb_memowrit( cFile, cHtml )
					oDom:SetUrl( '/prgs/z.html' )															
			
		endcase
	
	endif 
	
	oDom:Set( 'info', cFile )		
	
retu nil
