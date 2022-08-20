import 'package:flutter/material.dart';

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
}
