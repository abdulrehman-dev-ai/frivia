# Frivia Device Compatibility Check Script
# This PowerShell script helps users check if their Android device is compatible with Frivia

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
    exit 1
}

# Get device information
Write-Host "\nDevice information:" -ForegroundColor Cyan

# Get Android version
$androidVersion = adb shell getprop ro.build.version.release
Write-Host "Android version: $androidVersion" -ForegroundColor White

# Get API level
$apiLevel = adb shell getprop ro.build.version.sdk
Write-Host "API level: $apiLevel" -ForegroundColor White

# Get device model
$deviceModel = adb shell getprop ro.product.model
Write-Host "Device model: $deviceModel" -ForegroundColor White

# Get device manufacturer
$deviceManufacturer = adb shell getprop ro.product.manufacturer
Write-Host "Manufacturer: $deviceManufacturer" -ForegroundColor White

# Check compatibility
if ([int]$apiLevel -ge 21) {
    Write-Host "\n✅ Your device is COMPATIBLE with Frivia!" -ForegroundColor Green
    Write-Host "   Frivia requires Android 5.0 (API level 21) or higher." -ForegroundColor Green
} else {
    Write-Host "\n❌ Your device is NOT COMPATIBLE with Frivia." -ForegroundColor Red
    Write-Host "   Frivia requires Android 5.0 (API level 21) or higher." -ForegroundColor Red
    Write-Host "   Your device is running API level $apiLevel." -ForegroundColor Red
}

# Check available storage
$availableStorage = adb shell "df /data | awk 'NR==2 {print `$4}'"
$availableStorageMB = [math]::Round([int]$availableStorage / 1024)

Write-Host "\nAvailable storage: $availableStorageMB MB" -ForegroundColor White

if ($availableStorageMB -ge 50) {
    Write-Host "✅ Your device has enough storage for Frivia (requires 50MB)." -ForegroundColor Green
} else {
    Write-Host "❌ Your device may not have enough storage for Frivia (requires 50MB)." -ForegroundColor Red
}

Write-Host "\nCompatibility check complete." -ForegroundColor Cyan