@echo off
call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

c:\harb\msvc64\bin\hbmk2 tweb.hbp -comp=msvc64

IF ERRORLEVEL 1 GOTO COMPILEERROR

rem We will always copy the library to the samples folder to test it...s
copy lib\msvc64\tweb.lib sample\lib\tweb\msvc64\tweb.lib /Y

GOTO EXIT

:COMPILEERROR

echo *** Error ***

:EXIT

pause