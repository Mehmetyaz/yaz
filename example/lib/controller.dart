import 'package:yaz/yaz.dart';

import 'user.dart';


///
class UserController extends StorageContentController<User> {
  ///
  factory UserController() => _internal;

  ///
  UserController.internal();

  static final UserController _internal = UserController.internal();

  @override
  Future<User?> contentGetter(String identifier) async {
    // ignore: avoid_print
    print("$identifier Content get from db : $identifier");
    await Future.delayed(const Duration(milliseconds: 300));
    return User(identifier, "User Of $identifier");
  }

  @override
  User fromJson(Map<String, dynamic> map) {
    return User.fromJson(map);
  }

  @override
  int get maxCount => 30;

  @override
  Duration get maxDuration => const Duration(minutes: 30);

  @override
  String get saveKey => "users";

  @override
  Map<String, dynamic> toJson(User instance) {
    return instance.toJson();
  }
}
