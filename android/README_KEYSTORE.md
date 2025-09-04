# Keystore Generation Instructions

## Important Note

The automatic keystore generation script requires Java to be installed. If you see an error like `java is not recognized as the name of a cmdlet, function, script file, or operable program`, you need to install Java first.

## Installing Java

1. Download and install the Java Development Kit (JDK) from [Oracle's website](https://www.oracle.com/java/technologies/downloads/) or use OpenJDK
2. Add Java to your system PATH:
   - **Windows**: Edit system environment variables and add the path to the Java bin directory (e.g., `C:\Program Files\Java\jdk-17\bin`)
   - **macOS/Linux**: Add `export JAVA_HOME=/path/to/jdk` and `export PATH=$PATH:$JAVA_HOME/bin` to your `.bash_profile` or `.zshrc`
3. Verify installation by running `java -version` in your terminal

## Using the Shell Script on macOS/Linux

If you're using macOS or Linux, make the shell script executable first:

```
chmod +x generate_keystore.sh
./generate_keystore.sh
```

## Manual Keystore Creation

1. Make sure Java JDK is installed as described above

2. Run the following command in your terminal:

```
keytool -genkey -v -keystore fivia.keystore -alias fivia -keyalg RSA -keysize 2048 -validity 10000 -storepass fivia123 -keypass fivia123
```

3. When prompted, enter your details (name, organization, etc.)

4. Place the generated `fivia.keystore` file in the `android/` directory

5. The `key.properties` file is already configured with the following settings:
   - storePassword=fivia123
   - keyPassword=fivia123
   - keyAlias=fivia
   - storeFile=../fivia.keystore

## Building Without a Keystore

If you want to build the app without creating a keystore, the build process will automatically fall back to using the debug keystore. However, for production releases, a proper keystore is strongly recommended to prevent Google Play Protect warnings.