import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/modal_bottom_sheet/auth_modal_bottom_sheet.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => Container(
                padding: AppScreenUtils.appUIDefaultPadding,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/lounge.jpg"),
                        fit: BoxFit.fitHeight)),
                child: Column(children: [
                  //! SPACER
                  const Spacer(),

                  //! GREETING BOX
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(32.0)),
                      padding: AppScreenUtils.appUIDefaultPadding,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! HEADER
                            const CustomTextWidget(
                                theText: "Sweet & Smart Home",
                                isThisAHeader: true,
                                isThisABody: false,
                                isThisASubheader: false,
                                isThisAButton: false),

                            //! SPACER
                            AppScreenUtils.verticalSpaceMedium,

                            //! BODY TEXT
                            const CustomTextWidget(
                                theText:
                                    "Smart home can change the way you live in the future",
                                isThisAHeader: false,
                                isThisABody: true,
                                isThisASubheader: false,
                                isThisAButton: false),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall
                          ])),

                  //! SPACER
                  const Spacer(),

                  //! ELEVATED BUTTON
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32.0),
                                      topRight: Radius.circular(32.0))),
                              builder: (context) {
                                return AuthModalBottomSheet(
                                    theParentConstraints: constraints);
                              }),
                          child: const CustomTextWidget(
                              theText: "Get Smart",
                              isThisAHeader: false,
                              isThisABody: false,
                              isThisASubheader: false,
                              isThisAButton: true))),

                  //! SPACER
                  AppScreenUtils.verticalSpaceMedium
                ]))));
  }
}
