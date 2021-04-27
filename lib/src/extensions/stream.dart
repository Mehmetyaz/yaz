import '../class_replacements/stream.dart';

/// help to convert stream to change notifier
extension StreamNotifier<T> on Stream<T> {
  /// Notify changes on `onData`
  /// Please don't forget close
  /// listen started after construct
  YazStream<T?> get yazStream {
    return YazStreamNullable<T>(this);
  }

  /// Notify changes on `onData`
  /// Please don't forget close
  /// listen started after construct
  YazStream<T> yazStreamWithDefault(T defaultValue) {
    return YazStreamNonNullable<T>(this, defaultValue);
  }
}
