#!/bin/bash

echo "🔧 Plug & Play Dependency Installer"
echo "==================================="

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Installing dependencies for macOS..."

    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install dependencies
    brew install cmake git

    echo "✅ macOS dependencies installed!"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Installing dependencies for Linux..."

    # Detect package manager
    if command -v apt-get &> /dev/null; then
        # Ubuntu/Debian
        sudo apt-get update
        sudo apt-get install -y build-essential cmake git curl
    elif command -v yum &> /dev/null; then
        # CentOS/RHEL
        sudo yum groupinstall -y "Development Tools"
        sudo yum install -y cmake git curl
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        sudo pacman -Syu base-devel cmake git curl
    else
        echo "❌ Unsupported Linux distribution"
        echo "Please manually install: build-essential/cmake/git/curl"
        exit 1
    fi

    echo "✅ Linux dependencies installed!"

else
    echo "❌ Unsupported OS for dependency installation"
    echo "Please manually install: C++ compiler, CMake 3.10+, Git"
    exit 1
fi

echo ""
echo "🚀 Dependencies ready! Now run the main installer:"
echo "  ./install.sh"