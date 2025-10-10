import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Widget for displaying a search list item.
class SearchListItem extends StatefulWidget {
  /// The quote entity to display.
  final QuoteEntity entity;

  /// Callback function when like button is pressed.
  final void Function({required bool isLiked}) onLikePressed;

  /// Creates a new SearchListItem instance.
  const SearchListItem({super.key, required this.entity, required this.onLikePressed});

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.pureWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entity.quoteText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onLikePressed(isLiked: true);
                      },
                      icon: const Icon(CupertinoIcons.heart_fill, color: AppColors.primaryColor),
                    ),
                    IconButton(
                      onPressed: () {
                        SharePlus.instance.share(ShareParams(text: '"${widget.entity.quoteText}"'));
                      },
                      icon: const Icon(Icons.ios_share_rounded, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
