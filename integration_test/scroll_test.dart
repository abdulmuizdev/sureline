import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PageView scrolls visually 50 times', (
    WidgetTester tester,
  ) async {
    final items = List.generate(20, (i) => Text('Page $i'));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageView(scrollDirection: Axis.vertical, children: items),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final pageView = find.byType(PageView);
    for (int i = 0; i < 50; i++) {
      await tester.drag(pageView, const Offset(0, -300));
      await tester.pumpAndSettle(const Duration(milliseconds: 10));
    }
    expect(pageView, findsOneWidget);
  });
}
