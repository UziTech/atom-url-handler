@echo off
setlocal EnableDelayedExpansion

:: get url
set url="%~1"
set url=%url:?=&%
set url=!url:%%3A=:!
set url=!url:%%20= !
set url=%url:+= %
set url=!url:%%2B=+!
set url=!url:%%2F=/!
set url=!url:%%5C=\!

:: get file
if %url:file://=% == %url% (
	echo Invalid URL
	exit /B 1
)
set file="%url:*file://=|%
if %file% == "" (
	echo Invalid File
	exit /B 1
)
for /f "tokens=1 delims=^&" %%i in (%file%) do (set file=%%i)
if "%file%" == "|" (
	echo Invalid File
	exit /B 1
)
if "%file:~1,1%" == ":" (
	echo Invalid File
	exit /B 1
)
set file=%file:~1%

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
