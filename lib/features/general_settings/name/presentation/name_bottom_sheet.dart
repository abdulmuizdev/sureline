import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_bloc.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_event.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_state.dart';

class NameBottomSheet extends StatefulWidget {
  const NameBottomSheet({super.key});

  @override
  State<NameBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<NameBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<NameBloc>()..add(GetName())),
      ],
      child: BlocListener<NameBloc, NameState>(
        listener: (context, state) {
          if (state is NameSaved) {
            Navigator.of(context).pop();
          }
          if (state is GotName) {
            _nameController.text = state.name;
          }
        },
        child: BlocBuilder<NameBloc, NameState>(
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
                    'Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your name is used to personalize your content',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  SurelineTextField(
                    controller: _nameController,
                    showCharLimit: false,
                    hint: 'Your name',
                    disableCenterAlignment: true,
                    isNameInput: true,
                  ),
                  Spacer(),
                  SurelineButton(
                    text: 'Save',
                    onPressed: () {
                      context.read<NameBloc>().add(
                        OnSavePressed(_nameController.text),
                      );
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
