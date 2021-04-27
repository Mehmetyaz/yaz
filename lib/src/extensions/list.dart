import 'package:flutter/material.dart';

import '../../yaz.dart';

///
extension MultipleListenerOnList<T extends ChangeNotifier> on List<T> {
  ///
  MultipleChangeNotifier get notifyAll {
    return MultipleChangeNotifier(this);
  }
}

///
extension ListenableList<T> on List<T> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  List<YazNotifier<T>> get listeners {
    return map<YazNotifier<T>>((e) => e.notifier).toList();
  }

  /// Listen all changes and notify all changes
  YazList<T> get listenAll {
    return YazList<T>(this);
  }
}
