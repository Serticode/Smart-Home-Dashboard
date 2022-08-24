import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:smart_home_dashboard/models/user_model.dart';

class AppAuthService {
  //! GENERAL USERS BOX
  static Future<Box> openUsersBox() async =>
      await Hive.openBox<Users>("usersBox")
          .whenComplete(() => log("BD usersBox opened!"));

  //! REGISTER METHODS
  static bool registerNewUser(
      {required String fullName,
      required String userName,
      required String email,
      required String password}) {
    //! IS USER REGISTERED
    bool isUserRegistered = false;

    final Users _user = Users()
      ..fullName = fullName
      ..userName = userName
      ..email = email
      ..password = password
      ..userImage = null;

    //! FETCH CURRENT USER DATA BOX
    //! ADD DATA TO IT, USING THE USERS EMAIL AS KEY AND THE GOTTEN DETAILS AS VALUE.
    Box _authBox = Hive.box<Users>("usersBox");
    log("Fetched DB usersBox");

    _authBox.add(_user);
    isUserRegistered = true;

    return isUserRegistered;
  }

  //! SIGN IN METHODS
  static bool signInUser({required String email, required String password}) {
    //! RETURNED BOOL
    bool isUserSignedIn = false;

    //! GET USER DATA BOX
    Box _usersBox = Hive.box<Users>("usersBox");
    log("Sign in user started\nDB usersBox accessed!");

    //! FETCH VALUE OF USERS DETAILS STORED USING KEY EMAIL.
    Iterable<Users> _usersDB = _usersBox.values.cast<Users>();

    isUserSignedIn = _usersDB.any((element) => password == element.password);

    return isUserSignedIn;
  }

  //! CREATE LOGOUT METHODS
  static Future<bool> logOutUser() async {
    bool isLoggedOut = false;

    log("Logging out and closing DB boxes");
    await Hive.close().whenComplete(() => isLoggedOut = true);

    log("DB's Closed!");
    return isLoggedOut;
  }

  //! UPDATE USER DETAILS
  static Future<void> updateUserDetail({required String userEmail}) async {
    //! IS IMAGE UPDATED

    //! OPEN BOX
    Box _usersBox = Hive.box("usersBox");
    log("Fetched DB usersBox");

    //! FETCH VALUE OF USERS DETAILS STORED USING KEY EMAIL.
    Map<dynamic, dynamic> _usersDetails = _usersBox.get(userEmail);
    log("User details gotten. \nDetails: $_usersDetails");

    //! UPDATE SPECIFIC USER PROPERTY

    //! SAVE USER DETAILS BACK
    _usersBox.putAll({userEmail: _usersDetails});

    //! CONFIRM NEW ADDITION
    log("KEYS IN USERS BOX: ${_usersBox.keys}");
    Map<dynamic, dynamic> _user = _usersBox.get(userEmail);
    log(_user.containsKey("userImage").toString());
  }
}
