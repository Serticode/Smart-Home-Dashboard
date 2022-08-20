import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/login_screen/login_screen.dart';
import 'package:smart_home_dashboard/screens/auth_screens/register_screen/register_screen.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class AuthModalBottomSheet extends StatelessWidget {
  final BoxConstraints theParentConstraints;
  const AuthModalBottomSheet({Key? key, required this.theParentConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  width: theParentConstraints.maxWidth * 0.2,
                  decoration: BoxDecoration(
                      color: const Color(0xFFADB3BC),
                      borderRadius: BorderRadius.circular(12.0)),
                  height: theParentConstraints.maxHeight * 0.01),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! CONTENT
              const CustomTextWidget(
                  theText: "What would you like to do?",
                  isThisAHeader: false,
                  isThisASubheader: false,
                  isThisABody: true),

              //! SPACER
              AppScreenUtils.verticalSpaceMedium,

              //! BUTTONS
              //! LOGIN
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        //! CLOSE CURRENT MODAL SHEET
                        Navigator.of(context).pop();

                        //! SHOW MODAL SHEET
                        AppFunctionalUtils.showAppModalBottomSheet(
                            theBuildContext: context, child: const Login());
                      },
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary)),
                      child: Text("Login",
                          style: Theme.of(context).textTheme.bodyText2))),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! REGISTER
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          //! SHOW MODAL SHEET
                          AppFunctionalUtils.showAppModalBottomSheet(
                              theBuildContext: context,
                              child: const Register()),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.primary),
                      child: const Text("Register")))
            ])));
  }
}
