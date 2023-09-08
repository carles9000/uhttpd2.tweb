@echo OFF
cls
echo *************************************************
echo ** Harbour 3.2.0dev (r.28/04/2021 18:02) - 64 bit
echo ** MinGW C++ 8.5 64 bit    
echo *************************************************

set ccdir=c:\gcc85\mingw64
set hbdir=c:\harb\hgcc85w64
set include=%hbdir%\include;%ccdir%\include;
set lib=%hbdir%\lib;%ccdir%\lib;%ccdir%\x86_64-w64-mingw32\lib;
path c:\windows\system32;c:\windows;%hbdir%;%hbdir%\bin;%ccdir%\bin;

c:\harb\hgcc85w64\bin\hbmk2 tweb.hbp -comp=mingw64

IF ERRORLEVEL 1 GOTO COMPILEERROR

rem We will always copy the library to the samples folder to test it...
copy lib\mingw64\libtweb.a sample\lib\tweb\gcc64\libtweb.a /Y

GOTO EXIT

:COMPILEERROR

echo *** Error ***

:EXIT


echo.
pause