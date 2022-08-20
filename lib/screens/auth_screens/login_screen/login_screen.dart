import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/confirmation_screen/confirmation_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/register_screen/register_screen.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(
                      hintText: "you@you.com", labelText: "Email")),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! PASSWORD
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "******", labelText: "Password")),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! LOGIN BUTTON
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      //! SHOW CONFIRMATION MESSAGE
                      onPressed: () =>
                          AppFunctionalUtils.showAppModalBottomSheet(
                              theBuildContext: context, child: const Confirm()),
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
                        theBuildContext: context, child: const Register());
                  },
                  child: const CustomTextWidget(
                      theText: "Register",
                      isThisAHeader: false,
                      isThisASubheader: false,
                      isThisABody: true),
                )
              ]),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall
            ])));
  }
}
