import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class AppFunctionalUtils {
  //! PRE CACHE IMAGES
  static Future<void> precacheAppImages(BuildContext context) async {
    await precacheImage(const AssetImage("assets/abbey.jpg"), context);
    await precacheImage(const AssetImage("assets/bedroom.jpg"), context);
    await precacheImage(const AssetImage("assets/dining.jpg"), context);
    await precacheImage(const AssetImage("assets/living_room.jpg"), context);
    await precacheImage(const AssetImage("assets/lounge.jpg"), context);
    await precacheImage(
        const AssetImage("assets/smart_home_logo.png"), context);
  }

  //! PICK IMAGE
  static Future<File?>? pickProfilePhoto(
      {required BuildContext theBuildContext}) async {
    FilePickerResult? _pickedFile = await FilePicker.platform.pickFiles();
    File? _selectedImage;

    _pickedFile != null
        ? _selectedImage = File(_pickedFile.files.single.path!)
        // ignore: unnecessary_statements
        : {
            //! LOG RESPONSE
            log("User did not select any image"),

            //! SHOW SNACK BAR
            showAppSnackBar(theBuildContext: theBuildContext)
          };

    return _selectedImage;
  }

  //! SNACK BAR
  static showAppSnackBar({required BuildContext theBuildContext}) =>
      ScaffoldMessenger.of(theBuildContext).showSnackBar(SnackBar(
          backgroundColor: AppThemeColours.primaryColour,
          content: Text("You did not select any image",
              style: Theme.of(theBuildContext)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppThemeColours.tertiaryColour))));

  //! MODAL BOTTOM SHEET
  static showAppModalBottomSheet(
          {required BuildContext theBuildContext, required Widget child}) =>
      showModalBottomSheet(
          context: theBuildContext,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0))),
          builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: child));

  //! DIALOGUE BOX
  static showAppDialogBox(
          {required BuildContext theBuildContext,
          required Widget child,
          required double width,
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
                      padding: AppScreenUtils.cardPadding, child: child))),

          //! ANIMATION DURATION
          transitionDuration: Duration(milliseconds: 200),

          //! STILL DON'T KNOW WHAT THIS DOES, BUT IT'S REQUIRED
          pageBuilder: (context, animation1, animation2) => Text(""));

  //! SCROLL CONTROLLER
  static scrollToIndex(
          {required int index, required PageController pageController}) =>
      pageController.animateToPage(index,
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn);
}
