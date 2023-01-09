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

		//	url("https://placeimg.com/1000/480/nature")
		
		HTML oWeb
			<style>
				.jumbotron{
					background: url("images/bg-head-02.jpg") no-repeat center center; 
					background-size: 100% 100%;
					border-radius: 0px;
				}
				
				.container h3, h5 {
					text-shadow: 2px 2px #ffffff;;				
				}				
			</style>			
		
		ENDTEXT 
	
		DEFINE FORM o OF oWeb
			
			Banner(o)

		INIT FORM o  		
		
			HTML o 
				<div class="alert alert-success">				
					<img src="../files/images/tweb.png"/><strong> Success!</strong> Indicates a successful or positive action.
				</div>
			ENDTEXT		
		
			HTML o INLINE '<h3>Test Html</h3><hr>'
			
		ENDFORM o
	
	INIT WEB oWeb RETURN
	
retu nil

function Banner( o )
	
	HTML o
		<div class="jumbotron">
			<div class="container">
				<h1><a href="">Friends of Uhttpd2</a></h1>
				<h3>Uhttpd2 group project.</h3>
				<h5>Html code example</h5>
			</div>
		</div>
	ENDTEXT			

retu nil