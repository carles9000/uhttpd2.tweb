function myapi( oDom )

	
	do case

		case oDom:GetProc() == 'run' 		; DoRun( oDom )
		
		//	WEB SOCKETS...
		
		case oDom:GetProc() == 'ws_init'		; UWS_Init( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 


//	WEBSOCKETS ----------------------------------

function DoRun( oDom )

	//	Init long proc...
	
		oDom:SendSocket( 'console', 'Init process...' )
		oDom:SendSocketJS( 'MyTest', { 'id' => 'myform-mystatus', 'value' => 'Init process...' } )
		SecondsSleep( 2 )	//	Win_SysRefresh( 2000 )
		
		oDom:SendSocket( 'console', 'First proccess ready !' )
		oDom:SendSocketJS( 'MyTest', { 'id' => 'myform-mystatus', 'value' => 'First proccess ready !' } )
		SecondsSleep( 2 )	

		oDom:SendSocket( 'console', 'Second proccess ready !' )
		oDom:SendSocketJS( 'MyTest', { 'id' => 'myform-mystatus', 'value' => 'Second proccess ready !' } )
		SecondsSleep( 2 )	

		oDom:SendSocket( 'console', 'Third proccess ready !' )
		oDom:SendSocketJS( 'MyTest', { 'id' => 'myform-mystatus', 'value' => 'Third proccess ready !' } )
		SecondsSleep( 2 )		
		
		oDom:SendSocket( 'console', 'Proccess Ok !' )
		oDom:SendSocketJS( 'MyTest', { 'id' => 'myform-mystatus', 'value' => 'Proccess Ok !' } )
		
	//	End Proc ----------------------
	
	
	oDom:Set( 'btn', 'Init Long Proccess!' )
	oDom:Enable( 'btn' )	

return nil 
