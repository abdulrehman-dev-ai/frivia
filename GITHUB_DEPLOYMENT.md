# GitHub Deployment Guide for Fivia

This guide provides step-by-step instructions for deploying the Fivia app to GitHub, allowing users to download the APK from GitHub releases.

## Prerequisites

- GitHub account
- Git installed on your local machine
- Flutter development environment set up
- Completed Fivia app codebase

## Step 1: Create a GitHub Repository

1. Log in to your GitHub account
2. Click the "+" icon in the top-right corner and select "New repository"
3. Name your repository (e.g., "fivia")
4. Add a description: "A beautiful trivia quiz app built with Flutter"
5. Choose public or private visibility as needed
6. Select "Add a README file" if you haven't created one locally
7. Choose "Add .gitignore" with the "Flutter" template
8. Select a license (MIT recommended)
9. Click "Create repository"

## Step 2: Push Your Code to GitHub

If you created the repository with a README and .gitignore:

```bash
# Clone the repository
git clone https://github.com/frivia-app/frivia.git

# Copy your project files to the cloned directory
# (excluding .git, build/, and other files already in .gitignore)

# Add all files to git
git add .

# Commit the changes
git commit -m "Initial commit: Fivia app"

# Push to GitHub
git push origin main
```

If you're pushing an existing repository:

```bash
# Add the remote repository
git remote add origin https://github.com/frivia-app/frivia.git

# Push your code
git push -u origin main
```

## Step 3: Build the APK

```bash
# Navigate to your project directory
cd fivia

# Build the release APK
flutter build apk --release
```

The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`

## Step 4: Create a GitHub Release

### Manual Release

1. Go to your GitHub repository
2. Click on "Releases" in the right sidebar
3. Click "Create a new release" or "Draft a new release"
4. Enter a tag version (e.g., "v1.0.0")
5. Enter a release title (e.g., "Fivia v1.0.0")
6. Add release notes describing the features and changes
7. Upload the APK file from `build/app/outputs/flutter-apk/app-release.apk`
8. Check "This is a pre-release" if applicable
9. Click "Publish release"

### Automated Release with GitHub Actions

The repository includes a GitHub Actions workflow file (`.github/workflows/build_and_release.yml`) that automatically builds and releases the APK when you push a new tag.

To use this automated process:

```bash
# Create a new tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push the tag to GitHub
git push origin v1.0.0
```

The GitHub Action will:
1. Build the APK
2. Create a new release
3. Attach the APK to the release

## Step 5: Verify the Release

1. Go to the "Releases" section of your GitHub repository
2. Ensure the APK is attached to the release
3. Download the APK and test it on an Android device
4. Verify that the app installs and functions correctly

## Step 6: Update README with Download Instructions

Ensure your README.md includes clear instructions for users to download and install the APK:

```markdown
## Installation

### Direct APK Download

1. Go to the [Releases](https://github.com/frivia-app/frivia/releases) page
2. Download the latest `app-release.apk` file
3. On your Android device, enable "Install from Unknown Sources" in settings
4. Open the downloaded APK file to install
```

## Troubleshooting

### APK Installation Issues

- Ensure users have enabled "Install from Unknown Sources" in their device settings
- Verify the APK is properly signed with a keystore
- Check that the minimum Android SDK version is compatible with users' devices

### GitHub Actions Failures

- Check the workflow logs for error messages
- Ensure your Flutter project builds successfully locally
- Verify that the workflow file has the correct paths and configurations

## Maintaining Releases

- Keep a consistent versioning scheme (e.g., Semantic Versioning)
- Include detailed release notes for each version
- Consider using pre-releases for beta testing
- Maintain older releases for users who may need them

---

By following this guide, you'll successfully deploy your Fivia app to GitHub, making it easily accessible for users to download and install.