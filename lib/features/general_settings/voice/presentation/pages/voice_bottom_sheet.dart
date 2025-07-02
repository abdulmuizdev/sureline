import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart' show AppColors;
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_bloc.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_event.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_state.dart';
import 'package:sureline/features/general_settings/voice/presentation/widget/voice_list_item.dart';

class VoiceBottomSheet extends StatefulWidget {
  const VoiceBottomSheet({super.key});

  @override
  State<VoiceBottomSheet> createState() => _VoiceBottomSheetState();
}

class _VoiceBottomSheetState extends State<VoiceBottomSheet> {
  List<VoiceEntity> _voices = [];
  int _selectedIndex = -1;
  FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<VoiceBloc>()..add(GetVoices())),
      ],
      child: BlocListener<VoiceBloc, VoiceState>(
        listener: (context, state) {
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
                  Text(
                    'Voice',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 22),
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
                            context.read<VoiceBloc>().add(
                              OnVoiceItemPressed(_voices[index]),
                            );
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
