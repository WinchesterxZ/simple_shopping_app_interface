# Flutter Authentication App

A Flutter application demonstrating Firebase Authentication with a clean UI and multilingual support.

## Features

- User Authentication (Sign up/Sign in)
- Firebase Integration
- Bilingual Support (English/Arabic)
- Form Validation
- Custom Animations
- Social Media Integration (UI Only)
- Clean Material Design

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase Account
- Android Studio/VS Code

## Release Process

### 1. Build Release APK

```bash
# Generate release APK
flutter build apk --release

```

### 2. Firebase App Distribution Setup

1. Install Firebase CLI
```bash
npm install -g firebase-tools
```

2. Login to Firebase
```bash
firebase login
```

3. Initialize Firebase in your project
```bash
firebase init
# Select App Distribution when prompted
```

4. Add Firebase App Distribution Gradle Plugin
Add to android/build.gradle:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.firebase:firebase-appdistribution-gradle:4.0.0'
    }
}
```

Add to android/app/build.gradle:
```gradle
apply plugin: 'com.google.firebase.appdistribution'

android {
    defaultConfig {
        // ...existing config...
    }

    buildTypes {
        release {
            firebaseAppDistribution {
                groups="testers"
                releaseNotes="Bug fixes and improvements"
            }
        }
    }
}
```

### 3. Upload to Firebase App Distribution

- Using Firebase Console:
   - Go to Firebase Console
   - Select App Distribution
   - Click "New Release"
   - Upload APK
   - Select testers/groups
   - Add release notes
   - Distribute

### 4. Testing

1. Testers will receive an email invitation
2. They need to:
   - Accept the invitation
   - Install Firebase App Tester app
   - Download and test your app


## Screenshots


