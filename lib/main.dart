import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/core/theme.dart';
import 'package:miracle_tv/firebase_options.dart';
import 'package:miracle_tv/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MiracleTvApp());
}

class MiracleTvApp extends StatelessWidget {
  const MiracleTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const HomeScreen(),
    );
  }
}
