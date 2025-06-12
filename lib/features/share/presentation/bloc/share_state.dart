import 'package:flutter/cupertino.dart';

abstract class ShareState {
  const ShareState();
}

class Initial extends ShareState {
  const Initial();
}

class Rendering extends ShareState {
  final double? progress;
  const Rendering(this.progress);
}

class Rendered extends ShareState {
  final VoidCallback proceed;
  const Rendered(this.proceed);
}
