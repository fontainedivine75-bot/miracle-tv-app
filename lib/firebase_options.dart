// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      authDomain: 'miracle-tv-project.firebaseapp.com',
      projectId: 'miracle-tv-project',
      storageBucket: 'miracle-tv-project.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      appId: 'YOUR_APP_ID',
      androidClientId: 'YOUR_ANDROID_CLIENT_ID',
      iosBundleId: 'com.miracletv.mefdntv',
      iosClientId: 'YOUR_IOS_CLIENT_ID',
    );
  }
}
