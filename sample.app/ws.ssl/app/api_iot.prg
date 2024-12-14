#include 'hbsocket.ch' 

#xcommand TRY  => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS

//	--------------------------------------------------------- //

function Api_IOT( oDom )
	
	do case
							
		case oDom:GetProc() == 'my_iot' 			; DoMy_IOT( oDom )						
		case oDom:GetProc() == 'my_iot_stop' 		; DoMy_IOT_Stop( oDom )						
		case oDom:GetProc() == 'cpu' 				; Cpu( oDom )						
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

//	--------------------------------------------------------- //

function DoMy_IOT( oDom )

	LOCAL aData := {}
	LOCAL aResponse := {}		
	LOCAL n, hData 
	
	oDom:WSSetCargo(.T. )	
	
	while oDom:WSGetCargo() == .T.

		aResponse := {}
	
		//	Dummy ------------------------------------
			hData := { 'sensor' => 'dummy', 'values' => nil }	
			
			Aadd( aResponse, hData )
		
		//	Meter ------------------------------------
			aData := array(4)
			aData[ 1 ] := hb_randint( 1, 100 )
			aData[ 2 ] := hb_randint( 1, 100 )
			aData[ 3 ] := hb_randint( 1, 100 )
			aData[ 4 ] := hb_randint( 1, 100 )
		
			hData := { 'sensor' => 'meter', 'values' => aData }	

			Aadd( aResponse, hData )
			
		//	Helix ------------------------------------
			aData := array(6)
			aData[ 1 ] := hb_randint( 1, 5 )
			aData[ 2 ] := hb_randint( 1, 5 )
			aData[ 3 ] := hb_randint( 1, 5 )				
			aData[ 4 ] := hb_randint( 1, 5 )				
			aData[ 5 ] := hb_randint( 1, 5 )				
			aData[ 6 ] := hb_randint( 1, 5 )				
		
			hData := { 'sensor' => 'helix', 'values' => aData }	

			Aadd( aResponse, hData )				
			
		//	Volume ----------------------------------
			aData := array(6)
			aData[ 1 ] := hb_randint( 100, 1000 )
			aData[ 2 ] := hb_randint( 100, 1000 )
			aData[ 3 ] := hb_randint( 100, 1000 )
			aData[ 4 ] := hb_randint( 100, 1000 )
			aData[ 5 ] := hb_randint( 100, 1000 )
			aData[ 6 ] := hb_randint( 100, 1000 )
		
			hData := { 'sensor' => 'volume', 'values' => aData }	

			Aadd( aResponse, hData )			

		//	System ----------------------------------
			aData := array(5)			
			aData[ 1 ] := hb_randint( 50, 99 )
			aData[ 2 ] := hb_randint( 50, 99 )
			aData[ 3 ] := hb_randint( 50, 99 )
			aData[ 4 ] := hb_randint( 50, 99 )
			aData[ 5 ] := hb_randint( 50, 99 )				
		
			hData := { 'sensor' => 'system', 'values' => aData }	
			
			Aadd( aResponse, hData )	
			
		//	CPU ----------------------------------
			aData := array(1)
			aData[ 1 ] := hb_randint( 5, 20 )																
			
			hData := { 'sensor' => 'cpu', 'values' => aData }					

			Aadd( aResponse, hData )		

		//	Harbour  ---------------------------
		
			aData := array(1)
			aData[ 1 ] := 'Harbour ' + time() + ' - '  + ltrim(str(hb_milliseconds())) + ' => ' + ltrim(str(hb_randint( 5, 60 )))
			
			hData := { 'sensor' => 'log', 'values' => aData }					

			Aadd( aResponse, hData )				
		
		//	Circle  ---------------------------
			aData := array(4)
			aData[ 1 ] := hb_randint( -3, 3 )																
			aData[ 2 ] := hb_randint( -3, 3 )																
			aData[ 3 ] := hb_randint( -3, 3 )																
			aData[ 4 ] := hb_randint( -3, 3 )																
			
			hData := { 'sensor' => 'circle', 'values' => aData }					

			Aadd( aResponse, hData )				
		
		//	Response...
	
			oDom:SendSocketJS( 'ListenIOT', aResponse )
			SecondsSleep( 0.5 )
		
	end 

retu ''

//	--------------------------------------------------------- //

function DoMy_IOT_Stop( oDom )
	
	oDom:WSSetCargo( .F. )

	oDom:SetJS( 'CloseAll(true)' )

retu nil 

//	--------------------------------------------------------- //

function Cpu( oDom )

    LOCAL  oLoc 		:=  CreateObject( "wbemScripting.SwbemLocator" )
    LOCAL  objWMI 		:= oLoc:ConnectServer()
    LOCAL 	hAppInfo 	:= {=>}
    LOCAL	oError, oDatos, oJbs, cHtml 

	TRY
		oJbs := objWMI:ExecQuery("SELECT * FROM Win32_Processor")
		
		FOR EACH oDatos IN oJbs
			hAppInfo['cpu_usage'] := Alltrim(hb_CStr(oDatos:LoadPercentage))
			hAppInfo['cpu_name'] := Alltrim(hb_CStr(oDatos:Name))
			hAppInfo['cpu_cores'] := Alltrim(hb_CStr(oDatos:NumberOfCores))
			hAppInfo['cpu_threads'] := Alltrim(hb_CStr(oDatos:NumberOfLogicalProcessors))
		NEXT
		
	CATCH oError
	
		hAppInfo['cpu_usage'] := '0'
		hAppInfo['cpu_name'] := ''
		hAppInfo['cpu_cores'] := '0'
		hAppInfo['cpu_threads'] := '0'
		
	END		

	cHtml := 'CPU Usage: ' + hAppInfo['cpu_usage'] + '%' + '<br>'
	cHtml += 'Name: ' + hAppInfo['cpu_name'] + '<br>'
	cHtml += 'Cores: ' + hAppInfo['cpu_cores'] + '<br>'
	cHtml += 'Threads: ' + hAppInfo['cpu_threads'] 
	
	oDom:SetMsg( cHtml )
	
retu nil 