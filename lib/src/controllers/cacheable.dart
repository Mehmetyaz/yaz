/// Cacheable content mixin
///
/// Cacheable contents must have a
/// identifier for each getter and setter
///
/// identifier used indexing, contentGetter(from db)
/// local getter
///
///
mixin CacheAble<T> {
  /// Content cache time
  ///
  /// if content cache time greater than
  /// maxCacheDuration
  /// or
  /// maxStorageDuration
  /// controller will remove this content
  ///
  DateTime cacheTime = DateTime.now();

  /// Unique identifier for your content
  /// identifier used every where
  /// please ensure your identifier is unique
  String get identifier;

  /// == operator override for hashmap performance improvement
  /// == use identifier on compare your data
  /// if your identifier is not be unique,
  /// there may be data loss
  @override
  bool operator ==(Object other) {
    return other is CacheAble<T> && identifier == other.identifier;
  }

  /// hashcode override for hashmap performance improvement
  /// if your identifier is not be unique,
  /// there may be data loss
  @override
  int get hashCode => identifier.hashCode;
}
