import 'package:endurahero_admin/Controllers/activity_controller.dart';
import 'package:endurahero_admin/Resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  ActivityController activityController = Get.put(ActivityController());

  @override
  void initState() {
    super.initState();
    activityController.allAcivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionIcon: Icons.refresh,
        title: "Activity",
        leadingIcon: Icons.arrow_back_ios_outlined,
        leadingOnTap: () {
          GetStorage().erase();
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Activity",
                        style: Const.small.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.0.h,
                        ),
                      ),
                      Text(
                        "View Activity",
                        style: Const.small.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.0.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextField(
                    controller: activityController.activityType,
                    hintText: "Activity Type",
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextField(
                    readOnly: true,
                    onTap: () {
                      activityController.startDatePicker(context);
                    },
                    controller: activityController.timeStamp,
                    hintText: "Timestamp",
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextField(
                    controller: activityController.distance,
                    hintText: "Distance",
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextField(
                    controller: activityController.duration,
                    hintText: "Duration",
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CustomButton(
                      hight: 0.8.h,
                      onTap: () {
                        activityController
                            .checkValidationForAddActivityDetails();
                      },
                      title: "Add Activity"),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Text("All Activity",
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 2.8.h)),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  activityController.activityData.isEmpty
                      ? const Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: activityController.activityData.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Const.kWhite, width: 5),
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  child: Text(index.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 1.8.h)),
                                ),
                                Text(
                                    "Activity Type : ${activityController.activityData[index].activityType! == " " ? "-" : activityController.activityData[index].activityType!}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.8.h)),
                                Text(
                                    "Distance : ${activityController.activityData[index].distance! == " " ? "-" : activityController.activityData[index].distance!.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.8.h)),
                                Text(
                                    "Duration : ${activityController.activityData[index].duration! == " " ? "-" : activityController.activityData[index].duration!}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.8.h)),
                                Text(
                                    "Created Date : ${activityController.activityData[index].createdAt! == " " ? "-" : DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(activityController
                                            .activityData[index].createdAt!
                                            .toString()),
                                      )}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.8.h)),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
