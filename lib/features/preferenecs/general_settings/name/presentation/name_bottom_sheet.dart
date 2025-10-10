import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_event.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_state.dart';

/// Bottom sheet widget for editing the user's display name.
///
/// This widget provides a clean interface for users to set and update
/// their display name, which is used for personalization throughout
/// the app. It includes features like:
/// - Text input field for entering the name
/// - Save button to persist changes
/// - Auto-population with existing name
/// - Automatic navigation back on successful save
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the NameBloc.
class NameBottomSheet extends StatefulWidget {
  const NameBottomSheet({super.key});

  @override
  State<NameBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<NameBottomSheet> {
  /// Text editing controller for the name input field
  final TextEditingController _nameController = TextEditingController();

  /// Current name value (for internal state tracking)
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the NameBloc and trigger initial name loading
        BlocProvider(create: (_) => locator<NameBloc>()..add(const GetName())),
      ],
      child: BlocListener<NameBloc, NameState>(
        listener: (context, state) {
          // Navigate back on successful save
          if (state is NameSaved) {
            Navigator.of(context).pop();
          }
          // Populate input field with retrieved name
          if (state is GotName) {
            _nameController.text = state.name;
          }
        },
        child: BlocBuilder<NameBloc, NameState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Description text explaining the purpose
                  const Text(
                    'Your name is used to personalize your content',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Name input field
                  SurelineTextField(
                    controller: _nameController,
                    showCharLimit: false,
                    hint: 'Your name',
                    disableCenterAlignment: true,
                    isNameInput: true,
                  ),
                  const Spacer(),
                  // Save button
                  SurelineButton(
                    text: 'Save',
                    onPressed: () {
                      context.read<NameBloc>().add(OnSavePressed(_nameController.text));
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
