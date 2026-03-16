#!/bin/bash

echo "🔌 Universal Plug & Play Framework Installer"
echo "============================================="

# Auto-detect OS and run appropriate installer
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    echo "🎯 Detected Windows"
    # Run Windows batch file
    if command -v cmd.exe &> /dev/null; then
        cmd.exe /c install_windows.bat
    else
        echo "❌ Cannot run Windows installer from this environment"
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Detected macOS"
    chmod +x install_unix.sh
    ./install_unix.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Detected Linux"
    chmod +x install_unix.sh
    ./install_unix.sh
else
    echo "❌ Unsupported OS: $OSTYPE"
    echo "Supported: Windows, macOS, Linux"
    exit 1
fi