@echo off
@echo +-------------------------
@echo Creating folder .\dist 
@echo +-------------------------
@echo +
@echo +-- Copy lib harbour
xcopy sample\lib\    dist\lib\ /E/Y/Q

@echo +
@echo +-- Copy web files
xcopy sample\files\  dist\files\ /E/Y/Q

@echo +
@echo +-------------------------
@echo Folder .\dist was create !
@echo +-------------------------

@echo +
@echo +-- Copy dist to sample.tpl
xcopy dist\files\ sample.tpl\files\ /E/Y/Q
xcopy dist\lib\   sample.tpl\lib\ /E/Y/Q


@echo +
@echo +-------------------------
@echo \sample.tpl was updated !
@echo +-------------------------

@echo +
@echo +-- Copy dist to sample.tpl.ssl
xcopy dist\files\ sample.tpl.ssl\files\ /E/Y/Q
xcopy dist\lib\   sample.tpl.ssl\lib\ /E/Y/Q

@echo +
@echo +----------------------------
@echo \sample.tpl.ssl was updated !
@echo +----------------------------


echo.
pause