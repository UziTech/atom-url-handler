@echo off

:: request admin privileges
if not "%1"=="is_admin" (powershell start -verb runas '%0' is_admin & exit)

:: copy handler
copy /Y "%~dp0atom-url-handler.bat" "%LOCALAPPDATA%\atom-url-handler.bat"

:: add registry keys
reg add HKCR\atm /f
reg add HKCR\atm /ve /d "URL:Open Atom" /f
reg add HKCR\atm /v "URL Protocol" /d "" /f
reg add HKCR\atm\shell /f
reg add HKCR\atm\shell\open /f
reg add HKCR\atm\shell\open\command /f
reg add HKCR\atm\shell\open\command /ve /d "\"%LOCALAPPDATA%\atom-url-handler.bat\" \"%%1\"" /f
