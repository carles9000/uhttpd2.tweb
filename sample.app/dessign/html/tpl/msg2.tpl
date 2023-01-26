<!--
	TEMPLATE...: Message Alert
	
	Parameter 1: Message text
	Parameter 2: Alert type: success, danger, dark,... (Optional. Default Success)
				 https://getbootstrap.com/docs/4.0/components/alerts/
	Parameter:3: Icon. (Optional. Default mini-mercury ) 	
-->


<div class="alert alert-{{ if( empty(pvalue(2)), 'success', pvalue(2) ) }} form_title" style="box-shadow: 5px 5px 5px;border-radius: 10px !important;" role="alert">
	<h5 style="margin:0px;">
		
		<?prg 
			local cHtml := ''
			
			if empty( pValue(3) )
				cHtml := '<img src="files/images/mini-mercury.png" style="width:40px;"></img>'
			else
				cHtml := '<img src="' + pvalue(3) + '" style="width:40px;"></img>'
			endif
			
			cHtml += '&nbsp;'
			
			retu cHtml 
		?>
		
		<span style="vertical-align:middle;">{{ pvalue(1) }}</span>
		
	</h5>
</div>