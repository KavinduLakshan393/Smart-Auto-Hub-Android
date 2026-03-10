// Path: lib/app.dart
import 'package:flutter/material.dart';
import 'package:smart_auto_hub_app/core/theme/app_theme.dart';
import 'package:smart_auto_hub_app/features/splash/screens/splash_screen.dart';

class SmartAutoHubApp extends StatelessWidget {
  const SmartAutoHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Auto Hub',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
