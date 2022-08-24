import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_home_dashboard/models/device_model.dart';
import 'package:smart_home_dashboard/models/user_model.dart';
import 'package:smart_home_dashboard/router/router.dart';
import 'package:smart_home_dashboard/screens/wrapper/wrapper.dart';
import 'package:smart_home_dashboard/theme/theme.dart';
import 'package:smart_home_dashboard/utils/app_functional_utils.dart';
import 'package:path_provider/path_provider.dart' as _pathProvider;

Future<void> main() async {
  //! INITIALIZE WIDGETS BINDING
  WidgetsFlutterBinding.ensureInitialized();

  //! FETCH THE APP DOCUMENT PATH.
  final _appDocumentDirectory =
      await _pathProvider.getApplicationDocumentsDirectory();

  //! INITIALIZE DB
  Hive.init(_appDocumentDirectory.path);

  //! INITIALIZE ADAPTERS
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(DeviceModelAdapter());

  //! RUN APP
  runApp(ProviderScope(child: const SmartHomeDashboard()));
}

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
