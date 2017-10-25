@echo off
setlocal

:: change to this directory so i can call the handler with a relative path
cd %~dp0

set numtests=0
set passedtests=0

call :call_handler "atm://open/?url=file://C:\path\to\file.ext" "C:\path\to\file.ext"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext:1" "C:\path\to\file.ext:1"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext:1:2" "C:\path\to\file.ext:1:2"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext&line=1" "C:\path\to\file.ext:1"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext&line=1&col=2" "C:\path\to\file.ext:1:2"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext&line=1&column=2" "C:\path\to\file.ext:1:2"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext&col=1&line=2" "C:\path\to\file.ext:2:1"
call :call_handler "atm://open/?url=file://C:\path\to\file.ext&column=1&line=2" "C:\path\to\file.ext:2:1"

:: test url not first parameter
call :call_handler "atm://open/?line=1&url=file://C:\path\to\file.ext&col=2" "C:\path\to\file.ext:1:2"
call :call_handler "atm://open/?col=1&url=file://C:\path\to\file.ext&line=2" "C:\path\to\file.ext:2:1"
call :call_handler "atm://open/?line=1&col=2&url=file://C:\path\to\file.ext" "C:\path\to\file.ext:1:2"

:: test invalid
call :call_handler "atm://open/?url=file://" "Invalid File"
call :call_handler "atm://open/?url=file://&line=1" "Invalid File"
call :call_handler "atm://open/?url=file://:1:2" "Invalid File"
call :call_handler "atm://open/?url=" "Invalid URL"

:: test escaped characters
:: need 4 % so % is escaped twice
call :call_handler "atm://open/?url=file%%%%3A//C%%%%3A\path\to\file.ext" "C:\path\to\file.ext"
call :call_handler "atm://open/?url=file://C:\path%%%%20to\file.ext" "C:\path to\file.ext"
call :call_handler "atm://open/?url=file://C:\path+to\file.ext" "C:\path to\file.ext"
call :call_handler "atm://open/?url=file://C:\path%%%%2Bto\file.ext" "C:\path+to\file.ext"
call :call_handler "atm://open/?url=file:%%%%2F%%%%2FC:\path\to\file.ext" "C:\path\to\file.ext"
call :call_handler "atm://open/?url=file://C:%%%%5Cpath%%%%5Cto%%%%5Cfile.ext" "C:\path\to\file.ext"

echo.
echo %passedtests% out of %numtests% tests passed

if %passedtests% LSS %numtests% exit /B 1
exit /B

:call_handler
set /A "numtests+=1"
echo.
echo %1 =^> %2
set file=
for /F "tokens=* USEBACKQ" %%F IN (`..\atom-url-handler.bat "%~1"`) DO (SET file=%%F)
if not "%file:"=%" == "%~2" (
	echo fail =^> %file%
	exit /B 1
)
set /A "passedtests+=1"
echo pass
REM exit /B
