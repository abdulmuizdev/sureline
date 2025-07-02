import 'package:flutter/material.dart';

class TimesWidget extends StatelessWidget {
  final int id;
  final DateTime? lastAccessedAt;
  final Widget child;
  const TimesWidget({
    super.key,
    required this.id,
    this.lastAccessedAt,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
