// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/confirmation_screen/confirmation_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/login_screen/login_screen.dart';
import 'package:smart_home_dashboard/services/auth/auth_services.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordSeen = false;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _userNameController;
  TextEditingController? _fullNameController;

  @override
  void initState() {
    super.initState();
    _passwordSeen = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _userNameController!.dispose();
    _fullNameController!.dispose();
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
                      Text("Register",
                          style: Theme.of(context).textTheme.bodyText1),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! FULL NAME
                      TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          controller: _fullNameController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: InputDecoration(
                              hintText: "Ciroma, Chuckwuma Adekunle",
                              labelText: "Full name")),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! USER NAME
                      TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your preferred username';
                            }
                            return null;
                          },
                          controller: _userNameController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: InputDecoration(
                              hintText: "Serticode",
                              labelText: "Custom user name")),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! EMAIL
                      TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your preferred password';
                            }
                            return null;
                          },
                          obscureText: !_passwordSeen,
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordSeen = !_passwordSeen;
                                    });
                                  },
                                  icon: Icon(
                                      _passwordSeen
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black54)))),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! Register BUTTON
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              //! SHOW CONFIRMATION MESSAGE
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool _isUserAuthenticated =
                                      AppAuthService.registerNewUser(
                                          fullName: _fullNameController!.text,
                                          userName: _userNameController!.text,
                                          email: _emailController!.text,
                                          password: _passwordController!.text);

                                  _isUserAuthenticated
                                      ? {
                                          //! CLEAR EMAIL CONTROLLERS FROM MEMORY
                                          _emailController!.clear(),
                                          _passwordController!.clear(),
                                          _fullNameController!.clear(),
                                          _userNameController!.clear()
                                        }
                                      : AppFunctionalUtils.showAppSnackBar(
                                          theBuildContext: context,
                                          message: "Authentication Failed");

                                  AppFunctionalUtils.showAppModalBottomSheet(
                                      theBuildContext: context,
                                      child: Confirm(
                                          isUserAuthenticated:
                                              _isUserAuthenticated));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemeColours.primaryColour),
                              child: Text("Register"))),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! CONTENT
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),

                            //! SPACER
                            AppScreenUtils.horizontalSpaceMedium,

                            //! CONTENT
                            InkWell(
                                onTap: () => {
                                      //! CLOSE PREVIOUS MODAL SHEET
                                      Navigator.of(context).pop(),

                                      //! OPEN NEW MODAL SHEET
                                      AppFunctionalUtils
                                          .showAppModalBottomSheet(
                                              theBuildContext: context,
                                              child: Login())
                                    },
                                child: const Text("Login"))
                          ]),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall
                    ]))));
  }
}
