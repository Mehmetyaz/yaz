import 'dart:async';

import 'package:flutter/material.dart';

import '../../yaz.dart';

/// YazStream convert Stream to ChangeNotifier
/// start listening on construct
class YazStream<T> extends YazNotifier<T> {
  /// Use stream.notifier
  /// or stream.notifierWithDefault()
  @protected
  YazStream(Stream<T> stream, T value) : super(value) {
    _stream = stream.listen(_listen);
  }

  ///
  late StreamSubscription<T> _stream;

  // ignore: use_setters_to_change_properties
  void _listen(T event) {
    value = event;
  }

  ///
  Future<void> cancel() async {
    return _stream.cancel();
  }
}

///
class YazStreamNonNullable<T> extends YazStream<T> {
  ///
  YazStreamNonNullable(Stream<T> stream, T value) : super(stream, value);
}

///
class YazStreamNullable<T> extends YazStream<T?> {
  ///
  YazStreamNullable(Stream<T> stream) : super(stream, null);
}
