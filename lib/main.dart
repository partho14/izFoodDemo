import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_foodhub/localization/languages.dart';
import 'package:my_foodhub/pages/SplashScreen.dart';
import 'package:my_foodhub/utilities/bindings.dart';
import 'package:my_foodhub/utilities/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    OrientationBuilder(
      builder: (context, orientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return GetMaterialApp(
          initialBinding: InitialBindings(),
          title: 'FoodHub',
          translations: Languages(),
          locale: Locale('bn','BN'),
          fallbackLocale: Locale('en','EN'),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(context),
          home: SplashScreen(),
        );
      },
    );
  }
}



