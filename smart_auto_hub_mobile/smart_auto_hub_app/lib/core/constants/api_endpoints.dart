// Path: lib/core/constants/api_endpoints.dart

class ApiEndpoints {
  // Replace with your actual Next.js backend URL
  static const String nextJsBaseUrl = 'https://api.smartautohub.com/v1';
  
  // Replace with your actual Python RAG backend URL
  static const String ragBaseUrl = 'https://rag.smartautohub.com/api';

  // Next.js Endpoints
  static const String login = '$nextJsBaseUrl/auth/login';
  static const String register = '$nextJsBaseUrl/auth/register';
  static const String vehicles = '$nextJsBaseUrl/vehicles';
  static const String bookings = '$nextJsBaseUrl/bookings';

  // Python RAG Endpoints
  static const String chatbot = '$ragBaseUrl/chat';
}
