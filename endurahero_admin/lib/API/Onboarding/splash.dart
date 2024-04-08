import 'dart:async';

import 'package:endurahero_admin/Routes/routes.dart';
import 'package:endurahero_admin/Utils/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        getInitPage();
      },
    );
  }

  getInitPage() {
    var token = getAuthToken();

    if (token != "") {
      Get.offAllNamed(Routes.homeScreen);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "ENDURAHERO ADMIN",
          style: GoogleFonts.adventPro(
            color: Colors.amber,
            fontSize: 3.h,
          ),
        ),
      ),
    );
  }
}
