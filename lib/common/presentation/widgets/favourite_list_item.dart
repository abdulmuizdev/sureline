import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class FavouriteListItem extends StatefulWidget {
  final bool isOverlayVisible;
  final Function(bool) onOverlayToggled;

  final FavouriteEntity? favouriteEntity;
  final OwnQuoteEntity? ownQuoteEntity;
  final HistoryEntity? historyEntity;
  final SearchEntity? searchEntity;

  final bool? isOwnQuote;
  final bool? isFavourite;
  final bool? isHistory;
  final bool? isSearch;
  final VoidCallback onDeletePressed;
  final VoidCallback onAddToCollectionPressed;
  final VoidCallback? onFavouritePressed;

  const FavouriteListItem({
    super.key,
    this.favouriteEntity,
    this.ownQuoteEntity,
    this.historyEntity,
    this.searchEntity,
    required this.isOverlayVisible,
    required this.onOverlayToggled,
    required this.onDeletePressed,
    required this.onAddToCollectionPressed,
    this.isOwnQuote,
    this.isFavourite,
    this.onFavouritePressed,
    this.isHistory,
    this.isSearch,
  });

  @override
  State<FavouriteListItem> createState() => _FavouriteListItemState();
}

class _FavouriteListItemState extends State<FavouriteListItem> {
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
                    (widget.historyEntity != null)
                        ? widget.historyEntity!.quoteText
                        : (widget.favouriteEntity != null)
                        ? widget.favouriteEntity!.quote
                        : (widget.ownQuoteEntity != null)
                        ? widget.ownQuoteEntity!.quoteText
                        : widget.searchEntity!.quoteText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                if ((widget.isHistory ?? false) == false) ...[
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
                          () =>
                              widget.onOverlayToggled(!widget.isOverlayVisible),
                      icon: Icon(
                        Icons.more_vert_rounded,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (widget.favouriteEntity?.createdAt != null)
                      ? '${Utils.getWeekDayLabel(DateTime.parse(widget.favouriteEntity!.createdAt!).weekday, threeChars: true)}, ${DateTime.parse(widget.favouriteEntity!.createdAt!).day} ${Utils.getMonthLabel(DateTime.parse(widget.favouriteEntity!.createdAt!).month)} ${DateTime.parse(widget.favouriteEntity!.createdAt!).year}'
                      : (widget.ownQuoteEntity?.createdAt != null)
                      ? '${Utils.getWeekDayLabel(DateTime.parse(widget.ownQuoteEntity!.createdAt!).weekday, threeChars: true)}, ${DateTime.parse(widget.ownQuoteEntity!.createdAt!).day} ${Utils.getMonthLabel(DateTime.parse(widget.ownQuoteEntity!.createdAt!).month)} ${DateTime.parse(widget.ownQuoteEntity!.createdAt!).year}'
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
                      onPressed: widget.onAddToCollectionPressed,
                      icon: Icon(
                        (widget.favouriteEntity?.collections.isNotEmpty ==
                                    true ||
                                widget.ownQuoteEntity?.collections.isNotEmpty ==
                                    true ||
                                widget.historyEntity?.collections.isNotEmpty ==
                                    true ||
                                widget.searchEntity?.collections.isNotEmpty ==
                                    true)
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    if (widget.isOwnQuote == true ||
                        widget.isHistory == true ||
                        widget.isSearch == true) ...[
                      IconButton(
                        onPressed: widget.onFavouritePressed,
                        icon: Icon(
                          widget.isFavourite == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                    IconButton(
                      onPressed: () {
                        final quoteText =
                            widget.favouriteEntity?.quote ??
                            widget.ownQuoteEntity?.quoteText ??
                            widget.searchEntity?.quoteText ??
                            '';
                        if (quoteText.isNotEmpty) {
                          SharePlus.instance.share(
                            ShareParams(text: '"$quoteText"'),
                          );
                        }
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
