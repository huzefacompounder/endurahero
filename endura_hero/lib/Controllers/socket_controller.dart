import 'dart:async';
import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/Controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocketController extends GetxController {
  var socketId = ''.obs;
  MapController mapController = Get.put(MapController());
  var isAPICalledCurrency = false.obs;
  var riderDistanceFromPickupPoint = 0.obs;
  RxDouble estimatedArrivalTime = 0.0.obs;
  final _socketResponse = StreamController<Map<String, dynamic>>();
  var messageSendController = TextEditingController();
  void Function(Map<String, dynamic>) get sendMessageResponse =>
      _socketResponse.sink.add;
  var scrollController = ScrollController().obs;
  var supporterObjectId = ''.obs;
  var nameOfSupporter = ''.obs;
  var emailOfSupporter = ''.obs;
  var api = APIManager();
  Stream<Map<String, dynamic>> get receiveMessageResponse =>
      _socketResponse.stream;
}
