#Requires -Version 5.1

Write-Host "🔧 Plug & Play Dependency Installer for Windows" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

# Check if running as administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "❌ Please run as Administrator for dependency installation" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "📦 Installing Windows dependencies..." -ForegroundColor Green

# Install Chocolatey if not present
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📥 Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install dependencies via Chocolatey
Write-Host "📦 Installing CMake..." -ForegroundColor Yellow
choco install cmake -y

Write-Host "📦 Installing Git..." -ForegroundColor Yellow
choco install git -y

# Check for Visual Studio Build Tools
Write-Host "🔍 Checking for Visual Studio Build Tools..." -ForegroundColor Yellow
$vsPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $vsPath) {
    $vsInstallPath = & $vsPath -latest -property installationPath
    if ($vsInstallPath) {
        Write-Host "✅ Visual Studio Build Tools found!" -ForegroundColor Green
    } else {
        Write-Host "❌ Visual Studio Build Tools not found!" -ForegroundColor Red
        Write-Host "Please install Visual Studio Build Tools 2019+ with C++ support" -ForegroundColor Yellow
        Write-Host "Download: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Visual Studio installer not found!" -ForegroundColor Red
    Write-Host "Please install Visual Studio Build Tools 2019+ with C++ support" -ForegroundColor Yellow
    Write-Host "Download: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Yellow
}

Write-Host "" -ForegroundColor White
Write-Host "✅ Dependencies installed!" -ForegroundColor Green
Write-Host "🚀 Now run the main installer:" -ForegroundColor Cyan
Write-Host "  .\install_windows.bat" -ForegroundColor White

Read-Host "Press Enter to continue"