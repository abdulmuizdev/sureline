import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_bloc.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_event.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_state.dart';
import 'package:sureline/features/theme_selection/presentation/theme_mixes/bottom_sheet/widget/theme_mix_grid_item.dart';

class ThemeMixesBottomSheet extends StatefulWidget {
  final VoidCallback onCreatePressed;
  const ThemeMixesBottomSheet({super.key, required this.onCreatePressed});

  @override
  State<ThemeMixesBottomSheet> createState() => _ThemeMixesBottomSheetState();
}

class _ThemeMixesBottomSheetState extends State<ThemeMixesBottomSheet> {
  List<ThemeEntity> _mixes = [];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<ThemeSelectorBloc>()..add(GetThemeMixes()),
        ),
      ],
      child: BlocListener<ThemeSelectorBloc, ThemeSelectorState>(
        listener: (context, state) {
          if (state is GotThemeMixes) {
            _mixes = state.result;
          }
        },
        child: BlocBuilder<ThemeSelectorBloc, ThemeSelectorState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(18),
              decoration: Utils.bottomSheetDecoration(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SurelineBackButton(title: 'Themes'),
                      Text(
                        'Theme mixes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onCreatePressed,
                        child: Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 31),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 171 / 90,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _mixes.length,
                      itemBuilder: (context, index) {
                        return ThemeMixGridItem(entity: _mixes[index]);
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
