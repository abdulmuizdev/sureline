import 'package:sureline/common/data/model/recommendation_algorithm/question_model.dart';
import 'package:sureline/common/data/model/review_model.dart';
import 'package:sureline/features/remote_config/domain/entities/remote_config_entity.dart';

class RemoteConfigModel extends RemoteConfigEntity {
  final List<QuestionModel> survey1;
  final List<QuestionModel> survey2;
  final List<QuestionModel> survey3;
  final List<QuestionModel> survey4;
  final List<QuestionModel> survey5;
  final List<QuestionModel> survey6;
  final List<ReviewModel> reviews;
  final List<String> benefits;
  final List<String> benefitsImages;
  const RemoteConfigModel({
    required this.survey1,
    required this.survey2,
    required this.survey3,
    required this.survey4,
    required this.survey5,
    required this.survey6,
    required this.reviews,
    required this.benefits,
    required this.benefitsImages,
  }) : super(
         survey1: survey1,
         survey2: survey2,
         survey3: survey3,
         survey4: survey4,
         survey5: survey5,
         survey6: survey6,
         reviews: reviews,
         benefits: benefits,
         benefitsImages: benefitsImages,
       );

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigModel(
      survey1:
          (json['survey1'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      survey2:
          (json['survey2'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      survey3:
          (json['survey3'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      survey4:
          (json['survey4'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      survey5:
          (json['survey5'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      survey6:
          (json['survey6'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),

      reviews:
          (json['reviews'] as List)
              .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList(),

      benefits: (json['benefits'] as List).map((e) => e.toString()).toList(),
      benefitsImages: (json['benefitsImages'] as List).map((e) => e.toString()).toList(),
    );
  }
}
