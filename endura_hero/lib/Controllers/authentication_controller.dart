import 'dart:developer';
import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/API/dio_api_manager.dart';
import 'package:endura_hero/Model/login_register_model.dart';
import 'package:endura_hero/Model/user_profile.dart';
import 'package:endura_hero/Repository/authentication_repository.dart';
import 'package:endura_hero/Routes/routes.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/application/error_model.dart';
import 'package:endura_hero/application/saved_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as d;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AuthController extends GetxController {
  final authenticationRepository =
      AuthenticationRepository(APIManager(), DioAPIManager());
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController registerLoginEmail = TextEditingController();
  TextEditingController registerLoginPassword = TextEditingController();
  TextEditingController registerLoginName = TextEditingController();
  TextEditingController txtEnterCodeController = TextEditingController();
  TextEditingController profileName = TextEditingController();
  TextEditingController profileEmail = TextEditingController();
  var currentUserData = GetUserData().obs;
  var profileImagePath = ''.obs;
  final ImagePicker imagePicker = ImagePicker();
  var profileFetchImg = "".obs;

  RxBool isVisiblePassword = false.obs;
  RxString otpString = " ".obs;
  var context = Get.context;
  RxInt index = 1.obs;

  setInitialData() {
    profileEmail.text =
        authController.currentUserData.value.email.toString().trim();
    profileName.text =
        authController.currentUserData.value.username.toString().trim();
    profileFetchImg.value =
        authController.currentUserData.value.profileImage.toString().trim();
  }
  // Register User //

  Future registerUser() async {
    LoginAndRegisterResponse registrationResponse =
        await authenticationRepository.registrationApi(
            email: registerLoginEmail.text,
            name: registerLoginName.text,
            password: registerLoginPassword.text);

    if (registrationResponse.status == 200) {
      storUserId(registrationResponse.data!.userId.toString());
      storeUserName(registrationResponse.data!.username.toString());
      Get.offNamed(Routes.otpScreen, arguments: [registerLoginEmail.text]);
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
    } else if (registerLoginPassword.text.length < 8) {
      errorSnackBar(
        message: "Please enter password minimum 8 char.",
      );
    } else {
      registerUser();
    }
  }

  // Login  API

  Future loginApi() async {
    LoginAndRegisterResponse loginModel = await authenticationRepository.login(
      email: loginEmail.text,
      password: loginPassword.text,
    );
    log("----------------->${loginModel.status}");
    if (loginModel.status == 200) {
      Get.offAndToNamed(Routes.landingScreen);
      successSnackBar(message: loginModel.message!);
      storUserId(loginModel.data!.userId.toString());
      storeUserName(loginModel.data!.username.toString());
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
    } else if (loginPassword.text.length < 8) {
      errorSnackBar(
        message: "Please set password minimumn 8 char.",
      );
    } else {
      await loginApi();
    }
  }

  // Login  API

  Future otpAPI(String email) async {
    LoginAndRegisterResponse otpVerify =
        await authenticationRepository.otpVerify(
      email: email,
      otp: txtEnterCodeController.text,
    );
    log("----------------->${otpVerify.status}");
    if (otpVerify.status == 200) {
      Get.offAllNamed(Routes.landingScreen);
      successSnackBar(message: otpVerify.message!);

      storeAuthToken(otpVerify.data!.token!.toString());
      log("==============>");
      log("==============>");
    } else {
      errorSnackBar(message: otpVerify.message!);
    }
  }

  Future getProfileData() async {
    var userId = getUserId();
    UserProfileDataResponse userprofileData =
        await authenticationRepository.getUserprofile(
      userId: userId,
    );
    if (userprofileData.status == 200) {
      // storeUserProfileImage(userprofileData.data!.profileImage!);

      currentUserData.value = userprofileData.data!;
      await GetStorage().write(
        currUserData,
        userprofileData.data!.toJson(),
      );
      // successSnackBar(message: getUserDetailsResponse.message!);
    } else {
      // errorSnackBar(message: getUserDetailsResponse.message!);z
    }
  }

  updateProfileAPI() async {
    // showProgressIndicator();
    var userID = getUserId();

    var data = d.FormData.fromMap(
      {
        "userId": userID,
        "username": profileName.text,
        "profileImage": await d.MultipartFile.fromFile(
          profileImagePath.value,
          filename: profileImagePath.value,
          contentType: MediaType("image", "jpg"),
        ),
      },
    );

    d.Dio dio = d.Dio();

    d.Response response = await dio.post(
      '$baseUrl/userProfileUpdate',
      data: data,
      options: d.Options(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
        },
      ),
    );
    ErrorModel getProfile = ErrorModel.fromJson(response.data);

    if (getProfile.status == 200) {
      Get.back();
      // GetUserData();
      await getProfileData();
      successSnackBar(message: getProfile.message.toString());
    }
  }

  Future getImageFromGallery(
    RxString pathValue,
  ) async {
    var image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      pathValue.value = image.path;
      storeUserProfileImage(image.path);
    }
  }
  //     },
  //   );
  // }

  /// Get Profile picture from camera

  Future getImageFromCamera(
    RxString cameraPathValue,
  ) async {
    // await PermissionHandlerPermissionService.handleCameraPermission(context!)
    //     .then(
    //   (bool storagePermission) async {
    //     if (storagePermission == true) {
    var image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      cameraPathValue.value = image.path;
      storeUserProfileImage(image.path);
    }
  }

  imageSourceSelectionDialog({
    required RxString path,
  }) {
    return showDialog(
      context: context!,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: const BoxDecoration(
              color: Const.kWhite,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(1.5.h),
                  child: Column(
                    children: [
                      Text(
                        "Select Image Source",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 2.5.h),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: Const.kBlack,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 2.h, left: 2.h),
                        decoration: BoxDecoration(
                            color: const Color(0xff053C5E),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  getImageFromGallery(
                                    path,
                                  );
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(0.8.h),
                                  height: 14.0.h,
                                  decoration: BoxDecoration(
                                    color: Const.kWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.photo_camera_back,
                                    size: 5.h,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  getImageFromCamera(
                                    path,
                                  );
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                    margin: EdgeInsets.all(0.8.h),
                                    height: 14.0.h,
                                    decoration: BoxDecoration(
                                      color: Const.kWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 5.h,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
