import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dashboard/screens/wrapper/wrapper.dart';
import 'package:smart_home_dashboard/theme/theme.dart';

void main() => runApp(const SmartHomeDashboard());

class SmartHomeDashboard extends StatelessWidget {
  const SmartHomeDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theTheme,
        home: LayoutBuilder(
            builder: (context, constraints) => ScreenUtilInit(
                designSize: Size(constraints.maxWidth, constraints.maxHeight),
                builder: (context, widget) => const Wrapper())));
  }
}
