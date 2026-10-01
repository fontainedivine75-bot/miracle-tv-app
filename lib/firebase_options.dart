import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // TODO: Replace with your actual Firebase project configuration
    // Get these values from your Firebase Console:
    // 1. Go to Project Settings
    // 2. Download google-services.json for Android
    // 3. Extract the values and fill them below
    return const FirebaseOptions(
      apiKey: 'YOUR_API_KEY_HERE',
      authDomain: 'miracle-tv-project.firebaseapp.com',
      projectId: 'miracle-tv-project',
      storageBucket: 'miracle-tv-project.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID_HERE',
      appId: 'YOUR_APP_ID_HERE',
    );
  }
}
