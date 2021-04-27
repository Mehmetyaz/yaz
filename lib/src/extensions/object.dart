import '../../yaz.dart';

///
extension YazNotifierExtensions<T> on T {
  /// Convert your variable to change notifier
  /// You can get value [.value]
  YazNotifier<T> get notifier {
    return YazNotifier<T>(this);
  }
}
