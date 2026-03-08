import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paynvio/navigation.dart';
import 'dart:io';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  testWidgets('NavigationScreen tabs switch correctly', (
    WidgetTester tester,
  ) async {
    // Set a large screen size to avoid overflow errors in HomeScreen
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    // Build the NavigationScreen
    await tester.pumpWidget(const MaterialApp(home: NavigationScreen()));

    // Verify initial state (Home)
    // Use text finder for GButton to be specific
    expect(find.text('Home'), findsOneWidget);

    // Tap on Reports tab (index 3)
    // .last because it might be found in GButton (icon + text) and maybe body? No, body has "Reports" text?
    // Actually, distinct text is safer.
    // The GButton has text 'Reports'.
    // The ReportsScreen has body Center(child: Text('Reports')).
    // Initially ReportsScreen is NOT built. So find.text('Reports') should find 1 widget (the tab).
    await tester.tap(find.text('Reports'));
    await tester.pumpAndSettle();

    // Now ReportsScreen is built.
    // We expect to find 'Reports' text in the body.
    // Since the tab also says 'Reports', we should find 2 widgets now?
    // Let's verify we are on the screen by finding the Center widget with specific text or just count.
    expect(find.text('Reports'), findsNWidgets(2));

    // Tap on More tab (index 4)
    // Find the 'More' tab text.
    // Since MoreScreen is not built yet, find.text('More') should be 1 (the tab).
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    // Verify More screen is shown (finds 2 widgets: tab + body)
    expect(find.text('More'), findsNWidgets(2));

    // Reset window size
    addTearDown(tester.view.resetPhysicalSize);
  });
}
