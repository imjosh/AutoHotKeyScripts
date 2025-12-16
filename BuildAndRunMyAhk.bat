@echo off
setlocal

:: Get the directory of this script
set "SCRIPT_DIR=%~dp0"

:: Run the combineAhks.bat script to build my.ahk
echo.
call "%SCRIPT_DIR%combineAhks.bat"

:: Check if the build was successful
if not exist "%SCRIPT_DIR%release\my.ahk" (
  echo Error: my.ahk was not created successfully.
  pause
  exit /b 1
)

:: Start the combined AutoHotkey script
echo.
echo Starting my.ahk...
start "" "%SCRIPT_DIR%release\my.ahk"

endlocal
