#!/bin/bash

# ONE-LINER PLUG & PLAY INSTALLER
# curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

set -e

echo "🔌 PLUG & PLAY FRAMEWORK - ONE-LINER INSTALL"
echo "==========================================="

# Detect OS and install method
case "$(uname -s)" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=macOS;;
    CYGWIN*|MINGW*|MSYS*) OS=Windows;;
    *)          OS="UNKNOWN"
esac

echo "📍 OS: $OS"

# Install dependencies
echo "🔧 Installing dependencies..."

if [[ "$OS" == "Linux" ]]; then
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y build-essential cmake git curl unzip
    elif command -v yum >/dev/null 2>&1; then
        sudo yum groupinstall -y "Development Tools" && sudo yum install -y cmake git curl unzip
    fi
elif [[ "$OS" == "macOS" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || true
    brew install cmake git curl unzip || true
elif [[ "$OS" == "Windows" ]]; then
    echo "🪟 Windows: Please ensure Visual Studio Build Tools, CMake, and Git are installed"
    echo "Download: https://visualstudio.microsoft.com/downloads/"
fi

# Download and setup framework
echo "📥 Downloading framework..."
mkdir -p plugnplay && cd plugnplay
curl -L "https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip" -o temp.zip
unzip -q temp.zip
cd PLUGNPLAYCLI-master

# Build
echo "🚀 Building..."
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j4

# Download model
echo "🧠 Downloading GLM-4-9B..."
cd ..
if [ ! -f "glm-4-9b.gguf" ]; then
    curl -L "https://huggingface.co/THUDM/glm-4-9b/resolve/main/glm-4-9b.gguf" -o glm-4-9b.gguf
fi

echo ""
echo "🎆 READY TO ROCK!"
echo "cd plugnplay/PLUGNPLAYCLI-master && ./build/plugnplay"
echo ""
echo "🚀 GLM-4-9B + fireworks await! 🧠🎆🦋"