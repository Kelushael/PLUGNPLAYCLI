# 🔌 PLUG & PLAY FRAMEWORK - UNIVERSAL INSTALLERS
# ==================================================
# Copy-paste ONE of these commands for your platform

## 🪟 WINDOWS
# PowerShell (recommended)
irm https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.ps1 | iex

# PowerShell (full command)
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.ps1 | iex"

# CMD via PowerShell
powershell -c "irm https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.ps1 | iex"

## 🍎 macOS
# Homebrew + Framework
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && brew install cmake git && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Direct (if you have Xcode/tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh)"

# Manual download
curl -L https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip -o framework.zip && unzip framework.zip && cd PLUGNPLAYCLI-master && ./install_unix.sh

## 🐧 LINUX
# Ubuntu/Debian
sudo apt update && sudo apt install -y build-essential cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# CentOS/RHEL/Fedora
sudo yum install -y gcc-c++ cmake git curl unzip || sudo dnf install -y gcc-c++ cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Arch Linux
sudo pacman -Syu --noconfirm base-devel cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Alpine Linux
sudo apk add build-base cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Generic Linux
curl -L https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip -o framework.zip && unzip framework.zip && cd PLUGNPLAYCLI-master && ./install_unix.sh

## 🤖 ANDROID (Termux)
# Termux pkg
pkg update && pkg install -y clang cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Termux apt
apt update && apt install -y clang cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Termux manual
curl -L https://github.com/Kelushael/PLUGNPLAYCLI/archive/refs/heads/master.zip -o framework.zip && unzip framework.zip && cd PLUGNPLAYCLI-master && ./install_unix.sh

## 📦 NODE.JS/NPM
# Cross-platform (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && source ~/.bashrc && nvm install node && nvm use node && npm install -g cmake-js && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Windows (winget)
winget install OpenJS.NodeJS.LTS && npm install -g cmake-js && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.ps1 | iex

# macOS
brew install node && npm install -g cmake-js && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Linux (Ubuntu/Debian)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs && npm install -g cmake-js && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

## 📦 ADDITIONAL PACKAGE MANAGERS
# Snap (Ubuntu/snapd systems)
sudo snap install cmake --classic && sudo apt install -y build-essential git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# Flatpak (universal Linux)
flatpak install -y flathub org.freedesktop.Sdk.Extension.cmake && sudo apt install -y build-essential git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# FreeBSD
sudo pkg install -y cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# OpenBSD
doas pkg_add cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

# NetBSD
sudo pkgin install cmake git curl unzip && curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash

## 🎯 NOTES
# - All commands install dependencies + framework + GLM-4-9B model
# - Windows requires PowerShell (comes with Windows 10+)
# - macOS requires Xcode Command Line Tools
# - Linux requires sudo for package installation
# - Android requires Termux app

# Repository: https://github.com/Kelushael/PLUGNPLAYCLI