import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_event.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_state.dart';

class IconBloc extends Bloc<IconEvent, IconState> {
  final FlutterAppIconChangerPlugin plugin;

  IconBloc(this.plugin) : super(Initial()) {
    on<Initialize>((event, emit) async {
      emit(Initializing());

      if ((await plugin.isSupported())) {
        final currentIcon =
            await plugin.getCurrentIcon() ?? plugin.iconsSet.first.iOSIcon;
        emit(
          Initialized(
            SurelineIcons.values,
            plugin.iconsSet.indexWhere((icon) => icon.iOSIcon == currentIcon),
          ),
        );
      } else {
        emit(IconError('Icon change is not supported on this device'));
      }
    });

    on<ChangeIcon>((event, emit) async {
      emit(ChangingIcon());

      if ((await plugin.getCurrentIcon()) == event.icon.iOSIcon) {
        return emit(ChangedIcon());
      }

      final currentIcon = event.icon.currentIcon;
      try {
        final result = await plugin.changeIcon(currentIcon);

        if (result ?? false) {
          emit(ChangedIcon());
        } else {
          emit(IconError('Unable to change icon'));
        }
      } catch (e) {
        emit(IconError(e.toString()));
      }
    });
  }
}
