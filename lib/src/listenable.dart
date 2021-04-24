import 'package:flutter/cupertino.dart';

import '../yaz.dart';

///
extension ListenableObj<T> on T {
  /// Convert your variable to change notifier
  /// You can get value [.value]
  YazNotifier<T> get notifier {
    return YazNotifier<T>(this);
  }
}

///
extension MultipleNotifier on ChangeNotifier {
  /// Listen any changes this and [notifiers] any changes
  ChangeNotifier combineWith(List<ChangeNotifier> notifiers) {
    return MultipleChangeNotifier(notifiers..add(this));
  }
}

///
class YazNotifier<T> extends ChangeNotifier {
  ///
  YazNotifier(this._value);

  /// Listen any changes this and [notifiers] any changes
  ChangeNotifier combineWith(List<ChangeNotifier> notifiers) {
    return MultipleChangeNotifier(notifiers..add(this));
  }

  T _value;

  /// Your value.
  /// If you use as a setter notify listeners
  T get value => _value;

  /// Your value.
  /// If you use as a setter notify listeners
  set value(T value) {
    if (value == _value) return;
    _value = value;
    notifyListeners();
  }

  @override
  String toString() => "YazListener($value)";
}
