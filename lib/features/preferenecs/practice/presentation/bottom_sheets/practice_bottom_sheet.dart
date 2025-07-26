import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:sureline/core/theme/app_colors.dart';

import 'package:sureline/features/preferenecs/practice/widgets/practice_item.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Full-screen practice session bottom sheet for quote meditation.
///
/// This widget implements a story-view based practice session where
/// quotes are displayed sequentially for focused reading and reflection.
/// Each quote is shown for a predetermined duration, creating a
/// guided meditation experience for quote internalization.
///
/// Key Features:
/// - Story view implementation for sequential quote display
/// - Configurable quote duration per session type
/// - Full-screen immersive experience
/// - Close button for early session termination
/// - Automatic completion callback when session ends
///
/// UX Flow:
/// 1. User selects practice duration from dialog
/// 2. Bottom sheet opens with story view
/// 3. Quotes display sequentially with animations
/// 4. User can close early or complete full session
/// 5. Completion callback triggers session summary
///
/// Technical Implementation:
/// - Uses story_view package for smooth transitions
/// - Implements StoryController for playback control
/// - Generates StoryItem widgets for each quote
/// - Handles disposal of controller resources
/// - Provides completion callback for session tracking
///
/// Design Considerations:
/// - Full-screen immersive experience
/// - Rounded top corners for premium feel
/// - Floating close button for easy access
/// - Seamless quote transitions
/// - Background integration with app theme
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (context) => PracticeBottomSheet(
///     quotes: selectedQuotes,
///     perQuoteDuration: Duration(seconds: 10),
///   ),
/// );
/// ```
class PracticeBottomSheet extends StatefulWidget {
  /// List of quotes to display during practice session.
  final List<QuoteEntity> quotes;

  /// Duration to display each quote before transitioning.
  final Duration perQuoteDuration;

  /// Creates a new PracticeBottomSheet instance.
  const PracticeBottomSheet({super.key, required this.quotes, required this.perQuoteDuration});

  @override
  State<PracticeBottomSheet> createState() => _PracticeBottomSheetState();
}

class _PracticeBottomSheetState extends State<PracticeBottomSheet> {
  /// Controller for managing story view playback and transitions.
  final _controller = StoryController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: Stack(
        children: [
          // Story view for sequential quote display
          StoryView(
            storyItems: [
              // Generate story items for each quote
              ...List.generate(widget.quotes.length, (index) {
                return StoryItem(
                  PracticeItem(quote: widget.quotes[index].quoteText),
                  duration: widget.perQuoteDuration,
                );
              }),
            ],
            controller: _controller,
            onComplete: () {
              // Session completed successfully
              Navigator.of(context).pop(true);
            },
          ),
          // Floating close button for early termination
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
            child: IconButton(
              onPressed: () {
                // User terminated session early
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
