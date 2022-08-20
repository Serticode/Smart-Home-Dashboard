import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_dashboard/utils/app_screen_utils.dart';

class AppTheme {
  static ThemeData get theTheme {
    return ThemeData(
        //! GENERAL PAGE TRANSITIONS
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder()
        }),

        //! COLOURS
        backgroundColor: AppThemeColours.primaryColour,
        shadowColor: Colors.grey.shade100.withOpacity(0.2),

        //! COLOUR SCHEMES
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppThemeColours.primaryColour,
            secondary: AppThemeColours.secondaryColour,
            secondaryContainer: AppThemeColours.containersBackgroundColour,
            shadow: Colors.grey.shade100.withOpacity(0.2)),

        //! ICON THEME
        iconTheme:
            IconThemeData(size: 21.0, color: AppThemeColours.tertiaryColour),

        //! SNACK BAR THEME
        snackBarTheme: SnackBarThemeData(
            elevation: 8.0,
            backgroundColor: AppThemeColours.snackbarBackgroundColour,
            contentTextStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.lettersColour,
                fontSize: 12.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(21.0),
                    topRight: Radius.circular(21.0)))),

        //! TEXT
        textTheme: TextTheme(
            headline1: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 32.0,
                color: AppThemeColours.lettersColour),
            headline2: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: AppThemeColours.lettersColour),
            bodyText1: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.lettersColour,
                fontSize: 18.0),
            bodyText2: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.lettersColour,
                fontSize: 12.0)),

        //! ELEVATED BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: AppScreenUtils.elevatedButtonDefaultPadding,
                primary: AppThemeColours.elevatedButtonBackgroundColour,
                textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: AppThemeColours.lettersColour,
                    fontSize: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)))),

        //! INPUT DECORATION
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: AppScreenUtils.textFormFieldDefaultPadding,
            filled: true,
            fillColor:
                AppThemeColours.lettersAndIconsFaintColour.withOpacity(0.2),

            //! BORDERS
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppThemeColours.primaryColour, width: 2.0),
                borderRadius: BorderRadius.circular(21.0)),
            focusColor: AppThemeColours.focusedTextFormFieldColour,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: AppThemeColours.focusedTextFormFieldColour),
                borderRadius: BorderRadius.circular(21.0)),

            //! HINT
            hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.lettersAndIconsFaintColour,
                fontSize: 12.0),

            //! LABEL
            alignLabelWithHint: true,
            floatingLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.lettersAndIconsFaintColour,
                fontSize: 16.0),
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: AppThemeColours.lettersAndIconsFaintColour, fontSize: 12.0)));
  }
}

//! THEME COLOURS, SINGLETON INSTANCES & THEME COLOUR CLASS.
class AppThemeColours {
  static Color primaryColour = const Color(0xFF203033);
  static Color shadowColour = Color(0xFF21464d); //const Color(0xFF203033);
  static Color secondaryColour = const Color(0xFF1A224C);
  static Color tertiaryColour = Colors.white;
  static Color lettersColour = const Color(0xFF203033);
  static Color lettersAndIconsFaintColour = const Color(0xFF565759);
  static Color focusedTextFormFieldColour = Colors.green.shade300;

  static Color elevatedButtonBackgroundColour = Colors.white;
  static Color containersBackgroundColour = const Color(0xFF565759);
  static Color snackbarBackgroundColour = Colors.white;
}
