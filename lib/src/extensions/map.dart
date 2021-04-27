import 'package:flutter/material.dart';

import '../../yaz.dart';

///
extension MultipleListenerOnMap<K extends Object, V extends ChangeNotifier>
    on Map<K, V> {
  ///
  MultipleChangeNotifier get notifyAll {
    return MultipleChangeNotifier(values);
  }
}

///
extension ListenableMap<K, V> on Map<K, V> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  Map<K, YazNotifier<V>> get listeners {
    return map((key, value) => MapEntry(key, value.notifier));
  }

  /// Listen all changes and notify all changes
  YazMap<K, V> get listenAll {
    return YazMap(this);
  }
}
