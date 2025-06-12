import 'package:equatable/equatable.dart';

class DayEntity extends Equatable {
  final String title;
  final int dateTime;
  final bool isSelected;

  const DayEntity({
    required this.title,
    this.isSelected = false,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [title, dateTime, isSelected];

  DayEntity copyWith({String? title, int? dateTime, bool? isSelected}) {
    return DayEntity(
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
