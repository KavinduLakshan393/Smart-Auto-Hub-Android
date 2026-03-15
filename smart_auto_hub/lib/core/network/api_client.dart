import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class ApiClient {
  final http.Client _client = http.Client();

  Future<http.Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint').replace(
      queryParameters: queryParams?.map((key, value) => MapEntry(key, value.toString())),
    );
    
    final response = await _client.get(uri);
    return response;
  }

  void dispose() {
    _client.close();
  }
}
