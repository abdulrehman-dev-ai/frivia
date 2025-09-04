# Android Compatibility Guide for Fivia App

## Overview

This guide explains the configurations made to ensure Fivia runs on all Android devices without Google Play Protect warnings.

## Compatibility Features

1. **Wide Device Support**
   - Minimum SDK set to 21 (Android 5.0 Lollipop), supporting over 99% of active Android devices
   - MultiDex support for devices with method count limitations
   - Hardware acceleration enabled for smooth animations

2. **Security Enhancements**
   - Proper app signing with custom keystore
   - ProGuard enabled for code obfuscation and optimization
   - Appropriate backup and data extraction rules

3. **Google Play Protect Compliance**
   - Proper application ID format (com.fivia.quiz)
   - Target SDK set to latest stable version (34)
   - Explicit permissions declaration

## Building a Release APK

### Step 1: Generate a Keystore (First time only)

```
cd android
.\generate_keystore.ps1
```

This will create a keystore file with the following properties:
- Path: android/fivia.keystore
- Alias: fivia
- Password: fivia123
- Validity: 10000 days

### Step 2: Build the Release APK

```
flutter build apk --release
```

The optimized APK will be available at:
`build/app/outputs/flutter-apk/app-release.apk`

## Installation Notes

1. When installing on devices, you may need to enable "Install from Unknown Sources" in your device settings.

2. The app has been configured to minimize Google Play Protect warnings, but if you encounter any:
   - Ensure you're using the signed release build
   - Consider publishing to Google Play for full verification

## Troubleshooting

If you encounter compatibility issues:

1. **App crashes on older devices**
   - Verify MultiDex is working correctly
   - Check if any third-party libraries have compatibility issues

2. **Google Play Protect warnings**
   - Ensure you're using the properly signed release build
   - Verify the app is not requesting unnecessary permissions

3. **Performance issues**
   - Try disabling hardware acceleration in AndroidManifest.xml if graphics glitches occur
   - Consider reducing animations on lower-end devices