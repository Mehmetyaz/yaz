import 'package:flutter_test/flutter_test.dart';
import 'package:yaz/yaz.dart';

void main() {
  test("content_controller test", () async {
    var watch = Stopwatch();
    var controller = UserController();
    var i = 0;
    while (i < 10) {
      await controller.getContent("1");
      i++;
    }
    expect(controller.getCounts["1"], 1);

    /// 1000 first getter or ~100 other 9
    expect(watch.elapsedMilliseconds < 1100, true);
  });
}

class UserController extends CacheContentController<User> {
  Map<String, int> getCounts = {};

  @override
  Future<User?> contentGetter(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    var i = getCounts[identifier] ?? 0;
    i++;
    getCounts[identifier] = i;
    return User(identifier);
  }

  @override
  int get maxCount => 20;

  @override
  Duration get maxDuration => const Duration(seconds: 20);
}

///
class User with CacheAble {
  ///
  User(this._userID);

  @override
  String get identifier => _userID;

  ///
  final String _userID;
}
