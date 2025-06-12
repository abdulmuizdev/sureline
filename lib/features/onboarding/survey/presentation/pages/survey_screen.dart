import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/domain/entities/question_entity.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/features/onboarding/survey/presentation/widgets/survey_selector.dart';

class SurveyScreen extends StatefulWidget {
  final List<QuestionEntity> entities;
  final Widget navigateTo;
  final int pageNumber;

  const SurveyScreen({
    super.key,
    required this.entities,
    required this.navigateTo,
    this.pageNumber = 0,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int? _selectedIndex;

  void _goToNextPage() {
    if (widget.pageNumber < widget.entities.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SurveyScreen(
                entities: widget.entities,
                navigateTo: widget.navigateTo,
                pageNumber: widget.pageNumber + 1,
              ),
        ),
      );
    } else {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => widget.navigateTo));
    }
  }

  Widget fragment(QuestionEntity entity) {
    return Column(
      children: [
        OnboardingHeading(title: entity.title, subTitle: entity.subTitle),
        Expanded(
          child: ListView.builder(
            itemCount: entity.choices.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  debugPrint('clicked');
                  setState(() {
                    _selectedIndex = index;
                  });
                  HapticFeedback.lightImpact();
                  await Future.delayed(Duration(milliseconds: 1000), () {
                    _goToNextPage();
                  });
                },
                child: SurveySelector(
                  isChecked: _selectedIndex == index,
                  text: entity.choices[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            SafeArea(child: fragment(widget.entities[widget.pageNumber])),
          ],
        ),
      ),
    );
  }
}
