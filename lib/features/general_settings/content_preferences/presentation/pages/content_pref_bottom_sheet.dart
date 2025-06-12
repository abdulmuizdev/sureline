import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_bloc.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_event.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_state.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/widget/content_pref_grid_item.dart';

class ContentPrefBottomSheet extends StatefulWidget {
  const ContentPrefBottomSheet({super.key});

  @override
  State<ContentPrefBottomSheet> createState() => _ContentPrefBottomSheetState();
}

class _ContentPrefBottomSheetState extends State<ContentPrefBottomSheet> {
  List<ContentPrefEntity> _options = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => locator<ContentPrefBloc>()..add(GetContentPrefOptions()),
        ),
      ],
      child: BlocListener<ContentPrefBloc, ContentPrefState>(
        listener: (context, state) {
          if (state is GotContentPrefOptions) {
            _options = state.result;
          }
        },
        child: BlocBuilder<ContentPrefBloc, ContentPrefState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              decoration: Utils.bottomSheetDecoration(),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SurelineBackButton(title: 'Settings'),
                  SizedBox(height: 27),
                  Text(
                    'Content preferences',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Select all topics that interest you',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 60),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 170 / 85,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                      ),
                      itemCount: _options.length,
                      itemBuilder: (context, index) {
                        return ContentPrefGridItem(
                          title: _options[index].title,
                          isSelected: _options[index].isSelected,
                          onPressed: () {
                            final current = _options[index];
                            List<ContentPrefEntity> newEntities = [..._options];
                            newEntities[index] = current.copyWith(
                              isSelected: !current.isSelected,
                            );
                            context.read<ContentPrefBloc>().add(
                              OnContentPrefPressed(newEntities),
                            );
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
