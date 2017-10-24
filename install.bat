@echo off

:: request admin privileges
if not "%~1"=="is_admin" (
	powershell start -verb runas '%0' 'is_admin "%~1"'
	exit
)

if not "%~2" == "" (
	set "prot=%~2"
	goto start
)

:: choose protocol
set /P prot=Protocol [atm]? 
if "%prot%" == "" (
	set prot=atm
)

:start
echo "%prot%"
pause

:: copy handler
copy /Y "%~dp0atom-url-handler.bat" "%LOCALAPPDATA%\atom-url-handler.bat"

:: add registry keys
reg add HKCR\%prot% /f
reg add HKCR\%prot% /ve /d "URL:Open Atom" /f
reg add HKCR\%prot% /v "URL Protocol" /d "" /f
reg add HKCR\%prot%\shell /f
reg add HKCR\%prot%\shell\open /f
reg add HKCR\%prot%\shell\open\command /f
reg add HKCR\%prot%\shell\open\command /ve /d "\"%LOCALAPPDATA%\atom-url-handler.bat\" \"%%1\"" /f
