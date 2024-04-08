// ignore_for_file: deprecated_member_use_from_same_package

import 'package:endurahero_admin/Controllers/authentication_controller.dart';
import 'package:endurahero_admin/Resources/constants.dart';
import 'package:endurahero_admin/Resources/strings.dart';
import 'package:endurahero_admin/Routes/routes.dart';
import 'package:endurahero_admin/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  bool isPasswordVisible = true;
  GlobalKey<FormState> loginFormKey1 = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(AppString.pattern);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Form(
              key: loginFormKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(height: 2.h),
                  Text(AppString.letsSignYouIn, style: Const.bold),
                  SizedBox(height: 1.h),
                  Text(
                    AppString.welcomeBackYouveBeenMissed,
                    style: Const.medium,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                      controller: authController.loginEmail,
                      hintText: AppString.enterYourEmail,
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
                      controller: authController.loginPassword,
                      hintText: AppString.enterYourPassword,
                      obscureText: isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: isPasswordVisible
                          ? Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: Assets.images.svg.notVisible.svg(
                                color: Const.kWhite,
                              ),
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
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(() => const EmailVarificationScreen());
                      },
                      child: Text(
                        AppString.forgotYourPassword,
                        style: Const.small,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomButton(
                    onTap: () async {
                      // final FormState? form = loginFormKey.currentState;
                      // if (loginFormKey1.currentState!.validate()) {

                      // }

                      authController.checkValidationForLoginDetails();
                    },
                    title: AppString.login,
                    backgroundColor: Const.kBlueShade1,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppString.dontHaveAnAccount, style: Const.small),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.registerScreen);

                        },
                        child: Text(
                          AppString.signUp,
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
      ),
    );
  }
}
