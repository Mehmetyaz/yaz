import 'package:flutter/material.dart';

import '../../yaz.dart';

///
extension YazNotifierExtension on ChangeNotifier {
  /// Listen any changes this and [notifiers] any changes
  ChangeNotifier combineWith(List<ChangeNotifier> notifiers) {
    return MultipleChangeNotifier(notifiers..add(this));
  }

  /// Create Yaz Listener Widget that listen your change notifier
  Widget builder(WidgetBuilder builder) {
    return YazListenerWidget(
      changeNotifier: this,
      builder: builder,
    );
  }
}
