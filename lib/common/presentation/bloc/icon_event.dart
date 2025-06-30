import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

abstract class IconEvent {
  const IconEvent();
}

class Initialize extends IconEvent {
  const Initialize();
}

class ChangeIcon extends IconEvent {
  final IconEntity icon;
  const ChangeIcon(this.icon);
}