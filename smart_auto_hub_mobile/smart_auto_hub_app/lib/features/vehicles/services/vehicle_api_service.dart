// Path: lib/features/vehicles/services/vehicle_api_service.dart
import 'package:smart_auto_hub_app/core/network/api_client.dart';
import 'package:smart_auto_hub_app/core/constants/api_endpoints.dart';
import '../models/vehicle_model.dart';

class VehicleApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<VehicleModel>> getVehicles() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.vehicles);
      final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => VehicleModel.fromJson(json)).toList();
    } catch (e) {
      // Stubbing data for development
      return [
        VehicleModel(id: '1', make: 'Toyota', model: 'Camry', year: 2022, price: 24000, status: 'Available', imageUrl: ''),
        VehicleModel(id: '2', make: 'Honda', model: 'Civic', year: 2023, price: 26000, status: 'Available', imageUrl: ''),
      ];
    }
  }

  Future<VehicleModel> getVehicleById(String id) async {
    try {
      final response = await _apiClient.get('\${ApiEndpoints.vehicles}/$id');
      return VehicleModel.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch vehicle');
    }
  }
}
