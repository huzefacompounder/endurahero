import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as d;
import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/API/dio_api_manager.dart';
import 'package:endura_hero/Model/get_activity_reponse.dart';
import 'package:endura_hero/Model/user_posted_activity.dart';
import 'package:endura_hero/Repository/activity_repository.dart';
import 'package:endura_hero/Widgets/post_activity_dialog.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/application/error_model.dart';
import 'package:endura_hero/application/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class ActivityController extends GetxController {
  final activityRepository = ActivityRepository(APIManager(), DioAPIManager());
  TextEditingController activityName = TextEditingController();
  TextEditingController activityType = TextEditingController();
  TextEditingController timeStamp = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController route = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  var activityData = <ActivityList>[].obs;
  var userPostedActivityData = <UserPostedActivityList>[].obs;
  GlobalKey containerKey = GlobalKey();
  Uint8List? capturedImage;
  RxInt isActivityType = 1.obs;
  var context = Get.context;
  RxInt durationVal = 0.obs;
  RxDouble distanceVal = 0.0.obs;
  Future<Uint8List?> captureContainer() async {
    try {
      RenderRepaintBoundary boundary = containerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  void captureAndDisplay() async {
    Uint8List? imageBytes = await captureContainer();
    if (imageBytes != null) {
      capturedImage = imageBytes;
      Get.dialog(UserUploadDialog(
        distance: distanceVal.value,
        duration: durationVal.value,
      ));
    }
  }

  Future allAcivity() async {
    GetActivityResponse activiyResponse =
        await activityRepository.getAllActivity();

    if (activiyResponse.status == 200) {
      activityData.value = activiyResponse.data!.activityList!;
    }
  }

  Future allUserPostedAcivity() async {
    GetUserPostedActivityResponse userPostedActiviyResponse =
        await activityRepository.getUserPostedActivity();

    if (userPostedActiviyResponse.status == 200) {
      userPostedActivityData.value =
          userPostedActiviyResponse.data!.activityList!;
    }
  }

  postActivity(
      {required var distance,
      required var duration,
      required var activityType}) async {
    var userId = getUserId();
    var userName = getUserName();

    DateTime currentDate = DateTime.now();
    String formattedDate =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    img.Image image = img.decodeImage(capturedImage!)!;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/image.jpg');
    await file.writeAsBytes(img.encodeJpg(image));
    String savedFilePath = file.path;
    var data = d.FormData.fromMap(
      {
        "activityType": activityType,
        "duration": durationVal,
        "distance": distanceVal,
        "description": description.text,
        "timestamp": formattedDate,
        "username": userName,
        "userId": userId,
        "route": await d.MultipartFile.fromFile(
          savedFilePath.toString(),
          filename: savedFilePath.toString(),
          contentType: MediaType("image", "jpg"),
        ),
      },
    );

    d.Dio dio = d.Dio();
    d.Response response = await dio.post(
      '$developmentUrl/activity/AddActivity',
      data: data,
      options: d.Options(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
        },
      ),
    );
    ErrorModel getProfile = ErrorModel.fromJson(response.data);
    if (getProfile.status == 200) {
      Get.back();
      description.clear();
      successSnackBar(message: getProfile.message.toString());
    }
  }

  startDatePicker(context) async {
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData().copyWith(
            // colorScheme: ColorScheme.light(primary: ColorConstants.greenColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      timeStamp.text = formattedDate;
    } else {}
  }
}
