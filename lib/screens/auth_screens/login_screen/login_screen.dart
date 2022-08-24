import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/screens/auth_screens/confirmation_screen/confirmation_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/register_screen/register_screen.dart';
import 'package:smart_home_dashboard/services/auth/auth_services.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool? _passwordVisible;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        padding: AppScreenUtils.appUIDefaultPadding,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0))),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //! DIVIDING LINE
                Container(
                    width: screenSize.width * 0.2,
                    decoration: BoxDecoration(
                        color: const Color(0xFFADB3BC),
                        borderRadius: BorderRadius.circular(12.0)),
                    height: screenSize.height * 0.01),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall,

                //! CONTENT
                const CustomTextWidget(
                    theText: "Login",
                    isThisAHeader: false,
                    isThisASubheader: false,
                    isThisABody: true),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall,

                //! EMAIL
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                        hintText: "you@you.com", labelText: "Email")),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall,

                //! PASSWORD
                TextFormField(
                    obscureText: !_passwordVisible!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                        hintText: "******",
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible!;
                              });
                            },
                            icon: Icon(
                                _passwordVisible!
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black.withOpacity(0.5))))),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall,

                //! LOGIN BUTTON
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        //! SHOW CONFIRMATION MESSAGE
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            log("Login values validated. \nFiring Login method");

                            bool _isUserAuthenticated =
                                AppAuthService.signInUser(
                                    email: _emailController!.text,
                                    password: _passwordController!.text);

                            _isUserAuthenticated
                                // ignore: unnecessary_statements
                                ? {
                                    //! OPEN THE BOX OF USERS DEVICES
                                    //! OPEN ALL DATA BASE BOXES
                                    await Hive.openBox<DeviceModel>(
                                            "Living room")
                                        .whenComplete(
                                            () => log("box open! Living room")),
                                    await Hive.openBox<DeviceModel>("Kitchen")
                                        .whenComplete(
                                            () => log("box open! Kitchen")),
                                    await Hive.openBox<DeviceModel>("Dining")
                                        .whenComplete(
                                            () => log("box open! Dining")),
                                    await Hive.openBox<DeviceModel>("Lounge")
                                        .whenComplete(
                                            () => log("box open! Lounge")),
                                    await Hive.openBox<DeviceModel>("Bedroom")
                                        .whenComplete(
                                            () => log("box open! Bedroom")),

                                    //! CLEAR CONTROLLERS
                                    _emailController!.clear(),
                                    _passwordController!.clear(),

                                    AppFunctionalUtils.showAppModalBottomSheet(
                                        theBuildContext: context,
                                        child: Confirm(
                                            isUserAuthenticated:
                                                _isUserAuthenticated)),
                                  }
                                : AppFunctionalUtils.showAppSnackBar(
                                    theBuildContext: context,
                                    message: "Authentication Failed");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppThemeColours.primaryColour),
                        child: Text("Login"))),

                //! SPACER
                AppScreenUtils.verticalSpaceMedium,

                //! CONTENT
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const CustomTextWidget(
                      theText: "Don't have an account?",
                      isThisAHeader: false,
                      isThisASubheader: false,
                      isThisABody: true),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceMedium,

                  //! CONTENT
                  InkWell(
                      onTap: () {
                        //! CLOSE PREVIOUS MODAL SHEET
                        Navigator.of(context).pop();

                        //! OPEN NEW MODAL SHEET
                        AppFunctionalUtils.showAppModalBottomSheet(
                            theBuildContext: context, child: Register());
                      },
                      child: const CustomTextWidget(
                          theText: "Register",
                          isThisAHeader: false,
                          isThisASubheader: false,
                          isThisABody: true))
                ]),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall
              ]),
        )));
  }
}
