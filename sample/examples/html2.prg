#include "lib/tweb/tweb.ch"

function main()

    LOCAL o, oWeb
	LOCAL cHtml := ''	
	
	DEFINE WEB oWeb TITLE 'Test Html' 
	
	//	We need to specify the relative root path
	//	The reason is that being an index directory ( "\examples" ) and executing html/prg directly, 
	//	the system needs to know where the root path is.
	
		oWeb:cRootRelative = '../'		
		
	//	--------------------------------------------------------------------------------------------	
		
		HTML oWeb
			<style>
	
				.my_img { 
					float:left;
					margin-left: 10px;
				}

				.my_img img {
				   width: 40px !important;
				}
			</style>		
		
		ENDTEXT 		
	
	
		DEFINE FORM o OF oWeb

			HTML o 
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb bg-dark ">
					<li class="breadcrumb-item"><a class="text-success" href="#">Home</a></li>
					<li class="breadcrumb-item"><a class="text-warning" href="#">Library</a></li>
					<li class="breadcrumb-item active" aria-current="page">Data</li>
				  </ol>
				</nav>
			ENDTEXT		
			
			/*	bg-info
				bg-primary
				bg-secondary
				bg-dark
				...
			*/
			
			HTML o 		
				<!--<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top mynav">-->
				<nav class="navbar- navbar-expand-lg- navbar-dark- bg-white ">			  				
				
					<nav aria-label="breadcrumb">
					<div class="my_img">
						<a class="navbar-brand " href="#" onclick="Info()">
							<img src="../files/images/tweb.png" alt="Logo" >						
						</a>
					</div>
					  <ol class="breadcrumb bg-white ">
						<li class="breadcrumb-item"><a class="text-success" href="#">Home</a></li>
						<li class="breadcrumb-item"><a class="text-warning" href="#">Library</a></li>
						<li class="breadcrumb-item active" aria-current="page">Data</li>
					  </ol>
					</nav>

				</nav>
			
			ENDTEXT								
			
			
		INIT FORM o  

			HTML o 		
				<!--<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top mynav">-->
				<nav class="bg-dark ">			  				
						
					<nav aria-label="breadcrumb">
						<div class="my_img">
							<a class="navbar-brand " href="#" onclick="Info()">
								<img src="../files/images/tweb_white.png" alt="Logo" >						
							</a>
						</div>
						<ol class="breadcrumb bg-dark ">
							<li class="breadcrumb-item"><a  class="text-white" href="#">Home</a></li>
							<li class="breadcrumb-item"><a  class="text-white" href="#">Library</a></li>
							<li class="breadcrumb-item active " aria-current="page">Data</li>
						</ol>
					</nav>

				</nav>
			
			ENDTEXT				
			
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil
