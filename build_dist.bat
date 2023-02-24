@echo off
@echo --------------------------------
@echo Build distributate folder .\dist
@echo --------------------------------


@echo +
@echo +-- Copy lib harbour...
xcopy sample\lib\tweb\    dist\lib\tweb\ /Y/Q
xcopy sample\lib\uhttpd2\ dist\lib\uhttpd2\ /Y/Q


@echo +
@echo +-- Copy web files...
@xcopy sample\files\tweb\*.* dist\files\tweb\ /E/Y/Q
@xcopy sample\files\uhttpd2\*.* dist\files\uhttpd2\ /E/Y/Q

@echo +
@echo +-------------------------
@echo Folder .\dist was create !
@echo +-------------------------

@echo +
@echo +-- Copy dist to sample.tpl...
@xcopy dist\files\*.* sample.tpl\files\ /E/Y/Q
@xcopy dist\lib\*.*   sample.tpl\lib\ /E/Y/Q

@echo +
@echo +-------------------------
@echo \sample.tpl was updated !
@echo +-------------------------




pause

