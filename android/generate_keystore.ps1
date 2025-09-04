# PowerShell script to generate a keystore for signing Android apps

$keystorePath = "fivia.keystore"
$alias = "fivia"
$password = "fivia123"
$validity = 10000 # validity in days

# Check if Java is installed
try {
    $javaVersion = & java -version 2>&1
    Write-Host "Java is installed. Proceeding with keystore generation..."
} catch {
    Write-Host "Error: Java is not installed or not in PATH. Please install Java JDK and try again."
    Write-Host "See README_KEYSTORE.md for detailed instructions on installing Java."
    exit 1
}

# Generate the keystore
Write-Host "Generating keystore file: $keystorePath"
Write-Host "This will create a new keystore for signing your Android app."
Write-Host "You will be prompted to enter some information for the certificate."

# Build the keytool command
$keytoolCmd = "keytool -genkey -v -keystore $keystorePath -alias $alias -keyalg RSA -keysize 2048 -validity $validity -storepass $password -keypass $password"

# Execute the command
Invoke-Expression $keytoolCmd

if (Test-Path $keystorePath) {
    Write-Host "\nKeystore generated successfully at: $keystorePath"
    Write-Host "\nKeystore details:"
    Write-Host "  Path: $keystorePath"
    Write-Host "  Alias: $alias"
    Write-Host "  Password: $password"
    Write-Host "  Validity: $validity days"
    
    # Move the keystore to the android directory if it's not already there
    if (!(Test-Path "android\$keystorePath")) {
        Copy-Item $keystorePath -Destination "android\$keystorePath"
        Write-Host "\nKeystore copied to android directory."
    }
    
    Write-Host "\nYou can now build a signed APK using: flutter build apk --release"
} else {
    Write-Host "\nError: Failed to generate keystore."
    exit 1
}