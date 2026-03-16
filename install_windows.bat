@echo off
echo 🔌 Plug & Play Framework Installer for Windows
echo ===============================================

REM Check if Visual Studio Build Tools are installed
where cl >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Visual Studio Build Tools not found!
    echo Please install Visual Studio Build Tools 2019 or later with C++ support
    echo Download: https://visualstudio.microsoft.com/downloads/
    pause
    exit /b 1
)

REM Check if CMake is installed
where cmake >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ CMake not found!
    echo Please install CMake 3.10 or later
    echo Download: https://cmake.org/download/
    pause
    exit /b 1
)

REM Check if Git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git not found!
    echo Please install Git
    echo Download: https://git-scm.com/downloads
    pause
    exit /b 1
)

echo ✅ All prerequisites found!

REM Create build directory
if not exist build mkdir build
cd build

echo 🚀 Building Plug & Play Framework...
cmake .. -DCMAKE_BUILD_TYPE=Release
if %errorlevel% neq 0 (
    echo ❌ CMake configuration failed!
    pause
    exit /b 1
)

cmake --build . --config Release
if %errorlevel% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo ✅ Build successful!

REM Download GLM-4-9B model
echo 🚀 Downloading GLM-4-9B model...
if not exist ..\glm-4-9b.gguf (
    echo This will download ~5.5GB. Press any key to continue...
    pause >nul
    REM In real implementation, use curl or similar
    echo Model download placeholder - implement actual download here
) else (
    echo ✅ GLM-4-9B model already exists
)

echo 🎆 Installation complete!
echo Run: build\Release\plugnplay.exe
pause