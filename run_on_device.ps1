# Frivia - Run on External Device Script
# This PowerShell script helps users run the Frivia app on an external Android device via USB

# Check if Flutter is installed
try {
    flutter --version | Out-Null
    Write-Host "Flutter is installed. Proceeding..." -ForegroundColor Green
} catch {
    Write-Host "Flutter is not installed or not in PATH. Please install Flutter first." -ForegroundColor Red
    Write-Host "You can download it from: https://flutter.dev/docs/get-started/install" -ForegroundColor Yellow
    exit 1
}

# Check if ADB is installed
try {
    adb version | Out-Null
    Write-Host "ADB is installed. Proceeding with device check..." -ForegroundColor Green
} catch {
    Write-Host "ADB is not installed or not in PATH. Please install Android SDK Platform Tools first." -ForegroundColor Red
    Write-Host "You can download it from: https://developer.android.com/studio/releases/platform-tools" -ForegroundColor Yellow
    exit 1
}

# Check for connected devices
Write-Host "Checking for connected Android devices..." -ForegroundColor Cyan
$devices = adb devices

if ($devices.Count -le 1) {
    Write-Host "No Android devices detected. Please connect your device via USB and enable USB debugging." -ForegroundColor Red
    Write-Host "\nTo enable USB debugging:" -ForegroundColor Yellow
    Write-Host "1. Go to Settings > About phone" -ForegroundColor Yellow
    Write-Host "2. Tap Build number 7 times to enable Developer options" -ForegroundColor Yellow
    Write-Host "3. Go to Settings > System > Developer options" -ForegroundColor Yellow
    Write-Host "4. Enable USB debugging" -ForegroundColor Yellow
    Write-Host "5. Connect your device to your computer via USB" -ForegroundColor Yellow
    Write-Host "6. Allow USB debugging when prompted on your device" -ForegroundColor Yellow
    exit 1
}

# Run the app on the connected device
Write-Host "\nRunning Frivia app on connected device..." -ForegroundColor Cyan
Write-Host "This may take a few moments..." -ForegroundColor Yellow

# Change to the project directory (already in the correct directory)
# Run the Flutter app in debug mode
flutter run --release

# Note: Using --release flag for better performance on real devices
# You can use --debug instead if you need debugging capabilities