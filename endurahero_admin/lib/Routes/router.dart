import 'package:endurahero_admin/API/Onboarding/splash.dart';
import 'package:endurahero_admin/Routes/routes.dart';
import 'package:endurahero_admin/Screen/add_activity.dart';
import 'package:endurahero_admin/Screen/home.dart';
import 'package:endurahero_admin/Screen/login.dart';
import 'package:endurahero_admin/Screen/register.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.registerScreen,
      page: () => const RegistrationScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.addActivity,
      page: () => const AddActivity(),
    ),
  ];
}
