#include "hbcurl.ch"
#include "lib/tweb/tweb.ch"

function myapi( oDom )

	
	do case
		case oDom:GetProc() == 'hello' 		; DoHello( oDom )
		case oDom:GetProc() == 'clickme' 	; DoButton( oDom )
		case oDom:GetProc() == 'click2' 	; DoInfo( oDom )
		
		otherwise
			oDom:SetError( "Proc doesn't exist: " + oDom:GetProc() )
	endcase

retu oDom:Send() 

// --------------------------------------------------------- //

function DoHello( oDom )

	oDom:Console( 'Hello !' )

return nil 

// --------------------------------------------------------- //
 
function DoButton( oDom )

	local hData := {=>}

	hData[ 'name' ] := oDom:Get( 'myname' )
	hData[ 'age'  ] := oDom:Get( 'myage' )
	hData[ 'date' ] := oDom:Get( 'mydate' )

	USessionStart()
	Usession( 'data_user'	, hData )
	Usession( 'data_in'	, dtoc( date() ) + ' - ' + time() )

	oDom:Set( 'btn', 'Hello from server Harbour at ' + time() )

return nil  

function DoInfo( oDom )

    Local cJs := ""
    //
	TEXT TO cJs
      // Verifica si el navegador admite la API Web Share
      if (navigator.share) {
          // Crea un objeto de datos para compartir
          const shareData = {
              title: "ElTitulo",
              text: "ElTexto",
              url: "https://rxbase.duckdns.org/images/mini-mercury.png",
          };

          // Si deseas compartir una imagen, puedes hacerlo como un Blob
          // Aquí se utiliza una imagen de ejemplo como base64
          fetch('https://rxbase.duckdns.org/images/mini-mercury.png')
              .then(response => response.blob())
              .then(imageBlob => {
                  shareData.files = [new File([imageBlob], 'mini-mercury.png', { type: 'image/png' })];

                  // Llama a la API Web Share para compartir
                  navigator.share(shareData)
                      .then(() => {
                          // alert("Compartido con éxito");
                      })
                      .catch(error => {
                          alert("Error al compartir:", error);
                      });
              })
              .catch(error => {
                  alert("Error al cargar la imagen:", error);
              });
      } else {
          alert("El navegador no admite la API Web Share.");
      }
	ENDTEXT

    oDom:SetJS( cJs )

retu nil