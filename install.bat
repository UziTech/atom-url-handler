@echo off

:: request admin privileges
if not "%~1"=="is_admin" (
	powershell start -verb runas '%0' 'is_admin "%~1"'
	exit /B
)

:: set protocol if given as first parameter
if not "%~2" == "" (
	set "prot=%~2"
	goto start
)

:protocolselect

:: choose protocol
set prot=atm
set /P "prot=Protocol [atm]? "

:start

if not "%prot:.=%" == "%prot%" (
	echo Invalid Protocol
	goto protocolselect
)
if not "%prot: =%" == "%prot%" (
	echo Invalid Protocol
	goto protocolselect
)
if "%prot%" == "*" (
	echo Invalid Protocol
	goto protocolselect
)

:: check if registry key exists
reg query HKCR\%prot% >NUL 2>&1
if %ERRORLEVEL% NEQ 0 goto install

:: overwrite if exists
:overwrite
set overwrite=n
set /P "overwrite=The protocol '%prot%' already exists. Do you want to overwrite it [y/N]? "
if /I "%overwrite%" == "n" goto protocolselect
if /I "%overwrite%" == "no" goto protocolselect
if /I "%overwrite%" == "y" goto install
if /I "%overwrite%" == "yes" goto install

echo I didn't understand your answer. Please type Y or N
goto overwrite

:install

:: copy handler
copy /Y "%~dp0atom-url-handler.bat" "%LOCALAPPDATA%\atom-url-handler.bat" >NUL
if %ERRORLEVEL% NEQ 0 (
	echo Error copying handler
	pause
	exit /B 1
)

:: add registry keys
reg delete HKCR\%prot% /f >NUL 2>&1
reg add HKCR\%prot% /f >NUL 2>&1

:: if invalid key select different protocol
if %ERRORLEVEL% NEQ 0 (
	echo Error adding registry key
	goto protocolselect
)

reg add HKCR\%prot% /ve /d "URL:Open File in Atom" /f >NUL
reg add HKCR\%prot% /v "URL Protocol" /d "" /f >NUL
reg add HKCR\%prot%\shell /f >NUL
reg add HKCR\%prot%\shell\open /f >NUL
reg add HKCR\%prot%\shell\open\command /f >NUL
reg add HKCR\%prot%\shell\open\command /ve /d "\"%LOCALAPPDATA%\atom-url-handler.bat\" \"%%1\"" /f >NUL
