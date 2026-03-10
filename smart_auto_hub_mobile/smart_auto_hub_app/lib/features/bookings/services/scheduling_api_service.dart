// Path: lib/features/bookings/services/scheduling_api_service.dart
import 'package:flutter/material.dart';
import 'package:smart_auto_hub_app/core/network/api_client.dart';
import 'package:smart_auto_hub_app/core/constants/api_endpoints.dart';
import '../models/booking_model.dart';

class SchedulingApiService {
  final ApiClient _apiClient = ApiClient();

  Future<bool> bookConsultation({required String vehicleId, required DateTime date, required TimeOfDay time}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.bookings,
        body: {
          'vehicleId': vehicleId,
          'date': '\${date.year}-\${date.month}-\${date.day}',
          'time': '\${time.hour}:\${time.minute}',
        },
      );
      return response['success'] == true;
    } catch (e) {
      // Stubbing success for development
      await Future.delayed(const Duration(seconds: 1));
      return true;
    }
  }

  Future<List<BookingModel>> getMyBookings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.bookings);
      final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => BookingModel.fromJson(json)).toList();
    } catch (e) {
      // Stubbing data for development
      return [
        BookingModel(id: 'b1', userId: 'u1', vehicleId: '1', date: '2026-04-10', time: '14:00', status: 'Confirmed'),
      ];
    }
  }
}
