import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';

class OwnQuoteListItem extends StatefulWidget {
  final bool isOverlayVisible;
  final Function(bool) onOverlayToggled;
  final VoidCallback onDeletePressed;
  final OwnQuoteEntity entity;
  final VoidCallback onAddToCollectionPressed;

  const OwnQuoteListItem({
    super.key,
    required this.entity,
    required this.isOverlayVisible,
    required this.onOverlayToggled,
    required this.onDeletePressed,
    required this.onAddToCollectionPressed,
  });

  @override
  State<OwnQuoteListItem> createState() => _OwnQuoteListItemState();
}

class _OwnQuoteListItemState extends State<OwnQuoteListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: 14),
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
                    widget.entity.quoteText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SurelineOverlay(
                  onClose:
                      () => widget.onOverlayToggled(!widget.isOverlayVisible),

                  overlay: GestureDetector(
                    onTap: widget.onDeletePressed,
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
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
                          Icon(
                            CupertinoIcons.delete,
                            color: CupertinoColors.destructiveRed,
                          ),
                        ],
                      ),
                    ),
                  ),
                  visible: widget.isOverlayVisible,
                  target: Alignment.bottomRight,
                  follower: Alignment.topRight,
                  animateUpwards: true,
                  child: IconButton(
                    onPressed:
                        () => widget.onOverlayToggled(!widget.isOverlayVisible),
                    icon: Icon(
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
                  (widget.entity.createdAt != null)
                      ? '${Utils.getWeekDayLabel(DateTime.parse(widget.entity.createdAt!).weekday, threeChars: true)}, ${DateTime.parse(widget.entity.createdAt!).day} ${Utils.getMonthLabel(DateTime.parse(widget.entity.createdAt!).month)} ${DateTime.parse(widget.entity.createdAt!).year}'
                      : '',
                  // 'Thu, 01 May 2025',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.onAddToCollectionPressed();
                      },
                      icon: Icon(
                        (widget.entity.collections.isEmpty)
                            ? Icons.bookmark_border_outlined
                            : Icons.bookmark_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SharePlus.instance.share(
                          ShareParams(text: '"${widget.entity.quoteText}"'),
                        );
                      },
                      icon: Icon(
                        Icons.ios_share_rounded,
                        color: AppColors.primaryColor,
                      ),
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
