// Path: lib/features/bookings/screens/my_bookings_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/scheduling_api_service.dart';

class MyBookingsDashboardScreen extends StatefulWidget {
  const MyBookingsDashboardScreen({super.key});

  @override
  State<MyBookingsDashboardScreen> createState() => _MyBookingsDashboardScreenState();
}

class _MyBookingsDashboardScreenState extends State<MyBookingsDashboardScreen> {
  final _schedulingService = SchedulingApiService();
  List<BookingModel> _bookings = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final bookings = await _schedulingService.getMyBookings();
      if (mounted) {
        setState(() {
          _bookings = bookings;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Dashboard')),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error != null 
              ? Center(child: Text('Error: $_error'))
              : _bookings.isEmpty 
                  ? const Center(child: Text('No bookings found.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _bookings.length,
                      itemBuilder: (context, index) {
                        final booking = _bookings[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            title: Text('Booking \${booking.id.substring(0,6)}...'),
                            subtitle: Text('\${booking.date} at \${booking.time}\\nStatus: \${booking.status}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
    );
  }
}
