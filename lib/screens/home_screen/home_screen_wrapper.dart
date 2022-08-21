import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';
import 'package:smart_home_dashboard/screens/home_screen/app_drawer/app_drawer.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/bedroom/bedroom.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/dining/dining.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/kitchen/kitchen.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/living_room/living_room.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/lounge/lounge.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      GlobalKey<ScaffoldState>();
  static String _nameOfSelectedRoom = "Living room";
  File? _userProfileImage;

  static final PageController _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerScaffoldKey,
        drawer: AppDrawer(),
        body: SafeArea(
            child: Padding(
                padding: AppScreenUtils.appUIDefaultPadding,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            //! OPEN OR CLOSE APP DRAWER ON PRESSED
                            onPressed: () => _drawerScaffoldKey
                                    .currentState!.isDrawerOpen
                                ? Navigator.of(context).pop()
                                : _drawerScaffoldKey.currentState!.openDrawer(),
                            icon: Icon(Icons.drag_handle_outlined,
                                size: 32.0,
                                color: AppThemeColours.primaryColour)),

                        //! IMAGE
                        InkWell(
                            //! PICK IMAGE
                            onTap: () async {
                              //! LOG
                              log("File picker fired!");

                              //! CALL FILE PICKER
                              File? _selectedImage =
                                  await AppFunctionalUtils.pickProfilePhoto(
                                      theBuildContext: context);

                              _selectedImage != null
                                  ? setState(
                                      () => _userProfileImage = _selectedImage)
                                  : SizedBox();
                            },
                            child: Container(
                                height: 45.0,
                                width: 45.0,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        width: 2.0,
                                        color: AppThemeColours.primaryColour),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: _userProfileImage != null
                                        ? Image.file(_userProfileImage!,
                                            fit: BoxFit.contain)
                                        : Image(
                                            image: AssetImage(
                                                "assets/user.jpg")))))
                      ]),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! USER NAME
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
                                        AppFunctionalUtils.scrollToIndex(
                                            pageController: _pageViewController,
                                            index: HouseRoomModel.listOfRooms
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
                                                    : const Color(0xFFBCC1C2),
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
                          //! LIVING ROOM
                          LivingRoom(),

                          //! BEDROOMS
                          Bedroom(),

                          //! KITCHEN
                          Kitchen(),

                          //! DINING
                          Dining(),

                          //! LOUNGE
                          Lounge()
                        ])
                  ]))
                ]))),

        //! FLOATING ACTION BUTTON
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //! ADD NEW ROOM
            FloatingActionButton(
                onPressed: () {
                  //! SHOW A LOG
                  log("FAB - Add New Room Pressed");

                  //! SHOW A MODAL BOTTOM SHEET
                  AppFunctionalUtils.showAppDialogBox(
                      theBuildContext: context,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! CLOSE BUTTON &&  HEADER
                            Row(children: [
                              IconButton(
                                  onPressed: () =>
                                      //! CLOSE NAVIGATOR
                                      Navigator.of(context).pop(),
                                  icon: Icon(Icons.close,
                                      color: AppThemeColours.primaryColour)),

                              //! SPACER
                              AppScreenUtils.horizontalSpaceSmall,

                              //! HEADER
                              Text("Add a new room",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                            ]),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE NAME
                            TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Room name")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: AppThemeColours.primaryColour),
                                    child: Text("Add Room"))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall
                          ]));
                },
                backgroundColor: AppThemeColours.primaryColour,
                child: Icon(Icons.add_business_outlined)),

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! ADD NEW DEVICE
            FloatingActionButton(
                onPressed: () {
                  //! SHOW A LOG
                  log("FAB - Add New Device Pressed");

                  //! SHOW A MODAL BOTTOM SHEET
                  AppFunctionalUtils.showAppDialogBox(
                      theBuildContext: context,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! CLOSE BUTTON &&  HEADER
                            Row(children: [
                              IconButton(
                                  onPressed: () =>
                                      //! CLOSE NAVIGATOR
                                      Navigator.of(context).pop(),
                                  icon: Icon(Icons.close,
                                      color: AppThemeColours.primaryColour)),

                              //! SPACER
                              AppScreenUtils.horizontalSpaceSmall,

                              //! HEADER
                              Text(
                                  "Add a new device to \nyour $_nameOfSelectedRoom",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                            ]),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE NAME
                            TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Device name")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE TYPE
                            TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Device type")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE LOCATION
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: "In house device location")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: AppThemeColours.primaryColour),
                                    child: Text("Add device"))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall
                          ]));
                },
                backgroundColor: AppThemeColours.primaryColour,
                child: Icon(Icons.add_outlined)),
          ],
        ));
  }
}
