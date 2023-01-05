#include "../lib/tweb/tweb.ch" 

function DoList()

    LOCAL o, oWeb, oNav, hOptions, oBrw, oRow, oCol
	LOCAL aRows := {}
	
	//	Recover data...
	
	use ( 'data\notes.dbf' ) shared new via 'DBFCDX'
	
	DbGoTop()
	
	while ! eof()
	
		Aadd( aRows, { 'date' => field->date, 'alias' => field->alias, 'note' => field->note } )
	
		dbskip()
	end	
	
	//	Dessign screen...

	DEFINE WEB oWeb TITLE 'List' 
	
		NAV oNav ID 'nav' TITLE '&nbsp;Notes' LOGO "files/images/mini-mercury.png" ;
			ROUTE '/' WIDTH 30 HEIGHT 30 OF oWeb

			MENUITEM 'Home' 	ICON '<i class="fa fa-home" aria-hidden="true"></i>' ROUTE '/'	OF oNav
			MENUITEM 'Notes' 	ICON '<i class="fa fa-list" aria-hidden="true"></i>' ROUTE 'notes' 			OF oNav
			

		DEFINE FORM o OF oWeb
			o:lDessign 	:= .f.
			o:lFluid 	:= .t.
			//o:cClass 	:= 'p-0'
			
		INIT FORM o  
		
			ROWGROUP o 	
				
				COL o GRID 12
				
					//	https://tabulator.info/docs/5.4/options
				
					hOptions := { ;
						'height' => '300px',	;	
						'data' => aRows		;						
					}															
					
					DEFINE BROWSE oBrw ID 'mytable' OPTIONS hOptions TITLE '<h5>Notes list</h5>' OF o 
						
						//	https://tabulator.info/docs/5.4/columns 
						
						COL oCol TO oBrw CONFIG { 'title' => "Date", 'field' => "date"  }
						COL oCol TO oBrw CONFIG { 'title' => "Alias", 'field' => "alias"}
						COL oCol TO oBrw CONFIG { 'title' => "Note", 'field' => "note" }
						
					INIT BROWSE oBrw 
			
				ENDCOL o				
				
			ENDROW o			
		
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil 
