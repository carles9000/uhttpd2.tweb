#xcommand ? [<explist,...>] => UWrite( '<br>' [,<explist>] )
#xcommand ?? <cText> => UWrite( <cText> )

#xcommand DEFINE WEB <oWeb> [ TITLE <cTitle>] [ ICON <cIcon>] [<lTables: TABLES>] [ CHARSET <cCharSet>]  ;
	=> ;
		<oWeb> := TWeb():New( [<cTitle>], [<cIcon>], [<.lTables.>], [<cCharSet>] )
		
#xcommand INIT WEB <oWeb>  => <oWeb>:Activate()
#xcommand INIT WEB <oWeb> RETURN =>  return <oWeb>:Activate()

#xcommand CSS <oForm> => #pragma __cstream| <oForm>:Html( '<style>' + %s + '</style>' )

#xcommand TEXT TO <var> => #pragma __stream|<var> += %s

#xcommand HTML <o> => #pragma __cstream| <o>:Html( %s )
#xcommand HTML <o> INLINE <cHtml> => <o>:Html( <cHtml> )
#xcommand HTML <o> [ PARAMS [<v1>] [,<vn>] ] ;
=> ;
	#pragma __cstream |<o>:Html( UInlinePrg( UReplaceBlocks( %s, '<$', "$>" [,<(v1)>][+","+<(vn)>] [, @<v1>][, @<vn>] ) ) )

#xcommand HTML <oForm> FILE <cFile> [ <prm: PARAMS, VARS> <cValues,...> ]  => <oForm>:Html( TWebHtmlInline( <cFile>, [<cValues>]  ) )



#xcommand DEFINE FORM <oForm> [ID <cId> ] [ACTION <cAction>] [METHOD <cMethod>] ;
	[API <cApi>] [ON INIT <cProc>] OF <oWeb> ;
=> <oForm> := TWebForm():New( <oWeb>, [<cId>], [<cAction>], [<cMethod>], [<cApi>], [<cProc>] )

#xcommand INIT FORM <oForm> [ CLASS <cClass>] => <oForm>:InitForm( [<cClass> ] )
#xcommand ENDFORM <oForm>  => <oForm>:End()



#xcommand ROW <oForm> [ ID <cId> ] [ VALIGN <cVAlign> ] [ HALIGN <cHAlign> ] [ CLASS <cClass> ] [ TOP <cTop> ] [ BOTTOM <cBottom>] ;
=> ;
	<oForm>:Row( [<cId>], [<cVAlign>], [<cHAlign>], [<cClass>], [<cTop>], [<cBottom>] )
	
#xcommand COL <oForm> [GRID <nGrid>] [TYPE <cType>]  [ CLASS <cClass> ] => <oForm>:Col( [<nGrid>], [<cType>], [<cClass>] )
#xcommand ROWGROUP <oForm> [ VALIGN <cVAlign> ] [ HALIGN <cHAlign> ] [ CLASS <cClass> ] => <oForm>:RowGroup( <cVAlign>, <cHAlign>, <cClass> )
#xcommand DIV <oForm> [ ID <cId> ] [ CLASS <cClass> ] => <oForm>:Div( [<cId>], [<cClass>] )

#xcommand ENDROW <oForm> => <oForm>:End()
#xcommand ENDCOL <oForm> => <oForm>:End()
#xcommand ENDDIV <oForm> => <oForm>:End()	

	
#xcommand CAPTION <oForm> LABEL <cLabel> [ GRID <nGrid> ]  [ CLASS <cClass> ] => <oForm>:Caption( <cLabel>, <nGrid>, [<cClass>] )
#xcommand SEPARATOR <oForm>  [ ID <cId> ] LABEL <cLabel> [ CLASS <cClass> ] => <oForm>:Separator( [<cId>], <cLabel>, [<cClass>] )
#xcommand SMALL <oForm> [ ID <cId> ] [ LABEL <cLabel> ] [ GRID <nGrid> ] [ CLASS <cClass> ] => <oForm>:Small( <cId>, <cLabel>, <nGrid>, [<cClass>] )



#xcommand SAY [<oSay>] [ ID <cId> ] [ <prm: VALUE,PROMPT,LABEL> <uValue> ] [ ALIGN <cAlign> ] ;
	[GRID <nGrid>] [ CLASS <cClass> ] [ FONT <cFont> ] [ LINK <cLink> ] OF <oForm> ;
=> ;
	[<oSay> := ] TWebSay():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cAlign>], [<cClass>], [<cFont>], [<cLink>] )
	
#xcommand DEFINE FONT [<oFont>] NAME <cId> ;
	[ COLOR <cColor> ] [ BACKGROUND <cBackGround> ] [ SIZE <nSize> ] ;
	[ <bold: BOLD> ] [ <italic: ITALIC> ] [ FAMILY <cFamily> ] ;
	OF <oForm> ;
=> ;
	[<oFont> := ] TWebFont():New( <oForm>, <cId>, <cColor>, <cBackGround>, <nSize>, [<.bold.>], [<.italic.>], [<cFamily>] )

#xcommand GET [<oGet>] [ ID <cId> ] [ VALUE <uValue> ] [ <prm: PROMPT,LABEL> <cLabel> ] [ ALIGN <cAlign> ] [ <col:GRID, COL> <nGrid>] ;
	[ <ro: READONLY> ] [TYPE <cType>] [ PLACEHOLDER <cPlaceHolder>] ;
	[ <btn: BUTTON, BUTTONS> <cButton,...> ] [ <act: ACTION, ACTIONS> <cAction,...> ] [ <bid: BTNID, BTNIDS> <cBtnId,...> ] ;
	[ <rq: REQUIRED> ] [ AUTOCOMPLETE <uSource> [ SELECT <cSelect>] ] ;
	[ <chg: ONCHANGE,VALID> <cChange> ];
	[ CLASS <cClass> ] [ FONT <cFont> ] [ FONTLABEL <cFontLabel> ] ;
	[ LINK <cLink> ] [ GROUP <cGroup> ] [ DEFAULT <cDefault>] ;
	[ <spn: SPAN> <cSpan,...> ] [ <spnid: SPANID> <cSpanId,...> ] ;
	OF <oForm> ;
=> ;
	[<oGet> := ] TWebGet():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<cType>], [<cPlaceHolder>], [\{<cButton>\}], [\{<cAction>\}], [\{<cBtnId>\}], [<.rq.>], [<uSource>], [<cSelect>], [<cChange>], [<cClass>], [<cFont>], [<cFontLabel>],[<cLink>], [<cGroup>], [<cDefault>], [\{<cSpan>\}], [\{<cSpanId>\}]  )
	
#xcommand GET [<oGetMemo>] MEMO [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [GRID <nGrid>] ;
	[ <ro: READONLY> ] [ ROWS <nRows> ] ;	
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	[ <chg: ONCHANGE,VALID> <cChange> ];
	OF <oForm> ;
=> ;
	[<oGetMemo> := ] TWebGetMemo():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<nRows>], [<cClass>], [<cFont>], [<cChange>] )
	
#xcommand GETNUMBER [<oGet>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ ALIGN <cAlign> ] [ <col:GRID, COL> <nGrid>] ;
	[ <ro: READONLY> ] [ PLACEHOLDER <cPlaceHolder>] ;	
	[ <rq: REQUIRED> ]  ;
	[ <chg: ONCHANGE,VALID> <cChange> ];
	[ CLASS <cClass> ] [ FONT <cFont> ] ;	
	OF <oForm> ;
=> ;
	[<oGet> := ] TWebGetNumber():New( <oForm>, [<cId>], [<uValue>], [<nGrid>], [<cLabel>], [<cAlign>], [<.ro.>], [<cPlaceHolder>], [<.rq.>], [<cChange>], [<cClass>], [<cFont>] )



	
#xcommand BUTTON [<oBtn>] [ ID <cId> ] [ LABEL <cLabel> ] [ ACTION <cAction> ] [ NAME <cName> ] [ VALUE <cValue> ] ;
    [ GRID <nGrid> ] [ ALIGN <cAlign> ]  ;
	[ ICON <cIcon> ] [ <ds: DISABLED> ] [ <sb: SUBMIT> ] [ LINK <cLink> ] ;
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	[ <files: FILES> ] ;
	[ WIDTH <cWidth> ] ;
	[ CONFIRM <cConfirm> ] ;
	OF <oForm> ;
=> ;
	[ <oBtn> := ] TWebButton():New( <oForm>, [<cId>], <cLabel>, <cAction>, <cName>, <cValue>, <nGrid>, <cAlign>, <cIcon>, [<.ds.>], [<.sb.>], [<cLink>], [<cClass>], [<cFont>], [<.files.>], [<cWidth>], [<cConfirm>] )	
	
	
#xcommand IMAGE [<oImg>] [ ID <cId> ] [ FILE <cFile> ] [ BIGFILE <cBigFile> ] [ ALIGN <cAlign> ] ;
	[GRID <nGrid>] [ CLASS <cClass> ] [ WIDTH <nWidth>] [ GALLERY <cGallery> ] ;
	[ <nozoom: NOZOOM> ] OF <oForm> ;
=> ;
	[<oImg> := ] TWebImage():New( <oForm>, [<cId>], [<cFile>], [<cBigFile>], [<nGrid>], [<cAlign>], [<cClass>], [<nWidth>], [<cGallery>], [<.nozoom.>] )
	
	
#xcommand SWITCH [<oSwitch>] [ ID <cId> ] [ <lValue: ON> ] [ VALUE <lValue> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ <act:ACTION,ONCHANGE> <cAction> ] OF <oForm> ;
=> ;
	[ <oSwitch> := ] TWebSwitch():New( <oForm>, [<cId>], [<lValue>], [<cLabel>], [<nGrid>], [<cAction>] ) 	

#xcommand RADIO [<oRadio>] [ ID <cId> ]  [ <chk: VALUE, CHECKED> <uValue> ] ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES, KEYS> <cValue,...> ] ;			
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;
		[ <inline: INLINE> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ] ;		
		OF <oForm> ;
=> ;
	[ <oRadio> := ] TWebRadio():New( <oForm>, [<cId>], [<uValue>], [\{<cPrompt>\}], [\{<cValue>\}], [<nGrid>], [<cAction>], [<.inline.>], [<cClass>], [<cFont>] )
		 

#xcommand CHECKBOX [<oCheckbox>] [ ID <cId> ] [ <lValue: ON> ] [ LABEL <cLabel> ] [GRID <nGrid>] [ ACTION  <cAction> ] ;
	[ CLASS <cClass> ] [ FONT <cFont> ] ;
	OF <oForm> ;
=> ;
	[ <oCheckbox> := ] TWebCheckbox():New( <oForm>, [<cId>], [<.lValue.>], [<cLabel>], [<nGrid>], [<cAction>], [<cClass>], [<cFont>]  ) 	
	

	
#xcommand BOX [<oBox>] [ ID <cId> ]  ;
	[GRID <nGrid>] [ HEIGHT <nHeight> ] [ CLASS <cClass> ] OF <oContainer> ;
=> ;
	[<oBox> := ] TWebBox():New( <oContainer>, [<cId>], [<nGrid>], [<nHeight>], [<cClass>] )
	
#xcommand ENDBOX <oBox> => <oBox>:End()	

	 
#xcommand SELECT [<oSelect>] [ ID <cId> ] [ VALUE <uValue> ] [ LABEL <cLabel> ] [ KEYVALUE <aKeyValue> ] ;
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
		[ <tabs: VALUES> <cValue,...> ] ;		
		[ GRID <nGrid> ] ;
		[ ONCHANGE  <cAction> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ]  [ GROUP <cGroup> ];			
		OF <oForm> ;
=> ;
	[ <oSelect> := ] TWebSelect():New( <oForm>, [<cId>], [<uValue>], [\{<cPrompt>\}], [\{<cValue>\}], [<aKeyValue>], [<nGrid>], [<cAction>], [<cLabel>], [<cClass>], [<cFont>], <cGroup>  )

#xcommand ICON [<oIcon>] [ ID <cId> ] [ <prm: IMAGE,SRC> <cSrc> ] [ ALIGN <cAlign> ] ;
	[GRID <nGrid>] [ CLASS <cClass> ] [ FONT <cFont> ] [ LINK <cLink> ] OF <oForm> ;
=> ;
	[<oIcon> := ] TWebIcon():New( <oForm>, [<cId>], [<cSrc>], [<nGrid>], [<cAlign>], [<cClass>], [<cFont>], [<cLink>] )

#xcommand NAV [<oNav>] [ ID <cId> ] [ TITLE <cTitle> ] [ LOGO <cLogo> [ WIDTH <nWidth>] ;
	[ ROUTE <cRoute>] [HEIGHT <nHeight> ] ] OF <oWeb> ;	
=> ;
	[<oNav> := ] TWebNav():New( <oWeb>, [<cId>], [<cTitle>], [<cLogo>], [<nWidth>], [<nHeight>], [<cRoute>] )

#xcommand MENUITEM <cItem> [ ICON <cIcon> ] ROUTE <cRoute> OF <oNav>  => <oNav>:AddMenuItem( <cItem>, <cRoute>, [<cIcon>] )


		 
#xcommand FOLDER [<oFolder>] [ ID <cId> ] ;
		[ <tabs: TABS> <cTab,...> ] ;		
		[ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;		
		[ GRID <nGrid> ] ;
		[ OPTION <cOption> ] ;
		[ <lAdjust: ADJUST> ] ;
		[ CLASS <cClass> ] [ FONT <cFont> ] ;	
		OF <oForm> ;
=> ;
	[ <oFolder> := ] TWebFolder():New( <oForm>, [<cId>], [\{<cTab>\}], [\{<cPrompt>\}], [<nGrid>], [<cOption>], [<.lAdjust.>] , [<cClass>], [<cFont>]) 

#xcommand DEFINE TAB <cId> [ <lFocus: FOCUS> ] [ CLASS <cClass> ] OF <oFld> => <oFld>:AddTab( <cId>, [<.lFocus.>], [<cClass>] )
#xcommand ENDTAB <oFld> => <oFld>:End()
#xcommand ENDFOLDER <oFld> => <oFld>:End()	

//	--------------------------------------------------------


#xcommand DEFINE BROWSE [<oBrw>] [ ID <cId> ] [OPTIONS <hOptions>] [ EVENTS <aEvents>]  ;
	[ FILTER <aFilter> ] [ FILTER_ID <cFilter_id> ] [ TITLE <cTitle> ] OF <oForm> ;
=> ;
	[ <oBrw> := ] TWebBrowse():New( <oForm>, [<cId>], <hOptions>, [<aEvents>], [<aFilter>], [<cFilter_id>], [<cTitle>] )
	

#xcommand COL <oCol> TO <oBrw> CONFIG <hConfig> ;
=> ;						
	<oCol> := <oBrw>:AddCol( <hConfig> )
	

#xcommand INIT BROWSE <oBrw> [ DATA <aRows> ] ;
=> ;
	<oBrw>:Init( [<aRows>] )	
