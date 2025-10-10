import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/common/domain/use_cases/streak/is_streak_broken_use_case.dart';
import 'package:sureline/features/streak/data/data_source/streak_data_source.dart';
import 'package:sureline/features/streak/data/repository/streak_repository_impl.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

void main() {
  late IsStreakBrokenUseCase useCase;
  late StreakRepository repository;
  late StreakDataSource dataSource;
  late DateTime mockCurrentDate;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    dataSource = StreakDataSourceImpl(prefs);
    repository = StreakRepositoryImpl(dataSource);
    useCase = IsStreakBrokenUseCase(repository);
    mockCurrentDate = DateTime(2025, 1, 21, 9, 0);
  });

  group('IsStreakBrokenUseCase', () {
    test('returns false if there is single streak record', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);

      expect(result, Right(false));
    });

    test('returns false if there are 4 consecutive streak records', () {
      List<StreakEntity> entities = [
        // StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);

      expect(result, Right(false));
    });

    test('returns true if there are 4 records but 3 days missed', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);

      expect(result, Right(true));
    });

    test('returns false if there are 5 records but 2 days missed', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);

      expect(result, Right(false));
    });

    test('returns false if all 7 days are checked in', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 15, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);

      expect(result, Right(false));
    });

    test('returns false if 1 day is missing', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 15, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        // StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(
        entities,
        currentDate: mockCurrentDate,
      );
      expect(result, Right(false));
    });

    test('returns true/false WRT 1-7 days missing', () {
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 6, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 7, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 8, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 9, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 10, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 11, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 12, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 13, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 14, 9, 0)),

        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      List<StreakEntity> entitiesMirror = entities;

      for (int i =0; i < entities.length; i++){
        final lastSevenRecords = entities.sublist(entities.length - 7);
        final temp = lastSevenRecords.sublist(i);
        entitiesMirror.replaceRange(entitiesMirror.length - 7, entitiesMirror.length, temp);
        if (i <= 2){
          final result = useCase.execute(entitiesMirror, currentDate: mockCurrentDate);
          expect(result, Right(false));
        }else {
          final result = useCase.execute(entitiesMirror, currentDate: mockCurrentDate);
          expect(result, Right(true));
        }
      }

    });

    test('returns false if all 14 days are checked in', (){
      List<StreakEntity> entities = [
        StreakEntity(timeStamp: DateTime(2025, 1, 7, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 8, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 9, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 10, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 11, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 12, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 13, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 14, 9, 0)),

        StreakEntity(timeStamp: DateTime(2025, 1, 16, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 17, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 18, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 19, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 20, 9, 0)),
        StreakEntity(timeStamp: DateTime(2025, 1, 21, 9, 0)),
      ];
      final result = useCase.execute(entities, currentDate: mockCurrentDate);
      expect(result, Right(false));
    });
  });
}
