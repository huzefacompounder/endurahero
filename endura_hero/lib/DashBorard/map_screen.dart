import 'dart:async';
import 'dart:math';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/Controllers/activity_controller.dart';
import 'package:endura_hero/Controllers/map_controller.dart';
import 'package:endura_hero/Controllers/socket_controller.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? controller;
  String distance = '';
  int duration = 0;
  MapController mapController = Get.put(MapController());
  SocketController socketController = Get.put(SocketController());
  ActivityController activityController = Get.put(ActivityController());
  LatLng? currentLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  List<LatLng> polylinePoints = [];
  Position? currentPosition;
  bool isTimerRunning = false;
  late Timer timer;
  int durationInSeconds = 0;

  @override
  void initState() {
    super.initState();

    authController.getProfileData();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      updatePolyline();
    });
    _getCurrentLocation();
  }

  String formatDuration(int durationInSeconds) {
    Duration duration = Duration(seconds: durationInSeconds);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void pauseTimer() {
    if (timer.isActive) {
      timer.cancel();
      setState(() {
        isTimerRunning = false;
      });
    }
  }

  void toggleTimer() {
    if (isTimerRunning) {
      pauseTimer();
    } else {
      startTimer();
      setState(() {
        isTimerRunning = true;
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (durationInSeconds == 0) {
        timer.cancel();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Timer Ended'),
              content: const Text('The countdown timer has ended.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          durationInSeconds--;
        });
      }
    });
  }

  void updatePolyline() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = newPosition;
      polylinePoints.add(LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ));
    });

    controller!.animateCamera(CameraUpdate.newLatLng(
      LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
    ));
  }

  void _updateMarker(LatLng latLng) {
    setState(() {
      if (currentLocation == null) {
        currentLocation = latLng;
      } else {
        destinationLocation = latLng;
      }
    });
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _calculateDistanceAndDuration() async {
    if (currentLocation != null && destinationLocation != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCrL3gVikleoBf549g0DZWMKK_YN-rY-_U",
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        PointLatLng(
            destinationLocation!.latitude, destinationLocation!.longitude),
      );
      log(result.points.length);
      List<LatLng> polylineCoordinates = result.points.map((PointLatLng point) {
        return LatLng(point.latitude, point.longitude);
      }).toList();

      setState(() {
        polylines.add(Polyline(
          polylineId: const PolylineId('route1'),
          points: polylineCoordinates,
          color: Colors.green,
          width: 8,
        ));
      });

      double distanceInMeters = Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        destinationLocation!.latitude,
        destinationLocation!.longitude,
      );

      setState(() {
        distance = (distanceInMeters / 1000).toStringAsFixed(2);
        double durationInHours = distanceInMeters / 1000 / 10;
        int hours = durationInHours.toInt();
        int minutes = ((durationInHours - hours) * 60).toInt();
        duration = minutes * 60;
        durationInSeconds = duration;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatDuration(durationInSeconds);

    return Scaffold(
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                )
              : RepaintBoundary(
                  key: activityController.containerKey,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      controller = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation!.latitude,
                          currentLocation!
                              .longitude), // Initial position, can be changed
                      zoom: 15,
                    ),
                    onTap: (LatLng latLng) {
                      _updateMarker(latLng);
                      _calculateDistanceAndDuration();
                    },
                    polylines: polylines,
                    markers: {
                      if (currentLocation != null)
                        Marker(
                          markerId: const MarkerId("Current Location"),
                          position: currentLocation!,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                      if (destinationLocation != null)
                        Marker(
                          markerId: const MarkerId("Destination"),
                          position: destinationLocation!,
                          icon: BitmapDescriptor.defaultMarkerWithHue(120),
                        ),
                    },
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 6.h,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          child: ClipOval(
                              child: authController
                                          .currentUserData.value.profileImage ==
                                      null
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomCachedNetworkImage(
                                      imageUrl:
                                          '$developmentUrl/uploads/${authController.currentUserData.value.profileImage!}',
                                    )),
                        ),
                      ),
                      Text(
                        "Set Direction",
                        style: Const.bold.copyWith(color: Const.kBlueShade1),
                      ),
                      const SizedBox(),
                    ],
                  )),
              BlurryContainer(
                blur: 10,
                height: 42.h,
                width: double.infinity,
                elevation: 0,
                color: Colors.transparent,
                padding: const EdgeInsets.all(12),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(distance.isEmpty ? "0 km" : '$distance km',
                            style: Const.bold.copyWith(
                                color: Const.kBlueShade1, fontSize: 25.5.sp)),
                        GestureDetector(
                          onTap: () {
                            activityController.captureAndDisplay();
                            var duration = durationInSeconds / 60;
                            activityController.durationVal.value =
                                duration.toInt();
                            print(
                                'Duration:::::::::::::::[${activityController.durationVal.value}]');
                            activityController.distanceVal.value =
                                double.parse(distance);
                          },
                          child: const CircleAvatar(
                            radius: 26,
                            backgroundColor: Const.kBlueShade1,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.send),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(formattedTime,
                                    style: Const.bold
                                        .copyWith(color: Const.kBlack)),
                                Text("Time",
                                    style: Const.bold
                                        .copyWith(color: Const.kBlack)),
                              ],
                            ),
                            SizedBox(
                              width: 6.h,
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 3,
                            ),
                            SizedBox(
                              width: 2.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  "0:00",
                                  style:
                                      Const.bold.copyWith(color: Const.kBlack),
                                ),
                                Text("Avg pace",
                                    style: Const.bold
                                        .copyWith(color: Const.kBlack)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        toggleTimer();
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Const.kBlueShade1,
                        child: Icon(
                            isTimerRunning ? Icons.pause : Icons.play_arrow,
                            color: Const.kWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
