<!--
	TEMPLATE...: BtnBar
	
	Parameter 1: Array ( id, label, data-onclick, onclick )	
-->
	
<?prg 
	local cHtml := ''
	local aBtns	:= pvalue(1)
	local nLen  := len( aBtns )
	local n
	
	cHtml += '<div class="form-group">'
	cHtml += ' <div class="btn-group">'
	
	for n := 1 to nLen 
	
		cHtml += '<button type="button" id="' + aBtns[n][ 1 ] + '" class="btn btn-outline-dark" '
		
		if valtype( aBtns[n][3] ) == 'C'
			cHtml += 'data-onclick="' + aBtns[n][3]  + '" >' 
		else
			if valtype( aBtns[n][4] ) == 'C'
				cHtml += 'onclick="' + aBtns[n][4]  + '" >' 
			endif
		endif

		cHtml += aBtns[n][2] 
		cHtml += '</button>'

	next 
	
	cHtml += ' </div>'
	cHtml += '</div>'
	
	retu cHtml 
?>