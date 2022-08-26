import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/router/router.dart';
import 'package:smart_home_dashboard/router/routes.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class Confirm extends StatelessWidget {
  final bool isUserAuthenticated;
  const Confirm({Key? key, required this.isUserAuthenticated})
      : super(key: key);

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
              const Text("Confirmation"),

              //! SPACER
              AppScreenUtils.verticalSpaceLarge,

              //! CONTENT
              Transform.scale(
                  scale: 2, child: Text(isUserAuthenticated ? "☺️" : "😔")),

              //! SPACER
              AppScreenUtils.verticalSpaceLarge,

              Text(isUserAuthenticated
                  ? "You have been authenticated. \nWelcome."
                  : "Authentication not successful."),

              //! SPACER
              AppScreenUtils.verticalSpaceLarge,

              //! LOADER OR AUTH BUTTON
              isUserAuthenticated
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            //! CLOSE CURRENT MODAL
                            Navigator.of(context).pop();

                            //! GO TO HOME SCREEN
                            AppNavigator.navigateToReplacementPage(
                                thePageRouteName: AppRoutes.homeScreenWrapper,
                                context: context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppThemeColours.primaryColour),
                          child: Text("Go home")),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                              primary: AppThemeColours.primaryColour),
                          child: Text("Kindly retry")))
            ])));
  }
}
