import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart' show AppColors;
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_event.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_state.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/widget/voice_list_item.dart';

/// Bottom sheet widget for selecting text-to-speech voices.
///
/// This widget provides a clean interface for users to select and
/// configure text-to-speech voices for reading quotes aloud. It includes
/// features like:
/// - List of all available TTS voices on the device
/// - Visual indication of the currently selected voice
/// - Real-time voice preview when selecting
/// - Persistent storage of voice preferences
/// - Filtering to show only English voices
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the VoiceBloc.
class VoiceBottomSheet extends StatefulWidget {
  const VoiceBottomSheet({super.key});

  @override
  State<VoiceBottomSheet> createState() => _VoiceBottomSheetState();
}

class _VoiceBottomSheetState extends State<VoiceBottomSheet> {
  /// List of available voice entities
  List<VoiceEntity> _voices = [];

  /// Index of the currently selected voice in the list
  int _selectedIndex = -1;

  /// FlutterTts instance for voice preview functionality
  FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the VoiceBloc and trigger initial voice loading
        BlocProvider(create: (_) => locator<VoiceBloc>()..add(GetVoices())),
      ],
      child: BlocListener<VoiceBloc, VoiceState>(
        listener: (context, state) {
          // Update local state when voices are loaded
          if (state is GotVoices) {
            _voices = state.voices;
            _selectedIndex = state.selectedIndex;
          }
        },
        child: BlocBuilder<VoiceBloc, VoiceState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  Text(
                    'Voice',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 22),
                  // Scrollable list of available voices
                  Expanded(
                    child: ListView.builder(
                      itemCount: _voices.length,
                      itemBuilder: (context, index) {
                        return VoiceListItem(
                          title: _voices[index].name,
                          subTitle: _voices[index].locale,
                          isFirst: index == 0,
                          isLast: index == _voices.length - 1,
                          isSelected: _selectedIndex == index,
                          onPressed: () async {
                            // Update voice selection and trigger change
                            context.read<VoiceBloc>().add(OnVoiceItemPressed(_voices[index]));
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
