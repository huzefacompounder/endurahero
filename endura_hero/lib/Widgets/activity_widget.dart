import 'package:endura_hero/Controllers/activity_controller.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/timezone.dart' as tz;

class ActivityWidget extends StatefulWidget {
  const ActivityWidget({super.key});

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  ActivityController activityController = Get.put(ActivityController());
  @override
  void initState() {
    activityController.allUserPostedAcivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activityController.userPostedActivityData.length,
      itemBuilder: (context, index) {
        String isoDateString =
            activityController.userPostedActivityData[index].createdAt!;
        DateTime dateTime = DateTime.parse(isoDateString);
        String timeZoneId = "Asia/Kolkata";
        var istTimeZone = tz.getLocation(timeZoneId);

        // Convert the datetime to IST timezone
        var istDateTime = tz.TZDateTime.from(dateTime, istTimeZone);

        // Format the datetime as a string in IST timezone
        var formatter = DateFormat('dd-MMMM-yyyy');
        String formatedDate = formatter.format(istDateTime);
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Const.kBlueShade1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedNetworkImage(
                        imageUrl:
                            "$developmentUrl/uploads/${activityController.userPostedActivityData[index].profileImage}",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activityController.userPostedActivityData[index]
                            .username!.capitalizeFirst
                            .toString(),
                        style: Const.medium.copyWith(
                            color: Const.kBlueShade1,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        formatedDate,
                        style: Const.small.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert_rounded),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                activityController.userPostedActivityData[index].description
                    .toString(),
                style: Const.small
                    .copyWith(color: Const.kBlack, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.social_distance),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Distance",
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                          Text(
                            "${activityController.userPostedActivityData[index].distance.toString()} KM",
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.timer),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duration",
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                          Text(
                            "${activityController.userPostedActivityData[index].duration.toString()} Min",
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.run_circle),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Activity Type",
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                          Text(
                            activityController
                                .userPostedActivityData[index].activityType
                                .toString(),
                            style: Const.bold
                                .copyWith(color: Const.kBlack, fontSize: 1.5.h),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  height: 28.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Const.kBlueShade1, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: activityController
                          .userPostedActivityData[index].route!.isEmpty
                      ? Image.asset("assets/images/png/set_wallpaper_done.png")
                      : GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                child: SizedBox(
                                  height: 60.h,
                                  child: PinchZoom(
                                    zoomEnabled: true,
                                    maxScale: 3.5,
                                    onZoomStart: () {},
                                    onZoomEnd: () {},
                                    child: CustomCachedNetworkImage(
                                      imageUrl:
                                          "$developmentUrl/uploads/${activityController.userPostedActivityData[index].route![0]}",
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CustomCachedNetworkImage(
                            imageUrl:
                                "$developmentUrl/uploads/${activityController.userPostedActivityData[index].route![0]}",
                          ),
                        )),
              SizedBox(
                height: 2.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 10.h,
              //       width: 10.h,
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 2, color: Const.kBlueShade1),
              //         borderRadius: BorderRadius.circular(5),
              //         image: const DecorationImage(
              //             fit: BoxFit.cover,
              //             image: AssetImage(
              //                 "assets/images/png/Screenshot 2024-03-01 143834.png")),
              //       ),
              //     ),
              //     Container(
              //       height: 10.h,
              //       width: 10.h,
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 2, color: Const.kBlueShade1),
              //         borderRadius: BorderRadius.circular(5),
              //         image: const DecorationImage(
              //             fit: BoxFit.cover,
              //             image: AssetImage(
              //                 "assets/images/png/Screenshot 2024-03-01 143834.png")),
              //       ),
              //     ),
              //     Container(
              //       height: 10.h,
              //       width: 10.h,
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 2, color: Const.kBlueShade1),
              //         borderRadius: BorderRadius.circular(5),
              //         image: const DecorationImage(
              //             fit: BoxFit.cover,
              //             image: AssetImage(
              //                 "assets/images/png/Screenshot 2024-03-01 143834.png")),
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "630 Likes",
                    style: Const.small.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  const Icon(
                    Icons.comment,
                    color: Const.kBlueShade1,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "30 Comments",
                    style: Const.small.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
