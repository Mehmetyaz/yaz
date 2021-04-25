import 'dart:collection';

import '../../yaz.dart';

/// Copy of dart:core Map
///
/// But this Map notify any changes
class YazMap<K, V> extends YazNotifier<Map<K, V>> {
  ///
  YazMap(Map<K, V> value) : super(value);

  /// see dart core documentation
  factory YazMap.from(Map other) => YazMap(LinkedHashMap.from(other));

  /// see dart core documentation
  factory YazMap.of(Map<K, V> other) => YazMap(LinkedHashMap<K, V>.of(other));

  /// see dart core documentation
  factory YazMap.identity() => YazMap(LinkedHashMap<K, V>.identity());

  /// see dart core documentation
  factory YazMap.fromIterable(Iterable iterable,
          {K key(dynamic element)?, V value(dynamic element)?}) =>
      YazMap(
          LinkedHashMap<K, V>.fromIterable(iterable, key: key, value: value));

  /// see dart core documentation
  factory YazMap.fromIterables(Iterable<K> keys, Iterable<V> values) =>
      YazMap(LinkedHashMap<K, V>.fromIterables(keys, values));

  /// see dart core documentation
  factory YazMap.fromEntries(Iterable<MapEntry<K, V>> entries) =>
      YazMap(<K, V>{}..addEntries(entries));

  /// see dart core documentation
  V? operator [](Object? key) {
    return value[key];
  }

  /// see dart core documentation
  void operator []=(K key, V val) {
    value[key] = val;
    notifyListeners();
  }

  /// see dart core documentation
  Iterable<MapEntry<K, V>> get entries => value.entries;

  /// see dart core documentation
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    notifyListeners();
  }

  /// see dart core documentation
  V update(K key, V update(V value), {V ifAbsent()?}) {
    var _r = value.update(key, update, ifAbsent: ifAbsent);
    notifyListeners();
    return _r;
  }

  /// see dart core documentation
  void updateAll(V update(K key, V value)) {
    value.updateAll(update);
    notifyListeners();
  }

  /// see dart core documentation
  void removeWhere(bool test(K key, V value)) {
    value.removeWhere(test);
    notifyListeners();
  }

  /// see dart core documentation
  V putIfAbsent(K key, V ifAbsent()) {
    var _r = value.putIfAbsent(key, ifAbsent);
    notifyListeners();
    return _r;
  }

  /// see dart core documentation
  void addAll(Map<K, V> other) {
    value.addAll(other);
    notifyListeners();
  }

  /// see dart core documentation
  V? remove(Object? key) {
    var _r = value.remove(key);
    notifyListeners();
    return _r;
  }

  /// see dart core documentation
  void clear() {
    value.clear();
    notifyListeners();
  }

  /// see dart core documentation
  Iterable<K> get keys => value.keys;

  /// see dart core documentation
  Iterable<V> get values => value.values;

  /// see dart core documentation
  int get length => value.length;

  /// see dart core documentation
  bool get isEmpty => value.isEmpty;

  /// see dart core documentation
  bool get isNotEmpty => value.isNotEmpty;
}
