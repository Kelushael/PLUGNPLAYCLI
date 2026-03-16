# Plug & Play - ONE COMMAND INSTALLER
# Run with: irm https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/master/install.ps1 | iex
# That's IT. Done. Works.

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PLUG & PLAY - ONE COMMAND INSTALLER" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Download
Write-Host "[1/4] Downloading framework..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -OutFile "framework.zip"

# Step 2: Extract  
Write-Host "[2/4] Extracting..." -ForegroundColor Yellow
Expand-Archive -Path "framework.zip" -DestinationPath "." -Force

# Step 3: Go to folder
Set-Location "PLUGNPLAYCLI-master"

# Step 4: Check for compiler
$hasCompiler = $false
$clPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\*\bin\Hostx64\x64\cl.exe"
if (Test-Path $clPath) { $hasCompiler = $true }
$clPath2 = "C:\Program Files (x86)\Microsoft Visual Studio\*\*\VC\Tools\MSVC\*\*\bin\Hostx64\x64\cl.exe"
if (Test-Path $clPath2) { $hasCompiler = $true }

if (-not $hasCompiler) {
    Write-Host "[3/4] Installing Visual Studio Build Tools..." -ForegroundColor Yellow
    # Download VS Build Tools installer
    $vsInstaller = "vs_buildtools.exe"
    Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_buildtools.exe" -OutFile $vsInstaller
    Write-Host "Installing... This takes a few minutes..." -ForegroundColor Yellow
    Start-Process -Wait -FilePath $vsInstaller -ArgumentList "--quiet", "--wait", "--norestart", "--add", "Microsoft.VisualStudio.Workload.VCTools", "--add", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64", "--add", "Microsoft.VisualStudio.Component.Windows11SDK.22621"
    Remove-Item $vsInstaller -Force
}

# Step 5: Compile
Write-Host "[4/4] Compiling..." -ForegroundColor Yellow

# Find cl.exe
$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Community"
if (Test-Path $vsPath) {
    $cl = Get-ChildItem -Path "$vsPath\VC\Tools\MSVC" -Recurse -Filter "cl.exe" | Select-Object -First 1
    if ($cl) {
        $env:Path += ";" + $cl.DirectoryName
    }
}

$vsPath2 = "C:\Program Files (x86)\Microsoft Visual Studio"
if (Test-Path $vsPath2) {
    $cl2 = Get-ChildItem -Path $vsPath2 -Recurse -Filter "cl.exe" | Select-Object -First 1
    if ($cl2 -and -not $cl) {
        $env:Path += ";" + $cl2.DirectoryName
    }
}

# Try to compile
$compileCmd = "cl /EHsc /O2 /std:c++17 server.cpp /Fe:pnp.exe"
try {
    Invoke-Expression $compileCmd 2>$null
    if (Test-Path "plugnplay.exe") {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  COMPILATION SUCCESSFUL!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        
        # Create pnp launcher for easy access
        $pnpScript = @"
@echo off
"%~dp0pnp.exe"
"@ 
        $pnpScript | Out-File -FilePath "pnp.bat" -Encoding ASCII
        
        Write-Host "DONE!" -ForegroundColor Green
        Write-Host "===============" -ForegroundColor Green
        Write-Host ""
        Write-Host "NOW JUST TYPE: pnp" -ForegroundColor Cyan
        Write-Host "AND BOOM!" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "Type 'pnp' to start!" -ForegroundColor Yellow
        
        # Run it!
        Write-Host ""
        Write-Host "Starting Plug & Play..." -ForegroundColor Cyan
        Write-Host ""
        & ".\pnp.exe"
    } else {
        Write-Host "[ERROR] Compilation failed. Please install VS Build Tools manually." -ForegroundColor Red
        Write-Host "Download: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERROR] $_.Exception.Message" -ForegroundColor Red
}
