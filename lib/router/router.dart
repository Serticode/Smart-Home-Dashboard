import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/router/routes.dart';
import 'package:smart_home_dashboard/screens/home_screen/home_screen_wrapper.dart';

class AppNavigator {
  //! NAVIGATE TO A PAGE WITHOUT REPLACING THE PREVIOUS PAGE.
  static void navigateToPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushNamed(thePageRouteName);

  //! NAVIGATE TO A PAGE AND REPLACE THE PREVIOUS PAGE
  static void navigateToReplacementPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushReplacementNamed(thePageRouteName);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreenWrapper:
        return _getPageRoute(
            routeName: settings.name,
            args: settings.arguments,
            view: const HomeScreenWrapper());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}

//! GET A PAGE ROUTE
PageRoute _getPageRoute({String? routeName, Widget? view, Object? args}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view!);
}
