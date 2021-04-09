import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/core/routes/app_pages.dart';
import 'app/core/theme/dark/dark_theme.dart';
import 'app/core/theme/light/app_theme.dart';
import 'app/presentation/pages/splash/splash_binding.dart';
import 'app/presentation/pages/splash/splash_page.dart';
import 'app/presentation/translations/app_translations.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: true,
      builder: () => GetMaterialApp(
        title: 'Test Quick SAS',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        darkTheme: darkTheme,
        home: SplashPage(),
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
        navigatorObservers: <NavigatorObserver>[
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        defaultTransition: Transition.cupertino,
        popGesture: true,
        translations: AppTranslations(),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('es', 'CO'),
        ],
      ),
    );
  }
}
