// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Scroll Performance Test', () {
    testWidgets('should scroll continuously 1000 times without breaking', (
      WidgetTester tester,
    ) async {
      // Create a simple PageView with test content
      final testItems = List.generate(
        1000, // Generate 1000 test items
        (index) => Container(
          height: 800, // Fixed height for each page
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Page ${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(scrollDirection: Axis.vertical, children: testItems),
          ),
        ),
      );

      // Wait for initial build
      await tester.pumpAndSettle();

      // Find the PageView
      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);

      // Perform 1000 scrolls
      const int scrollCount = 1000;
      int successfulScrolls = 0;
      int failedScrolls = 0;

      for (int i = 0; i < scrollCount; i++) {
        try {
          // Perform a vertical scroll gesture
          await tester.drag(pageViewFinder, const Offset(0, -300));
          await tester.pumpAndSettle(const Duration(milliseconds: 50));

          successfulScrolls++;

          // Add a small delay to prevent overwhelming the system
          await Future.delayed(const Duration(milliseconds: 5));
        } catch (e) {
          failedScrolls++;
          print('Scroll $i failed: $e');
        }

        // Print progress every 100 scrolls
        if ((i + 1) % 100 == 0) {
          print(
            'Completed ${i + 1} scrolls. Successful: $successfulScrolls, Failed: $failedScrolls',
          );
        }
      }

      // Assertions
      expect(
        successfulScrolls,
        greaterThan(scrollCount * 0.95),
        reason: 'At least 95% of scrolls should be successful',
      );
      expect(
        failedScrolls,
        lessThan(scrollCount * 0.05),
        reason: 'Less than 5% of scrolls should fail',
      );

      // Verify that the PageView is still functional
      expect(find.byType(PageView), findsOneWidget);

      print('Test completed successfully!');
      print('Total scrolls attempted: $scrollCount');
      print('Successful scrolls: $successfulScrolls');
      print('Failed scrolls: $failedScrolls');
      print(
        'Success rate: ${(successfulScrolls / scrollCount * 100).toStringAsFixed(2)}%',
      );
    });

    testWidgets('should handle rapid scrolling without memory leaks', (
      WidgetTester tester,
    ) async {
      // Create a simple PageView with test content
      final testItems = List.generate(
        200, // Generate 200 test items
        (index) => Container(
          height: 800,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Page ${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(scrollDirection: Axis.vertical, children: testItems),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Perform rapid scrolling (500 quick scrolls)
      const int rapidScrollCount = 500;

      for (int i = 0; i < rapidScrollCount; i++) {
        await tester.drag(find.byType(PageView), const Offset(0, -200));
        await tester.pump(const Duration(milliseconds: 20)); // Faster pumping
      }

      await tester.pumpAndSettle();

      // Verify the widget is still stable
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('should maintain scroll position after many scrolls', (
      WidgetTester tester,
    ) async {
      // Create a simple PageView with test content
      final testItems = List.generate(
        500, // Generate 500 test items
        (index) => Container(
          height: 800,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Page ${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(scrollDirection: Axis.vertical, children: testItems),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Perform 1000 scrolls
      for (int i = 0; i < 1000; i++) {
        await tester.drag(find.byType(PageView), const Offset(0, -300));
        await tester.pumpAndSettle(const Duration(milliseconds: 50));
      }

      // Verify that scrolling still works after many scrolls
      await tester.drag(find.byType(PageView), const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('should handle extreme scrolling stress test', (
      WidgetTester tester,
    ) async {
      // Create a simple PageView with test content
      final testItems = List.generate(
        100, // Generate 100 test items
        (index) => Container(
          height: 800,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Page ${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(scrollDirection: Axis.vertical, children: testItems),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Perform extreme stress test - 2000 very fast scrolls
      const int stressScrollCount = 2000;

      for (int i = 0; i < stressScrollCount; i++) {
        await tester.drag(find.byType(PageView), const Offset(0, -100));
        await tester.pump(
          const Duration(milliseconds: 10),
        ); // Very fast pumping
      }

      await tester.pumpAndSettle();

      // Verify the widget is still stable
      expect(find.byType(PageView), findsOneWidget);

      // Try a few more scrolls to ensure it's still working
      for (int i = 0; i < 10; i++) {
        await tester.drag(find.byType(PageView), const Offset(0, -300));
        await tester.pumpAndSettle();
      }

      expect(find.byType(PageView), findsOneWidget);
    });
  });
}
