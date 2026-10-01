import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: 'YOUR_APP_ID',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      projectId: 'miracle-tv-project',
      storageBucket: 'miracle-tv-project.appspot.com',
      iosBundleId: 'com.miracletv.mefdntv',
      iosClientId: 'YOUR_IOS_CLIENT_ID',
      androidClientId: 'YOUR_ANDROID_CLIENT_ID',
    );
  }
}
