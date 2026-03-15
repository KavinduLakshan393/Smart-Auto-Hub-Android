import 'dart:convert';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/vehicle_model.dart';

class VehicleApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<VehicleModel>> fetchVehicles({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.vehicles, queryParams: queryParams);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => VehicleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch vehicles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vehicles: $e');
    }
  }

  Future<VehicleModel> fetchVehicleDetails(String id) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.vehicleDetails(id));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return VehicleModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch vehicle details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vehicle details: $e');
    }
  }
}
