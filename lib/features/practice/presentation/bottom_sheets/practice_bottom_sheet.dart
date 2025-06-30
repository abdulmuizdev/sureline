import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:sureline/core/theme/app_colors.dart';

import 'package:sureline/features/practice/widgets/practice_item.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

class PracticeBottomSheet extends StatefulWidget {
  final List<QuoteEntity> quotes;
  final Duration perQuoteDuration;

  const PracticeBottomSheet({
    super.key,
    required this.quotes,
    required this.perQuoteDuration,
  });

  @override
  State<PracticeBottomSheet> createState() => _PracticeBottomSheetState();
}

class _PracticeBottomSheetState extends State<PracticeBottomSheet> {
  final _controller = StoryController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Stack(
        children: [
          StoryView(
            storyItems: [
              ...List.generate(widget.quotes.length, (index) {
                return StoryItem(
                  PracticeItem(quote: widget.quotes[index].quoteText),
                  duration: widget.perQuoteDuration,
                );
              }),
            ],
            controller: _controller,
            onComplete: () {
              Navigator.of(context).pop(true);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: Icon(
                Icons.close_rounded,
                size: 22,
                color: AppColors.primaryColor.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
