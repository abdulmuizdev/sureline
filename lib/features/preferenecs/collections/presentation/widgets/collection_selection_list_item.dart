import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';

class CollectionSelectionListItem extends StatefulWidget {
  final CollectionEntity entity;
  final VoidCallback onSelected;
  final bool isFirst;
  final bool isLast;
  final bool isSelected;

  const CollectionSelectionListItem({
    super.key,
    required this.entity,
    required this.onSelected,
    required this.isFirst,
    required this.isLast,
    required this.isSelected,
  });

  @override
  State<CollectionSelectionListItem> createState() =>
      _CollectionSelectionListItemState();
}

class _CollectionSelectionListItemState
    extends State<CollectionSelectionListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: widget.isFirst ? Radius.circular(8) : Radius.circular(0),
            topRight: widget.isFirst ? Radius.circular(8) : Radius.circular(0),
            bottomLeft: widget.isLast ? Radius.circular(8) : Radius.circular(0),
            bottomRight:
                widget.isLast ? Radius.circular(8) : Radius.circular(0),
          ),
          border: Border(
            bottom:
                (widget.isFirst && widget.isLast)
                    ? BorderSide.none
                    : BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      width: 1,
                    ),
          ),
          color: AppColors.pureWhite,
        ),
        child: Row(
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
            CollectionSelectionCheckbox(isSelected: widget.isSelected),
          ],
        ),
      ),
    );
  }
}

class CollectionSelectionCheckbox extends StatelessWidget {
  final bool isSelected;

  const CollectionSelectionCheckbox({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
          width: 1,
        ),
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
      ),
      child:
          isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : null,
    );
  }
}
