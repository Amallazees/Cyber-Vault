@echo off
title Cyber Assistant Vault - Desktop Software
echo ========================================================
echo          CYBER ASSISTANT VAULT - MADE BY AMALL
echo ========================================================
echo Starting Cyber Assistant Vault Standalone Desktop App...
echo.

set "DATA_DIR=%APPDATA%\CyberAssistantVault\Profile"
if not exist "%DATA_DIR%" mkdir "%DATA_DIR%"

set "APP_URL=https://www.amall.site/tools"

:: Try Microsoft Edge
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)

if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)

:: Try Google Chrome
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)

if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)

:: Fallback default browser launch
echo Launching in default web browser...
start "" "%APP_URL%"
exit /b
