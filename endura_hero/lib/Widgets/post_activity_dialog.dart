import 'package:endura_hero/Controllers/activity_controller.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class UserUploadDialog extends StatefulWidget {
  double? distance;
  int? duration;
  UserUploadDialog({super.key, this.distance, this.duration});
  @override
  State<UserUploadDialog> createState() => _UserUploadDialogState();
}

class _UserUploadDialogState extends State<UserUploadDialog> {
  ActivityController activityController = Get.put(ActivityController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Const.kBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Post Activity",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 2.2.h,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(
                color: Const.kWhite,
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Const.kWhite, width: 1),
                  ),
                  child: Image.memory(
                    activityController.capturedImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    "Discription",
                    style: TextStyle(
                      fontSize: 1.7.h,
                      fontWeight: FontWeight.bold,
                      color: Const.kWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              CustomTextField(
                controller: activityController.description,
                hintText: "Discription",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Text(
                    "Activity Type",
                    style: TextStyle(
                      fontSize: 1.7.h,
                      fontWeight: FontWeight.bold,
                      color: Const.kWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Const.kBlueShade1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            activityController.isActivityType.value = 1;
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              color:
                                  activityController.isActivityType.value != 1
                                      ? Const.kBlueShade1
                                      : Const.kWhite,
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/png/cycling.png")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            activityController.isActivityType.value = 2;
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              color:
                                  activityController.isActivityType.value != 2
                                      ? Const.kBlueShade1
                                      : Const.kWhite,
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/png/runner.png")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            activityController.isActivityType.value = 3;
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              color:
                                  activityController.isActivityType.value != 3
                                      ? Const.kBlueShade1
                                      : Const.kWhite,
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/png/walk.png")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomButton(
                onTap: () {
                  activityController.postActivity(
                      activityType: activityController.isActivityType.value == 1
                          ? "cycling"
                          : activityController.isActivityType.value == 2
                              ? "Running"
                              : activityController.isActivityType.value == 3
                                  ? "Walking"
                                  : "-",
                      distance: widget.distance,
                      duration: widget.duration);
                },
                title: "Post",
              )
            ],
          ),
        ),
      ),
    );
  }
}
