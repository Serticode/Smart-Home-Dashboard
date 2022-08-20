import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/bedroom/bedroom.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/dining/dining.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/kitchen/kitchen.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/living_room/living_room.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/lounge/lounge.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  static String _nameOfSelectedRoom = "Living room";

  static final PageController _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: AppScreenUtils.appUIDefaultPadding,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.drag_handle_outlined,
                            size: 32.0, color: AppThemeColours.primaryColour),

                        //! IMAGE
                        Container(
                            height: 45.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: AssetImage("assets/user.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(12.0)))
                      ]),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  SizedBox(
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hi Serticode",
                                style: Theme.of(context).textTheme.headline2),
                            Text("Welcome to your Smart Home.")
                          ])),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! ROOM ICONS
                  Padding(
                      padding: AppScreenUtils.appUIDefaultPadding,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: HouseRoomModel.listOfRooms
                                  .map((room) => InkWell(
                                      onTap: () {
                                        log(room["roomName"]);

                                        //! SET VALUE
                                        setState(() => _nameOfSelectedRoom =
                                            room["roomName"]);

                                        //! SCROLL TO ROOM PAGE
                                        _scrollToIndex(HouseRoomModel
                                            .listOfRooms
                                            .indexOf(room));
                                      },
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            //! ICON
                                            Card(
                                                color: _nameOfSelectedRoom ==
                                                        room["roomName"]
                                                    ? AppThemeColours
                                                        .primaryColour
                                                    : Color(0xFFBCC1C2),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)),
                                                child: Padding(
                                                    padding: AppScreenUtils
                                                        .cardPadding,
                                                    child: Icon(
                                                        room["roomIcon"],
                                                        color: _nameOfSelectedRoom ==
                                                                room["roomName"]
                                                            ? AppThemeColours
                                                                .tertiaryColour
                                                            : AppThemeColours
                                                                .primaryColour))),

                                            //! SPACER
                                            AppScreenUtils.verticalSpaceTiny,

                                            //! NAMES
                                            Text(room["roomName"])
                                          ])))
                                  .toList()))),

                  Expanded(
                      child: Stack(children: [
                    PageView(
                        controller: _pageViewController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //! HOME PAGE
                          LivingRoom(),

                          //! BEDROOMS / LOCATIONS PAGE
                          Bedroom(),

                          //! USERS PAGE / SETTING
                          Kitchen(),

                          //! BEDROOMS / LOCATIONS PAGE
                          Dining(),

                          //! USERS PAGE / SETTING
                          Lounge()
                        ])
                  ]))
                ]))),

        //! FLOATING ACTION BUTTON
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            log("FAB Pressed");
          },
          backgroundColor: AppThemeColours.primaryColour,
          child: Icon(Icons.add_outlined),
        ));
  }

  void _scrollToIndex(int index) {
    _pageViewController.animateToPage(index,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}
