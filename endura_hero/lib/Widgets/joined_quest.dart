import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class JoinedQuestWidget extends StatefulWidget {
  String? title;
  String? subTitle;
  int? duration;
  String? distance;
  String? date;
  Function()? onTapPendingButton;
  JoinedQuestWidget(
      {super.key,
      this.subTitle,
      this.title,
      this.distance,
      this.duration,
      this.onTapPendingButton,
      this.date});

  @override
  State<JoinedQuestWidget> createState() => _JoinedQuestWidgetState();
}

class _JoinedQuestWidgetState extends State<JoinedQuestWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              3.h,
            ),
          ),
        ),
        child: Material(
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
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Join Activity",
                      style: Const.medium.copyWith(
                          fontSize: 2.0.h,
                          color: Const.kBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      widget.date.toString(),
                      style: Const.medium.copyWith(
                          fontSize: 1.5.h,
                          color: Const.kBlueShade1,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8.w)
                  ],
                ),
              ),
              const Divider(
                color: Const.kBlack,
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 8.h,
                        width: 7.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/png/walkingImage.png")),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title!,
                            style: Const.small.copyWith(
                                color: Const.kBlack,
                                fontWeight: FontWeight.w600)),
                        Text(
                          "Walk Total Of ${widget.distance} Kilometers",
                          style: Const.small.copyWith(
                              color: Const.kBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 1.3.h),
                        ),
                        Text(
                          "Walk Duration ${widget.duration} min",
                          style: Const.small.copyWith(
                              color: Const.kBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 1.3.h),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 5.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.5.h)),
                      child: Center(
                        child: Text("Cancle",
                            style: Const.small.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          gradient: LinearGradient(
                              colors: [
                                Const.kBlueShade1,
                                Colors.blue.shade400,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(0.5.h)),
                      child: GestureDetector(
                        onTap: widget.onTapPendingButton!,
                        child: Center(
                          child: Text("Join",
                              style: Const.small
                                  .copyWith(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
