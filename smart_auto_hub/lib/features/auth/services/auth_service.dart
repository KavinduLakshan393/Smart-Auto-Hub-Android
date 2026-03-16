import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants/api_endpoints.dart'; 

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      // 1. Fetch the CSRF Token required by NextAuth
      final csrfResponse = await http.get(Uri.parse('${ApiEndpoints.baseUrl}/auth/csrf'));
      if (csrfResponse.statusCode != 200) return false;
      
      final csrfData = jsonDecode(csrfResponse.body);
      final csrfToken = csrfData['csrfToken'];
      
      // Grab the CSRF cookie to send alongside the token in the POST request
      String? csrfCookie = csrfResponse.headers['set-cookie'];

      // 2. Authenticate with NextAuth's "user-credentials" provider
      final loginResponse = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}/auth/callback/user-credentials'),
        headers: {
          'Content-Type': 'application/json',
          if (csrfCookie != null) 'cookie': csrfCookie, 
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'csrfToken': csrfToken,
          'json': 'true', // Forces NextAuth to return JSON instead of redirecting
        }),
      );

      if (loginResponse.statusCode == 200) {
        final data = jsonDecode(loginResponse.body);
        
        // NextAuth returns 200 even on failure, but provides a 'url' on success
        if (data['url'] != null && data['url'].toString().isNotEmpty) {
          
          // 3. Extract the NextAuth session cookie and save it securely
          String? sessionCookie = loginResponse.headers['set-cookie'];
          if (sessionCookie != null) {
            await _storage.write(key: 'session_cookie', value: sessionCookie);
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  Future<bool> register(String username, String email, String password, String phone, String countryCode) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'countryCode': countryCode, // Ensure this matches your Next.js API expectations
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }
}
