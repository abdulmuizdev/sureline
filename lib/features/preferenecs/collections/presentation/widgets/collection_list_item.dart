import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';

class CollectionListItem extends StatefulWidget {
  final bool isOverlayVisible;
  final Function(bool) onOverlayToggled;
  final VoidCallback onDeletePressed;
  final CollectionEntity entity;

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
                    widget.entity.name,
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
                  '${widget.entity.favouriteQuotes.length + widget.entity.ownQuotes.length + widget.entity.historyQuotes.length + widget.entity.searchQuotes.length} quotes',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SharePlus.instance.share(
                      ShareParams(text: '"${widget.entity.name}"'),
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
      ),
    );
  }
}
