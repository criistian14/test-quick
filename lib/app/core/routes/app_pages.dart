import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/chat/chat_binding.dart';
import 'package:testquick/app/presentation/pages/chat/chat_page.dart';
import 'package:testquick/app/presentation/pages/edit_profile/edit_profile_binding.dart';
import 'package:testquick/app/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:testquick/app/presentation/pages/home/home_binding.dart';
import 'package:testquick/app/presentation/pages/home/home_page.dart';
import 'package:testquick/app/presentation/pages/sign_in/sign_in_binding.dart';
import 'package:testquick/app/presentation/pages/sign_in/sign_in_page.dart';
import 'package:testquick/app/presentation/pages/splash/splash_binding.dart';
import 'package:testquick/app/presentation/pages/splash/splash_page.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
  ];
}
