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

  testWidgets('InvoiceScreen tabs test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: invoicescreen(),
        ),
      ),
    );

    // Verify all tabs are present
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Unpaid'), findsOneWidget);
    expect(find.text('Overdue'), findsOneWidget);
    expect(find.text('Draft'), findsOneWidget);

    // Helper function to check selection style
    bool isTabSelected(String tabName) {
      final container = tester.widget<Container>(
        find.widgetWithText(Container, tabName).first,
      );
      final decoration = container.decoration as BoxDecoration;
      return decoration.color == const Color(0xFF1A2B61);
    }

    // Verify 'All' is selected initially
    expect(isTabSelected('All'), isTrue);
    expect(isTabSelected('Paid'), isFalse);

    // Tap 'Paid'
    await tester.tap(find.text('Paid'));
    await tester.pumpAndSettle();

    // Verify 'Paid' is selected and 'All' is unselected
    expect(isTabSelected('Paid'), isTrue);
    expect(isTabSelected('All'), isFalse);

    // Tap 'Draft'
    await tester.tap(find.text('Draft'));
    await tester.pumpAndSettle();

    // Verify 'Draft' is selected
    expect(isTabSelected('Draft'), isTrue);
    expect(isTabSelected('Paid'), isFalse);
  });
}
