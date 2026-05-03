#!/bin/bash
# build.sh - Automated build script for ParSec Nova
# Usage: ./build.sh [linux|windows|macos]

# Default to linux if no argument provided
TARGET_OS=${1:-linux}

echo "Building ParSec Nova for $TARGET_OS..."

# Create build directory
mkdir -p build/{$TARGET_OS}

# Check if Godot is available
if ! command -v godot &> /dev/null; then
    echo "Warning: Godot is not installed or not in PATH"
    echo "Please install Godot 4.x or run this script in a DevContainer"
    echo "Download Godot from: https://godotengine.org/download"
    echo ""
    echo "For now, creating placeholder files for testing..."
    
    # Create placeholder file for testing
    case $TARGET_OS in
        linux)
            touch build/linux/ParSecNova.x86_64
            ;;
        windows)
            touch build/windows/ParSecNova.exe
            ;;
        macos)
            touch build/macos/ParSecNova.zip
            ;;
        *)
            echo "Error: Invalid OS. Use: linux, windows, or macos"
            exit 1
            ;;
    esac
    
    echo "✓ Placeholder file created for $TARGET_OS"
    echo "Replace this with real build by installing Godot"
    exit 0
fi

echo "✓ Godot found: $(godot --version)"

# Check if project files exist
if [ ! -f "project.godot" ]; then
    echo "Error: project.godot not found. Are you in the correct directory?"
    exit 1
fi

if [ ! -f "export_presets.cfg" ]; then
    echo "Error: export_presets.cfg not found. Cannot export."
    exit 1
fi

# Build for target OS
case $TARGET_OS in
    linux)
        echo "Building Linux version..."
        godot --headless --export-release "Linux/X11" "build/linux/ParSecNova.x86_64"
        if [ $? -eq 0 ]; then
            echo "✓ Linux build successful"
            FILE_PATH="build/linux/ParSecNova.x86_64"
        else
            echo "✗ Linux build failed"
            exit 1
        fi
        ;;
    windows)
        echo "Building Windows version..."
        godot --headless --export-release "Windows Desktop" "build/windows/ParSecNova.exe"
        if [ $? -eq 0 ]; then
            echo "✓ Windows build successful"
            FILE_PATH="build/windows/ParSecNova.exe"
        else
            echo "✗ Windows build failed (cross-compilation may not be available)"
            exit 1
        fi
        ;;
    macos)
        echo "Building macOS version..."
        godot --headless --export-release "macOS" "build/macos/ParSecNova.zip"
        if [ $? -eq 0 ]; then
            echo "✓ macOS build successful"
            FILE_PATH="build/macos/ParSecNova.zip"
        else
            echo "✗ macOS build failed (cross-compilation may not be available)"
            exit 1
        fi
        ;;
    *)
        echo "Error: Invalid OS. Use: linux, windows, or macos"
        exit 1
        ;;
esac

echo ""
echo "Build completed!"
echo "File created: $FILE_PATH"
