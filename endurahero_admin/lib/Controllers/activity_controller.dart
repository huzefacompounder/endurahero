import 'package:endurahero_admin/API/api_manager.dart';
import 'package:endurahero_admin/API/dio_api_manager.dart';
import 'package:endurahero_admin/Model/error_model.dart';
import 'package:endurahero_admin/Model/get_activity_reponse.dart';
import 'package:endurahero_admin/Repository/activity_repository.dart';
import 'package:endurahero_admin/Utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ActivityController extends GetxController {
  final activityRepository = ActivityRepository(APIManager(), DioAPIManager());
  TextEditingController activityName = TextEditingController();
  TextEditingController activityType = TextEditingController();
  TextEditingController timeStamp = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController route = TextEditingController();
  TextEditingController duration = TextEditingController();
  var activityData = <ActivityList>[].obs;

  var context = Get.context;

  Future allAcivity() async {
    GetActivityResponse activiyResponse =
        await activityRepository.getAllActivity();

    if (activiyResponse.status == 200) {
      activityData.value = activiyResponse.data!.activityList!;
    }
  }

  Future addActivity() async {
    ErrorModel activityResponse = await activityRepository.addActivityApi(
      activityType: activityName.text,
      distance: distance.text,
      duration: duration.text,
      // rewardId: "sfsff",
      // route: route.text,
      timestamp: timeStamp.text,
      // username: "userName",
    );

    if (activityResponse.status == 200) {
      allAcivity();
      activityType.clear();
      distance.clear();
      duration.clear();
      timeStamp.clear();
      successSnackBar(message: activityResponse.message!);
    }
  }

  Future checkValidationForAddActivityDetails() async {
    if (activityType.text.isEmpty) {
      errorSnackBar(message: "Please enter activity type");
    } else if (distance.text.isEmpty) {
      errorSnackBar(
        message: "Please enter distance",
      );
    } else if (duration.text.isEmpty) {
      errorSnackBar(
        message: "Please set duration of the activity",
      );
    } else if (timeStamp.text.isEmpty) {
      errorSnackBar(
        message: "Please set Timestap",
      );
    } else {
      await addActivity();
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
