# MIRACLE TV

MIRACLE TV is a Flutter Android app for the MEFDN ministry.

## Project structure
- lib/core
- lib/models
- lib/services
- lib/screens
- lib/widgets
- lib/providers
- lib/admin
- lib/firebase_options.dart

## Firebase setup
1. Create a Firebase project for package `com.miracletv.mefdntv`.
2. Enable Firebase Authentication, Cloud Firestore, Cloud Storage, and Hosting if needed.
3. Download `google-services.json` and place it in `android/app/`.
4. Replace the placeholder values in `lib/firebase_options.dart` with the generated project values.

## Run project
```bash
flutter pub get
flutter run
```

## Build Android APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```

## Notes
- YouTube is used as the primary source for heavy video content.
- Admin-only actions are enforced through Firestore security rules and app-level checks.
- Firebase secrets are never committed to source control.
