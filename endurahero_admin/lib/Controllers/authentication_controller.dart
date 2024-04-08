import 'dart:developer';

import 'package:endurahero_admin/API/api_manager.dart';
import 'package:endurahero_admin/API/dio_api_manager.dart';
import 'package:endurahero_admin/Model/login_register_response.dart';
import 'package:endurahero_admin/Repository/authentication_repository.dart';
import 'package:endurahero_admin/Routes/routes.dart';
import 'package:endurahero_admin/Utils/common_widget.dart';
import 'package:endurahero_admin/Utils/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final authenticationRepository =
      AuthenticationRepository(APIManager(), DioAPIManager());
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController registerLoginEmail = TextEditingController();
  TextEditingController registerLoginPassword = TextEditingController();
  TextEditingController registerLoginName = TextEditingController();
  RxBool isVisiblePassword = false.obs;
  // final ImagePicker imagePicker = ImagePicker();
  var context = Get.context;

  // Register User //

  Future registerUser() async {
    LoginAndRegisterResponse registrationResponse =
        await authenticationRepository.registrationApi(
            email: registerLoginEmail.text,
            name: registerLoginName.text,
            password: registerLoginPassword.text);

    if (registrationResponse.status == 200) {
      Get.offAllNamed(Routes.homeScreen);
      storeAuthToken(registrationResponse.data!.token!.toString());

      successSnackBar(message: registrationResponse.message!);
    } else {
      errorSnackBar(message: registrationResponse.message!);
    }
  }

  checkValidationForRegisterDetails() {
    if (registerLoginName.text.isEmpty) {
      errorSnackBar(
        message: "Please enter name.",
      );
    } else if (registerLoginEmail.text.isEmpty) {
      errorSnackBar(
        message: "Please enter email.",
      );
    } else if (registerLoginPassword.text.length < 4) {
      errorSnackBar(
        message: "Please enter password minimum 8 char.",
      );
    } else {
      registerUser();
    }
  }

  // Login  API6

  Future loginApi() async {
    LoginAndRegisterResponse loginModel = await authenticationRepository.login(
      email: loginEmail.text,
      password: loginPassword.text,
    );
    log("----------------->${loginModel.status}");
    if (loginModel.status == 200) {
      Get.offAndToNamed(Routes.homeScreen);
      successSnackBar(message: loginModel.message!);

      storeAuthToken(loginModel.data!.token!.toString());
      log("==============>");
      log("==============>");
    } else {
      errorSnackBar(message: loginModel.message!);
    }
  }

  Future checkValidationForLoginDetails() async {
    if (loginPassword.text.contains(" ")) {
      errorSnackBar(message: "Do not allow space in this fileds");
    } else if (loginEmail.text.isEmpty) {
      errorSnackBar(
        message: "Please enter valid email",
      );
    } else if (loginPassword.text.isEmpty) {
      errorSnackBar(
        message: "Please enter valid password",
      );
    } else if (loginPassword.text.length < 4) {
      errorSnackBar(
        message: "Please set password minimumn 8 char.",
      );
    } else {
      await loginApi();
    }
  }
}
