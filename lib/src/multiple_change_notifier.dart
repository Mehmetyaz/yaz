import 'package:flutter/material.dart';

/// Notify listeners any changes in your change notifiers list
class MultipleChangeNotifier extends ChangeNotifier {

  /// Notify listeners any changes in your change notifiers list
  MultipleChangeNotifier(this.changeNotifiers);

  /// Listened change notifiers
  final List<ChangeNotifier> changeNotifiers;

  void _combine(VoidCallback listener) {
    for (var o in changeNotifiers) {
      o.addListener(listener);
    }
  }

  void _remove(VoidCallback listener) {
    for (var o in changeNotifiers) {
      o.removeListener(listener);
    }
  }

  @override
  void addListener(VoidCallback listener) {
    _combine(listener);
    super.addListener(_dummy);
  }

  @override
  void removeListener(VoidCallback listener) {
    _remove(listener);
    super.removeListener(_dummy);
  }

  void _dummy() {}
}
