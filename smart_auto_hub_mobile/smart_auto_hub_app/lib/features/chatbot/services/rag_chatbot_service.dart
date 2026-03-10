// Path: lib/features/chatbot/services/rag_chatbot_service.dart
import 'package:smart_auto_hub_app/core/network/api_client.dart';
import 'package:smart_auto_hub_app/core/constants/api_endpoints.dart';

class RagChatbotService {
  final ApiClient _apiClient = ApiClient();

  Future<String> sendMessage(String text) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.chatbot,
        body: {'message': text},
      );
      return response['response'] as String;
    } catch (e) {
      // Stubbing success for development
      await Future.delayed(const Duration(seconds: 1));
      return "I'm the AI assistant stub. Your message was: '$text'. The RAG backend is currently unavailable.";
    }
  }
}
