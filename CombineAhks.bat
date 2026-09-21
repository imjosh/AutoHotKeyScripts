@echo off
setlocal EnableDelayedExpansion

:: Get the directory of this script
set "SCRIPT_DIR=%~dp0"

:: Create release folder if it doesn't exist
if not exist "%SCRIPT_DIR%release" (
  echo Creating release folder...
  mkdir "%SCRIPT_DIR%release"
)

:: Set output file path
set "OUTPUT_FILE=%SCRIPT_DIR%release\my.ahk"

:: Delete existing output file if it exists
if exist "%OUTPUT_FILE%" (
  del "%OUTPUT_FILE%"
)

echo Concatenating .ahk files into:
echo    %OUTPUT_FILE%...
echo.


:: Shared startup settings must precede all concatenated scripts.
echo #Requires AutoHotkey v2 >> "%OUTPUT_FILE%"
echo #SingleInstance Force >> "%OUTPUT_FILE%"
echo ; Avoid synthetic Ctrl triggering Wispr Flow's Ctrl+Win shortcut. >> "%OUTPUT_FILE%"
echo A_MenuMaskKey := "vkE8" >> "%OUTPUT_FILE%"
echo. >> "%OUTPUT_FILE%"

:: Loop through all .ahk files in the scripts directory and concatenate them
for %%F in ("%SCRIPT_DIR%scripts\*.ahk") do (
  if exist "%%~F" (
    echo Adding %%~nxF...
    echo ; ========================================== >> "%OUTPUT_FILE%"
    echo ; Source: %%~nxF >> "%OUTPUT_FILE%"
    echo ; ========================================== >> "%OUTPUT_FILE%"
    echo. >> "%OUTPUT_FILE%"
    type "%%~F" >> "%OUTPUT_FILE%"
    echo. >> "%OUTPUT_FILE%"
    echo. >> "%OUTPUT_FILE%"
  )
)

echo.

endlocal

