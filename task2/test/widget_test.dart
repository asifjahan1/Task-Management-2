import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task2/main.dart';

// Create a mock database using Mockito
class MockDatabase extends Mock implements Database {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create an instance of the mock database
    final mockDatabase = MockDatabase();

    // Build our app and trigger a frame with the mock database
    await tester.pumpWidget(MyApp(database: mockDatabase));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
