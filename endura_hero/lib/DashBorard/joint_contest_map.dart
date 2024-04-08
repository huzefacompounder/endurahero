import 'dart:async';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dio/dio.dart';
import 'package:endura_hero/Controllers/activity_controller.dart';
import 'package:endura_hero/Model/direction_model.dart';
import 'package:endura_hero/Repository/direction_repository.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class JointContestMapScreen extends StatefulWidget {
  int? duration;
  double? distance;
  JointContestMapScreen({super.key, this.duration, this.distance});

  @override
  State<JointContestMapScreen> createState() => _JointContestMapScreenState();
}

class _JointContestMapScreenState extends State<JointContestMapScreen> {
  ActivityController activityController = Get.put(ActivityController());
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  double distance = 10;
  String duration = '';
  late Timer timer;
  bool isTimerRunning = false;
  int durationInSeconds = 0;
  Marker? origin;
  Marker? destination;
  Directions? info;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    addMarker();
    durationInSeconds = widget.duration! * 60;
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
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
    mapController!.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (durationInSeconds == 0) {
        timer.cancel();
        // Add any actions you want to perform after the timer ends
        // For example, show an alert dialog
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

  void addMarker() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: currentLocation!,
      );
      destination = null;
      info = null;
    });

    destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position:
            _calculateDestination(currentLocation!, widget.distance! / 1.60),
        rotation: 1);

    // Get directions
    final directions = await DirectionsRepository(dio: Dio()).getDirections(
      origin: origin!.position,
      destination:
          _calculateDestination(currentLocation!, widget.distance! / 1.60),
    );
    setState(() => info = directions);
  }

  // LatLng generate10KmAway(LatLng currentLocation) {
  //   const double bearing = 0; // Initial bearing (north)
  //   const double radiusEarth = 6371.0; // Radius of the Earth in kilometers
  //   const double targetDistance = 10.0; // Target distance in kilometers

  //   double lat1 = currentLocation.latitude * (pi / 180); // Convert to radians
  //   double lon1 = currentLocation.longitude * (pi / 180); // Convert to radians

  //   double lat2 = asin(sin(lat1) * cos(targetDistance / radiusEarth) +
  //       cos(lat1) * sin(targetDistance / radiusEarth) * cos(bearing));
  //   double lon2 = lon1 +
  //       atan2(sin(bearing) * sin(targetDistance / radiusEarth) * cos(lat1),
  //           cos(targetDistance / radiusEarth) - sin(lat1) * sin(lat2));

  //   lat2 = lat2 * (180 / pi); // Convert back to degrees
  //   lon2 = lon2 * (180 / pi); // Convert back to degrees

  //   return LatLng(lat2, lon2);
  // }
  LatLng _calculateDestination(LatLng start, double distanceInKm) {
    // Simplified conversion factor for demonstration purposes
    // You may need a more accurate formula for real applications
    const double latFactor = 0.00904371733; // Approximately 1 km in latitude
    const double lngFactor = 0.01122374254; // Approximately 1 km in longitude

    return LatLng(
      start.latitude + (latFactor * distanceInKm),
      start.longitude + (lngFactor * distanceInKm),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatDuration(durationInSeconds);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Const.kWhite,
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
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            currentLocation!.latitude,
                            currentLocation!
                                .longitude), // Initial position, can be changed
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                        addMarker();
                      },
                      markers: {
                        if (origin != null) origin!,
                        if (destination != null) destination!
                      },
                      polylines: {
                        if (info != null)
                          Polyline(
                            polylineId: const PolylineId('overview_polyline'),
                            color: Colors.red,
                            width: 5,
                            points: info!.polylinePoints
                                .map((e) => LatLng(e.latitude, e.longitude))
                                .toList(),
                          ),
                      },
                    ),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlurryContainer(
                  blur: 10,
                  width: double.infinity,
                  elevation: 0,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(12),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(info == null ? "0 km" : info!.totalDistance,
                              style: Const.bold.copyWith(
                                  color: Const.kBlueShade1, fontSize: 25.5.sp)),
                          GestureDetector(
                            onTap: () {
                              var duration = durationInSeconds / 60;
                              activityController.durationVal.value =
                                  duration.toInt();
                              print(
                                  'Duration::::::::::::::::::::::::::::[${activityController.durationVal.value}]');
                              activityController.distanceVal.value =
                                  widget.distance!;
                              activityController.captureAndDisplay();
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
                                  // Text(
                                  //     widget.duration!.isEmpty
                                  //         ? "0:00:00"
                                  //         : widget.duration!,
                                  //     style: Const.bold
                                  //         .copyWith(color: Const.kBlack)),
                                  Text(
                                    formattedTime,
                                    style: Const.bold
                                        .copyWith(color: Const.kBlack),
                                  ),
                                  Text("Time",
                                      style: Const.bold
                                          .copyWith(color: Const.kBlack)),
                                ],
                              ),
                              SizedBox(
                                width: 2.h,
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
                                    style: Const.bold
                                        .copyWith(color: Const.kBlack),
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
                      SizedBox(
                        height: 2.h,
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
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
