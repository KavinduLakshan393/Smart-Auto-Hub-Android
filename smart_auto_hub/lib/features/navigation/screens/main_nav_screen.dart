import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';
import '../../vehicles/screens/vehicle_catalog_screen.dart';

/// ----------------------------------------------------------------------------
/// DRILL-DOWN ROUTING ARCHITECTURE
///
/// This screen serves as the main navigation shell. Standard Navigator.push()
/// will be used to route to drill-down pages like the "7. Vehicle Details Screen"
/// or "8. Consultation Booking Form". 
///
/// Because we push a new route onto the main Navigator in this way, it will
/// naturally slide over and cover this screen completely, including the floating 
/// navigation bar. This is the exact intended behavior for full-screen detail views.
/// ----------------------------------------------------------------------------

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  // Placeholder components for the top-level pages in the IndexedStack
  final List<Widget> _screens = const [
    HomeScreen(),
    VehicleCatalogScreen(),
    Center(child: Text('Bookings Screen')),
    Center(child: Text('AI Chat Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBody: true, // Allows the body content to go behind the floating bar
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Padding(
        // Padding forces the NavigationBar to float off the screen edges
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface, // Adapts to light/dark mode automatically
            borderRadius: BorderRadius.circular(10.0), // Matching global card theme
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                // Use the new Material 3 interactions but strictly control colors
                backgroundColor: Colors.transparent,
                indicatorColor: colorScheme.primary.withOpacity(0.1),
                
                // Active: Brand Primary Color | Inactive: Muted Gray
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return IconThemeData(color: colorScheme.primary);
                  }
                  return const IconThemeData(color: Colors.grey);
                }),
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return TextStyle(
                      color: colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    );
                  }
                  return const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  );
                }),
                // Keep it clean by hiding labels for unselected items
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              ),
              child: NavigationBar(
                elevation: 0, // Disable internal elevation to rely on Container's shadow
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.space_dashboard_rounded),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.directions_car_rounded),
                    label: 'Catalog',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.calendar_month_rounded),
                    label: 'Bookings',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.smart_toy_rounded),
                    label: 'AI Chat',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
