import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';

class SearchListItem extends StatefulWidget {
  final QuoteEntity entity;
  final Function(bool) onLikePressed;

  const SearchListItem({
    super.key,
    required this.entity,
    required this.onLikePressed,
  });

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.only(top: 14, left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.pureWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entity.quote,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        widget.onLikePressed(!widget.entity.isLiked);
                      },
                      icon: Icon(
                        (widget.entity.isLiked)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        SharePlus.instance.share(
                          ShareParams(text: '"${widget.entity.quote}"'),
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
