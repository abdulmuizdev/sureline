import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SettingsListItem extends StatefulWidget {
  final bool? isFirst;
  final bool? isLast;
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final VoidCallback? onPressed;
  final bool? hideArrow;
  final bool? useDarkHover;

  const SettingsListItem({
    super.key,
    this.isLast,
    required this.title,
    this.isFirst,
    this.icon,
    this.imageAsset,
    this.onPressed,
    this.hideArrow,
    this.useDarkHover,
  });

  @override
  State<SettingsListItem> createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  bool _isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _isTappedDown = true),
      onTapUp: (_) => setState(() => _isTappedDown = false),
      onTapCancel: () => setState(() => _isTappedDown = false),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color:
              (_isTappedDown)
                  ? AppColors.primaryColor.withValues(
                    alpha: (widget.useDarkHover ?? false) ? 0.2 : 0.05,
                  )
                  : AppColors.pureWhite,
          borderRadius: BorderRadius.only(
            topLeft:
                (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
            topRight:
                (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
            bottomLeft:
                (widget.isLast ?? false) ? Radius.circular(10) : Radius.zero,
            bottomRight:
                (widget.isLast ?? false) ? Radius.circular(10) : Radius.zero,
          ),
          border:
              (widget.isLast ?? false)
                  ? null
                  : Border(
                    bottom: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.imageAsset != null) ...[
                  Image.asset(widget.imageAsset!, width: 20, height: 20),
                  SizedBox(width: 25),
                ] else if (widget.icon != null) ...[
                  Icon(widget.icon, color: AppColors.primaryColor, size: 20),
                  SizedBox(width: 25),
                ],
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            if (!(widget.hideArrow ?? false)) ...[
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: AppColors.primaryColor.withValues(alpha: 0.3),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
