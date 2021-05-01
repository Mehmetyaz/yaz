import 'package:flutter/material.dart';

/// Built Notifier paint your widget after built
class BuiltNotifier extends StatefulWidget {
  /// It reaches from specified color to
  /// transparent color in the specified time.
  BuiltNotifier(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 250),
      this.color = Colors.red})
      : super(key: key);

  /// Your widget
  final Widget child;

  /// Built color
  final Color color;

  /// To transparent duration
  final Duration duration;

  @override
  _BuiltNotifierState createState() => _BuiltNotifierState();
}

class _BuiltNotifierState extends State<BuiltNotifier>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = _controller
        .drive(ColorTween(begin: widget.color, end: Colors.transparent));
    super.initState();
  }

  Future<void> _start() async {
    _controller.reset();
    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _start();
    return AnimatedBuilder(
      animation: _animation,
      builder: (c, b) {
        return Container(
          color: _animation.value ?? Colors.white,
          child: b,
        );
      },
      child: widget.child,
    );
  }
}
