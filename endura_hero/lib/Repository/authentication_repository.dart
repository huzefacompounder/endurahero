import 'dart:developer';

import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/API/dio_api_manager.dart';
import 'package:endura_hero/Model/login_register_model.dart';
import 'package:endura_hero/Model/user_profile.dart';
import 'package:endura_hero/application/api_strings.dart';

class AuthenticationRepository {
  final APIManager apiManager;
  final DioAPIManager dioAPIManager;

  AuthenticationRepository(this.apiManager, this.dioAPIManager);

  // // Register api calling
  Future<LoginAndRegisterResponse> registrationApi(
      {required String name,
      required String email,
      required String password,
      bool isLoaderShow = true}) async {
    var jsonData = await apiManager.postAPICall(
      isLoaderShow: isLoaderShow,
      url: '$baseUrl/register',
      params: {
        "username": name,
        "email": email,
        "password": password,
      },
    );

    var response = LoginAndRegisterResponse.fromJson(jsonData);
    return response;
  }

  // Login api calling

  Future<LoginAndRegisterResponse> login({
    required String email,
    required String password,
  }) async {
    var jsonData = await apiManager.postAPICall(
      isLoaderShow: true,
      url: '$baseUrl/login',
      params: {
        "emailOrUsername": email,
        "password": password,
      },
    );

    var response = LoginAndRegisterResponse.fromJson(jsonData);
    log("$response");
    return response;
  }
  // Login api calling

  Future<LoginAndRegisterResponse> otpVerify({
    required String email,
    required String otp,
  }) async {
    var jsonData = await apiManager.postAPICall(
      isLoaderShow: true,
      url: '$baseUrl/verify-otp',
      params: {
        "email": email,
        "otp": otp,
      },
    );

    var response = LoginAndRegisterResponse.fromJson(jsonData);
    log("$response");
    return response;
  }

  Future<UserProfileDataResponse> getUserprofile({
    required String userId,
  }) async {
    var jsonData = await apiManager.postAPICall(
      isLoaderShow: true,
      url: '$baseUrl/getUserProfile',
      params: {
        "userId": userId,
      },
    );

    var response = UserProfileDataResponse.fromJson(jsonData);
    log("$response");
    return response;
  }
}
