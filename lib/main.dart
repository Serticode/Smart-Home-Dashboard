import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dashboard/router/router.dart';
import 'package:smart_home_dashboard/screens/wrapper/wrapper.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';

void main() => runApp(const SmartHomeDashboard());

class SmartHomeDashboard extends StatefulWidget {
  const SmartHomeDashboard({Key? key}) : super(key: key);

  @override
  State<SmartHomeDashboard> createState() => _SmartHomeDashboardState();
}

class _SmartHomeDashboardState extends State<SmartHomeDashboard> {
  @override
  void initState() {
    //! PRECACHE IMAGES
    AppFunctionalUtils.precacheAppImages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theTheme,
        onGenerateRoute: AppNavigator.generateRoute,
        home: LayoutBuilder(
            builder: (context, constraints) => ScreenUtilInit(
                designSize: Size(constraints.maxWidth, constraints.maxHeight),
                builder: (context, widget) => const Wrapper())));
  }
}
