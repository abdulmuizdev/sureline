import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/history/domain/entity/history_entity.dart';
import 'package:sureline/features/history/presentation/bloc/history_bloc.dart';
import 'package:sureline/features/history/presentation/bloc/history_event.dart';
import 'package:sureline/features/history/presentation/bloc/history_state.dart';

class HistoryBottomSheet extends StatefulWidget {
  const HistoryBottomSheet({super.key});

  @override
  State<HistoryBottomSheet> createState() => _HistoryBottomSheetState();
}

class _HistoryBottomSheetState extends State<HistoryBottomSheet> {
  List<HistoryEntity> _quotes = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<HistoryBloc>()..add(GetHistory()),
      child: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryLoaded) {
            _quotes = [...state.history];
            print(_quotes.length);
          }
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (_quotes.isEmpty) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SurelineBackButton(title: 'Sureline'),
                      SizedBox(height: 27),
                      Text(
                        'History',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 27),
                      const Spacer(),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: Placeholder(),
                            ),
                            const OnboardingHeading(
                              reduceMargins: true,
                              title: 'Your scrolled quotes will appear here',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            } else {
              return Portal(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SurelineBackButton(title: 'Sureline'),
                        SizedBox(height: 27),
                        Text(
                          'History',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 27),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _quotes.length,
                            itemBuilder: (context, index) {
                              return FavouriteListItem(
                                historyEntity: _quotes[index],
                                isFavourite: _quotes[index].isFavourite,
                                isHistory: true,
                                isOverlayVisible: false,
                                onOverlayToggled: (value) {},
                                onDeletePressed: () {},
                                onFavouritePressed: () {
                                  context.read<HistoryBloc>().add(
                                    OnLikePressed(
                                      _quotes[index],
                                      !_quotes[index].isFavourite,
                                    ),
                                  );
                                },
                                onAddToCollectionPressed: () {
                                  showModalBottomSheet(
                                    context:
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).context,
                                    builder:
                                        (ctx) => CollectionSelectionBottomSheet(
                                          quoteId: _quotes[index].id,

                                          onHistoryUpdated: (
                                            _,
                                            collectionsOfHistory,
                                          ) {
                                            print(
                                              'collectionsOfHistory: ${collectionsOfHistory.length}',
                                            );
                                            setState(() {
                                              _quotes[index] = _quotes[index]
                                                  .copyWith(
                                                    collections:
                                                        collectionsOfHistory,
                                                  );
                                            });
                                          },
                                        ),
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SurelineButton(
                          text: 'See older quotes',
                          onPressed: () {},
                          disableVerticalPadding: true,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
