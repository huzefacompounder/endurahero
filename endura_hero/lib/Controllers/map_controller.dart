import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:endura_hero/Widgets/custom_dialog.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class MapController extends GetxController {
  var cameraPosition = const CameraPosition(target: LatLng(0.123, 0.123)).obs;
  var currentLocLng = 0.123.obs;
  var currentLocLat = 0.123.obs;
  LocationPermission? locationPermission;
  List<PointLatLng> polyLines = <PointLatLng>[].obs;
  final client = Client();
  List<Marker> allMarkers = <Marker>[].obs;
  StreamSubscription<Position>? positionSubscription;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
 @override
  void onInit() {
    checkLocationPermission();
    super.onInit();
  }
  @override
  void onClose() async {
    positionSubscription?.cancel();
    customInfoWindowController.dispose();
  }
  checkLocationPermission() async {
    bool serviceEnabled;

    // check when device's location services on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Get.dialog(
        permissionDialog(
            onTap: () async {
              Get.back();
              await Geolocator.openLocationSettings();
            },
            title:
                "Please turn on GPS service of this device for live location detection."),
        barrierDismissible: false,
      );
    }

    // check when app has location permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      }
    }

    // check when location permission denied forever
    if (locationPermission == LocationPermission.deniedForever) {
      return Get.dialog(
        permissionDialog(
          onTap: () async {
            Get.back();
            await Geolocator.openAppSettings();
          },
          title:
              "Allow Towing Driver App to access this device's location for assigning nearby trips.",
        ),
        barrierDismissible: false,
      );
    }
  }

  permissionDialog({String? title, Function()? onTap}) {
    return CustomDialog(
      title: "Location Permission",
      isShowClosebutton: false,
      children: [
        SizedBox(height: 1.h),
        SizedBox(height: 1.h),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 12.0.sp,
          ),
        ),
        SizedBox(height: 2.h),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 5.0.h,
            width: 60.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Const.kBlueShade1,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                "Open Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
