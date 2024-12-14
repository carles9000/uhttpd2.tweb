//	---------------------------------------------------------------------------- //
var _TWebIdDlg = 0

function MsgInfo( cMsg, fCallback, cTitle, cIcon ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-info-circle"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = String(cMsg)
	
	//	Check animations -> https://codepen.io/ghimawan/pen/vXYYOz?editors=0010#0
	//						https://codepen.io/ghimawan/pen/vXYYOz	
	
	var dialog = bootbox.dialog({
		title: cIcon + '&nbsp;' + cTitle,
		message: cMsg,
		size: 'medium',
		backdrop: false,
		onEscape: true, 
		className: 'animated fadeIn',
		buttons: {
			confirm: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-outline-success',
				callback: function(result) {									
					if ( typeof fCallback === "function") {					
						fCallback.apply(null, [result] );
					}
				}
			}
		}
	});
	
	dialog.on("shown.bs.modal", function() {
		_TWebIdDlg++
		dialog.attr("id", "TWebIdDlg" +  _TWebIdDlg );
	});
	
	dialog.init(function(){
		dialog.bind('shown.bs.modal', function(){
			//$('.modal-content').draggable()														
		});	
	})	

	return dialog
}

//----------------------------------------------------------------------------//

function MsgError( cMsg, fCallback, cTitle, cIcon ) {

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'System Error' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-bug"></i>' ;

	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = '&nbsp;'
	
	var dialog = bootbox.dialog({
		title: cIcon + '&nbsp;' + cTitle,
		message: cMsg,
		size: 'large',
		backdrop: false,
		onEscape: true, 		
		className: 'animated fadeIn',
		buttons: {
			cancel: {
				label: '<i class="fa fa-check"></i> Accept',
				className: 'btn-danger',
				callback: function( result ){
				
					if ( typeof fCallback === "function") {					
						fCallback.apply(null, [result] );
					}				
				}
			}
		}
	});
	
	return dialog
}

//	---------------------------------------------------------------------------- //

function MsgGet( cInput, fCallback, cTitle, cIcon ) {


	if ( typeof fCallback !== "function") {	
		MsgError( 'MsgGet need fCallback' )
		
		console.trace( 'Error MsgGet(). I need fcallback' )
		return null
	}

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-info-circle"></i>' ;
	
	if ( typeof cInput !== 'string' ||( typeof cInput == 'string' && cInput.length == 0 ))
		cInput = String(cInput)
	
	//	Check animations -> https://codepen.io/ghimawan/pen/vXYYOz?editors=0010#0
	//						https://codepen.io/ghimawan/pen/vXYYOz	
	
	var dialog = bootbox.prompt({
		title: cIcon + '&nbsp;' + cTitle,
		value: cInput,
		size: 'medium',
		backdrop: false,
		onEscape: true, 
		className: 'animated fadeIn',
		callback: function(result) {
	
			if ( typeof result == 'string' )
				fCallback.apply(null, [result] );			
		}					
	});
	
	return dialog
}

//	---------------------------------------------------------------------------- //

function MsgYesNo( cMsg, fCallback, cTitle, cIcon ){

	if ( typeof fCallback !== "function") {	
		MsgError( 'MsgYesNo need fCallback' )
		
		console.trace( 'Error MsgYesNo(). I need fcallback' )
		return null
	}

	cTitle 	= (typeof cTitle ) == 'string' ? cTitle : 'Information' ;
	cIcon 	= (typeof cIcon ) == 'string' ? cIcon : '<i class="fas fa-info-circle"></i>' ;
	
	if ( typeof cMsg !== 'string' ||( typeof cMsg == 'string' && cMsg.length == 0 ))
		cMsg = '&nbsp;'


	var dialog = bootbox.confirm({
		title: cIcon + ' ' + cTitle,
		message: cMsg,
		buttons: {
			cancel: {
				label: '<i class="fa fa-times"></i> Cancel'
			},
			confirm: {
				label: '<i class="fa fa-check"></i> Confirm'
			}
		},
		callback: function (result) {		
			
			if ( result ) {					
				fCallback.apply(null, [result] );
			}
		}
	});	
	
	return dialog

}

//	---------------------------------------------------------------------------- //

function MsgServer( cUrl, fCallback, oValues) {	
	
	var oPar = TValuesToParam( oValues )		
		/*
			//	If don't exist fcalback, then we send oValues via Submit Post, not AJAX 

			if ( typeof fCallback !== "function") {	
			
				TWeb_Redirect( cUrl, oValues )
			
				return null
			}
		*/
	
	$.post( cUrl, oPar )		
	
		.done( function( data ) { 	
	
			if ( typeof fCallback == "function") {	
				fCallback.apply(null, [data] );							
			}
			 
		})
		.fail( function(data){ 
			console.log( 'FAIL', data )
			MsgError( data.responseText ) 
		})
}

//	---------------------------------------------------------------------------- //

function TValuesToParam( oValues ) {
	
	var cType 	= $.type( oValues )
	var oPar 	= new Object()
		
	switch ( cType ) {
	
		case 'object':
			oPar[ 'type' ] = 'H'
			oPar[ 'value' ] = JSON.stringify( oValues ) 	
			break;
			
		case 'string':
				
			oPar[ 'type' ] = 'C'
			oPar[ 'value' ] = oValues	
			break;	
			
		case 'boolean':
				
			oPar[ 'type' ] = 'L'
			oPar[ 'value' ] = oValues	
			break;	

		case 'number':
				
			oPar[ 'type' ] = 'N'
			oPar[ 'value' ] = oValues	
			break;			
			
		default:
		
			oPar[ 'type' ] = 'U'
			oPar[ 'value' ] = oValues;				
	}

	return oPar 
}

//	---------------------------------------------------------------------------- //

/*	Icons Animated
  "fas fa-spinner fa-spin"
  "fas fa-circle-notch fa-spin"
  "fas fa-sync fa-spin"
  "fas fa-cog fa-spin"
  "fas fa-spinner fa-pulse"
  "fas fa-stroopwafel fa-spin"
*/

var _TWebMsgLoading = null

function MsgLoading( cMessage, cTitle, cIcon, lHeader ) {



	//	If cMessage == false , close MsgLoading is it was opened
	
		if ( cMessage == false || ( $.type( cMessage ) == 'array' && cMessage.length == 1 && cMessage[0] == false )) {
			if ( $.type( _TWebMsgLoading ) == 'object' ) {

				//	No funciona bien. De momento cerraremos todas...
				//_TWebMsgLoading.modal( 'hide' );
				//_TWebMsgLoading = null																
				
				_TWebMsgLoading.modal( 'hide' );
				_TWebMsgLoading = null				
				
				//bootbox.hideAll();
		
			}
			return false		
		}
		
	//	--------------------------------------------------------


	cMessage 	= (typeof cMessage ) == 'string' ? cMessage : 'Loading...' ;
	cTitle 		= (typeof cTitle ) == 'string' ? cTitle : 'System' ;
	cIcon 		= (typeof cIcon ) == 'string' ? '<i class="' + cIcon + '"></i>': '<i class="fas fa-sync fa-spin"></i>' ;
	lHeader		= (typeof lHeader ) == 'boolean' ? lHeader : false ;

	_TWebMsgLoading = bootbox.dialog({
			id: 'zzzz',
			title: cTitle,
			message: '<p id="msgloading">' + cIcon + '&nbsp;&nbsp;'  + cMessage + '</p>',
			animate: false,							
			//closeButton: false
		}); 

	_TWebMsgLoading.addClass("loading_center");
	_TWebMsgLoading.find("div.modal-content").addClass("loading_content");
	_TWebMsgLoading.find("div.modal-body").addClass("loading_body");																

	if ( ! lHeader )
		_TWebMsgLoading.find("div.modal-header").addClass("loading_header");																
		
	return _TWebMsgLoading
}


//	MsgNotify ------------------------------------------------------------------	
//	cType = 	success, info, danger, warning
//	Examples -> http://bootstrap-growl.remabledesigns.com/
/*
	NEW VERSION --> files\tweb\notify

function MsgNotify( cMsg, cType, cIcon, lSound ) {

	cType  = ( $.type(cType) == 'string' ) ? cType : 'info';
	cIcon  = ( $.type( cIcon )== 'string' ) ? cIcon : '';
	lSound = ( $.type( lSound )== 'boolean' ) ? lSound : false;	

	$.notify( { icon: cIcon, message: cMsg }, { type: cType, icon_type: 'image' } );

}
*/

//	---------------------------------------------------------------------------- //

function TDoClick( cId ){ $('#' + cId).click() }

//	---------------------------------------------------------------------------- //

function TWebIntro( cId, fFunction ) {

	$("#" + cId ).on('keyup', function (e) {
		if (e.key === 'Enter' || e.keyCode === 13) {
			if ( typeof fFunction === "function") {					
				fFunction.apply(null);
			}		
		}
	});
}

//	---------------------------------------------------------------------------- //

function TWebDefault( o, key, uValue ) {

	if ( $.type(o) == 'object' )	{		
		return ( key in o ) ? o[ key ] : uValue ;		
	}
	
	return uValue 
}


/* 	TGetComplete ---------------------------------------------------------------
 		
	El webservice devolvera un array de array asociativo con los valores:
		value:	Valor clave que buscamos
		item:	Texto que aparecerá en el desplegable
	-----------------------------------------------------------------------------*/

var TWebGetAutocomplete = function( cId, cSource, bSelect, oConfig, oParameters ){

	this.cId   			= cId;
	this.cSource 		= cSource;
	this.cType 			= TWebDefault( oConfig, 'type', 'POST' );
	this.bSelect		= bSelect;
	this.minLength		= TWebDefault( oConfig, 'minLength', 1 );
	this.delay			= TWebDefault( oConfig, 'delay', 300 );
	this.trigger		= TWebDefault( oConfig, 'trigger', '' );		
	this.bBefore		= null;		
	this.cId_Dialog		= '';
	this.oPar			= new Object();
	
	var oGet = this;
	
	this.Init = function(){
	
		oGet.oParam = new Object();
		
		//	Load  vars live ----------------------------------------
		
			var oDlg	= $( "#" + this.cId ).parents('[data-dialog]' )									
			
			if ( oDlg.length == 1 ) {
			
				var id_parent		= $(oDlg[0]).attr('id')	
				
				var oHttpd2			= new UHttpd2()					
				//var oPar 			= new Object()

					this.oPar[ 'dlg' ] 		= id_parent
					this.oPar[ 'api' ] 		= $('#'+id_parent).data('api')
					this.oPar[ 'proc' ] 	= ''	//proc 
					this.oPar[ 'controls' ] = JSON.stringify( oHttpd2.GetLive(id_parent) )	
					this.oPar[ 'trigger' ] 	= this.cId													
			}			
		//	-------------------------------------------------------

		if ( $.type( oGet.cSource ) == 'array'  ){
		
			$( "#" + this.cId ).autocomplete({			  
			  delay: 100, 		  
			  minLength: 1,	
			  source: oGet.cSource ,
			  select: TWeb_TGet_Select,				  
			});
		
		} else {
		
			$( "#" + this.cId ).autocomplete({			  
			  delay: this.delay, 		
			  focus: function( event, ui ) {
				 // prevent value inserted on focus		
				return false;
			  },		  
			  minLength: this.minLength + this.trigger.length,		// 1 = longitud del trigger -> =
			  source: TWeb_TGet_Source ,
			  select: TWeb_TGet_Select,
			  search: TWeb_TGet_Search			  
			});

		}
		
		if ( this.cId_Dialog !== '' )
			$( "#" + this.cId ).autocomplete( 'option', 'appendTo', '#' + this.cId_Dialog );	//	IMPORTANTE si se ejecuta desde un Dialog
	
	};
	
	function TWeb_TGet_Search() {

		if ( oGet.trigger === '' )
			return true;

		var cValue = this.value;
	  
		if ( cValue.length < this.minLength  )
			return false;
		
		if ( cValue.substr(0,1) !== oGet.trigger )		//oGet.trigger.length 
			return false;									
	};

	function TWeb_TGet_Source( request, response ) {
	
		var uValue = request.term;	
		
		if ( oGet.trigger !== '' ){						
			uValue = uValue.substr(1);										
		}	
					
		var oParam = new Object();
			oParam[ 'search' ] = uValue			
		
		var fn = oGet.bBefore;
		var oNewParam = null
		
	
		if (typeof fn === "function") {				

			var fnparams = null;
			oNewParam = fn.apply(null, fnparams );								
		}
		
		if ( $.type( oNewParam ) == 'object' ) {
			for( var key in oNewParam ) {			
				oParam[ key ] = oNewParam[ key ]			
			}
		}

		if ( $.type( oParameters ) == 'object' ) {
	
			for( var key in oParameters ) {					
				oParam[ key ] = oParameters[ key ]			
			}
		}	


		if ( Object.keys(oGet.oPar).length > 0 ) {
			for( var key in oGet.oPar ) {					
				oParam[ key ] = oGet.oPar[ key ]			
			}
		}						

		$.ajax({
		  type: oGet.cType,
		  url: oGet.cSource,
		  data: oParam,
		  success: response,
		  complete: function() {  },
		  error: function( oError ) {			  				
			console.error( 'Autocomplete error', oError.responseText ) 
			console.error( oError ) 
		  },			  
		  dataType: 'json'
		});			

	} ;			
	
	function TWeb_TGet_Select( event, ui ) {			

		var fn = window[ oGet.bSelect ];
		
		if (typeof fn === "function") {	
			var fnparams = [event, ui];
			fn.apply(null, fnparams );								
		} else {
		
			if ( $.type( oGet.cSource ) != 'array'  ) {
				// 	prevent autocomplete from updating the textbox
					event.preventDefault();			
			}
				
			$( "#" + oGet.cId ).val( ui.item.id )
		}
	}									
	
}

//	---------------------------------------------------------------------------- //

//	Init Sidebar click out...

	var _sbopened = false
	
	function _SidebarInit() {
	
		//console.log( 'Init sidebar...')
	
		$(".sidebar").on("sidebar:closed", function () { _sbopened = false });	
		$(".sidebar").on("sidebar:opened", function () { _sbopened = true });					
		
		$(document).mouseup(function(e){ 
			var _sb = $(".sidebar")
		
			if (!_sb.is(e.target) && _sb.has(e.target).length === 0) {						
				
				if ( _sbopened ){							
					_sb.trigger("sidebar:close");
				}					
			}					
		});															
	}


//	---------------------------------------------------------------------------- //