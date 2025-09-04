#!/bin/bash
# Fivia Build and Deploy Script
# This bash script helps build and prepare the Fivia app for GitHub release

# Set text colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Flutter is not installed or not in PATH. Please install Flutter first.${NC}"
    exit 1
fi

echo -e "${GREEN}Flutter is installed. Proceeding with build...${NC}"

# Clean previous builds
echo -e "${CYAN}Cleaning previous builds...${NC}"
flutter clean

# Get dependencies
echo -e "${CYAN}Getting dependencies...${NC}"
flutter pub get

# Build APK
echo -e "${CYAN}Building release APK...${NC}"
flutter build apk --release

# Check if build was successful
if [ $? -eq 0 ]; then
    APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
    
    if [ -f "$APK_PATH" ]; then
        # Create a releases directory if it doesn't exist
        mkdir -p releases
        
        # Extract version from pubspec.yaml
        VERSION=$(grep 'version:' pubspec.yaml | sed 's/version:\s*//' | tr -d '[:space:]')
        TARGET_PATH="releases/fivia-$VERSION.apk"
        
        # Copy the APK to the releases directory
        cp "$APK_PATH" "$TARGET_PATH"
        
        echo -e "${GREEN}Build successful!${NC}"
        echo -e "${GREEN}APK is available at: $APK_PATH${NC}"
        echo -e "${GREEN}A copy has been saved to: $TARGET_PATH${NC}"
        echo -e "\n${YELLOW}To create a GitHub release:${NC}"
        echo -e "${YELLOW}1. Tag your release: git tag -a v$VERSION -m 'Release $VERSION'${NC}"
        echo -e "${YELLOW}2. Push the tag: git push origin v$VERSION${NC}"
        echo -e "${YELLOW}3. The GitHub Action will automatically create a release with the APK${NC}"
        echo -e "${YELLOW}   or manually upload $TARGET_PATH to a GitHub release${NC}"
    else
        echo -e "${RED}Build completed but APK not found at expected location: $APK_PATH${NC}"
    fi
else
    echo -e "${RED}Build failed. Please check the error messages above.${NC}"
fi