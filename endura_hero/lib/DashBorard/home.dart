import 'package:endura_hero/Controllers/activity_controller.dart';
import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/DashBorard/joint_contest_map.dart';
import 'package:endura_hero/Widgets/activity_widget.dart';
import 'package:endura_hero/Widgets/daily_activity.dart';
import 'package:endura_hero/Widgets/joined_quest.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../application/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());
  ActivityController activityController = Get.put(ActivityController());
  @override
  void initState() {
    super.initState();
    authController.getProfileData();
    authController.setInitialData();
    activityController.allAcivity();
    activityController.allUserPostedAcivity();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white24,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Const.kWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "Hello, ",
                                    style: Const.medium.copyWith(
                                        color: Const.kBlack,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: getUserName(),
                                    style: Const.medium.copyWith(
                                        color: Const.kBlueShade1,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => CircleAvatar(
                              child: ClipOval(
                                  child: authController.currentUserData.value
                                              .profileImage ==
                                          null
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : CustomCachedNetworkImage(
                                          imageUrl:
                                              '$developmentUrl/uploads/${authController.currentUserData.value.profileImage!}',
                                        )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            authController.index.value = 1;
                          },
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                gradient: LinearGradient(
                                    colors: [
                                      authController.index.value == 1
                                          ? Const.kBlueShade1
                                          : Const.kWhite,
                                      authController.index.value == 1
                                          ? Colors.blue.shade400
                                          : Const.kWhite,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(1.5.h),
                                    bottomLeft: Radius.circular(1.5.h))),
                            child: Center(
                              child: Text("My Activity",
                                  style: Const.medium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: authController.index.value == 1
                                          ? Const.kWhite
                                          : Const.kBlack)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            authController.index.value = 2;
                          },
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      authController.index.value == 2
                                          ? Const.kBlueShade1
                                          : Const.kWhite,
                                      authController.index.value == 2
                                          ? Colors.blue.shade400
                                          : Const.kWhite,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(1.5.h),
                                    topRight: Radius.circular(1.5.h))),
                            child: Center(
                              child: Text("Following Activity",
                                  style: Const.medium.copyWith(
                                      color: authController.index.value == 2
                                          ? Const.kWhite
                                          : Const.kBlack,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                authController.index.value == 1
                    ? Column(
                        children: [
                          DailyActivity(),
                          activityController.activityData.isEmpty
                              ? SizedBox(
                                  height: 20.h,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("No Activity",
                                        style: Const.bold
                                            .copyWith(color: Colors.grey)),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      activityController.activityData.length,
                                  itemBuilder: (context, index) =>
                                      JoinedQuestWidget(
                                    onTapPendingButton: () {
                                      Get.to(JointContestMapScreen(
                                        distance: activityController
                                            .activityData[index].distance!
                                            .toDouble(),
                                        duration: activityController
                                            .activityData[index].duration,
                                      ));
                                    },
                                    date: DateFormat('dd - MMM').format(
                                        DateTime.parse(activityController
                                            .activityData[index].createdAt!
                                            .toString())),
                                    distance: activityController
                                        .activityData[index].distance
                                        .toString(),
                                    duration: activityController
                                        .activityData[index].duration,
                                    subTitle: activityController
                                        .activityData[index].activityType,
                                    title: activityController
                                        .activityData[index].activityType,
                                  ),
                                ),
                        ],
                      )
                    : activityController.userPostedActivityData.isEmpty
                        ? SizedBox(
                            height: 20.h,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("No Activity",
                                  style:
                                      Const.bold.copyWith(color: Colors.grey)),
                            ),
                          )
                        : const ActivityWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
