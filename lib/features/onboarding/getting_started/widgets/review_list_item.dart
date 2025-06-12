import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ReviewListItem extends StatelessWidget {
  final int starCount;
  final String reviewText;
  const ReviewListItem({super.key, required this.starCount, required this.reviewText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          width: 270,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(starCount, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Image.asset(
                      'assets/images/star.png',
                      width: 17,
                      height: 17,
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Text(
                  '"$reviewText"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.normal,
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
