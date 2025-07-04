import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_event.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_state.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/widget/author_pref_grid_item.dart';

class AuthorPrefBottomSheet extends StatefulWidget {
  const AuthorPrefBottomSheet({super.key});

  @override
  State<AuthorPrefBottomSheet> createState() => _AuthorPrefBottomSheetState();
}

class _AuthorPrefBottomSheetState extends State<AuthorPrefBottomSheet> {
  List<AuthorPrefEntity> _options = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<AuthorPrefBloc>()..add(GetAuthorPrefOptions()),
        ),
      ],
      child: BlocListener<AuthorPrefBloc, AuthorPrefState>(
        listener: (context, state) {
          if (state is GotAuthorPrefOptions) {
            _options = state.result;
          }
        },
        child: BlocBuilder<AuthorPrefBloc, AuthorPrefState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Author preferences',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Select all authors that interest you',
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
                        return AuthorPrefGridItem(
                          title: _options[index].authorName,
                          isSelected: _options[index].isPreferred,
                          isLocked: _options[index].isLocked,
                          onPressed: () {
                            context.read<AuthorPrefBloc>().add(
                              OnAuthorPrefPressed(_options[index]),
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
