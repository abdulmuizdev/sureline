import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:sureline/core/theme/app_colors.dart';

class AuthorPrefGridItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onPressed;
  final VoidCallback onSubscriptionPurchased;

  const AuthorPrefGridItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isLocked,
    required this.onPressed,
    required this.onSubscriptionPurchased,
  });
  void _presentPaywallIfNeeded() async {
    final paywallResult = await RevenueCatUI.presentPaywall();
    print('Paywall result: $paywallResult');
    if (paywallResult == PaywallResult.purchased || paywallResult == PaywallResult.restored) {
      onSubscriptionPurchased();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          (isLocked)
              ? () {
                _presentPaywallIfNeeded();
              }
              : onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: isSelected ? null : Border.all(color: AppColors.primaryColor, width: 1),
          color:
              (isLocked)
                  ? AppColors.primaryColor.withValues(alpha: 0.1)
                  : isSelected
                  ? AppColors.peach
                  : AppColors.pureWhite,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color:
                      isSelected
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (isLocked)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    size: 15,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
