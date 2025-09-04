# Fivia Release Guide

## Creating a GitHub Release

This guide explains how to create a new release of the Fivia app on GitHub, making the APK available for download.

### Prerequisites

- GitHub account with write access to the repository
- Git installed on your local machine
- Flutter development environment set up

### Steps to Create a Release

1. **Ensure your code is ready for release**
   - All features are implemented and tested
   - No known critical bugs
   - Version number is updated in `pubspec.yaml`
   - **IMPORTANT:** Generate the keystore file for signing the APK
     ```
     cd android
     .\generate_keystore.ps1  # On Windows
     ./generate_keystore.sh   # On macOS/Linux
     ```
     Note: Java JDK must be installed first. See `android/README_KEYSTORE.md` for detailed instructions.

2. **Create and push a new tag**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```
   Replace `v1.0.0` with your actual version number.

3. **Wait for the GitHub Action to complete**
   - The workflow will automatically build the APK
   - It will create a new release with the APK attached
   - You can monitor progress in the "Actions" tab of your GitHub repository

4. **Verify the release**
   - Go to the "Releases" section of your GitHub repository
   - Ensure the APK is attached to the release
   - Check that the release notes are generated correctly

5. **Update the release notes (optional)**
   - You can edit the release to add more detailed notes
   - Highlight key features, improvements, and bug fixes

## Manual Release Process

If you need to create a release manually without using the GitHub Action:

1. **Build the APK locally**
   ```bash
   flutter build apk --release
   ```

2. **Create a new release on GitHub**
   - Go to the "Releases" section of your repository
   - Click "Draft a new release"
   - Enter the tag version (e.g., `v1.0.0`)
   - Add a release title and description
   - Upload the APK from `build/app/outputs/flutter-apk/app-release.apk`
   - Publish the release

## Downloading and Installing the APK

To download and install the APK from a GitHub release:

1. Go to the "Releases" section of the Fivia GitHub repository
2. Find the latest release (or the specific version you want)
3. Download the APK file attached to the release
4. On your Android device, open the APK file to install it
   - You may need to enable "Install from Unknown Sources" in your device settings

## Troubleshooting

- If the GitHub Action fails, check the workflow logs for error messages
  - Common issue: Missing keystore file for signing the APK
  - Solution: Set up the `KEYSTORE_BASE64` secret in your GitHub repository settings
    - Generate a keystore file locally
    - Convert it to base64: `base64 -i fivia.keystore -o fivia.keystore.base64`
    - Add the content as a secret named `KEYSTORE_BASE64` in your repository settings
- If users report installation issues, ensure they have enabled "Install from Unknown Sources"
- For any other issues, please create a GitHub issue with detailed information