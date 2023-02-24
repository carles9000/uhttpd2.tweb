@echo off
call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

c:\harbour\bin\hbmk2 tweb.hbp -comp=msvc64

IF ERRORLEVEL 1 GOTO COMPILEERROR

@echo -----------------------------------
@echo Copy Lib to project sample\lib\tweb
@echo -----------------------------------

copy tweb.lib sample\lib\tweb\tweb.lib /Y


GOTO EXIT

:COMPILEERROR

echo *** Error ***


:EXIT

pause