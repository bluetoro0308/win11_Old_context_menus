@echo off
title Registry Modifier - Apply Changes for All Users

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ==================================================
    echo [ERROR] This script must be run as administrator.
    echo Right-click the batch file and select "Run as administrator."
    echo ==================================================
    pause
    exit /b
)

echo ==================================================
echo [INFO] Administrator privileges confirmed.
echo [INFO] Creating registry keys under HKLM for all users...
echo ==================================================

:: Create the first key under HKLM
reg add "HKLM\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f

:: Create the InprocServer32 subkey under HKLM
reg add "HKLM\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f

:: Set the (Default) value to an empty string
reg add "HKLM\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f

echo ==================================================
echo [SUCCESS] Registry keys created successfully for all users.
echo ==================================================

:: Prompt user for restart
echo Your system needs to be restarted to apply the changes.
echo Restarting in 10 seconds... Press Ctrl+C to cancel.
timeout /t 10

:: Restart computer
shutdown /r /t 0