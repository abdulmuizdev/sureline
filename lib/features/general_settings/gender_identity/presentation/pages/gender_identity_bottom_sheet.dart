import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_bloc.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_event.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_state.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/widget/gender_identity_grid_item.dart';

class GenderIdentityBottomSheet extends StatefulWidget {
  const GenderIdentityBottomSheet({super.key});

  @override
  State<GenderIdentityBottomSheet> createState() =>
      _GenderIdentityBottomSheetState();
}

class _GenderIdentityBottomSheetState extends State<GenderIdentityBottomSheet> {
  List<GenderIdentityEntity> _options = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => locator<GenderIdentityBloc>()..add(GetGenderIdentities()),
        ),
      ],
      child: BlocListener<GenderIdentityBloc, GenderIdentityState>(
        listener: (context, state) {
          if (state is GotGenderIdentities) {
            _options = state.result;
          }
        },
        child: BlocBuilder<GenderIdentityBloc, GenderIdentityState>(
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
                    'Gender identity',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your gender identity is used to personalize your content',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      return GenderIdentityGridItem(
                        title: _options[index].title,
                        isSelected: _options[index].isSelected,
                        onPressed: () {
                          final current = _options[index];
                          List<GenderIdentityEntity> newEntities = [
                            ...(_options
                                .map(
                                  (entity) =>
                                      entity.copyWith(isSelected: false),
                                )
                                .toList()),
                          ];
                          newEntities[index] = current.copyWith(
                            isSelected: !current.isSelected,
                          );
                          context.read<GenderIdentityBloc>().add(
                            OnGenderIdentityPressed(newEntities),
                          );
                        },
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      'Prefer not to say',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
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
