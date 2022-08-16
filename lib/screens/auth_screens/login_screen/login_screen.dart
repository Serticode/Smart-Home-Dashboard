import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
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
                  isThisABody: true,
                  isThisAButton: false),
            ])));
  }
}
