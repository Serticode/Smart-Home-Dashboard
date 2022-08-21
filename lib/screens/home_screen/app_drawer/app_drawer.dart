import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Drawer(
          elevation: 14.0,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(children: [
            //! DRAWER HEADER
            SizedBox(
                width: double.infinity,
                child: Card(
                    color: const Color(0xFFBCC1C2),
                    margin: EdgeInsets.zero,
                    child: Padding(
                        padding: AppScreenUtils.cardPadding,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //! IMAGE
                              Container(
                                  height: 120.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          width: 3.0,
                                          color: AppThemeColours.primaryColour),
                                      image: DecorationImage(
                                          image: AssetImage("assets/user.jpg"),
                                          fit: BoxFit.cover))),

                              //! SPACER
                              AppScreenUtils.verticalSpaceMedium,

                              //! NAME
                              Text("Serticode",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceTiny,

                              //! EMAIL
                              Text("you@you.com",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 14.0))
                            ])))),

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! OTHER CONTENT
            ListTile(
                onTap: () => Navigator.pop(context),
                leading: const Icon(Icons.person),
                title: Text("My Profile",
                    style: Theme.of(context).textTheme.bodyText2)),

            //! SPACER
            Spacer(),

            //! LOG OUT
            Card(
                color: Colors.red.shade100,
                margin: EdgeInsets.zero,
                child: Padding(
                    padding: AppScreenUtils.containerPaddingSmall,
                    child: ListTile(
                        leading: Icon(Icons.logout_outlined,
                            color: Colors.red.shade900),
                        title: Text("Log out",
                            style: GoogleFonts.poppins(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade900)),
                        onTap: () {
                          //! SHOW LOG OUT DIALOGUE
                          AppFunctionalUtils.showAppModalBottomSheet(
                              theBuildContext: context,
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Padding(
                                      padding: AppScreenUtils.cardPadding,
                                      child: Column(children: [
                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! HEADER
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //! ICON
                                              Icon(Icons.close,
                                                  color: Colors.red.shade900),

                                              //! NOTICE
                                              Text(
                                                  "Would you like to Logout of the app or exit the app.")
                                            ]),

                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! BUTTONS
                                        //! EXIT
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () => SystemChannels
                                                    .platform
                                                    .invokeMethod(
                                                        'SystemNavigator.pop'),
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.red.shade100),
                                                child: Text("Exit the app.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.red
                                                                .shade900)))),

                                        //! SPACER
                                        AppScreenUtils.verticalSpaceSmall,

                                        //! LOG OUT
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.red.shade300),
                                                child: Text("Log out",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.red
                                                                .shade900))))
                                      ]))));
                        })))
          ])));
}
