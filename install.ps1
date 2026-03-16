# Universal Plug & Play Installer for PowerShell
# Run with: irm https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/master/install.ps1 | iex

Write-Host "PLUG & PLAY FRAMEWORK - UNIVERSAL INSTALLER" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

Write-Host "[DOWNLOAD] Downloading framework..." -ForegroundColor Green
Invoke-WebRequest -Uri "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -OutFile "framework.zip"

Write-Host "[EXTRACT] Extracting..." -ForegroundColor Green
Expand-Archive -Path "framework.zip" -DestinationPath "." -Force

Write-Host "[OK] Download complete!" -ForegroundColor Green
Write-Host "[INSTALL] Running Windows installer..." -ForegroundColor Yellow

# Run the Windows installer
Set-Location "PLUGNPLAYCLI-master"
& ".\install_windows.ps1"

Write-Host "" -ForegroundColor White
Write-Host "PLUG & PLAY FRAMEWORK READY!" -ForegroundColor Magenta
Write-Host "Run: .\build\Release\plugnplay.exe" -ForegroundColor Cyan