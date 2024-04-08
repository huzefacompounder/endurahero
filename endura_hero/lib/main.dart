import 'package:endura_hero/Routes/router.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tzdata;+

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  tzdata.initializeTimeZones();

  // await AppConfiguration.shared.init();

  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(const WallpaperUser());
}

class WallpaperUser extends StatefulWidget {
  const WallpaperUser({super.key});

  @override
  State<WallpaperUser> createState() => WallpaperUserState();
}

class WallpaperUserState extends State<WallpaperUser> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: Sizer(
        builder: (context, orientation, deivceType) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            builder: EasyLoading.init(),
            theme: ThemeData(scaffoldBackgroundColor: Const.kBlueShade1),
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            initialRoute: AppPages.initialRoute,
            // home: RunningApp(),
          ),
        ),
      ),
    );
  }
}
