#!/bin/bash

echo "🔌 Plug & Play Framework Installer"
echo "=================================="

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
else
    echo "❌ Unsupported OS: $OSTYPE"
    exit 1
fi

echo "📍 Detected OS: $OS"

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check for C++ compiler
if ! command -v clang++ &> /dev/null && ! command -v g++ &> /dev/null; then
    echo "❌ C++ compiler not found!"
    echo "Please install Xcode Command Line Tools (macOS) or build-essential (Linux)"
    if [[ "$OS" == "macOS" ]]; then
        echo "Run: xcode-select --install"
    else
        echo "Run: sudo apt-get install build-essential"
    fi
    exit 1
fi

# Check for CMake
if ! command -v cmake &> /dev/null; then
    echo "❌ CMake not found!"
    echo "Please install CMake 3.10 or later"
    if [[ "$OS" == "macOS" ]]; then
        echo "Run: brew install cmake"
    else
        echo "Run: sudo apt-get install cmake"
    fi
    exit 1
fi

# Check for Git
if ! command -v git &> /dev/null; then
    echo "❌ Git not found!"
    echo "Please install Git"
    if [[ "$OS" == "macOS" ]]; then
        echo "Run: brew install git"
    else
        echo "Run: sudo apt-get install git"
    fi
    exit 1
fi

echo "✅ All prerequisites found!"

# Create build directory
mkdir -p build
cd build

echo "🚀 Building Plug & Play Framework..."
cmake .. -DCMAKE_BUILD_TYPE=Release
if [ $? -ne 0 ]; then
    echo "❌ CMake configuration failed!"
    exit 1
fi

make -j$(nproc)
if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo "✅ Build successful!"

# Download GLM-4-9B model
echo "🚀 Downloading GLM-4-9B model..."
if [ ! -f "../glm-4-9b.gguf" ]; then
    echo "This will download ~5.5GB. Press Enter to continue..."
    read -r

    # Real implementation would download from Hugging Face
    echo "📥 Downloading GLM-4-9B..."
    curl -L "https://huggingface.co/THUDM/glm-4-9b/resolve/main/glm-4-9b.gguf" \
         -o "../glm-4-9b.gguf" \
         --progress-bar

    if [ $? -ne 0 ]; then
        echo "❌ Model download failed! You can download manually from:"
        echo "https://huggingface.co/THUDM/glm-4-9b"
    else
        echo "✅ GLM-4-9B model downloaded!"
    fi
else
    echo "✅ GLM-4-9B model already exists"
fi

echo ""
echo "🎆 Installation complete!"
echo "Run: ./build/plugnplay"
echo ""
echo "🚀 Ready to develop with GLM-4-9B + fireworks! 🧠🎆"