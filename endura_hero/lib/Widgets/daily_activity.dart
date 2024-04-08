import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class DailyActivity extends StatefulWidget {
  String? completeKm = "10KM";
  String? unreachedKm = "3KM";
  String? rewards = "3";
  DailyActivity({super.key, this.unreachedKm, this.completeKm, this.rewards});

  @override
  State<DailyActivity> createState() => _DailyActivityState();
}

class _DailyActivityState extends State<DailyActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.black,
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              3.h,
            ),
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Const.kBlueShade1,
              Colors.blue.shade400,
            ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Daily Activity",
                  style: Const.medium.copyWith(fontSize: 2.0.h),
                ),
              ),
              const Divider(
                color: Const.kWhite,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 15.h,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Biking",
                            style: Const.bold.copyWith(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Completed", style: Const.small),
                                    Text(
                                        widget.unreachedKm == null
                                            ? "0"
                                            : widget.unreachedKm.toString(),
                                        style: Const.bold
                                            .copyWith(fontSize: 1.5.h)),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                                Column(
                                  children: [
                                    Text("Unreached", style: Const.small),
                                    Text(
                                        widget.unreachedKm == null
                                            ? "0"
                                            : widget.unreachedKm.toString(),
                                        style: Const.bold
                                            .copyWith(fontSize: 1.5.h)),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                                Column(
                                  children: [
                                    Text("Rewards", style: Const.small),
                                    Text(
                                        widget.unreachedKm == null
                                            ? "0"
                                            : widget.unreachedKm.toString(),
                                        style: Const.bold
                                            .copyWith(fontSize: 1.5.h)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 13.0,
                        animation: true,
                        animationDuration: 3000,
                        percent: 0.52,
                        animateFromLastPercent: true,
                        center: const Text(
                          "52.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Const.kWhite,
                              fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Const.kBlueShade1,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
