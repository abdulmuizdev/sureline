import 'package:mockito/annotations.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';
// Add other repositories as needed

@GenerateMocks([
  SoundRepository,
  VoiceRepository,
  CollectionsRepository,
  // Add other repositories here as you go
])
void main() {}
