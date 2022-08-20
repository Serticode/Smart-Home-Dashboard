import 'package:smart_home_dashboard/models/device_model.dart';

class Users {
  int? _userId;
  String? email;
  String? _username;
  String? _password;
  List<DeviceModel>? allUserDevices;

  Users(this._userId, this.email, this._username, this._password,
      this.allUserDevices);

  Users.fromMap(Map<String, dynamic> map) {
    _userId = map['id'];
    email = map["email"];
    _username = map['username'];
    _password = map["password"];
    allUserDevices = map["allDevices"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _userId,
      'email': email,
      'username': _username,
      'password': _password,
      'allDevices': allUserDevices,
    };
    return map;
  }
}
