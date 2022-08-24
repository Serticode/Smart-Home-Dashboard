import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_home_dashboard/models/house_room_model.dart';
import 'package:smart_home_dashboard/models/user_model.dart';
import 'package:smart_home_dashboard/screens/home_screen/app_drawer/app_drawer.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/bedroom/bedroom.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/dining/dining.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/kitchen/kitchen.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/living_room/living_room.dart';
import 'package:smart_home_dashboard/screens/home_screen/pages/lounge/lounge.dart';
import 'package:smart_home_dashboard/services/providers/app_providers.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      GlobalKey<ScaffoldState>();
  static final PageController _pageViewController = PageController();

  File? _userProfileImage;
  File? _userDeviceImage;
  Uint8List? _deviceImageBytes;
  late var _theLoggedInUser;
  String _selectedRoom = "Living room";
  //late Box _devicesBox;
  late TextEditingController _deviceNameController;
  late TextEditingController _deviceTypeController;
  late TextEditingController _deviceLocationController;

  @override
  void initState() {
    super.initState();
    _theLoggedInUser = Hive.box<Users>("usersBox")
        .values
        .firstWhere((element) => element.email == "test");
    log("User Data Gotten: ${_theLoggedInUser.toString()}");

    //! INITIALIZE CONTROLLERS
    _deviceNameController = TextEditingController();
    _deviceLocationController = TextEditingController();
    _deviceTypeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerScaffoldKey,
        drawer: AppDrawer(
            userEmail: _theLoggedInUser!.email!,
            userName: _theLoggedInUser!.userName!),
        body: SafeArea(
            child: 
                Padding(
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
                                    : _drawerScaffoldKey.currentState!
                                        .openDrawer(),
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
                                      ? setState(() =>
                                          _userProfileImage = _selectedImage)
                                      : SizedBox();
                                },
                                child: Container(
                                    height: 45.0,
                                    width: 45.0,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 2.0,
                                            color:
                                                AppThemeColours.primaryColour),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
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
                                Text("Hi ${_theLoggedInUser!.userName}",
                                    style:
                                        Theme.of(context).textTheme.headline2),
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
                                            setState(() => _selectedRoom =
                                                room["roomName"]);

                                            //! SCROLL TO ROOM PAGE
                                            AppFunctionalUtils.scrollToIndex(
                                                pageController:
                                                    _pageViewController,
                                                index: HouseRoomModel
                                                    .listOfRooms
                                                    .indexOf(room));
                                          },
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //! ICON
                                                Card(
                                                    color: _selectedRoom ==
                                                            room["roomName"]
                                                        ? AppThemeColours
                                                            .primaryColour
                                                        : const Color(
                                                            0xFFBCC1C2),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    12.0)),
                                                    child: Padding(
                                                        padding: AppScreenUtils
                                                            .cardPadding,
                                                        child: Icon(
                                                            room["roomIcon"],
                                                            color: _selectedRoom ==
                                                                    room[
                                                                        "roomName"]
                                                                ? AppThemeColours
                                                                    .tertiaryColour
                                                                : AppThemeColours
                                                                    .primaryColour))),

                                                //! SPACER
                                                AppScreenUtils
                                                    .verticalSpaceTiny,

                                                //! NAMES
                                                Text(room["roomName"])
                                              ])))
                                      .toList()))),

                      //! BODY
                      Expanded(
                          child: PageView(
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
                          ]))
                    ]))),

        //! FLOATING ACTION BUTTON
        floatingActionButton: FloatingActionButton(
            elevation: 12.0,
            onPressed: () {
              //! SHOW A LOG
              log("FAB - Add New Device Pressed");

              //! SHOW A MODAL BOTTOM SHEET
              showAppDialogBox(
                  theBuildContext: context,
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  selectedRoom: _selectedRoom);
            },
            backgroundColor: AppThemeColours.primaryColour,
            child: Icon(Icons.add_outlined)));
  }

  showAppDialogBox(
          {required BuildContext theBuildContext,
          required double width,
          required String selectedRoom,
          required double height}) =>
      showGeneralDialog(
          //!SHADOW EFFECT
          barrierColor: AppThemeColours.primaryColour.withOpacity(0.5),

          //! OTHER NEEDED PARAMETERS
          barrierDismissible: false,
          barrierLabel: "LABEL",
          context: theBuildContext,

          //! USE PROVIDED ANIMATION
          transitionBuilder: (context, a1, a2, widget) => Dialog(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21)),
              child: SizedBox(
                  height: height * a1.value,
                  width: width * a1.value,
                  child: SingleChildScrollView(
                      padding: AppScreenUtils.cardPadding,
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
                              Text("Add a new device to \nyour $selectedRoom",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                            ]),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            Container(
                                padding: AppScreenUtils.containerPaddingSmall,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.0,
                                        color: AppThemeColours.primaryColour),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: InkWell(
                                    onTap: () async {
                                      FilePickerResult? _pickedFile =
                                          await FilePicker.platform.pickFiles();

                                      //! ADD IMAGE & GET BYTES
                                      setState(() {
                                        _userDeviceImage = File(
                                            _pickedFile!.files.single.path!);

                                        _deviceImageBytes =
                                            _userDeviceImage!.readAsBytesSync();
                                      });
                                    },
                                    child: _userDeviceImage != null
                                        ? Center(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Image.file(
                                                    _userDeviceImage!)))
                                        : Center(
                                            child: Text(
                                                "Tap to add device Image",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2)))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE NAME
                            TextFormField(
                                controller: _deviceNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter the device name';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(hintText: "Device name")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE TYPE
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Device type missing!';
                                  }
                                  return null;
                                },
                                controller: _deviceTypeController,
                                decoration: InputDecoration(
                                    hintText:
                                        "Device type - Fridge, Speaker, Television")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! DEVICE LOCATION
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Where is the device placed in-house?';
                                  }
                                  return null;
                                },
                                controller: _deviceLocationController,
                                decoration: InputDecoration(
                                    hintText:
                                        "In house device location - Bedroom, Lounge, Living room, Kitchen?")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      //! SAVE DEVICE
                                      bool _isDeviceAdded =
                                          await AppProviders.addDevice(
                                              deviceName:
                                                  _deviceNameController.text,
                                              deviceType:
                                                  _deviceTypeController.text,
                                              deviceImageBytes:
                                                  _deviceImageBytes!, //_deviceImageBytes!.toString(),
                                              inHouseDeviceLocation:
                                                  _deviceLocationController
                                                      .text,
                                              storageBoxName: "$selectedRoom");

                                      _isDeviceAdded
                                          // ignore: unnecessary_statements
                                          ? {
                                              log("Device added"),
                                              _deviceTypeController.clear(),
                                              _deviceNameController.clear(),
                                              _deviceLocationController.clear(),
                                              _deviceImageBytes = null,
                                              _userDeviceImage!.delete(),
                                              Navigator.of(context).pop()
                                            }
                                          : log("Device not added.");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: AppThemeColours.primaryColour),
                                    child: Text("Add device"))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall
                          ])))),

          //! ANIMATION DURATION
          transitionDuration: Duration(milliseconds: 200),

          //! STILL DON'T KNOW WHAT THIS DOES, BUT IT'S REQUIRED
          pageBuilder: (context, animation1, animation2) => Text(""));
}
