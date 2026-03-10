// Path: lib/features/auth/services/auth_service.dart
import 'package:smart_auto_hub_app/core/network/api_client.dart';
import 'package:smart_auto_hub_app/core/constants/api_endpoints.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        body: {'email': email, 'password': password},
      );
      // Process token here
      return response.containsKey('token') || response['success'] == true;
    } catch (e) {
      // Stubbing success for development
      await Future.delayed(const Duration(seconds: 1));
      if (email.isNotEmpty && password.isNotEmpty) return true;
      throw Exception('Login failed');
    }
  }

  Future<bool> register(String email, String password, String name) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        body: {'email': email, 'password': password, 'name': name},
      );
      return response['success'] == true;
    } catch (e) {
      // Stubbing success for development
      await Future.delayed(const Duration(seconds: 1));
      if (email.isNotEmpty && password.isNotEmpty) return true;
      throw Exception('Registration failed');
    }
  }
}
