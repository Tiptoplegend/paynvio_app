import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('InvoiceCard UI test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InvoiceCard(
              name: 'John Doe',
              email: 'john@example.com',
              amount: '\$5,200',
              id: '#1234',
              date: '04 Dec 2024',
              status: 'Paid',
              image: 'https://i.pravatar.cc/150?u=1',
            ),
          ),
        ),
      );

      // Verify Name and Email
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);

      // Verify Status (pill and/or timer section)
      expect(find.text('Paid'), findsAtLeastNWidgets(1));

      // Verify Details
      expect(find.text('\$5,200'), findsOneWidget);
      expect(find.text('#1234'), findsOneWidget);
      expect(find.text('04 Dec 2024'), findsOneWidget);

      // Verify Labels
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
    });
  });

  testWidgets('InvoiceScreen list test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(800, 1200)),
          child: invoicescreen(),
        ),
      ),
    );

    // Verify initially loaded items from dummy data
    expect(find.text('Jansen Ackless'), findsOneWidget);
    expect(find.text('Mia Wong'), findsOneWidget);

    // Check that Paid filter works.
    // Use GestureDetector to find the tab, as the status badge is just a Container.
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(GestureDetector, 'Paid'));
      await tester.pumpAndSettle();
    });

    expect(find.text('Jansen Ackless'), findsOneWidget); // Paid
    expect(find.text('Mia Wong'), findsNothing); // Unpaid
  });
}
