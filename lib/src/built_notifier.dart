import 'package:flutter/material.dart';

import '../yaz.dart';

/// Built Notifier paint your widget after built
class BuiltNotifier extends StatelessWidget {
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

  ///
  final built = true.notifier;

  @override
  Widget build(BuildContext context) {
    ///
    return YazListenerWidget(
        changeNotifier: built,
        builder: (c) {
          Future.delayed(const Duration(milliseconds: 50)).then((value) {
            built.value = false;
          });
          return AnimatedContainer(
            duration: duration,
            child: child,
            color: built.value ? color : Colors.transparent,
          );
        });
  }
}
