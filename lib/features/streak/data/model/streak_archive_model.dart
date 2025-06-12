import 'package:sureline/features/streak/data/model/streak_model.dart';

// For data keeping for future analysis
class StreakArchiveModel extends StreakModel {
  final DateTime archivedOn;

  StreakArchiveModel({required super.timeStamp, required this.archivedOn});

  @override
  Map<String, dynamic> toJson() {
    return {'archivedOn': archivedOn, 'timeStamp': timeStamp.toIso8601String()};
  }
}
