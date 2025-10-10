import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class SurelineOverlay extends StatefulWidget {
  const SurelineOverlay({
    super.key,
    required this.onClose,
    required this.overlay,
    required this.visible,
    this.follower = Alignment.bottomRight,
    this.target = Alignment.topRight,
    this.animateUpwards,
    required this.child,
  });

  final VoidCallback onClose;
  final Widget overlay;
  final bool visible;
  final Widget child;
  final Alignment follower;
  final Alignment target;
  final bool? animateUpwards;

  @override
  State<SurelineOverlay> createState() => _SurelineOverlayState();
}

class _SurelineOverlayState extends State<SurelineOverlay>
    with SingleTickerProviderStateMixin {
  late bool _shouldShow;
  late AnimationController _controller;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _shouldShow = widget.visible;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Cubic(0.4, 0.0, 0.2, 1.2),
    );

    if (_shouldShow) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant SurelineOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !_shouldShow) {
      setState(() => _shouldShow = true);
      _controller.forward();
    } else if (!widget.visible && _shouldShow) {
      _controller.reverse().then((_) {
        if (context.mounted) {
          setState(() => _shouldShow = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.visible ? widget.onClose : null,
      child: PortalTarget(
        visible: _shouldShow,
        portalFollower: FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            alignment: Alignment(
              0.7,
              (widget.animateUpwards ?? false) ? -1 : 1,
            ),
            scale: _animation,
            child: widget.overlay,
          ),
        ),
        anchor: Aligned(
          follower: widget.follower,
          target: widget.target,
          backup: Aligned(
            follower: widget.follower,
            target: widget.target,
            widthFactor: 1,
          ),
        ),
        child: IgnorePointer(ignoring: _shouldShow, child: widget.child),
      ),
    );
  }
}
