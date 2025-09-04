#!/bin/bash

# Shell script to generate a keystore for signing Android apps

KEYSTORE_PATH="fivia.keystore"
ALIAS="fivia"
PASSWORD="fivia123"
VALIDITY=10000 # validity in days

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "Error: Java is not installed or not in PATH. Please install Java JDK and try again."
    echo "See README_KEYSTORE.md for detailed instructions on installing Java."
    exit 1
fi

echo "Java is installed. Proceeding with keystore generation..."

# Generate the keystore
echo "Generating keystore file: $KEYSTORE_PATH"
echo "This will create a new keystore for signing your Android app."
echo "You will be prompted to enter some information for the certificate."

# Build the keytool command
KEYTOOL_CMD="keytool -genkey -v -keystore $KEYSTORE_PATH -alias $ALIAS -keyalg RSA -keysize 2048 -validity $VALIDITY -storepass $PASSWORD -keypass $PASSWORD"

# Execute the command
eval $KEYTOOL_CMD

if [ -f "$KEYSTORE_PATH" ]; then
    echo "\nKeystore generated successfully at: $KEYSTORE_PATH"
    echo "\nKeystore details:"
    echo "  Path: $KEYSTORE_PATH"
    echo "  Alias: $ALIAS"
    echo "  Password: $PASSWORD"
    echo "  Validity: $VALIDITY days"
    
    # Move the keystore to the android directory if it's not already there
    if [ ! -f "android/$KEYSTORE_PATH" ]; then
        cp $KEYSTORE_PATH android/$KEYSTORE_PATH 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "\nKeystore copied to android directory."
        fi
    fi
    
    echo "\nYou can now build a signed APK using: flutter build apk --release"
else
    echo "\nError: Failed to generate keystore."
    exit 1
fi