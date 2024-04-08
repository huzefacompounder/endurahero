import 'package:endurahero_admin/Controllers/authentication_controller.dart';
import 'package:endurahero_admin/Resources/constants.dart';
import 'package:endurahero_admin/Resources/strings.dart';
import 'package:endurahero_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AuthController authController = Get.put(AuthController());

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(AppString.pattern);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(AppString.gettingStarted, style: Const.bold),
                SizedBox(height: 1.h),
                Text(
                  AppString.createAnAccountToContinue,
                  style: Const.medium,
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                    controller: authController.registerLoginName,
                    hintText: AppString.username,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.userNameCannotBeEmpty;
                      }
                      return null;
                    }),
                SizedBox(height: 2.h),
                CustomTextField(
                    controller: authController.registerLoginEmail,
                    hintText: AppString.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.emailCannotBeEmpty;
                      } else if (!regex.hasMatch(value)) {
                        return AppString.enterAValidEmail;
                      }
                      return null;
                    }),
                SizedBox(height: 2.h),
                CustomTextField(
                    controller: authController.registerLoginPassword,
                    hintText: AppString.password,
                    obscureText: isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: isPasswordVisible
                        ? Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Assets.images.svg.notVisible
                                .svg(color: Const.kWhite),
                          )
                        : Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Assets.images.svg.visible
                                .svg(color: Const.kWhite),
                          ),
                    suffixOnPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.passwordCannotBeEmpty;
                      }
                      return null;
                    }),
                SizedBox(height: 2.h),
                SizedBox(height: 5.h),
                CustomButton(
                  onTap: () async {
                    authController.checkValidationForRegisterDetails();
                  },
                  title: AppString.register,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.alreadyHaveAnAccount,
                      style: Const.small,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(Routes.login);
                      },
                      child: Text(
                        AppString.signIn,
                        style: Const.small.copyWith(
                          color: Const.kBlueShade1,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
