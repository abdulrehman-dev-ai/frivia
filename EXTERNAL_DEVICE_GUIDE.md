# Running Frivia on External Device via USB

## Prerequisites

1. **Flutter SDK**: Make sure Flutter is installed on your system.
   - If not installed, download from [Flutter's official website](https://flutter.dev/docs/get-started/install).
   - Verify installation with `flutter --version`.

2. **Android SDK Platform Tools**: You need ADB (Android Debug Bridge) to connect to your device.
   - Download from [Android Developer website](https://developer.android.com/studio/releases/platform-tools).
   - Extract the downloaded zip file to a location on your computer.
   - Add the platform-tools directory to your system PATH:
     - **Windows**: 
       - Right-click on 'This PC' or 'My Computer' > Properties > Advanced system settings > Environment Variables
       - Edit the PATH variable and add the full path to the platform-tools directory
       - Example: `C:\Users\YourUsername\AppData\Local\Android\Sdk\platform-tools`
     - **Mac/Linux**: 
       - Add `export PATH=$PATH:/path/to/platform-tools` to your `.bash_profile` or `.zshrc`
   - Verify installation with `adb version`.

## Preparing Your Android Device

1. **Enable Developer Options**:
   - Go to Settings > About phone
   - Tap Build number 7 times to enable Developer options

2. **Enable USB Debugging**:
   - Go to Settings > System > Developer options
   - Enable USB debugging

3. **Connect Your Device**:
   - Connect your Android device to your computer via USB
   - Allow USB debugging when prompted on your device

## Running the App

### Method 1: Using the Script

After installing ADB, run the provided script:

```
./run_on_device.ps1
```

### Method 2: Manual Commands

1. **Verify Device Connection**:
   ```
   adb devices
   ```
   You should see your device listed.

2. **Run the App**:
   ```
   flutter run --release
   ```
   This will build and install the app on your connected device.

## Troubleshooting

1. **Device Not Detected**:
   - Make sure USB debugging is enabled
   - Try a different USB cable or port
   - Restart your device and computer

2. **Permission Issues**:
   - Make sure you've allowed USB debugging on your device
   - On Windows, try running the command prompt as Administrator

3. **Build Errors**:
   - Run `flutter doctor` to check for any issues with your Flutter installation
   - Run `flutter clean` and try again

## Using the App Logo

The app uses `assets/Frivia_logo.png` as its logo. This has been configured in:
- The home screen (`lib/screens/home_screen.dart`)
- The assets section in `pubspec.yaml`

If you want to use a different logo, replace the file at `assets/Frivia_logo.png` with your preferred image and run `flutter pub get` to update the assets.