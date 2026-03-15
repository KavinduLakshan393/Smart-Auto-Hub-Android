import 'dart:async';
import '../models/booking_model.dart';

class SchedulingApiService {
  // Mock data for demonstration
  final List<BookingModel> _mockBookings = [
    BookingModel(
      id: '1',
      serviceType: 'Oil Change',
      vehicleDetails: '2022 Toyota Camry (ABC-1234)',
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
      status: BookingStatus.confirmed,
    ),
    BookingModel(
      id: '2',
      serviceType: 'Brake Inspection',
      vehicleDetails: '2020 Honda Civic (XYZ-5678)',
      scheduledDate: DateTime.now().subtract(const Duration(days: 5)),
      status: BookingStatus.completed,
    ),
    BookingModel(
      id: '3',
      serviceType: 'Tire Rotation',
      vehicleDetails: '2021 Ford F-150 (TRK-9012)',
      scheduledDate: DateTime.now().add(const Duration(days: 10)),
      status: BookingStatus.pending,
    ),
    BookingModel(
      id: '4',
      serviceType: 'Engine Diagnostics',
      vehicleDetails: '2019 BMW X5 (LUX-3456)',
      scheduledDate: DateTime.now().add(const Duration(hours: 4)),
      status: BookingStatus.cancelled,
    ),
  ];

  /// Fetches the list of user bookings.
  Future<List<BookingModel>> getUserBookings() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real implementation, this would be an http call:
      // final response = await http.get(Uri.parse('${ApiEndpoints.baseUrl}/bookings'));
      // if (response.statusCode == 200) { ... }
      
      return List.from(_mockBookings);
    } catch (e) {
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  /// Cancels a specific booking by ID.
  Future<bool> cancelBooking(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final index = _mockBookings.indexWhere((b) => b.id == id);
      if (index != -1) {
        // In a real app, you'd send a DELETE or PATCH request
        // For mock, we'll just return success
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }
}
