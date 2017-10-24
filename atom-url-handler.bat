@echo off

:: get url
set url="%~1"

:: get file
set file="%url:*file://=%
for /f "tokens=1 delims=^&" %%i in (%file%) do (set file=%%i)
if "%file%" == "" (
	echo Invalid File
	exit /B 1
)
if "%file:~0,1%" == ":" (
	echo Invalid File
	exit /B 1
)

:: get line
if %url:&line=% == %url% (
  goto open
)
set line=
set query="%url:*&line=|%
for /f "tokens=2 delims==^&" %%i in (%query%) do (set line=%%i)
set file=%file%:%line%

:: get col or column
if %url:&col=% == %url% (
  goto open
)
set col=
set query="%url:*&col=|%
for /f "tokens=2 delims==^&" %%i in (%query%) do (set col=%%i)
set file=%file%:%col%

:: open url
:open

atom "%file%"
