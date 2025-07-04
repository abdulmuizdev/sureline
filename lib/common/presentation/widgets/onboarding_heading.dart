import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class OnboardingHeading extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? reduceMargins;
  final bool? disableMargins;
  final bool? disableTopMargin;

  const OnboardingHeading({
    super.key,
    required this.title,
    this.subTitle,
    this.reduceMargins,
    this.disableMargins,
    this.disableTopMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          (disableMargins ?? false)
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(
                horizontal: (reduceMargins ?? false) ? 60 : 80,
              ),
      child: Column(
        children: [
          if (!(disableTopMargin ?? false)) ...[SizedBox(height: 20)],
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          if (subTitle != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (reduceMargins ?? false) ? 0 : 10,
              ),
              child: Text(
                subTitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ],
      ),
    );
  }
}
