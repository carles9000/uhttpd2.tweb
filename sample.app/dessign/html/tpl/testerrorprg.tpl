<body style="background-color:aliceblue;">
{{ time() }}
<div class="container-fluid">

Tomorrow: 
	<?prg
		local cHtml := DToC(date()+1)
		
		return cHtml
	?>
	
Value: 
	<?prg	
		#include 'error.ch'
		public n	:= 0
		

			A()
			B(
			
			cHtml := 'n = ' + ltrim(str(n))				
		
		retu cHtml 	
			
		function A()
			n:= 5
		retu nil 
		
		function B()
			n := n * 2
		retu nil 	
	?> 	

</div>	
</body>