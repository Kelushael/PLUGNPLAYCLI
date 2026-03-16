# Plug & Play - Full Stack AI Framework

A plug-and-play executable that launches the complete Zaphod AI framework with fireworks animation and native tool-calling.

## Features

- **🔌 Plug & Play**: Zero configuration - downloads GLM-4-9B automatically
- **🎆 Fireworks Animation**: Animated startup sequence using Unicode emojis
- **🦋 Cocoon Loading**: ASCII animation shows model loading progress
- **🔥 Fire Error Art**: Dramatic fire animation for any errors
- **🛠️ Native Tool-Calling**: Built-in tool calling at protocol level
- **🔄 Recursive Stack Launch**: One command starts entire development environment
- **🧠 GLM-4-9B**: Advanced reasoning, code generation, and tool-calling

## Installation

### Quick Install (Recommended)

**🚀 ONE-LINER INSTALL (All OS):**
```bash
curl -fsSL https://raw.githubusercontent.com/Kelushael/PLUGNPLAYCLI/main/install.sh | bash
```

**That's it.** Auto-detects OS, installs dependencies, builds framework, downloads GLM-4-9B model, and sets you up for development!

### Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Kelushael/PLUGNPLAYCLI.git
   cd PLUGNPLAYCLI
   ```

2. **Setup dependencies (optional but recommended):**
   - **Windows:** Run `setup_deps_windows.ps1` as Administrator
   - **macOS/Linux:** Run `chmod +x setup_deps.sh && ./setup_deps.sh`

3. **Run the installer:**
   - **Windows:** Double-click `install_windows.bat`
   - **macOS/Linux:** Run `chmod +x install_unix.sh && ./install_unix.sh`
   - **Universal:** Run `./install.sh` (auto-detects OS)

4. **Done!** The installer handles:
   - ✅ Dependency checking (CMake, compilers, Git)
   - ✅ Building the framework
   - ✅ Downloading GLM-4-9B model (~5.5GB)
   - ✅ Ready to run with `plugnplay.exe` or `./plugnplay`

## Usage

```bash
# Build the project
cmake -B build
cmake --build build

# Run - that's it! Everything launches automatically
./build/plugnplay.exe
```

## What It Does

1. **Automatic Model Download**: Downloads GLM-4-9B model if not present
2. **Cocoon Animation**: Shows shaking cocoons during loading
3. **Framework Launch**: Starts CLI agent and all dependent processes
4. **Server Startup**: Launches Zaphod server with fireworks animation
5. **API Ready**: Provides completion and tool-calling endpoints

## API Endpoints

- `POST /completion` - Generate text completion
- `POST /tool_call` - Execute tool calls
- `GET /status` - Server status

## Philosophy

"One command triggers entire framework stack" - no manual setup, no config files, no model paths. Just run and develop.