@echo off
title Cyber Assistant Vault - Setup Installer
color 0A
echo ========================================================
echo   CYBER ASSISTANT VAULT - 1-CLICK PC INSTALLER
echo   Made by AMALL - https://www.amall.site/tools
echo ========================================================
echo.
echo Installing Cyber Assistant Vault to your PC...
echo.

set "TARGET_DIR=%LOCALAPPDATA%\CyberAssistantVault"
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: Copy custom logo icon if present
if exist "%~dp0assets\icon.ico" copy /y "%~dp0assets\icon.ico" "%TARGET_DIR%\icon.ico" >nul

:: Create launcher executable batch script
(
echo @echo off
echo set "DATA_DIR=%%APPDATA%%\CyberAssistantVault\Profile"
echo if not exist "%%DATA_DIR%%" mkdir "%%DATA_DIR%%"
echo set "APP_URL=https://www.amall.site/tools"
echo if exist "%%ProgramFiles(x86)%%\Microsoft\Edge\Application\msedge.exe" ^(
echo     start "" "%%ProgramFiles(x86)%%\Microsoft\Edge\Application\msedge.exe" --app="%%APP_URL%%" --user-data-dir="%%DATA_DIR%%" --window-size=1280,800
echo     exit /b
echo ^)
echo if exist "%%ProgramFiles%%\Microsoft\Edge\Application\msedge.exe" ^(
echo     start "" "%%ProgramFiles%%\Microsoft\Edge\Application\msedge.exe" --app="%%APP_URL%%" --user-data-dir="%%DATA_DIR%%" --window-size=1280,800
echo     exit /b
echo ^)
echo if exist "%%ProgramFiles%%\Google\Chrome\Application\chrome.exe" ^(
echo     start "" "%%ProgramFiles%%\Google\Chrome\Application\chrome.exe" --app="%%APP_URL%%" --user-data-dir="%%DATA_DIR%%" --window-size=1280,800
echo     exit /b
echo ^)
echo if exist "%%ProgramFiles(x86)%%\Google\Chrome\Application\chrome.exe" ^(
echo     start "" "%%ProgramFiles(x86)%%\Google\Chrome\Application\chrome.exe" --app="%%APP_URL%%" --user-data-dir="%%DATA_DIR%%" --window-size=1280,800
echo     exit /b
echo ^)
echo start "" "%%APP_URL%%"
echo exit /b
) > "%TARGET_DIR%\CyberAssistantVault.bat"

:: Create Desktop & Start Menu Shortcuts with custom logo icon
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $d = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop); $ico = \"$env:LOCALAPPDATA\CyberAssistantVault\icon.ico\"; $s = $ws.CreateShortcut(\"$d\Cyber Assistant Vault.lnk\"); $s.TargetPath = \"$env:LOCALAPPDATA\CyberAssistantVault\CyberAssistantVault.bat\"; $s.WorkingDirectory = \"$env:LOCALAPPDATA\CyberAssistantVault\"; if (Test-Path $ico) { $s.IconLocation = $ico }; $s.WindowStyle = 7; $s.Save(); $sm = \"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\"; $s2 = $ws.CreateShortcut(\"$sm\Cyber Assistant Vault.lnk\"); $s2.TargetPath = \"$env:LOCALAPPDATA\CyberAssistantVault\CyberAssistantVault.bat\"; $s2.WorkingDirectory = \"$env:LOCALAPPDATA\CyberAssistantVault\"; if (Test-Path $ico) { $s2.IconLocation = $ico }; $s2.WindowStyle = 7; $s2.Save();"

echo.
echo ========================================================
echo   SUCCESS! Cyber Assistant Vault has been installed.
echo   Desktop Shortcut with custom logo icon created.
echo ========================================================
echo.
echo Launching Cyber Assistant Vault now...
timeout /t 2 >nul

start "" "%TARGET_DIR%\CyberAssistantVault.bat"
exit /b
