import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/cacheable.dart';
import 'controllers/versionable.dart';

abstract class _ContentController<T extends CacheAble> {
  final HashMap<String, T> _contents = HashMap.from({});

  /// Your stored/cached contents
  Map<String, T> get contents => _contents;

  /// sorted asc by cache dates index of cache dates
  final Map<String, int> _cacheDates = {};

  /// Maximum storage/cache duration
  ///
  /// If any content is older than difference now,
  /// this content removed
  Duration get maxDuration;

  /// Maximum storage/cache count
  ///
  /// If content count greater than max, will remove oldest content
  int get maxCount;

  /// Content getter from your source (database)
  ///
  /// If return non-null , content save storage or cache
  Future<T?> contentGetter(String identifier);

  /// Save content in storage/cache
  ///
  /// #### WARN !! You don't need most cases.
  ///
  /// Only if you have data unordered you can use this
  ///
  ///
  /// Many Times you should use [getContent]
  ///
  /// [getContent] will get from and save if necessary
  @mustCallSuper
  Future<void> save(T content) async {
    if (_cacheDates.containsKey(content.identifier)) {
      _cacheDates.remove(content.identifier);
    }

    _contents[content.identifier] = content;
    _cacheDates[content.identifier] = content.cacheTime.millisecondsSinceEpoch;
    return _checkNeedsRemove();
  }

  /// Remove content from storage/cache
  @mustCallSuper
  Future<void> remove(String identifier) async {
    _contents.remove(identifier);
    _cacheDates.remove(identifier);
    return;
  }

  ///
  final Map<String, Future<T?>> _isUpdating = {};

  /// Update content from your source
  @mustCallSuper
  Future<void> update(String identifier, {bool checkAfterUpdate = true}) async {
    if (_isUpdating[identifier] == null) {
      _isUpdating[identifier] = contentGetter(identifier);
    }
    var content = await _isUpdating[identifier]!;
    if (content != null) {
      if (_cacheDates.containsKey(identifier)) {
        _cacheDates.remove(identifier);
      }

      _contents[identifier] = content;
      _cacheDates[identifier] = content.cacheTime.millisecondsSinceEpoch;
    }
    if (checkAfterUpdate) {
      await _checkNeedsRemove();
    }
    //ignore: unawaited_futures
    _isUpdating.remove(identifier);
    return;
  }

  /// Is content exists
  bool isThere(String identifier) {
    return _contents.containsKey(identifier);
  }

  /// Get content by identifier
  ///
  /// If content exists and newly your duration,
  /// return content from cache/storage
  ///
  /// If not, content will get before
  ///
  /// If you will call same time and same identifier,
  /// feel free.
  ///
  /// Because contentGetter only use once. Your other invokes wait first getter
  Future<T?> getContent(String identifier) async {
    if (isThere(identifier)) {
      var content = _contents[identifier];

      if (content != null) {
        if (content.cacheTime.difference(DateTime.now()).abs().inMilliseconds >
            maxDuration.inMilliseconds) {
          await update(identifier, checkAfterUpdate: false);
        }
      } else {
        await update(identifier, checkAfterUpdate: false);
      }
    } else {
      await update(identifier, checkAfterUpdate: false);
    }
    await _checkNeedsRemove();
    return _contents[identifier];
  }

  Future<void> _checkNeedsRemove() async {
    var needDeleteTime =
        DateTime.now().subtract(maxDuration).millisecondsSinceEpoch;
    var list = _cacheDates.entries.toList();
    for (var contentDate in list) {
      if (contentDate.value > needDeleteTime) break;
      await remove(contentDate.key);
    }

    if (_contents.length > maxCount) {
      var _l = _cacheDates.keys.toList();
      var i = 0;
      // ignore: invariant_booleans
      while (_contents.length > maxCount) {
        await remove(_l[i]);
        i++;
      }
    }
    return;
  }
}

/// Your contents only save session cache
abstract class CacheContentController<T extends CacheAble>
    extends _ContentController<T> {
  ///
}

/// Storable Content Controller
///
/// This controller get and store your json encodable/decodable
/// contents on device key-value storage
///
/// shared_preferences package used for storage
///
/// usage :
///
/// Example usage for your users own entries in forum app
/// [Link](http://github.com)
///
abstract class StorageContentController<T extends CacheAble>
    extends _ContentController<T> {
  /// Is initialize
  bool get isInit => _preferences != null;

  /// Used for shared_preferences key
  String get saveKey;

  ///
  String get _key => "${saveKey}_yaz_contents";

  ///
  SharedPreferences? _preferences;

  /// Must implement fromJson
  ///
  /// Because StorageContentController use json encodable objects.
  ///
  /// fromJson must return non-nullable object that you want to storage
  T fromJson(Map<String, dynamic> map);

  /// Must implement fromJson
  ///
  /// Because StorageContentController use json encodable objects.
  Map<String, dynamic> toJson(T instance);

  @override
  Future<void> save(T content) async {
    if (!isInit) throw Exception("Before must init");
    await super.save(content);
    return _setApplicationStorage();
  }

  @override
  Future<void> remove(String identifier) async {
    if (!isInit) throw Exception("Before must init");
    await super.remove(identifier);
    return _setApplicationStorage();
  }

  @override
  Future<void> update(String identifier, {bool checkAfterUpdate = true}) async {
    if (!isInit) throw Exception("Before must init");
    await super.update(identifier, checkAfterUpdate: checkAfterUpdate);
    return _setApplicationStorage();
  }

  ///
  Future<void> init({bool clearAndReInit = false}) async {
    if (!clearAndReInit && isInit) return;
    _preferences = await SharedPreferences.getInstance();
    _contents.clear();
    _cacheDates.clear();
    await _getApplicationStorage();
  }

  Future<void> _setApplicationStorage() async {
    if (!isInit) throw Exception("Before must init");
    await _preferences!.setStringList(_key,
        _contents.values.map<String>((e) => json.encode(toJson(e))).toList());
  }

  Future<void> _getApplicationStorage() async {
    var contentStrings = (_preferences!.getStringList(_key) ?? <String>[]);
    var keys = <String>[];
    for (var contentString in contentStrings) {
      var content = fromJson(json.decode(contentString));
      keys.add(content.identifier);
      _contents[content.identifier] = content;
    }

    keys.sort(
        (a, b) => _contents[a]!.cacheTime.compareTo(_contents[b]!.cacheTime));

    for (var c in keys) {
      _cacheDates[c] = _contents[c]!.cacheTime.millisecondsSinceEpoch;
    }
    return;
  }
}

///
abstract class VersionedContentController<T extends Versioned>
    extends StorageContentController<T> {
  /// Content Versions
  Map<String, int> versions = {};

  @override
  int get maxCount => 10000;

  @override
  Duration get maxDuration => const Duration(days: 365);

  @override
  bool get isInit => super.isInit;

  @override
  Future<void> init(
      {bool storeAllDocuments = false, bool clearAndReInit = false}) async {
    var localFtr = super.init(clearAndReInit: clearAndReInit);
    versions = await versionGetter();
    await localFtr;
    await checkAndUpdate(updateVersions: false);
    return;
  }

  /// Check and compare contents versions and update if necessary
  Future<void> checkAndUpdate({bool updateVersions = true}) async {
    if (updateVersions) {
      versions = await versionGetter();
    }
    var ftrs = <Future<void>>[];
    for (var con in versions.entries) {
      if (con.value != contents[con.key]?.version) {
        ftrs.add(update(con.key));
      }
    }
    await Future.wait(ftrs);
    return;
  }

  ///
  Future<Map<String, int>> versionGetter();
}
