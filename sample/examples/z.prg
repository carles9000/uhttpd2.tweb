#include "lib/tweb/tweb.ch"

function main()

	LOCAL nId := 1000
	
	USE ( AppPathData() + 'test.dbf' ) SHARED NEW 
	
	cAlias := Alias()
	
	while (cAlias)->( !eof() )
	
		if (cAlias)->( Rlock() )
		
			(cAlias)->id := nId
		
			nId++
		
		endif 
	
		(cAlias)->( DbSkip() )
	end 
	
return 'Done!'

	
	
