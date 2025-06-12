import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_container.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_bloc.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_event.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_state.dart';
import 'package:sureline/features/general_settings/streak/presentation/widget/streak_switcher.dart';

class StreakSettingBottomSheet extends StatefulWidget {
  const StreakSettingBottomSheet({super.key});

  @override
  State<StreakSettingBottomSheet> createState() =>
      _StreakSettingBottomSheetState();
}

class _StreakSettingBottomSheetState extends State<StreakSettingBottomSheet> {
  bool _isStreakEnable = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<StreakBloc>()..add(GetStreakStatus()),
        ),
      ],
      child: BlocListener<StreakBloc, StreakState>(
        listener: (context, state) {
          if (state is GotStreakStatus) {
            _isStreakEnable = state.isEnabled;
          }
          if (state is StreakStatusUpdated) {
            _isStreakEnable = state.isEnabled;
          }
        },
        child: BlocBuilder<StreakBloc, StreakState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(18),
              decoration: Utils.bottomSheetDecoration(),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SurelineBackButton(title: 'Settings'),
                  SizedBox(height: 27),
                  Text(
                    'Streak',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Practicing quotes every day can significantly improve your mental health',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  StreakSwitcher(
                    isSelected: _isStreakEnable,
                    onChange:
                        (value) => context.read<StreakBloc>().add(
                          UpdateStreakStatus(value),
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
