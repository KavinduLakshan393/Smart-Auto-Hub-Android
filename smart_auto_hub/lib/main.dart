import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const SmartAutoHub());
}

class SmartAutoHub extends StatelessWidget {
  const SmartAutoHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Auto Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Switches based on OS settings
      home: const HomeScreen(), // Your initial page
    );
  }
}
