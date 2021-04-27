import 'package:flutter/material.dart';

import '../controllers/user_options.dart';
import 'yaz_listener_widget.dart';

/// Trigger for on user option change
/// when options change, wrapped widgets rebuilt
typedef OptionWidgetBuilder = Widget Function(
    BuildContext context, UserOption option);

/// Option wrapper is wrap [builder] returned widgets
/// for your option.
///
/// When option change, rebuilt widgets
class OptionWrapper<T> extends StatelessWidget {
  ///
  const OptionWrapper(
      {Key? key, required this.builder, required this.userOption})
      : super(key: key);

  /// Widget builder for triggered option changes
  final OptionWidgetBuilder builder;

  /// Option that your want
  final UserOption<T> userOption;

  @override
  Widget build(BuildContext context) {
    return YazListenerWidget(
        changeNotifier: userOption,
        builder: (c) {
          return builder(c, userOption);
        });
  }
}
