#!/bin/bash

# Universal Plug & Play Framework Installer
# Works on Windows (Git Bash/MSYS2), macOS, Linux with just curl

set -e  # Exit on any error

echo "🔌 PLUG & PLAY FRAMEWORK INSTALLER"
echo "=================================="

# Detect OS
case "$(uname -s)" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=macOS;;
    CYGWIN*|MINGW*|MSYS*) OS=Windows;;
    *)          OS="UNKNOWN:$(uname -s)"
esac

echo "📍 Detected OS: $OS"

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "📥 Downloading framework..."
# Download the repository as zip
curl -L "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -o framework.zip

echo "📦 Extracting..."
unzip -q framework.zip
cd "PLUGNPLAYCLI-master"

echo "🔧 Setting up dependencies..."

# Install dependencies based on OS
case "$OS" in
    Linux*)
        if command -v apt-get >/dev/null 2>&1; then
            echo "🐧 Ubuntu/Debian detected - installing dependencies..."
            sudo apt-get update && sudo apt-get install -y build-essential cmake git curl
        elif command -v yum >/dev/null 2>&1; then
            echo "🐧 CentOS/RHEL detected - installing dependencies..."
            sudo yum groupinstall -y "Development Tools" && sudo yum install -y cmake git curl
        elif command -v pacman >/dev/null 2>&1; then
            echo "🐧 Arch Linux detected - installing dependencies..."
            sudo pacman -Syu --noconfirm base-devel cmake git curl
        else
            echo "❌ Unsupported Linux distribution. Please install manually: build-essential cmake git"
            exit 1
        fi
        ;;

    macOS*)
        if ! command -v brew >/dev/null 2>&1; then
            echo "🍺 Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        echo "🍎 Installing macOS dependencies..."
        brew install cmake git
        ;;

    Windows*)
        echo "🪟 Windows detected - checking for Visual Studio..."
        if ! command -v cl >/dev/null 2>&1; then
            echo "❌ Visual Studio Build Tools not found!"
            echo "Please install from: https://visualstudio.microsoft.com/downloads/"
            echo "Then run this installer again."
            exit 1
        fi

        # Install CMake and Git if missing
        if ! command -v cmake >/dev/null 2>&1; then
            echo "📦 Installing CMake..."
            curl -L "https://github.com/Kitware/CMake/releases/download/v3.27.0/cmake-3.27.0-windows-x86_64.zip" -o cmake.zip
            unzip -q cmake.zip
            export PATH="$PWD/cmake-3.27.0-windows-x86_64/bin:$PATH"
        fi

        if ! command -v git >/dev/null 2>&1; then
            echo "📦 Installing Git..."
            curl -L "https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/Git-2.40.0-64-bit.exe" -o git-installer.exe
            ./git-installer.exe /VERYSILENT /NORESTART
        fi
        ;;
esac

echo "✅ Dependencies ready!"

echo "🚀 Building Plug & Play Framework..."
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc 2>/dev/null || echo 4)

echo "✅ Build successful!"

echo "🧠 Downloading GLM-4-9B model..."
cd ..
if [ ! -f "glm-4-9b.gguf" ]; then
    echo "📥 This will download ~5.5GB. Press Enter to continue..."
    read -r || true  # Continue if no input (non-interactive)
    curl -L "https://huggingface.co/THUDM/glm-4-9b/resolve/main/glm-4-9b.gguf" -o glm-4-9b.gguf
    echo "✅ Model downloaded!"
else
    echo "✅ Model already exists!"
fi

echo ""
echo "🎆 INSTALLATION COMPLETE!"
echo "Run: ./build/plugnplay"
echo ""
echo "🚀 Ready to develop with GLM-4-9B + fireworks! 🧠🎆🦋"

# Don't cleanup temp dir in case user wants to inspect