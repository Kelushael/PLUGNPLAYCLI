#!/bin/bash

echo "🔌 PLUG & PLAY FRAMEWORK INSTALLER"
echo "=================================="

echo "📥 Downloading framework..."
curl -L "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -o framework.zip

echo "📦 Extracting..."
unzip -q framework.zip
cd PLUGNPLAYCLI-master

echo "✅ Download complete!"
echo "Run the appropriate installer for your OS:"
echo "  Windows: install_windows.bat"
echo "  macOS/Linux: ./install_unix.sh"
echo "  PowerShell: ./install_windows.ps1"
echo ""
echo "🚀 Ready for setup!"