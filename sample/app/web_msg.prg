#include "../lib/tweb/tweb.ch" 

#define CRLF Chr(13)+Chr(10)

// -------------------------------------------------- //

function Ping_Data()

	local hData := GetMsgServer()
	
	_d( hData )
	
	UAddHeader("Content-Type", "application/json")		
	
	UWrite( hb_jsonEncode( hData ) )
	
retu nil 

// -------------------------------------------------- //

function Ping_DataRecno()

	local cRecno 	:= GetMsgServer()
	local nRecno 	:= Val( cRecno )	
	local cInfo 	:= ''
	
	USE ( 'data\test.dbf' ) SHARED NEW VIA 'DBFCDX'		

	GOTO nRecno
	
	cInfo += FIELD->first + ' ' + FIELD->last  + CRLF
	cInfo += FIELD->street + ' ' + FIELD->city + ' ' + FIELD->state + CRLF
	cInfo += FIELD->notes	
	
	UWrite( cInfo )
	
retu nil 

// -------------------------------------------------- //