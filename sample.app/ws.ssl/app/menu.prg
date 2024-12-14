#include 'lib\tweb\tweb.ch'

function Menu( oWeb, cCrumbs )

	local oNav

	NAV oNav ID 'nav' TITLE '&nbsp;WebSockets SSL' LOGO 'files/images/mini-mercury.png' ;
		ROUTE '/' WIDTH 30 HEIGHT 30 OF oWeb		
		
	//	Sidebar

		MENU GROUP 'Examples' OF oNav
		
			MENUITEM 'Basic commands' 		ICON '<i class="fa fa-list" aria-hidden="true"></i>' ROUTE 'basic'     ACTIVE ( cCrumbs == 'Basic' ) OF oNav 
			MENUITEM 'Error Connecting' 	ICON '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>' ROUTE 'error'     ACTIVE ( cCrumbs == 'Error' ) OF oNav 
			MENUITEM 'Progress task'  		ICON '<i class="fa fa-database" aria-hidden="true"></i>' ROUTE 'progress'  ACTIVE ( cCrumbs == 'Progress' ) OF oNav
			MENUITEM 'Simple Chat'    		ICON '<i class="fa fa-comments" aria-hidden="true"></i>' ROUTE 'chat'      ACTIVE ( cCrumbs == 'Chat' ) OF oNav
			MENUITEM 'Dashboard IoT'  		ICON '<i class="fa fa-home" aria-hidden="true"></i>' ROUTE 'dashboard' ACTIVE ( cCrumbs == 'Dashboard' ) OF oNav
	
		ENDMENU GROUP OF oNav	
		
		MENU GROUP 'System' OF oNav
			MENUITEM 'Monitor' 			ICON '<i class="fa fa-list" aria-hidden="true"></i>' ROUTE 'monitor'     ACTIVE ( cCrumbs == 'Monitor' ) OF oNav 
		ENDMENU GROUP OF oNav	
		
		
retu nil
	