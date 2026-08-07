# ========================================================
#   Cyber Assistant Vault - 1-Click Installer Script
#   Made by AMALL | https://www.amall.site/tools
# ========================================================

$ErrorActionPreference = "Stop"

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  Installing Cyber Assistant Vault Desktop App..." -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

$installDir = "$env:LOCALAPPDATA\CyberAssistantVault"
$desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$startMenuPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"

if (!(Test-Path -Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$batSource = Join-Path $scriptDir "CyberAssistantVault.bat"
$iconSource = Join-Path $scriptDir "assets\icon.ico"
$targetIcon = Join-Path $installDir "icon.ico"

if (Test-Path $iconSource) {
    Copy-Item -Path $iconSource -Destination $targetIcon -Force
}

if (Test-Path $batSource) {
    Copy-Item -Path $batSource -Destination "$installDir\CyberAssistantVault.bat" -Force
} else {
    $batContent = @"
@echo off
set "DATA_DIR=%APPDATA%\CyberAssistantVault\Profile"
if not exist "%DATA_DIR%" mkdir "%DATA_DIR%"
set "APP_URL=https://www.amall.site/tools"
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="%APP_URL%" --user-data-dir="%DATA_DIR%" --window-size=1280,800
    exit /b
)
start "" "%APP_URL%"
exit /b
"@
    Set-Content -Path "$installDir\CyberAssistantVault.bat" -Value $batContent
}

# Create Desktop Shortcut with custom logo icon
$wshShell = New-Object -ComObject WScript.Shell

$shortcutPath = Join-Path $desktopPath "Cyber Assistant Vault.lnk"
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "$installDir\CyberAssistantVault.bat"
$shortcut.WorkingDirectory = $installDir
if (Test-Path $targetIcon) {
    $shortcut.IconLocation = $targetIcon
}
$shortcut.WindowStyle = 7
$shortcut.Description = "Cyber Assistant Vault - 1000+ Tools by AMALL"
$shortcut.Save()

# Create Start Menu Shortcut
$startShortcutPath = Join-Path $startMenuPath "Cyber Assistant Vault.lnk"
$startShortcut = $wshShell.CreateShortcut($startShortcutPath)
$startShortcut.TargetPath = "$installDir\CyberAssistantVault.bat"
$startShortcut.WorkingDirectory = $installDir
if (Test-Path $targetIcon) {
    $startShortcut.IconLocation = $targetIcon
}
$startShortcut.WindowStyle = 7
$startShortcut.Description = "Cyber Assistant Vault - 1000+ Tools by AMALL"
$startShortcut.Save()

Write-Host "[SUCCESS] Installation Complete!" -ForegroundColor Green
Write-Host "Desktop Shortcut 'Cyber Assistant Vault' with custom icon created." -ForegroundColor Green
Write-Host "Launching Cyber Assistant Vault now..." -ForegroundColor Yellow
Start-Sleep -Seconds 1

Start-Process -FilePath "$installDir\CyberAssistantVault.bat"
