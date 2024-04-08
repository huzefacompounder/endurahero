import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RunningApp extends StatefulWidget {
  const RunningApp({super.key});

  @override
  RunningAppState createState() => RunningAppState();
}

class RunningAppState extends State<RunningApp> {
  GoogleMapController? controller;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  String _distance = '';
  String _duration = '';
  final Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Running App'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                controller = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 15,
              ),
              onTap: (LatLng latLng) {
                _updateMarker(latLng);
              },
              polylines: _polylines,
              markers: {
                if (_currentLocation != null)
                  Marker(
                    markerId: const MarkerId("Current Location"),
                    position: _currentLocation!,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                if (_destinationLocation != null)
                  Marker(
                    markerId: const MarkerId("Destination"),
                    position: _destinationLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(120),
                  ),
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                child: const Text('Get Current Location'),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  _calculateDistanceAndDuration();
                },
                child: const Text('Calculate Distance & Duration'),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 20,
              child: Column(
                children: [
                  Text('Distance: $_distance'),
                  Text('Duration: $_duration'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateMarker(LatLng latLng) {
    setState(() {
      if (_currentLocation == null) {
        _currentLocation = latLng;
      } else {
        _destinationLocation = latLng;
      }
    });
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _calculateDistanceAndDuration() async {
    if (_currentLocation != null && _destinationLocation != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCrL3gVikleoBf549g0DZWMKK_YN-rY-_U",
        PointLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
        PointLatLng(
            _destinationLocation!.latitude, _destinationLocation!.longitude),
      );

      List<LatLng> polylineCoordinates = result.points.map((PointLatLng point) {
        return LatLng(point.latitude, point.longitude);
      }).toList();

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route1'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 3,
        ));
      });

      double distanceInMeters = Geolocator.distanceBetween(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        _destinationLocation!.latitude,
        _destinationLocation!.longitude,
      );

      setState(() {
        _distance = '${(distanceInMeters / 1000).toStringAsFixed(2)} km';
        // Assuming average running speed of 10 km/h
        double durationInHours = distanceInMeters / 1000 / 10;
        int hours = durationInHours.toInt();
        int minutes = ((durationInHours - hours) * 60).toInt();
        _duration = '$hours hours $minutes minutes';
      });
    }
  }
}

void main() {
  runApp(const RunningApp());
}
