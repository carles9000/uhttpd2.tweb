<!-- Template Splash -------------------------------

	Parameters:
	1.- Logo file
	2.- Route when click logo
	3.- Background color
-->

<body style="background-color:{{ if( pvalue(3) == NIL, '#7e94a7;', pvalue(3) ) }}">

<div class="container-fluid">
	
	<div style="margin-top:30%" align="center">
		<img id="logo" class="logo" src="{{ pvalue(1) }}" >							
	</div>

	<?prg 
		local cHtml  := ''
		local cRoute := pvalue(2)
		
		if valtype( cRoute ) == 'C'
		
			cHtml := "<script>"
			cHtml += "  $( '#logo' ).on( 'click', function(){"
			cHtml += "     window.location.assign( '" + cRoute + "' );"
			cHtml += "	})"
			cHtml += "</script>"
			
		endif
		
		retu cHtml
	?>
	
</div>	
</body>