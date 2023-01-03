@echo off
@echo --------------------------------
@echo Build distributate folder .\dist
@echo --------------------------------


@echo +
@echo +-- Copy lib harbour...
xcopy sample\lib\uhttpd2.* dist\lib\tweb\ /Y/Q


@echo +
@echo +-- Copy web files...
@xcopy sample\files\tweb\*.* dist\files\tweb\ /E/Y/Q

@echo --------------------------
@echo Folder .\dist was create !
@echo --------------------------

pause

