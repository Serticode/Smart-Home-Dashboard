import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/confirmation_screen/confirmation_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/login_screen/login_screen.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Register extends StatefulWidget {
   Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}
final _formKey = GlobalKey<FormState>();
bool _passwordSeen = false;

@override
void initState() {
  _passwordSeen = false;
}

class _RegisterState extends State<Register> {
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
                        theText: "Register",
                        isThisAHeader: false,
                        isThisASubheader: false,
                        isThisABody: true),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! FULL NAME
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your fullname';
                          }
                          return null;
                        },
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
                        decoration: InputDecoration(
                            hintText: "Serticode", labelText: "Custom user name")),

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
                      decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordSeen = !_passwordSeen;
                              });
                            },
                            icon: Icon(
                              _passwordSeen ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          )
                      ),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! Register BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        //! SHOW CONFIRMATION MESSAGE
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppFunctionalUtils.showAppModalBottomSheet(
                                  theBuildContext: context,
                                  child: const Confirm());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppThemeColours.primaryColour),
                          child: Text("Register")),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! CONTENT
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const CustomTextWidget(
                          theText: "Already have an account?",
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
                              theBuildContext: context, child: Login());
                        },
                        child: const CustomTextWidget(
                            theText: "Login",
                            isThisAHeader: false,
                            isThisASubheader: false,
                            isThisABody: true),
                      )
                    ]),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,
                  ]),
            )));
  }
}