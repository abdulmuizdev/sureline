import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_slider.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_event.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Bottom sheet widget for adjusting sound volume settings.
///
/// This widget provides a clean interface for users to adjust
/// volume settings for theme sounds and other audio elements
/// in the app. It includes features like:
/// - Volume slider with real-time preview
/// - Visual feedback for current volume level
/// - Persistent storage of volume preferences
/// - Smooth animations and haptic feedback
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the SoundBloc.
class SoundBottomSheet extends StatefulWidget {
  const SoundBottomSheet({super.key});

  @override
  State<SoundBottomSheet> createState() => _SoundBottomSheetState();
}

class _SoundBottomSheetState extends State<SoundBottomSheet> {
  /// Current volume value for the slider (0.0 to 1.0)
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the SoundBloc and trigger initial volume loading
        BlocProvider(create: (_) => locator<SoundBloc>()..add(const GetVolume())),
      ],
      child: BlocListener<SoundBloc, SoundState>(
        listener: (context, state) {
          // Update slider value when volume is loaded
          if (state is GotVolume) {
            _sliderValue = state.volume;
          }
        },
        child: BlocBuilder<SoundBloc, SoundState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  const Text(
                    'Sound',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Description text explaining the purpose
                  const Text(
                    'Set the volume you\'d like',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Section label for theme sound
                  const Text(
                    'THEME SOUND',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Volume slider with real-time updates
                  SurelineSlider(
                    value: _sliderValue,
                    onChange: (val) {
                      setState(() {
                        _sliderValue = val;
                      });
                    },
                    onChangeEnd: (val) {
                      // Save volume setting when user finishes adjusting
                      context.read<SoundBloc>().add(SetVolume(val));
                    },
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
