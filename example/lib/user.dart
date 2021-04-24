import 'package:yaz/yaz.dart';

///
class User with CacheAble<User> {
  ///
  User(this.userId, this.userName);

  /// We must have fromJson contructor
  /// for UserController class
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json["user_id"], json["user_name"]);
  }

  /// We must have [toJson] function
  /// for UserController class
  Map<String, dynamic> toJson() {
    return {"user_id": userId, "user_name": userName};
  }

  @override
  String get identifier => userId;

  ///
  String userId;

  ///
  String userName;
}
