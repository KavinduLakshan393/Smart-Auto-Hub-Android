import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_auto_hub/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartAutoHub());

    // Verify that the home screen is displayed
    expect(find.text('Smart Auto Hub'), findsOneWidget);
    expect(find.text('Welcome to Sameera Auto Traders!'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
