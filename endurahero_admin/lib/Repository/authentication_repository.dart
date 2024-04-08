import 'dart:developer';

import 'package:endurahero_admin/API/api_manager.dart';
import 'package:endurahero_admin/API/dio_api_manager.dart';
import 'package:endurahero_admin/Model/login_register_response.dart';
import 'package:endurahero_admin/Utils/strings.dart';

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
      isLoaderShow: false,
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
}
