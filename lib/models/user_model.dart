import 'dart:typed_data';

import "package:hive/hive.dart";
part "user_model.g.dart";

@HiveType(typeId: 0)
class Users extends HiveObject {
  @HiveField(0)
  late String? email;

  @HiveField(1)
  late String? fullName;

  @HiveField(2)
  late String? userName;

  @HiveField(3)
  late String? password;

  @HiveField(4)
  late Uint8List? userImage;

  Users(
      {this.email,
      this.fullName,
      this.userName,
      this.password,
      this.userImage});

  Users.fromMap(Map<dynamic, dynamic> map) {
    email = map["email"];
    fullName = map["fullName"];
    userName = map['userName'];
    password = map["password"];
    userImage = map["userImage"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email': email,
      "fullName": fullName,
      'userName': userName,
      'password': password,
      "userImage": userImage
    };
    return map;
  }
}
