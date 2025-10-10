/// Individual collection item widget for list display.
///
/// Shows collection name, quote count, and action buttons.
/// This widget represents a single collection in the collections list,
/// displaying the collection's name, quote count, and interactive
/// elements for sharing and deletion. It provides a clean, touch-friendly
/// interface for collection management.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Displays a single collection with its metadata and actions.
///
/// This widget represents an individual collection item in the collections list.
/// It displays the collection's name, total quote count, and provides actions
/// for sharing and deletion. The widget includes an overlay menu for additional
/// actions and maintains proper touch targets for accessibility.
///
/// Key features:
/// - Displays collection name with proper text overflow handling
/// - Shows total quote count from all quote types
/// - Provides share functionality for collection names
/// - Includes overlay menu for delete action
/// - Maintains proper touch targets and accessibility
/// - Responsive design with proper spacing and styling
class CollectionListItem extends StatefulWidget {
  /// Whether the overlay menu is currently visible.
  final bool isOverlayVisible;

  /// Callback for toggling overlay visibility.
  final Function(bool) onOverlayToggled;

  /// Callback for delete action.
  final VoidCallback onDeletePressed;

  /// The collection entity to display.
  final CollectionEntity entity;

  /// Creates a new collection list item.
  const CollectionListItem({
    super.key,
    required this.entity,
    required this.isOverlayVisible,
    required this.onOverlayToggled,
    required this.onDeletePressed,
  });

  @override
  State<CollectionListItem> createState() => _CollectionListItemState();
}

class _CollectionListItemState extends State<CollectionListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.pureWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.entity.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SurelineOverlay(
                  onClose: () => widget.onOverlayToggled(!widget.isOverlayVisible),

                  overlay: GestureDetector(
                    onTap: widget.onDeletePressed,
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: CupertinoColors.destructiveRed,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(CupertinoIcons.delete, color: CupertinoColors.destructiveRed),
                        ],
                      ),
                    ),
                  ),
                  visible: widget.isOverlayVisible,
                  target: Alignment.bottomRight,
                  follower: Alignment.topRight,
                  animateUpwards: true,
                  child: IconButton(
                    onPressed: () => widget.onOverlayToggled(!widget.isOverlayVisible),
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.entity.favouriteQuotes.length + widget.entity.ownQuotes.length + widget.entity.historyQuotes.length + widget.entity.searchQuotes.length} quotes',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Create formatted string with collection name as heading and all quotes
                    final shareText =
                        StringBuffer()
                          // Add collection name as heading
                          ..writeln('${widget.entity.name}:')
                          ..writeln(); // Empty line after heading

                    // Add all favourite quotes
                    for (final favourite in widget.entity.favouriteQuotes) {
                      shareText
                        ..writeln(favourite.quote)
                        ..writeln(); // Empty line after heading
                    }

                    // Add all own quotes
                    for (final ownQuote in widget.entity.ownQuotes) {
                      shareText
                        ..writeln(ownQuote.quoteText)
                        ..writeln(); // Empty line after heading
                    }

                    // Add all history quotes
                    for (final history in widget.entity.historyQuotes) {
                      shareText
                        ..writeln(history.quoteText)
                        ..writeln(); // Empty line after heading
                    }

                    // Add all search quotes
                    for (final search in widget.entity.searchQuotes) {
                      shareText
                        ..writeln(search.quoteText)
                        ..writeln(); // Empty line after heading
                    }

                    // Add footer
                    shareText.writeln('From Sureline app.');

                    SharePlus.instance.share(ShareParams(text: shareText.toString()));
                  },
                  icon: const Icon(Icons.ios_share_rounded, color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
