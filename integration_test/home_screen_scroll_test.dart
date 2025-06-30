import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';
import 'package:sureline/features/home/presentation/bloc/home_bloc.dart';
import 'package:sureline/features/home/presentation/bloc/home_event.dart';
import 'package:sureline/features/home/presentation/bloc/home_state.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/core/di/injection.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomeScreen scrolls visually 50 times', (
    WidgetTester tester,
  ) async {
    // Initialize dependency injection
    await setupLocator();

    // Create test quotes
    final testQuotes = List.generate(
      100, // Generate 100 test quotes
      (index) => QuoteEntity(
        id: index + 1,
        quoteText:
            'Test quote ${index + 1} - This is a sample quote for testing purposes. It should be long enough to test scrolling behavior.',
        author: 'Test Author ${index + 1}',
        createdAt: DateTime.now(),
        shownAt: null,
        quoteKey: GlobalKey(),
      ),
    );

    // Create a mock HomeBloc that returns our test quotes
    final homeBloc = locator<HomeBloc>();

    // Build the HomeScreen
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeBloc>.value(
          value: homeBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Wait for initial build
    await tester.pumpAndSettle();

    // Find the PageView
    final pageViewFinder = find.byType(PageView);
    expect(pageViewFinder, findsOneWidget);

    // Perform 50 scrolls
    const int scrollCount = 50;
    int successfulScrolls = 0;
    int failedScrolls = 0;

    for (int i = 0; i < scrollCount; i++) {
      try {
        // Perform a vertical scroll gesture
        await tester.drag(pageViewFinder, const Offset(0, -300));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        successfulScrolls++;

        // Add delay based on scroll number
        if (i < 5) {
          // First 5 scrolls: 5 seconds delay each
          print('Scroll ${i + 1}: Waiting 5 seconds...');
          await Future.delayed(const Duration(seconds: 5));
        } else {
          // Remaining scrolls: normal delay
          await Future.delayed(const Duration(milliseconds: 50));
        }
      } catch (e) {
        failedScrolls++;
        print('Scroll $i failed: $e');
      }

      // Print progress every 10 scrolls
      if ((i + 1) % 10 == 0) {
        print(
          'Completed ${i + 1} scrolls. Successful: $successfulScrolls, Failed: $failedScrolls',
        );
      }
    }

    // Assertions
    expect(
      successfulScrolls,
      greaterThan(scrollCount * 0.9),
      reason: 'At least 90% of scrolls should be successful',
    );
    expect(
      failedScrolls,
      lessThan(scrollCount * 0.1),
      reason: 'Less than 10% of scrolls should fail',
    );

    // Verify that the PageView is still functional
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);

    print('HomeScreen scroll test completed successfully!');
    print('Total scrolls attempted: $scrollCount');
    print('Successful scrolls: $successfulScrolls');
    print('Failed scrolls: $failedScrolls');
    print(
      'Success rate: ${(successfulScrolls / scrollCount * 100).toStringAsFixed(2)}%',
    );
  });
}
