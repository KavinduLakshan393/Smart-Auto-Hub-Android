// Path: lib/core/network/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'error_boundary.dart';

class ApiClient {
  final http.Client _client = http.Client();
  final ErrorBoundary _errorBoundary = ErrorBoundary();

  Future<Map<String, dynamic>> get(String url, {Map<String, String>? headers}) async {
    return _errorBoundary.run(() async {
      final response = await _client.get(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    });
  }

  Future<Map<String, dynamic>> post(String url, {Map<String, String>? headers, dynamic body}) async {
    return _errorBoundary.run(() async {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    });
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: \${response.statusCode} - \${response.body}');
    }
  }
}
