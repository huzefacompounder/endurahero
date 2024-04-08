import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/Routes/routes.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    authController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.kWhite,
      body: Obx(
        () => Column(
          children: [
            Container(
                height: 6.h,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: Const.bold.copyWith(color: Const.kBlueShade1),
                    ),
                    Container(
                      width: 20.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Const.kBlueShade1,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "100 Coins",
                              style: Const.bold.copyWith(
                                  color: Const.kWhite, fontSize: 1.2.h),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 3.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 17.h,
                  width: 17.h,
                  child: Container(
                    width: 17.0.h,
                    height: 17.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff053C5E), width: 5),
                      color: Const.kWhite,
                    ),
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 12.0.h,
                          height: 12.0.h,
                          // padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // border: Border.all(color: AppColors.appColorGreen),
                          ),
                          child: ClipOval(
                              child: authController
                                          .currentUserData.value.profileImage ==
                                      null
                                  ? Center(
                                      child: SizedBox(
                                          height: 5.h,
                                          width: 5.h,
                                          child:
                                              const CircularProgressIndicator()))
                                  : CustomCachedNetworkImage(
                                      imageUrl:
                                          '$developmentUrl/uploads/${authController.currentUserData.value.profileImage!}',
                                    )),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     authController.imageSourceSelectionDialog(
                  //         path: authController.profileImagePath);
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: Container(
                  //       height: 5.h,
                  //       width: 5.h,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.white, width: 3),
                  //           color: Const.kBlueShade1,
                  //           shape: BoxShape.circle),
                  //       child: const Icon(Icons.edit, color: Colors.white),
                  //     ),
                  //   ),
                  // )
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  hight: 0.1.h,
                  width: 30.w,
                  onTap: () {
                    Get.toNamed(Routes.editProfile);
                  },
                  txtStyle: TextStyle(fontSize: 1.3.h, color: Colors.white),
                  title: "Edit Profile"),
            ),
            SizedBox(
              height: 3.h,
            ),
            profilefeed(
              heading: "Name",
              details: authController.currentUserData.value.username == null
                  ? "-"
                  : authController.currentUserData.value.username.toString(),
            ),
            SizedBox(
              height: 2.h,
            ),
            profilefeed(
              heading: "Email",
              details: authController.currentUserData.value.email == null
                  ? "-"
                  : authController.currentUserData.value.email.toString(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  onTap: () {
                    GetStorage().erase();
                    Get.offAllNamed(Routes.login);
                  },
                  title: "Logout"),
            )
          ],
        ),
      ),
    );
  }

  Widget profilefeed({required String heading, required String details}) {
    return Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12.0),
      // color: Colors.amber,
      height: 5.h,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                padding: EdgeInsets.only(left: 5.w),
                height: 5.h,
                // color: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      heading,
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            flex: 7,
            child: SizedBox(
              height: 5.h,
              // color: Colors.blue,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  details,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
