#Requires -Version 5.1

param(
    [switch]$SkipDeps
)

Write-Host "🔌 Plug & Play Framework Installer for Windows" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

# Check prerequisites
if (-not $SkipDeps) {
    Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow

    # Check if Visual Studio Build Tools are installed
    $vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $vsInstalled = $false

    if (Test-Path $vsWhere) {
        $vsPath = & $vsWhere -latest -property installationPath 2>$null
        if ($vsPath -and (Test-Path "$vsPath\VC\Tools\MSVC")) {
            $vsInstalled = $true
        }
    }

    if (-not $vsInstalled) {
        Write-Host "❌ Visual Studio Build Tools not found!" -ForegroundColor Red
        Write-Host "Please install Visual Studio Build Tools 2019 or later with C++ support" -ForegroundColor Yellow
        Write-Host "Download: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Yellow
        $install = Read-Host "Do you want me to try opening the download page? (y/n)"
        if ($install -eq 'y' -or $install -eq 'Y') {
            Start-Process "https://visualstudio.microsoft.com/downloads/"
        }
        exit 1
    }

    # Check for CMake
    if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
        Write-Host "❌ CMake not found!" -ForegroundColor Red
        Write-Host "Installing CMake..." -ForegroundColor Yellow

        try {
            # Try Chocolatey first
            if (Get-Command choco -ErrorAction SilentlyContinue) {
                choco install cmake -y
            } else {
                Write-Host "Please install CMake manually from: https://cmake.org/download/" -ForegroundColor Yellow
                exit 1
            }
        } catch {
            Write-Host "❌ CMake installation failed!" -ForegroundColor Red
            Write-Host "Please install CMake manually from: https://cmake.org/download/" -ForegroundColor Yellow
            exit 1
        }
    }

    # Check for Git
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "❌ Git not found!" -ForegroundColor Red
        Write-Host "Installing Git..." -ForegroundColor Yellow

        try {
            # Try Chocolatey first
            if (Get-Command choco -ErrorAction SilentlyContinue) {
                choco install git -y
            } else {
                Write-Host "Please install Git manually from: https://git-scm.com/downloads" -ForegroundColor Yellow
                exit 1
            }
        } catch {
            Write-Host "❌ Git installation failed!" -ForegroundColor Red
            Write-Host "Please install Git manually from: https://git-scm.com/downloads" -ForegroundColor Yellow
            exit 1
        }
    }

    Write-Host "✅ All prerequisites found!" -ForegroundColor Green
}

# Create build directory
if (-not (Test-Path "build")) {
    New-Item -ItemType Directory -Path "build" | Out-Null
}

Set-Location build

Write-Host "🚀 Building Plug & Play Framework..." -ForegroundColor Green

# Configure with CMake
try {
    & cmake .. -DCMAKE_BUILD_TYPE=Release
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configuration failed"
    }
} catch {
    Write-Host "❌ CMake configuration failed!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Build
try {
    & cmake --build . --config Release
    if ($LASTEXITCODE -ne 0) {
        throw "Build failed"
    }
} catch {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Build successful!" -ForegroundColor Green

# Download GLM-4-9B model
Write-Host "🚀 Downloading GLM-4-9B model..." -ForegroundColor Green

$modelPath = "..\glm-4-9b.gguf"
if (-not (Test-Path $modelPath)) {
    Write-Host "This will download ~5.5GB. Press Enter to continue or Ctrl+C to cancel..." -ForegroundColor Yellow
    Read-Host

    try {
        Write-Host "📥 Downloading GLM-4-9B from Hugging Face..." -ForegroundColor Cyan
        # Use Invoke-WebRequest for download with progress
        $url = "https://huggingface.co/THUDM/glm-4-9b/resolve/main/glm-4-9b.gguf"
        Invoke-WebRequest -Uri $url -OutFile $modelPath -UseBasicParsing

        Write-Host "✅ GLM-4-9B model downloaded!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Model download failed!" -ForegroundColor Red
        Write-Host "You can download manually from:" -ForegroundColor Yellow
        Write-Host "https://huggingface.co/THUDM/glm-4-9b" -ForegroundColor Yellow
        Write-Host "" -ForegroundColor White
        Write-Host "Place the file as: glm-4-9b.gguf in the project root" -ForegroundColor White
    }
} else {
    Write-Host "✅ GLM-4-9B model already exists" -ForegroundColor Green
}

Write-Host "" -ForegroundColor White
Write-Host "🎆 Installation complete!" -ForegroundColor Green
Write-Host "Run: .\build\Release\plugnplay.exe" -ForegroundColor Cyan
Write-Host "" -ForegroundColor White
Write-Host "🚀 Ready to develop with GLM-4-9B + fireworks! 🧠🎆" -ForegroundColor Magenta

Read-Host "Press Enter to exit"