import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend/main.dart';
import 'package:flutter_frontend/screens/inventory/inventory_main_s.dart';

void main() {
  testWidgets('App starts with Dashboard and shows drawer',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the dashboard title is present
    expect(find.text('Dashboard'), findsOneWidget);

    // Find and tap the menu button
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify drawer menu items are present
    expect(find.text('Inventory'), findsOneWidget);
    expect(find.text('POS'), findsOneWidget);
    expect(find.text('Ordering'), findsOneWidget);
    expect(find.text('Booking'), findsOneWidget);
    expect(find.text('Financial'), findsOneWidget);
    expect(find.text('Employee'), findsOneWidget);
  });

  testWidgets('Inventory buttons are present and clickable',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify inventory buttons are present
    expect(find.text('Menu Items'), findsOneWidget);
    expect(find.text('Ingredients'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Request Purchase Order'), findsOneWidget);

    // Test menu items button navigation
    await tester.tap(find.text('Menu Items'));
    await tester.pumpAndSettle();

    // Verify we're on the menu items screen
    expect(find.text('Menu Items'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Notification icon works', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Tap the notification icon
    await tester.tap(find.byIcon(Icons.notifications));
    await tester.pump();

    // Verify the snackbar appears
    expect(find.text('No new notifications'), findsOneWidget);
  });
}
