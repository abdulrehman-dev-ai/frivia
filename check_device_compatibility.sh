#!/bin/bash
# Fivia Device Compatibility Check Script
# This bash script helps users check if their Android device is compatible with Fivia

# Set text colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
WHITE="\033[1;37m"
NC="\033[0m" # No Color

# Check if ADB is installed
if ! command -v adb &> /dev/null; then
    echo -e "${RED}ADB is not installed or not in PATH. Please install Android SDK Platform Tools first.${NC}"
    echo -e "${YELLOW}You can download it from: https://developer.android.com/studio/releases/platform-tools${NC}"
    exit 1
fi

echo -e "${GREEN}ADB is installed. Proceeding with device check...${NC}"

# Check for connected devices
echo -e "${CYAN}Checking for connected Android devices...${NC}"
DEVICES=$(adb devices | grep -v "List" | grep -v "^$")

if [ -z "$DEVICES" ]; then
    echo -e "${RED}No Android devices detected. Please connect your device via USB and enable USB debugging.${NC}"
    exit 1
fi

# Get device information
echo -e "\n${CYAN}Device information:${NC}"

# Get Android version
ANDROID_VERSION=$(adb shell getprop ro.build.version.release)
echo -e "${WHITE}Android version: $ANDROID_VERSION${NC}"

# Get API level
API_LEVEL=$(adb shell getprop ro.build.version.sdk)
echo -e "${WHITE}API level: $API_LEVEL${NC}"

# Get device model
DEVICE_MODEL=$(adb shell getprop ro.product.model)
echo -e "${WHITE}Device model: $DEVICE_MODEL${NC}"

# Get device manufacturer
DEVICE_MANUFACTURER=$(adb shell getprop ro.product.manufacturer)
echo -e "${WHITE}Manufacturer: $DEVICE_MANUFACTURER${NC}"

# Check compatibility
if [ "$API_LEVEL" -ge 21 ]; then
    echo -e "\n${GREEN}✅ Your device is COMPATIBLE with Fivia!${NC}"
    echo -e "${GREEN}   Fivia requires Android 5.0 (API level 21) or higher.${NC}"
else
    echo -e "\n${RED}❌ Your device is NOT COMPATIBLE with Fivia.${NC}"
    echo -e "${RED}   Fivia requires Android 5.0 (API level 21) or higher.${NC}"
    echo -e "${RED}   Your device is running API level $API_LEVEL.${NC}"
fi

# Check available storage
AVAILABLE_STORAGE=$(adb shell "df /data | awk 'NR==2 {print \$4}'")
AVAILABLE_STORAGE_MB=$(echo "scale=0; $AVAILABLE_STORAGE/1024" | bc)

echo -e "\n${WHITE}Available storage: $AVAILABLE_STORAGE_MB MB${NC}"

if [ "$AVAILABLE_STORAGE_MB" -ge 50 ]; then
    echo -e "${GREEN}✅ Your device has enough storage for Fivia (requires 50MB).${NC}"
else
    echo -e "${RED}❌ Your device may not have enough storage for Fivia (requires 50MB).${NC}"
fi

echo -e "\n${CYAN}Compatibility check complete.${NC}"