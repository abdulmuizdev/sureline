import 'package:flutter/cupertino.dart';

class RenderEntity {
  final String quote;
  final String path;
  final bool isLiveBackground;
  final GlobalKey quoteKey;
  final GlobalKey rootKey;

  const RenderEntity({
    required this.quote,
    required this.path,
    required this.isLiveBackground,
    required this.quoteKey,
    required this.rootKey,
  });
}
