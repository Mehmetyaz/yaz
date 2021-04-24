import 'dart:math';

import '../../../yaz.dart';

/// Copy of dart:core List
///
/// But this list notify any changes
class YazList<E> extends YazNotifier<List<E>> {
  ///
  YazList(List<E> list) : super(list);

  /// Creates a list of the given length with [fill] at each position.
  ///
  /// The [length] must be a non-negative integer.
  ///
  /// Example:
  /// ```dart
  /// List<int>.filled(3, 0, growable: true); // [0, 0, 0]
  /// ```
  ///
  /// The created list is fixed-length if [growable] is false (the default)
  /// and growable if [growable] is true.
  /// If the list is growable, increasing its [length] will *not* initialize
  /// new entries with [fill].
  /// After being created and filled, the list is no different from any other
  /// growable or fixed-length list created
  /// using `[]` or other [List] constructors.
  ///
  /// All elements of the created list share the same [fill] value.
  /// ```dart
  /// var shared = List.filled(3, []);
  /// shared[0].add(499);
  /// print(shared);  // => [[499], [499], [499]]
  /// ```
  /// You can use [List.generate] to create a list with a fixed length
  /// and a new object at each position.
  /// ```dart
  /// var unique = List.generate(3, (_) => []);
  /// unique[0].add(499);
  /// print(unique); // => [[499], [], []]
  /// ```
  factory YazList.filled(int length, E fill,
      {bool growable = false}) {
    return YazList(List.filled(length, fill, growable: growable));
  }

  /// Creates a new empty list.
  ///
  /// If [growable] is `false`, which is the default,
  /// the list is a fixed-length list of length zero.
  /// If [growable] is `true`, the list is growable and equivalent to `<E>[]`.
  factory YazList.empty({bool growable = false}) =>
      YazList(List.empty(growable: growable));

  /// Creates a list containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// All the [elements] should be instances of [E].
  /// The `elements` iterable itself may have any element type, so this
  /// constructor can be used to down-cast a `List`, for example as:
  /// ```dart
  /// List<dynamic> dynList = ...some JSON value...;
  /// List<Map<String, dynamic>> fooList =
  ///     List.from(dynList.where((x) => x is Map && map["kind"] == "foo"));
  /// ```
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  factory YazList.from(Iterable elements, {bool growable = true}) =>
      YazList(List.from(elements, growable: growable));

  /// Creates a list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  factory YazList.of(Iterable<E> elements, {bool growable = true}) {
    return YazList(List.of(elements, growable: growable));
  }

  /// Generates a list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  /// ```dart
  /// List<int>.generate(3, (int index) => index * index); // [0, 1, 4]
  /// ```
  /// The created list is fixed-length if [growable] is set to false.
  ///
  /// The [length] must be non-negative.
  factory YazList.generate(int length, E generator(int index),
      {bool growable = true}) {
    return YazList(
        List.generate(length, generator, growable: growable));
  }

  /// Creates an unmodifiable list containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// An unmodifiable list cannot have its length or elements changed.
  /// If the elements are themselves immutable, then the resulting list
  /// is also immutable.
  factory YazList.unmodifiable(Iterable elements) {
    return YazList(List.unmodifiable(elements));
  }

  ///
  E operator [](int index) {
    return value[index];
  }

  ///
  void operator []=(int index, E val) {
    value[index] = val;
    notifyListeners();
    return;
  }

  ///
  bool get isNotEmpty => value.isNotEmpty;

  ///
  bool get isEmpty => value.isEmpty;

  ///
  E get first {
    return value.first;
  }

  ///
  E get last {
    return value.last;
  }

  /// Updates the first position of the list to contain [value].
  ///
  /// Equivalent to `theList[0] = value;`.
  ///
  /// The list must be non-empty.
  set first(E val) {
    value.first = val;
    notifyListeners();
  }

  /// Updates the last position of the list to contain [value].
  ///
  /// Equivalent to `theList[theList.length - 1] = value;`.
  ///
  /// The list must be non-empty.
  set last(E val) {
    value.last = val;
    notifyListeners();
  }

  /// The number of objects in this list.
  ///
  /// The valid indices for a list are `0` through `length - 1`.
  int get length => value.length;

  /// Changes the length of this list.
  ///
  /// The list must be growable.
  /// If [newLength] is greater than current length,
  /// new entries are initialized to `null`,
  /// so [newLength] must not be greater than the current length
  /// if the element type [E] is non-nullable.
  set length(int newLength) {
    value.length = newLength;
    notifyListeners();
  }

  /// Adds [value] to the end of this list,
  /// extending the length by one.
  ///
  /// The list must be growable.
  void add(E val) {
    value.add(val);
    notifyListeners();
  }

  /// Appends all objects of [iterable] to the end of this list.
  ///
  /// Extends the length of the list by the number of objects in [iterable].
  /// The list must be growable.
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    notifyListeners();
  }

  /// Shuffles the elements of this list randomly.
  void shuffle([Random? random]) {
    value.shuffle(random);
    notifyListeners();
  }

  /// Removes all objects from this list; the length of the list becomes zero.
  ///
  /// The list must be growable.
  void clear() {
    value.clear();
    notifyListeners();
  }

  /// Inserts [element] at position [index] in this list.
  ///
  /// This increases the length of the list by one and shifts all objects
  /// at or after the index towards the end of the list.
  ///
  /// The list must be growable.
  /// The [index] value must be non-negative and no greater than [length].
  void insert(int index, E element) {
    value.insert(index, element);
    notifyListeners();
  }

  /// Inserts all objects of [iterable] at position [index] in this list.
  ///
  /// This increases the length of the list by the length of [iterable] and
  /// shifts all later objects towards the end of the list.
  ///
  /// The list must be growable.
  /// The [index] value must be non-negative and no greater than [length].
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    notifyListeners();
  }

  /// Overwrites elements with the objects of [iterable].
  ///
  /// The elements of [iterable] are written into this list,
  /// starting at position [index].
  /// ```dart
  /// var list = ['a', 'b', 'c', 'd'];
  /// list.setAll(1, ['bee', 'sea']);
  /// list.join(', '); // 'a, bee, sea, d'
  /// ```
  /// This operation does not increase the length of the list.
  ///
  /// The [index] must be non-negative and no greater than [length].
  ///
  /// The [iterable] must not have more elements than what can fit from [index]
  /// to [length].
  ///
  /// If `iterable` is based on this list, its values may change _during_ the
  /// `setAll` operation.
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    notifyListeners();
  }

  /// Removes the first occurrence of [value] from this list.
  ///
  /// Returns true if [value] was in the list, false otherwise.
  /// ```dart
  /// var parts = ['head', 'shoulders', 'knees', 'toes'];
  /// parts.remove('head'); // true
  /// parts.join(', ');     // 'shoulders, knees, toes'
  /// ```
  /// The method has no effect if [value] was not in the list.
  /// ```dart
  /// // Note: 'head' has already been removed.
  /// parts.remove('head'); // false
  /// parts.join(', ');     // 'shoulders, knees, toes'
  /// ```
  ///
  /// The list must be growable.
  bool remove(Object? val) {
    var _r = value.remove(val);
    notifyListeners();
    return _r;
  }

  /// Removes the object at position [index] from this list.
  ///
  // ignore_for_file: lines_longer_than_80_chars
  /// This method reduces the length of `this` by one and moves all later objects
  /// down by one position.
  ///
  /// Returns the removed value.
  ///
  /// The [index] must be in the range `0 ≤ index < length`.
  ///
  /// The list must be growable.
  E removeAt(int index) {
    var _r = value.removeAt(index);
    notifyListeners();
    return _r;
  }

  /// Removes and returns the last object in this list.
  ///
  /// The list must be growable and non-empty.
  E removeLast() {
    var _r = value.removeLast();
    notifyListeners();
    return _r;
  }

  /// Removes all objects from this list that satisfy [test].
  ///
  /// An object `o` satisfies [test] if `test(o)` is true.
  /// ```dart
  /// var numbers = ['one', 'two', 'three', 'four'];
  /// numbers.removeWhere((item) => item.length == 3);
  /// numbers.join(', '); // 'three, four'
  /// ```
  /// The list must be growable.
  void removeWhere(bool test(E element)) {
    value.removeWhere(test);
    notifyListeners();
  }

  /// Removes all objects from this list that fail to satisfy [test].
  ///
  /// An object `o` satisfies [test] if `test(o)` is true.
  /// ```dart
  /// var numbers = ['one', 'two', 'three', 'four'];
  /// numbers.retainWhere((item) => item.length == 3);
  /// numbers.join(', '); // 'one, two'
  /// ```
  /// The list must be growable.
  void retainWhere(bool test(E element)) {
    value.retainWhere(test);
    notifyListeners();
  }

  /// Returns the concatenation of this list and [other].
  ///
  /// Returns a new list containing the elements of this list followed by
  /// the elements of [other].
  ///
  /// The default behavior is to return a normal growable list.
  /// Some list types may choose to return a list of the same type as themselves
  // ignore: comment_references
  /// (see [Uint8List.+]);
  List<E> operator +(List<E> other) {
    var _r = value + other;
    notifyListeners();
    return _r;
  }

  /// Writes some elements of [iterable] into a range of this list.
  ///
  /// Copies the objects of [iterable], skipping [skipCount] objects first,
  /// into the range from [start], inclusive, to [end], exclusive, of this list.
  /// ```dart
  /// var list1 = [1, 2, 3, 4];
  /// var list2 = [5, 6, 7, 8, 9];
  /// // Copies the 4th and 5th items in list2 as the 2nd and 3rd items
  /// // of list1.
  /// list1.setRange(1, 3, list2, 3);
  /// list1.join(', '); // '1, 8, 9, 4'
  /// ```
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The [iterable] must have enough objects to fill the range from `start`
  /// to `end` after skipping [skipCount] objects.
  ///
  /// If `iterable` is this list, the operation correctly copies the elements
  /// originally in the range from `skipCount` to `skipCount + (end - start)` to
  /// the range `start` to `end`, even if the two ranges overlap.
  ///
  /// If `iterable` depends on this list in some other way, no guarantees are
  /// made.
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    notifyListeners();
  }

  /// Removes a range of elements from the list.
  ///
  /// Removes the elements with positions greater than or equal to [start]
  /// and less than [end], from the list.
  /// This reduces the list's length by `end - start`.
  ///
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The list must be growable.
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    notifyListeners();
  }

  /// Overwrites a range of elements with [fillValue].
  ///
  /// Sets the positions greater than or equal to [start] and less than [end],
  /// to [fillValue].
  ///
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// Example:
  /// ```dart
  /// var list = List.filled(5, -1);
  /// print(list); //  [-1, -1, -1, -1, -1]
  /// list.fillRange(1, 3, 4);
  /// print(list); //  [-1, 4, 4, -1, -1]
  /// ```
  ///
  /// If the element type is not nullable, the [fillValue] must be provided and
  /// must be non-`null`.
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    notifyListeners();
  }

  /// Replaces a range of elements with the elements of [replacements].
  ///
  /// Removes the objects in the range from [start] to [end],
  /// then inserts the elements of [replacements] at [start].
  /// ```dart
  /// var list = [1, 2, 3, 4, 5];
  /// list.replaceRange(1, 4, [6, 7]);
  /// list.join(', '); // '1, 6, 7, 5'
  /// ```
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The operation `list.replaceRange(start, end, replacements)`
  /// is roughly equivalent to:
  /// ```dart
  /// list.removeRange(start, end);
  /// list.insertAll(start, replacements);
  /// ```
  /// but may be more efficient.
  ///
  /// The list must be growable.
  /// This method does not work on fixed-length lists, even when [replacements]
  /// has the same number of elements as the replaced range. In that case use
  /// [setRange] instead.
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    notifyListeners();
  }
}
