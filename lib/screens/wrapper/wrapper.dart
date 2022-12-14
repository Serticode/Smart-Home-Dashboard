import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/screens/auth_screens/modal_bottom_sheet/auth_modal_bottom_sheet.dart';
import 'package:smart_home_dashboard/services/auth/auth_services.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: FutureBuilder(
          future: AppAuthService.openDBBoxes(),
          builder: (context, snapshot) => LayoutBuilder(
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
                              Text("Sweet & Smart Home",
                                  style: Theme.of(context).textTheme.headline1),

                              //! SPACER
                              AppScreenUtils.verticalSpaceMedium,

                              //! BODY TEXT
                              Text(
                                  "Smart home can change the way you live in the future",
                                  style: Theme.of(context).textTheme.bodyText1),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall
                            ])),

                    //! SPACER
                    const Spacer(),

                    //! ELEVATED BUTTON
                    snapshot.connectionState == ConnectionState.waiting
                        ? SizedBox()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () =>
                                    AppFunctionalUtils.showAppModalBottomSheet(
                                        theBuildContext: context,
                                        child: AuthModalBottomSheet(
                                            theParentConstraints: constraints)),
                                child: Text("Get Smart",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium
                  ])))));
}
