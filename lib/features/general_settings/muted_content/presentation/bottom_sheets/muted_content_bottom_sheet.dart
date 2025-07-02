import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bloc/muted_content_bloc.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bloc/muted_content_event.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bloc/muted_content_state.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/widgets/muted_content_grid_item.dart';

class MutedContentBottomSheet extends StatefulWidget {
  const MutedContentBottomSheet({super.key});

  @override
  State<MutedContentBottomSheet> createState() =>
      _MutedContentBottomSheetState();
}

class _MutedContentBottomSheetState extends State<MutedContentBottomSheet> {
  MutedContentEntity _mutedContent = MutedContentEntity(
    isWithAuthorMuted: false,
    isWithoutAuthorMuted: false,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MutedContentBloc>(
          create:
              (context) =>
                  locator<MutedContentBloc>()..add(GetMutedContentOptions()),
        ),
      ],
      child: BlocListener<MutedContentBloc, MutedContentState>(
        listener: (context, state) {
          if (state is GotMutedContentOptions) {
            print('got muted content options');
            _mutedContent = state.result;
          }
        },
        child: BlocBuilder<MutedContentBloc, MutedContentState>(
          builder: (context, state) {
            return Container(
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Muted Content',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'When you mute content, you won\'t see it in your feed, notifications, or widgets',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 170 / 85,
                                    mainAxisSpacing: 18,
                                    crossAxisSpacing: 18,
                                  ),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return MutedContentGridItem(
                                  title:
                                      index == 0
                                          ? 'With Author'
                                          : 'Without Author',
                                  isSelected:
                                      index == 0
                                          ? _mutedContent.isWithAuthorMuted
                                          : _mutedContent.isWithoutAuthorMuted,
                                  onPressed: () {
                                    final newOptions = _mutedContent.copyWith(
                                      isWithAuthorMuted:
                                          index == 0
                                              ? !_mutedContent.isWithAuthorMuted
                                              : false,
                                      isWithoutAuthorMuted:
                                          index == 1
                                              ? !_mutedContent
                                                  .isWithoutAuthorMuted
                                              : false,
                                    );

                                    context.read<MutedContentBloc>().add(
                                      OnMutedContentPressed([newOptions]),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
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
