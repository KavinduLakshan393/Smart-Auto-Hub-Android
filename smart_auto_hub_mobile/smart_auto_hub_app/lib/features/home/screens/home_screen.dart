// Path: lib/features/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:smart_auto_hub_app/features/home/widgets/bottom_navigation_bar.dart';
import 'package:smart_auto_hub_app/features/vehicles/screens/vehicle_catalog_screen.dart';
import 'package:smart_auto_hub_app/features/bookings/screens/my_bookings_dashboard_screen.dart';
import 'package:smart_auto_hub_app/features/chatbot/screens/ai_chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const VehicleCatalogScreen(),
    const MyBookingsDashboardScreen(),
    const AiChatbotScreen(),
    const Center(child: Text('Profile')), // Placeholder for Profile
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
