@echo off

:: get url
set url="%~1"
set url="%url:*file://=%

:: get file
for /f "tokens=1 delims=^&" %%i in (%url%) do (set file=%%i)
if %url:&=% == %url% (
  goto open
)

:: get line
set query="%url:*&=%
for /f "tokens=2 delims==^&" %%i in (%query%) do (set line=%%i)
set file=%file%:%line%
if %query:&=% == %query% (
  goto open
)

REM :: get column
set query="%query:*&=%
for /f "tokens=2 delims==^&" %%i in (%query%) do (set col=%%i)
set file=%file%:%col%

REM :: open url
:open

atom "%file%"
