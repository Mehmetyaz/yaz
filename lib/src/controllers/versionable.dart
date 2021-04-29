import '../../yaz.dart';

///
mixin Versioned on CacheAble {
  ///
  int get version;

  @override
  bool operator ==(Object other) {
    return other is Versioned && super == other && version == other.version;
  }

  @override
  int get hashCode => super.hashCode + version;
}
