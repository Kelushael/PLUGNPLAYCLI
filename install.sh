#!/bin/bash

# Universal installer that auto-detects OS
# Run with: curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/master/install.sh | bash

echo "🔌 PLUG & PLAY FRAMEWORK - UNIVERSAL INSTALLER"
echo "==============================================="

# Auto-detect OS
case "$(uname -s)" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=macOS;;
    CYGWIN*|MINGW*|MSYS*|WIN*) OS=Windows;;
    *)          OS="UNKNOWN"
esac

echo "📍 Detected OS: $OS"

echo "📥 Downloading framework..."
curl -L "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -o framework.zip

echo "📦 Extracting..."
unzip -q framework.zip
cd PLUGNPLAYCLI-master

echo "✅ Download complete!"

# Run appropriate installer based on OS
if [[ "$OS" == "Windows" ]]; then
    echo "🪟 Running Windows installer..."
    ./install_windows.bat
elif [[ "$OS" == "macOS" ]] || [[ "$OS" == "Linux" ]]; then
    echo "🐧 Running Unix installer..."
    chmod +x install_unix.sh
    ./install_unix.sh
else
    echo "❌ Unsupported OS. Please run manually:"
    echo "  Windows: install_windows.bat"
    echo "  macOS/Linux: ./install_unix.sh"
fi

echo ""
echo "🎆 PLUG & PLAY FRAMEWORK READY!"