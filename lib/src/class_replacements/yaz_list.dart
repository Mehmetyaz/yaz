import 'dart:math';

import '../../yaz.dart';

/// Copy of dart:core List
///
/// But this list notify any changes
class YazList<E> extends YazNotifier<List<E>> {
  ///
  YazList(List<E> list) : super(list);

  /// see dart:core documentation
  factory YazList.filled(int length, E fill, {bool growable = false}) {
    return YazList(List.filled(length, fill, growable: growable));
  }

  /// see dart:core documentation
  factory YazList.empty({bool growable = false}) =>
      YazList(List.empty(growable: growable));

  /// see dart:core documentation
  factory YazList.from(Iterable elements, {bool growable = true}) =>
      YazList(List.from(elements, growable: growable));

  /// see dart:core documentation
  factory YazList.of(Iterable<E> elements, {bool growable = true}) {
    return YazList(List.of(elements, growable: growable));
  }

  /// see dart:core documentation
  factory YazList.generate(int length, E generator(int index),
      {bool growable = true}) {
    return YazList(List.generate(length, generator, growable: growable));
  }

  /// see dart:core documentation
  factory YazList.unmodifiable(Iterable elements) {
    return YazList(List.unmodifiable(elements));
  }

  /// see dart:core documentation
  List<T> map<T>(T f(E e)) => value.map(f).toList();

  /// see dart:core documentation
  E operator [](int index) {
    return value[index];
  }

  /// see dart:core documentation
  void operator []=(int index, E val) {
    value[index] = val;
    notifyListeners();
    return;
  }

  /// see dart:core documentation
  bool get isNotEmpty => value.isNotEmpty;

  /// see dart:core documentation
  bool get isEmpty => value.isEmpty;

  /// see dart:core documentation
  E get first {
    return value.first;
  }

  /// see dart:core documentation
  E get last {
    return value.last;
  }

  /// see dart:core documentation
  set first(E val) {
    value.first = val;
    notifyListeners();
  }

  /// see dart:core documentation
  set last(E val) {
    value.last = val;
    notifyListeners();
  }

  /// see dart:core documentation
  int get length => value.length;

  /// see dart:core documentation
  set length(int newLength) {
    value.length = newLength;
    notifyListeners();
  }

  /// see dart:core documentation
  void add(E val) {
    value.add(val);
    notifyListeners();
  }

  /// see dart:core documentation
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    notifyListeners();
  }

  /// see dart:core documentation
  void shuffle([Random? random]) {
    value.shuffle(random);
    notifyListeners();
  }

  /// see dart:core documentation
  void clear() {
    value.clear();
    notifyListeners();
  }

  /// see dart:core documentation
  void insert(int index, E element) {
    value.insert(index, element);
    notifyListeners();
  }

  /// see dart:core documentation
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    notifyListeners();
  }

  /// see dart:core documentation
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    notifyListeners();
  }

  /// see dart:core documentation
  bool remove(Object? val) {
    var _r = value.remove(val);
    notifyListeners();
    return _r;
  }

  /// see dart:core documentation
  E removeAt(int index) {
    var _r = value.removeAt(index);
    notifyListeners();
    return _r;
  }

  /// see dart:core documentation
  E removeLast() {
    var _r = value.removeLast();
    notifyListeners();
    return _r;
  }

  /// see dart:core documentation
  void removeWhere(bool test(E element)) {
    value.removeWhere(test);
    notifyListeners();
  }

  /// see dart:core documentation
  void retainWhere(bool test(E element)) {
    value.retainWhere(test);
    notifyListeners();
  }

  /// see dart:core documentation
  List<E> operator +(List<E> other) {
    var _r = value + other;
    notifyListeners();
    return _r;
  }

  /// see dart:core documentation
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    notifyListeners();
  }

  /// see dart:core documentation
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    notifyListeners();
  }

  /// see dart:core documentation
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    notifyListeners();
  }

  /// see dart:core documentation
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    notifyListeners();
  }
}
