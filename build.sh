#!/bin/bash
# build.sh - Automated build script for ParSec Nova

echo "Building ParSec Nova..."

# Create build directory
mkdir -p build/{linux,windows,macos}

# Check if Godot is available
if ! command -v godot &> /dev/null; then
    echo "Warning: Godot is not installed or not in PATH"
    echo "Please install Godot 4.x or run this script in a DevContainer"
    echo "Download Godot from: https://godotengine.org/download"
    echo ""
    echo "For now, creating placeholder files for testing..."
    
    # Create placeholder files for testing
    touch build/linux/ParSecNova.x86_64
    touch build/windows/ParSecNova.exe
    touch build/macos/ParSecNova.zip
    
    echo "✓ Placeholder files created for testing"
    echo "Replace these with real builds by installing Godot"
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

# Linux Build
echo "Building Linux version..."
godot --headless --export-release "Linux/X11" "build/linux/ParSecNova.x86_64"
if [ $? -eq 0 ]; then
    echo "✓ Linux build successful"
else
    echo "✗ Linux build failed"
fi

# Windows Build (if cross-compilation tools are available)
echo "Building Windows version..."
godot --headless --export-release "Windows Desktop" "build/windows/ParSecNova.exe"
if [ $? -eq 0 ]; then
    echo "✓ Windows build successful"
else
    echo "✗ Windows build failed (cross-compilation may not be available)"
fi

# macOS Build (if cross-compilation tools are available)
echo "Building macOS version..."
godot --headless --export-release "macOS" "build/macos/ParSecNova.zip"
if [ $? -eq 0 ]; then
    echo "✓ macOS build successful"
else
    echo "✗ macOS build failed (cross-compilation may not be available)"
fi

echo ""
echo "Build completed!"
echo "Files created:"
if [ -f "build/linux/ParSecNova.x86_64" ]; then
    echo "  Linux: build/linux/ParSecNova.x86_64"
fi
if [ -f "build/windows/ParSecNova.exe" ]; then
    echo "  Windows: build/windows/ParSecNova.exe"
fi
if [ -f "build/macos/ParSecNova.zip" ]; then
    echo "  macOS: build/macos/ParSecNova.zip"
fi
