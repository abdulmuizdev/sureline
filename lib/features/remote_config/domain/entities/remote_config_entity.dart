import 'package:sureline/common/domain/entities/question_entity.dart';
import 'package:sureline/common/domain/entities/review_entity.dart';

class RemoteConfigEntity {
  final List<QuestionEntity> survey1;
  final List<QuestionEntity> survey2;
  final List<QuestionEntity> survey3;
  final List<QuestionEntity> survey4;
  final List<QuestionEntity> survey5;
  final List<QuestionEntity> survey6;
  final List<ReviewEntity> reviews;
  final List<String> benefits;

  const RemoteConfigEntity  ({
    required this.survey1,
    required this.survey2,
    required this.survey3,
    required this.survey4,
    required this.survey5,
    required this.survey6,
    required this.reviews,
    required this.benefits,
  });
} 