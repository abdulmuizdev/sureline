import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';

abstract class HistoryEvent {}

class GetHistory extends HistoryEvent {}

class OnLikePressed extends HistoryEvent {
  final HistoryEntity entity;
  final bool isLiked;
  OnLikePressed(this.entity, this.isLiked);
}
