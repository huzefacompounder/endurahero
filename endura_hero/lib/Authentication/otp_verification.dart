import 'dart:async';
import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/application/strings.dart';
import 'package:endura_hero/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OTPVarificationScreen extends StatefulWidget {
  const OTPVarificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVarificationScreen> createState() => _OTPVarificationScreenState();
}

class _OTPVarificationScreenState extends State<OTPVarificationScreen> {
  AuthController authController = Get.put(AuthController());
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
  bool isShow = true;

  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  Future<void> resendCode() async {
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          isShow = true;
        });
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Form(
              key: forgotPassKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.otpVerification, style: Const.bold),
                  SizedBox(height: 1.h),
                  Text(AppString.otpVerificationDesc, style: Const.medium),
                  SizedBox(height: 4.h),
                  isShow
                      ? Align(
                          alignment: Alignment.center,
                          child: Assets.images.svg.otpVerification.svg(
                            height: 40.h,
                            width: 40.w,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 6.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: authController.txtEnterCodeController,
                      onTap: () {
                        setState(() {
                          isShow = false;
                        });
                      },
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      validator: (value) {
                        return value ==
                                authController.txtEnterCodeController.text
                            ? null
                            : '';
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      keyboardType: TextInputType.number,
                      focusedPinTheme: PinTheme(
                        width: 8.h,
                        height: 8.h,
                        textStyle: Const.medium,
                        decoration: BoxDecoration(
                          color: Const.kGreyShade1,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Const.kGreyShade1,
                          ),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 8.h,
                        height: 8.h,
                        textStyle: Const.medium,
                        decoration: BoxDecoration(
                          color: Const.kBackground,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Const.kGreyShade1,
                          ),
                        ),
                      ),
                      disabledPinTheme: PinTheme(
                        width: 8.h,
                        height: 8.h,
                        textStyle: Const.medium,
                        decoration: BoxDecoration(
                          color: Const.kGreyShade1,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Const.kGreyShade1,
                          ),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: 8.h,
                        height: 8.h,
                        textStyle: Const.medium,
                        decoration: BoxDecoration(
                          color: Const.kGreyShade1,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Const.kGreyShade1,
                          ),
                        ),
                      ),
                      errorPinTheme: PinTheme(
                        width: 8.h,
                        height: 8.h,
                        textStyle: Const.medium,
                        decoration: BoxDecoration(
                          color: Const.kBackground,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Const.kRed,
                          ),
                        ),
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.resendCodeAfter,
                        style: Const.small,
                      ),
                      Text(
                        secondsRemaining.toString(),
                        style: Const.small,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onTap: () {
                          enableResend ? resendCode() : null;
                        },
                        width: 0.43.w,
                        style: Const.buttonBorderStyle,
                        title: AppString.resend,
                        txtStyle: Const.small,
                      ),
                      CustomButton(
                        onTap: () {
                          var data = Get.arguments;
                          authController.otpAPI(data[0]);
                        },
                        title: AppString.confirm,
                        txtStyle: Const.small,
                        backgroundColor: Const.kBackground,
                      ),
                    ],
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
