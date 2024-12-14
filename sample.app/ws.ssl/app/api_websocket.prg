#include 'hbsocket.ch' 

//	--------------------------------------------------------- //

function Api_Websocket( oDom )
	
	do case

		case oDom:GetProc() == 'my_process' 		; DoMy_Process( oDom )								
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

//	--------------------------------------------------------- //

function DoMy_Process( oDom )

	LOCAL n, n100 
		
	//	Init long proc...
	
		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Init process. Working...', 'bar' => 1 } )
		SecondsSleep( 2 )	//	Win_SysRefresh( 2000 )	
		
		n100 := 10
		
		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Start first process', 'bar' => n100 } )
		SecondsSleep( 2 )	
		
		n100 += 30
		
		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'First process finished. Preparing reporting...', 'bar' => n100 } )
		SecondsSleep( 2 )	
	
		for n := 1 to 20
			n100++
			oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Generating reporting ' + ltrim(str(n)), 'bar' => n100 } )
			SecondsSleep( 0.1 )			
		next	
		
		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Start second process', 'bar' => n100 } )
		SecondsSleep( 2 )		
		
		
		n100 += 20
		
		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Second process finished...', 'bar' => n100 } )
		SecondsSleep( 2 )	
		
		for n := 1 to 20
			n100++
			oDom:SendSocketJS( 'ShowProcess', { 'prompt' => 'Preparing output ' + ltrim(str(n)), 'bar' => n100 } )
			SecondsSleep( 0.1 )			
		next	

		oDom:SendSocketJS( 'ShowProcess', { 'prompt' => '<h4><b>Process finished successfull !</b></h4>', 'bar' => 100 } )		
		
	//	End Proc ----------------------	
	
	oDom:Set( 'btn', 'Execute' )
	oDom:Enable( 'btn' )	

return nil 

//	--------------------------------------------------------- //
