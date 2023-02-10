function Api_Functional( oDom )

	//	Acceso a API Security

	do case
		case oDom:GetProc() == 'getid'			; GetId( oDom )						
		case oDom:GetProc() == 'upd_salary'	; Upd_Salary( oDom )						

		otherwise 				
			oDom:SetError( "Proc don't defined => " + oDom:GetProc())
	endcase
	
retu oDom:Send()	

// -------------------------------------------------- //

static function GetId( oDom )

	local cAlias 	:= OpenDbf( 'test.dbf', 'test.cdx', 'ID' )
	local nId 		:= Val( oDom:Get( 'id' ) )		
	local h			:= {=>}
	local lFound
	local cKeyId	:= ''
	
	
	
	h[ 'first' ] 	:= ''
	h[ 'last' ] 	:= ''
	h[ 'street' ] 	:= ''
	h[ 'salary' ] 	:= ''	
	
	//	Validacion datos de entrada
	//	id type N
	//	salary type N, min, max
	//	Sino back --->
	
	//	Seguridad
	//	Puedes editar el Id ? 
	
		if nId == 1002
			oDom:SetError( 'No tienes autorizacion' )
			retu nil
		endif		

	//	Proceso
	
	lFound := (cAlias)->( DbSeek( nId ) )	
	
	if lFound
		 h[ 'first' ] 	:= '<b>First: </b>' + (cAlias)->first 					
		 h[ 'last' ] 	:= '<b>Last: </b>' + (cAlias)->last 					
		 h[ 'street' ] 	:= '<b>Street: </b>' + (cAlias)->street 
		 h[ 'salary' ] 	:= (cAlias)->salary 
		 
		cKeyId := USetToken( nId )
		
	endif
	
	//	Respuesta...
	
	oDom:Set( 'keyid'	, cKeyId )
	
	oDom:Set( 'first'	, h[ 'first' ] )
	oDom:Set( 'last'	, h[ 'last' ] )
	oDom:Set( 'street'	, h[ 'street' ] )
	oDom:Set( 'salary'	, h[ 'salary' ] )
	
	if lFound 
		oDOm:Show( 'data' )
		oDOm:Enable( 'salary' )
		oDOm:Enable( 'btn_upd' )
		oDOm:Focus( 'salary' )
	else
		oDOm:Hide( 'data' )
		oDOm:Disable( 'salary' )
		oDOm:Disable( 'btn_upd' )
		oDom:SetError( "ID don't exist&nbsp<b>" + ltrim(str(nId)) )
	endif				
	
retu nil

// -------------------------------------------------- //

static function Upd_Salary( oDom )

	local cAlias 	:= OpenDbf( 'test.dbf', 'test.cdx' )
	local cKeyId 	:= oDom:Get( 'keyid' ) 	
	local nId 		:= Val( oDom:Get( 'id' ) )	
	local nSalary	:= Val( oDom:Get( 'salary' ) )	
	local lFound
	
	//	Validacion datos de entrada
	//	id type N
	//	salary type N, min, max
	//	Sino back --->
	
	//	Seguridad
	//	Puedes editar el Id ? 
	
		if nId == 1002
			oDom:SetError( 'No tienes autorizacion' )
			retu nil
		endif
		
//-------------		
	if empty( cKeyId ) 
		retu nil
	endif

	if nId <> UGetToken( cKeyId ) 
		oDom:SetError( 'Hacked forbidden!!!' )
		retu nil
	endif
//--------------	
	
	(cAlias)->( OrdSetFocus( 'ID' ) )
	
	lFound := (cAlias)->( DbSeek( nId ) )

	if lFound 
		if (cAlias)->( Rlock() )
			(cAlias)->salary := nSalary
			oDom:SetMsg( "Id: <b>" + ltrim(str(nId)) + "</b> => Salary updated !" )
		else
			oDom:SetError( 'Error de bloqueo' )
		endif
	else
	
		oDom:SetError( "ID don't exist&nbsp<b>" + ltrim(str(nId))  )
		
	endif		

retu nil 
// -------------------------------------------------- //