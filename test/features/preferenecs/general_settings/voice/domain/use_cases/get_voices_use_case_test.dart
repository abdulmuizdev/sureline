import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/use_cases/get_voices_use_case.dart';

import '../../../../../../helpers/mocks.mocks.dart';

@GenerateMocks([VoiceRepository])
void main() {
  group('GetVoicesUseCase', () {
    late GetVoicesUseCase useCase;
    late MockVoiceRepository mockRepository;

    setUp(() {
      mockRepository = MockVoiceRepository();
      useCase = GetVoicesUseCase(mockRepository);
    });

    test('should get voices from repository successfully', () async {
      // Arrange
      final voices = <VoiceEntity>[];
      when(mockRepository.getVoices()).thenAnswer((_) async => Right(voices));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, Right(voices));
      verify(mockRepository.getVoices()).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getVoices()).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result.isLeft(), true);
      verify(mockRepository.getVoices()).called(1);
    });
  });
}
