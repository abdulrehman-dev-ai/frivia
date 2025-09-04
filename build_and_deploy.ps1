# Fivia Build and Deploy Script
# This PowerShell script helps build and prepare the Fivia app for GitHub release

# Check if Flutter is installed
try {
    flutter --version | Out-Null
    Write-Host "Flutter is installed. Proceeding with build..." -ForegroundColor Green
} catch {
    Write-Host "Flutter is not installed or not in PATH. Please install Flutter first." -ForegroundColor Red
    exit 1
}

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Cyan
flutter clean

# Get dependencies
Write-Host "Getting dependencies..." -ForegroundColor Cyan
flutter pub get

# Build APK
Write-Host "Building release APK..." -ForegroundColor Cyan
flutter build apk --release

# Check if build was successful
if ($LASTEXITCODE -eq 0) {
    $apkPath = "build/app/outputs/flutter-apk/app-release.apk"
    
    if (Test-Path $apkPath) {
        # Create a releases directory if it doesn't exist
        if (-not (Test-Path "releases")) {
            New-Item -ItemType Directory -Path "releases" | Out-Null
        }
        
        # Copy the APK to the releases directory
        $version = (Get-Content pubspec.yaml | Select-String "version:") -replace "version:\s*", ""
        $version = $version.Trim()
        $targetPath = "releases/fivia-$version.apk"
        
        Copy-Item $apkPath $targetPath
        
        Write-Host "Build successful!" -ForegroundColor Green
        Write-Host "APK is available at: $apkPath" -ForegroundColor Green
        Write-Host "A copy has been saved to: $targetPath" -ForegroundColor Green
        Write-Host "
To create a GitHub release:" -ForegroundColor Yellow
        Write-Host "1. Tag your release: git tag -a v$version -m 'Release $version'" -ForegroundColor Yellow
        Write-Host "2. Push the tag: git push origin v$version" -ForegroundColor Yellow
        Write-Host "3. The GitHub Action will automatically create a release with the APK" -ForegroundColor Yellow
        Write-Host "   or manually upload $targetPath to a GitHub release" -ForegroundColor Yellow
    } else {
        Write-Host "Build completed but APK not found at expected location: $apkPath" -ForegroundColor Red
    }
} else {
    Write-Host "Build failed. Please check the error messages above." -ForegroundColor Red
}