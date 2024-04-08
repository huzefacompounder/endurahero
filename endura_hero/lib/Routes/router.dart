import 'package:endura_hero/Authentication/login_screen.dart';
import 'package:endura_hero/Authentication/otp_verification.dart';
import 'package:endura_hero/Authentication/register_view.dart';
import 'package:endura_hero/Bottom_navbar/landing_screen.dart';
import 'package:endura_hero/DashBorard/edit_profile.dart';
import 'package:endura_hero/DashBorard/home.dart';
import 'package:endura_hero/Onboarding/splash.dart';
import 'package:endura_hero/Routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const OTPVarificationScreen(),
    ),
    GetPage(
      name: Routes.landingScreen,
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const RegistrationScreen(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfilePage(),
    )
  ];
}
