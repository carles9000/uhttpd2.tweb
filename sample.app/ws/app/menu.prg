#include 'lib\tweb\tweb.ch'

function Menu( oWeb, cCrumbs )

	local oNav

	NAV oNav ID 'nav' TITLE '&nbsp;WebSockets SSL' LOGO 'files/images/mini-mercury.png' ;
		ROUTE '/' WIDTH 30 HEIGHT 30 OF oWeb		
		
	//	Sidebar

		MENU GROUP 'Examples' OF oNav		

			MENUITEM 'Progress task'  		ICON '<i class="fa fa-database" aria-hidden="true"></i>' ROUTE 'progress'  ACTIVE ( cCrumbs == 'Progress' ) OF oNav
	
		ENDMENU GROUP OF oNav	

retu nil
	