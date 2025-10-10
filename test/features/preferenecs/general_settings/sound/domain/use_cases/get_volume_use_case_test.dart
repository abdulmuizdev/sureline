import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

import '../../../../../../helpers/mocks.mocks.dart';

@GenerateMocks([SoundRepository, VoiceRepository])
void main() {
  group('GetVolumeUseCase', () {
    late GetVolumeUseCase useCase;
    late MockSoundRepository mockRepository;

    setUp(() {
      mockRepository = MockSoundRepository();
      useCase = GetVolumeUseCase(mockRepository);
    });

    test('should get volume from repository successfully', () async {
      const volume = 0.75;
      when(
        mockRepository.getVolume(),
      ).thenAnswer((_) async => const Right<Failure, double>(volume));
      final result = await useCase.execute();
      expect(result, const Right<Failure, double>(volume));
      verify(mockRepository.getVolume()).called(1);
    });

    test('should return failure when repository fails', () async {
      when(
        mockRepository.getVolume(),
      ).thenAnswer((_) async => const Left<Failure, double>(UnknownFailure()));
      final result = await useCase.execute();
      expect(result.isLeft(), true);
      verify(mockRepository.getVolume()).called(1);
    });
  });
}
