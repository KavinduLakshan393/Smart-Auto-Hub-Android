import 'package:flutter_test/flutter_test.dart';
import 'package:smart_auto_hub/features/chatbot/models/chat_message_model.dart';

void main() {
  group('ChatMessageModel Tests', () {
    final timestamp = DateTime(2026, 3, 15, 20, 36);
    final json = {
      'id': 'test-id-123',
      'text': 'Hello AI',
      'isUser': true,
      'timestamp': timestamp.toIso8601String(),
    };

    test('fromJson should create valid model', () {
      final model = ChatMessageModel.fromJson(json);

      expect(model.id, 'test-id-123');
      expect(model.text, 'Hello AI');
      expect(model.isUser, true);
      expect(model.timestamp, timestamp);
    });

    test('toJson should create valid Map', () {
      final model = ChatMessageModel(
        id: 'test-id-123',
        text: 'Hello AI',
        isUser: true,
        timestamp: timestamp,
      );

      final result = model.toJson();

      expect(result['id'], 'test-id-123');
      expect(result['text'], 'Hello AI');
      expect(result['isUser'], true);
      expect(result['timestamp'], timestamp.toIso8601String());
    });
  });
}
