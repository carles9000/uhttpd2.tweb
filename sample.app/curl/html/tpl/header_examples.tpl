<!--
	Parameters:
	1.- Title
	2.- Subtitle
-->


<div class="alert alert-dark form_title" style="overflow:hidden;height:56px;">
	<h4 style="margin:0px;cursor: pointer;" onClick="location.href='javascript:history.back();'" >
		<i class="fa fa-list-alt" aria-hidden="true"></i>
		{{ pvalue(1) }}		
		<span style="font-size:14px;">{{ pvalue(2) }}</span>
		<span style="font-size:14px;float: right;margin-top:20px;font-style: italic;">TWeb Version: {{ TWebVersion() }}</span>		
	</h4>
</div>