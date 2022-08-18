import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/confirmation_screen/confirmation_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/login_screen/login_screen.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
                  theText: "Register",
                  isThisAHeader: false,
                  isThisASubheader: false,
                  isThisABody: true,
                  isThisAButton: false),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! FULL NAME
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "Ciroma, Chuckwuma Adekunle",
                      labelText: "Full name")),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! USER NAME
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "Serticode", labelText: "Custom user name")),

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

              //! Register BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    //! SHOW CONFIRMATION MESSAGE
                    onPressed: () => AppScreenUtils.showAppModalBottomSheet(
                        theBuildContext: context, child: const Confirm()),
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
                    isThisABody: true,
                    isThisAButton: false),

                //! SPACER
                AppScreenUtils.horizontalSpaceMedium,

                //! CONTENT
                InkWell(
                  onTap: () {
                    //! CLOSE PREVIOUS MODAL SHEET
                    Navigator.of(context).pop();

                    //! OPEN NEW MODAL SHEET
                    AppScreenUtils.showAppModalBottomSheet(
                        theBuildContext: context, child: const Login());
                  },
                  child: const CustomTextWidget(
                      theText: "Login",
                      isThisAHeader: false,
                      isThisASubheader: false,
                      isThisABody: true,
                      isThisAButton: false),
                )
              ]),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,
            ])));
  }
}
