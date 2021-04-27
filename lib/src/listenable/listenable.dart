import 'package:flutter/cupertino.dart';

import '../../yaz.dart';

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
