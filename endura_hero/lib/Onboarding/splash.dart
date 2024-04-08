import 'dart:async';
import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/Routes/routes.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/application/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  initState() {
    Timer(
      const Duration(seconds: 3),
      () async {
        initPage();
      },
    );
    authController.getProfileData();
    authController.setInitialData();
    super.initState();
  }

  initPage() {
    var token = getAuthToken();
    if (token != "") {
      Get.offAllNamed(Routes.landingScreen);
    } else {
      Get.offAllNamed(Routes.login);  
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/png/endurahero_logo.png",
                height: 20.h, width: 20.h),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "EnuduraHero",
              style: Const.bold.copyWith(letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}
