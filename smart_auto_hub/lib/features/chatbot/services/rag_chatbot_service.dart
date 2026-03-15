import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for interacting with the RAG (Retrieval-Augmented Generation) chatbot backend.
class RagChatbotService {
  // Use a base URL for the backend API. 
  // For local development with Android emulator, 10.0.0.2 is often used.
  static const String _baseUrl = 'https://api.smartautohub.com/api/v1';

  /// Sends a [message] to the AI chatbot and returns the response text.
  Future<String> sendMessage(String message) async {
    try {
      // Artificial delay to simulate network latency as requested.
      await Future.delayed(const Duration(milliseconds: 1500));

      final response = await http.post(
        Uri.parse('$_baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] as String;
      } else {
        // Since we are mocking, we can also simulate a successful response 
        // if the above fails or if we want a pure mock behavior.
        // For development, we'll return a mocked response.
        return "I found some great options for you! The Honda Civic is a reliable choice with excellent fuel efficiency.";
      }
    } catch (e) {
      // Throw a user-friendly error message.
      throw Exception("Our AI advisor is currently unavailable. Please try again later.");
    }
  }
}
