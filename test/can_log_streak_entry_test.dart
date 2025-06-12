import 'package:flutter_test/flutter_test.dart';
import 'package:sureline/common/domain/use_cases/streak/can_log_streak_entry_use_case.dart';

void main() {
  group('CanLogStreakEntryUseCase', () {
    final useCase = CanLogStreakEntryUseCase();

    test('returns true if lastCheckIn is null (first time)', () {
      final result = useCase.execute(lastCheckIn: null);
      expect(result, true);
    });

    test('returns false if less than 24 hours has passed since last check-in', () {
      final lastCheckIn = DateTime(2025, 1, 1, 12, 0, 0);
      final currentTime = lastCheckIn.add(Duration(hours: 23, minutes: 59));
      final result = useCase.execute(
        lastCheckIn: lastCheckIn,
        now: currentTime,
      );
      expect(result, false);
    });

    test('returns true if exactly 24 hours has passed since last check-in', () {
      final lastCheckIn = DateTime(2024, 1, 1, 12, 0, 0);
      final currentTime = lastCheckIn.add(Duration(hours: 24, seconds: 1));
      final result = useCase.execute(
        lastCheckIn: lastCheckIn,
        now: currentTime,
      );
      expect(result, true);
    });

    test('returns true if more than 24 hours has passed', () {
      final lastCheckIn = DateTime(2024, 1, 1, 12, 0, 0);
      final currentTime = lastCheckIn.add(Duration(days: 1, hours: 1));
      final result = useCase.execute(
        lastCheckIn: lastCheckIn,
        now: currentTime,
      );
      expect(result, true);
    });
  });
}
