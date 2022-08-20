class NewUser {
   int? _newUserId;
   String? _email;
   String? _username;
   String? _password;

  NewUser(
      this._newUserId,
      this._email,
      this._username,
      this._password,
      );

  NewUser.fromMap(Map<String, dynamic> map) {
    _newUserId = map['id'];
    _email = map["email"];
    _username = map['username'];
    _password = map["password"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _newUserId,
      'email': _email,
      'username': _username,
      'password': _password,
    };
    return map;
  }
}


