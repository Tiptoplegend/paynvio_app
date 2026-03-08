import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paynvio/navigation.dart';
import 'package:paynvio/menus/home.dart';
import 'package:paynvio/menus/invoice.dart';
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

  testWidgets('NavigationScreen navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We need to wrap in a standardized size to avoid overflow errors during layout
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: NavigationScreen(),
        ),
      ),
    );

    // Verify that HomeScreen is displayed initially.
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(invoicescreen), findsNothing);

    // Tap the Invoice icon (index 1).
    // Using icon finder is more robust as it targets the GButton's icon which is unique here.
    await tester.tap(find.byIcon(Icons.receipt_long_rounded));
    await tester.pumpAndSettle();

    // Verify that invoicescreen is displayed.
    expect(find.byType(HomeScreen), findsNothing);
    expect(find.byType(invoicescreen), findsOneWidget);

    // Verify AppBar title "Invoice" is present.
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Invoice')),
      findsOneWidget,
    );

    // Tap the Add icon (index 2).
    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    // Verify that we are STILL on invoicescreen (Add button shouldn't change screen).
    expect(find.byType(invoicescreen), findsOneWidget);

    // Tap the Home icon (index 0).
    await tester.tap(find.byIcon(Icons.home_rounded));
    await tester.pumpAndSettle();

    // Verify that HomeScreen is displayed again.
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(invoicescreen), findsNothing);
  });
}
