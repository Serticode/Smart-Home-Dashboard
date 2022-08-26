import 'dart:typed_data';
import "package:hive/hive.dart";
part "user_model.g.dart";

@HiveType(typeId: 0)
class User extends HiveObject {
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

  User(
      {this.email,
      this.fullName,
      this.userName,
      this.password,
      this.userImage});
}
