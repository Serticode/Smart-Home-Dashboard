import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_dashboard/router/router.dart';
import 'package:smart_home_dashboard/router/routes.dart';
import 'package:smart_home_dashboard/services/auth/auth_services.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class AppDrawer extends StatefulWidget {
  final String userName, userEmail;
  const AppDrawer({Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordSeen = false;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _userNameController;
  TextEditingController? _fullNameController;
  File? _userProfilePicture;
  Uint8List? _userProfilePictureBytes;

  @override
  void initState() {
    super.initState();
    _passwordSeen = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _userNameController!.dispose();
    _fullNameController!.dispose();
    super.dispose();
  }

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
                                          color:
                                              AppThemeColours.primaryColour)),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: AppAuthService
                                                  .loggedInUser.userImage ==
                                              null
                                          ? Image.asset("assets/user.jpg")
                                          : Image.memory(
                                              AppAuthService
                                                  .loggedInUser.userImage!,
                                              fit: BoxFit.cover))),

                              //! SPACER
                              AppScreenUtils.verticalSpaceMedium,

                              //! NAME
                              Text(this.widget.userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceTiny,

                              //! EMAIL
                              Text(this.widget.userEmail,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 14.0))
                            ])))),

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! OTHER CONTENT
            ListTile(
                onTap: () {
                  AppFunctionalUtils.showAppDialogBox(
                      theBuildContext: context,
                      child: Form(
                          key: _formKey,
                          child: Column(children: [
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
                              Text("Update your details",
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
                                        _userProfilePicture = File(
                                            _pickedFile!.files.single.path!);

                                        _userProfilePictureBytes =
                                            _userProfilePicture!
                                                .readAsBytesSync();
                                      });
                                    },
                                    child: _userProfilePicture != null
                                        ? Center(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Image.file(
                                                    _userProfilePicture!,
                                                    fit: BoxFit.cover)))
                                        : Center(
                                            child: Text(
                                                "Tap to add device Image",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2)))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceMedium,

                            //! FULL NAME
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  return null;
                                },
                                controller: _fullNameController,
                                style: Theme.of(context).textTheme.bodyText2,
                                decoration: InputDecoration(
                                    hintText: "Ciroma, Chuckwuma Adekunle",
                                    labelText: "Full name")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! USER NAME
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your preferred username';
                                  }
                                  return null;
                                },
                                controller: _userNameController,
                                style: Theme.of(context).textTheme.bodyText2,
                                decoration: InputDecoration(
                                    hintText: "Serticode",
                                    labelText: "Custom user name")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! EMAIL
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                                style: Theme.of(context).textTheme.bodyText2,
                                decoration: InputDecoration(
                                    hintText: "you@you.com",
                                    labelText: "Email")),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! PASSWORD
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your preferred password';
                                  }
                                  return null;
                                },
                                obscureText: !_passwordSeen,
                                style: Theme.of(context).textTheme.bodyText2,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                        onPressed: () => setState(() =>
                                            _passwordSeen = !_passwordSeen),
                                        icon: Icon(
                                            _passwordSeen
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black54)))),

                            //! SPACER
                            AppScreenUtils.verticalSpaceSmall,

                            //! SAVE BUTTON
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () => AppAuthService
                                            .updateUserDetail(
                                                fullName:
                                                    _fullNameController!.text,
                                                userName:
                                                    _userNameController!.text,
                                                email: _emailController!.text,
                                                password:
                                                    _passwordController!.text,
                                                userImage:
                                                    _userProfilePictureBytes)
                                        .then((value) => value
                                            ? {
                                                AppFunctionalUtils.showAppSnackBar(
                                                    theBuildContext: context,
                                                    message:
                                                        "Your details have been updated."),
                                                Navigator.of(context).pop()
                                              }
                                            : {
                                                AppFunctionalUtils.showAppSnackBar(
                                                    theBuildContext: context,
                                                    message:
                                                        "Failed to update details"),
                                                Navigator.of(context).pop()
                                              }),
                                    style: ElevatedButton.styleFrom(
                                        primary: AppThemeColours.primaryColour),
                                    child: Text("Save")))
                          ])),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.7);
                },
                leading: Icon(Icons.person_outlined,
                    color: AppThemeColours.primaryColour),
                title: Text("Edit Details",
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
                                                onPressed: () async {
                                                  if (await AppAuthService
                                                      .logOutUser()) {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    AppNavigator
                                                        .navigateToReplacementPage(
                                                            thePageRouteName:
                                                                AppRoutes
                                                                    .appWrapper,
                                                            context: context);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.red.shade200),
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
