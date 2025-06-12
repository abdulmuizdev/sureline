import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

abstract class IconState {
  const IconState();
}

class Initial extends IconState{
  const Initial();
}

class Initializing extends IconState {
  const Initializing();
}

class Initialized extends IconState {
  final List<IconEntity> icons;
  final int selectedIndex;
  const Initialized(this.icons, this.selectedIndex);
}

class ChangingIcon extends IconState {
  const ChangingIcon();
}

class ChangedIcon extends IconState {
  const ChangedIcon();
}

class IconError extends IconState {
  final String message;
  const IconError(this.message);
}
