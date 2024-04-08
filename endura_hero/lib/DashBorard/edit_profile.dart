import 'dart:io';

import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();

    authController.setInitialData();
  }

  @override
  void dispose() {
    super.dispose();
    authController.profileImagePath.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Const.kWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                        const Icon(Icons.arrow_back_ios,
                            color: Const.kBlueShade1),
                        Text(
                          "Edit Profile",
                          style: Const.bold.copyWith(color: Const.kBlueShade1),
                        ),
                        const SizedBox()
                      ],
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 12.h,
                                width: 12.h,
                                child: Stack(children: [
                                  Container(
                                    width: 17.0.h,
                                    height: 17.0.h,
                                    // padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Const.kBlueShade1,
                                          width: 0.5.h),
                                      color: Const.kWhite,
                                    ),
                                    child: ClipOval(
                                      child: authController
                                              .profileImagePath.value.isEmpty
                                          ? CustomCachedNetworkImage(
                                              imageUrl: authController
                                                          .currentUserData
                                                          .value
                                                          .profileImage ==
                                                      null
                                                  ? ''
                                                  : authController
                                                      .currentUserData
                                                      .value
                                                      .profileImage!,
                                            )
                                          : (authController.profileImagePath
                                                  .value.isNotEmpty)
                                              ? Image.file(
                                                  File(
                                                    authController
                                                        .profileImagePath.value,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/png/profileImage.png",
                                                ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // editProfileController.authController.getImageFromGallery(
                                      //   editProfileController.profileImagePath,
                                      // );
                                      authController.imageSourceSelectionDialog(
                                          path:
                                              authController.profileImagePath);
                                    },
                                    child: const Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Text(
                                authController.profileName.text,
                                style: TextStyle(
                                    fontSize: 2.5.h,
                                    fontWeight: FontWeight.w900,
                                    color: Const.kBlack),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 1.7.h,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              TextField(
                                controller: authController.profileName,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Const.kBlueShade1, width: 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.5.h,
                              ),
                              CustomButton(
                                width: 50.w,
                                onTap: () {
                                  authController.updateProfileAPI();
                                },
                                title: "Save",
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
