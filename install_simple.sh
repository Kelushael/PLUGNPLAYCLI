#!/bin/bash

echo "🔌 PLUG & PLAY FRAMEWORK INSTALLER"
echo "=================================="

echo "📥 Downloading framework..."
curl -L "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -o framework.zip

echo "📦 Extracting..."
unzip -q framework.zip
cd PLUGNPLAYCLI-master

echo "✅ Download complete!"
echo "Run: cd PLUGNPLAYCLI-master && ./install_unix.sh"
echo ""
echo "🚀 Ready for manual setup!"