// ignore_for_file: deprecated_member_use_from_same_package
import 'package:endura_hero/DashBorard/home.dart';
import 'package:endura_hero/DashBorard/map_screen.dart';
import 'package:endura_hero/DashBorard/message.dart';
import 'package:endura_hero/DashBorard/profile.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int activeIndex = 0;
  List<Widget> screensList = [
    const HomeScreen(),
    const MapScreen(),
    // const MessageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Const.kWhite,
        extendBody: true,
        body: NavigationScreen(screensList[activeIndex]),
        bottomNavigationBar: Container(
          height: 8.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Const.kBlueShade1,
            // border: Border.all(color: Colors.deepPurple.shade600, width: 2),
            borderRadius: BorderRadius.circular(3.h),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = 0;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == 0 ? Const.kWhite : null),
                      child: Assets.images.svg.home.svg(
                          color: activeIndex == 0
                              ? Const.kBlueShade1
                              : Const.kWhite))),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = 1;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == 1 ? Const.kWhite : null),
                      child: Assets.images.svg.grid2.svg(
                          color: activeIndex == 1
                              ? Const.kBlueShade1
                              : Const.kWhite))),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       activeIndex = 2;
              //     });
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(2.w),
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: activeIndex == 2 ? Const.kWhite : null),
              //     child: Assets.images.svg.search.svg(
              //         color:
              //             activeIndex == 2 ? Const.kBlueShade1 : Const.kWhite),
              //   ),
              // ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = 2;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == 2 ? Const.kWhite : null),
                      child: Assets.images.svg.setting.svg(
                          color: activeIndex == 2
                              ? Const.kBlueShade1
                              : Const.kWhite))),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget currentPage;

  const NavigationScreen(this.currentPage, {super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.currentPage;
  }
}
