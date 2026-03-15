import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/vehicle_model.dart';

class VehicleApiService {
  final ApiClient _apiClient = ApiClient();

  // Mock data for development
  static final List<VehicleModel> _mockVehicles = [
    VehicleModel(
      id: '1',
      brand: 'Toyota',
      model: 'Premio',
      year: 2018,
      mileage: 45000,
      price: 12500000,
      images: ['https://images.unsplash.com/photo-1550355291-bbee04a92027?q=80&w=800'],
      location: 'Colombo',
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'Available',
      type: 'Sedan',
    ),
    VehicleModel(
      id: '2',
      brand: 'Honda',
      model: 'Vezel',
      year: 2017,
      mileage: 62000,
      price: 9800000,
      images: ['https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?q=80&w=800'],
      location: 'Kandy',
      transmission: 'Automatic',
      fuelType: 'Hybrid',
      status: 'Available',
      type: 'SUV',
    ),
    VehicleModel(
      id: '3',
      brand: 'Mitsubishi',
      model: 'Montero Cross',
      year: 2021,
      mileage: 15000,
      price: 32000000,
      images: ['https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?q=80&w=800'],
      location: 'Gampaha',
      transmission: 'Automatic',
      fuelType: 'Diesel',
      status: 'Shipped',
      type: 'SUV',
    ),
  ];

  Future<List<VehicleModel>> fetchVehicles({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.vehicles, queryParams: queryParams);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['data'] ?? [];
        return data.map((json) => VehicleModel.fromJson(json)).toList();
      } else {
        debugPrint('API Error: ${response.statusCode}. Falling back to mock data.');
        return _mockVehicles;
      }
    } catch (e) {
      debugPrint('Fetch Error: $e. Falling back to mock data.');
      return _mockVehicles;
    }
  }

  Future<VehicleModel> fetchVehicleDetails(String id) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.vehicleDetails(id));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final Map<String, dynamic> data = body['data'];
        return VehicleModel.fromJson(data);
      } else {
        return _mockVehicles.firstWhere((v) => v.id == id);
      }
    } catch (e) {
      debugPrint('Fetch Details Error: $e. Falling back to mock data.');
      return _mockVehicles.firstWhere((v) => v.id == id);
    }
  }
}
