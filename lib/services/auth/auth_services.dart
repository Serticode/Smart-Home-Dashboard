import 'dart:developer';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/models/user_model.dart';

class AppAuthService {
  //! LOGGED IN USER
  static late User loggedInUser;

  //! GENERAL USER BOX
  static Future<Box> openDBBoxes() async =>
      await Hive.openBox<User>("usersBox").whenComplete(() async => {
            log("BD usersBox opened!"),
            await Hive.openBox<Device>("Living room")
                .whenComplete(() => log("box open! Living room")),
            await Hive.openBox<Device>("Kitchen")
                .whenComplete(() => log("box open! Kitchen")),
            await Hive.openBox<Device>("Dining")
                .whenComplete(() => log("box open! Dining")),
            await Hive.openBox<Device>("Lounge")
                .whenComplete(() => log("box open! Lounge")),
            await Hive.openBox<Device>("Bedroom")
                .whenComplete(() => log("box open! Bedroom"))
          });

  //! REGISTER METHODS
  static bool registerNewUser(
      {required String fullName,
      required String userName,
      required String email,
      required String password}) {
    //! IS USER REGISTERED
    bool isUserRegistered = false;

    //! FETCH USER DATA BOX
    Box _authBox = Hive.box<User>("usersBox");

    //! ASSIGN VALUES
    final User _user = User()
      ..fullName = fullName
      ..userName = userName
      ..email = email
      ..password = password
      ..userImage = null;

    //! UPDATE LOGGED IN USER FOR USE THROUGH OUT APP.
    loggedInUser = _user;

    //! ADD USER TO DB.
    _authBox.add(_user);

    //! UPDATE VALUES.
    isUserRegistered = true;

    return isUserRegistered;
  }

  //! SIGN IN METHODS
  static bool signInUser({required String email, required String password}) {
    //! RETURNED BOOL
    bool isUserSignedIn = false;

    //! GET USER DATA BOX
    Box _authBox = Hive.box<User>("usersBox");

    //! FETCH VALUE OF USER DETAILS STORED USING KEY EMAIL.
    Iterable<User> _userDB = _authBox.values.cast<User>();

    //! FIND A USER IN THE DB WHOSE PASSWORD MATCHES THE ONE PASSED.
    //! PASSWORDS ARE UNIQUE, EVEN IF EMAILS OR USER NAMES ARE EQUAL, PASSWORDS ARE MOST LIKELY DIFFERENT
    loggedInUser =
        _userDB.firstWhere((element) => element.password == password);

    isUserSignedIn = _userDB.any((element) => password == element.password);

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
  static Future<bool> updateUserDetail(
      {required String? fullName,
      required String? userName,
      required String? email,
      required String? password,
      required Uint8List? userImage}) async {
    //! IS USER DETAILS UPDATED
    bool _isUserDetailsUpdated = false;

    //! OPEN BOX
    Box<User> _authBox = Hive.box<User>("usersBox");
    log("Fetched DB usersBox");

    //! FETCH VALUE OF USER DETAILS STORED USING KEY EMAIL.
    User _user = _authBox.get(loggedInUser.key)!;
    log("User details gotten. \nDetails: ${_user.fullName}");

    //! UPDATE SPECIFIC USER PROPERTY
    _user = User()
      ..email = email ?? _user.email
      ..password = password ?? _user.password
      ..fullName = fullName ?? _user.fullName
      ..userName = userName ?? _user.userName
      ..userImage = userImage ?? _user.userImage;

    //! SAVE USER DETAILS BACK
    _authBox.putAt(loggedInUser.key, _user);

    loggedInUser = _user;

    //! CONFIRM NEW ADDITION
    _isUserDetailsUpdated = _authBox.values.contains(loggedInUser);
    log(_isUserDetailsUpdated.toString());

    return _isUserDetailsUpdated;
  }
}
