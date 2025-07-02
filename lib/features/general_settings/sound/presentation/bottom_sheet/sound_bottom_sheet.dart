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
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_bloc.dart';
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_event.dart';
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SoundBottomSheet extends StatefulWidget {
  const SoundBottomSheet({super.key});

  @override
  State<SoundBottomSheet> createState() => _SoundBottomSheetState();
}

class _SoundBottomSheetState extends State<SoundBottomSheet> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<SoundBloc>()..add(GetVolume())),
      ],
      child: BlocListener<SoundBloc, SoundState>(
        listener: (context, state) {
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
                  Text(
                    'Sound',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Set the volume you\'d like',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'THEME SOUND',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  SurelineSlider(
                    value: _sliderValue,
                    onChange: (val) {
                      setState(() {
                        _sliderValue = val;
                      });
                    },
                    onChangeEnd: (val) {
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
