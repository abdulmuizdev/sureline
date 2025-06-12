import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';

class IconEntity extends AppIcon {
  final String previewPath;
  IconEntity({
    required this.previewPath,
    required super.iOSIcon,
    required super.androidIcon,
    required super.isDefaultIcon,
  });
}
