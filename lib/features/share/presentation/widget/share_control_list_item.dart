import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ShareControlListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const ShareControlListItem({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: (){
          HapticFeedback.lightImpact();
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: SizedBox(
          width: 65,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(icon, size: 20,),
              ),
              SizedBox(height: 6),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
