// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:endura_hero/Controllers/authentication_controller.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/constants.dart';
import 'package:endura_hero/application/saved_variable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/error_model.dart';
import 'api_exception.dart';

AuthController authController = Get.put(AuthController());

class APIManager {
  // Used to call get API method, pass the url for api call
  Future<dynamic> getAPICall(
      {required String url, bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");

    try {
      // Show progress loader
      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      // Set header for send request
      var headers = GetStorage().read(userName) == null
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [GET API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------>');
      responseJson = _response(response);
    } on SocketException {
      // Show error message on SocketException
      Get.showSnackbar(errorSnackBar(message: 'No Internet Connection'));
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      // Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      // Hide progress loader
      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  // Used to call post API method, pass the url and param for api call
  Future<dynamic> postAPICall(
      {required String url,
      required Map params,
      bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");
    print("[Calling parameters] => $params");

    try {
      // Show progress loader
      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      // Set header for send request
      var username = getUserName();
      var headers = username == null
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: json.encode(params),
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [POST API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------->');
      responseJson = _response(response);
    } on SocketException {
      // Show error message on SocketException
      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      // Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      // Hide progress loader
      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  // Used to call put API method, pass the url for api call
  Future<dynamic> putAPICall(
      {required String url, bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");

    try {
      // Show progress loader
      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      // Set header for send request
      var headers = GetStorage().read(userName) == null
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [PUT API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------>');
      responseJson = _response(response);
    } on SocketException {
      // Show error message on TimeoutException
      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      // Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      // Hide progress loader
      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  // Used to call put with param API method, pass the url and param for api call
  Future<dynamic> putAPICallWithParam(
      {required String url,
      required Map params,
      bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");
    print("[Calling parameters] => $params");

    try {
      // Show progress loader
      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      // Set header for send request
      var headers = GetStorage().read(userName) == null
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
            body: json.encode(params),
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [PUT API WITH PARAM RESPONSE] -------------------->");
      log(response.body);
      log('<----------------------------------------------------------------------->');
      responseJson = _response(response);
    } on SocketException {
      // Show error message on TimeoutException
      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      // Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      // Hide progress loader
      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  // Used to call delete API method, pass the url for api call
  Future<dynamic> deleteAPICall(
      {required String url, bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");
    try {
      // Show progress loader
      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      // Set header for send request
      var headers = GetStorage().read(userName) == null
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [DELETE API RESPONSE] -------------------->");
      log(response.body);
      log('<--------------------------------------------------------------->');
      responseJson = _response(response);
    } on SocketException {
      // Show error message on SocketException
      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No internet connection');
    } on TimeoutException catch (_) {
      // Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      // Hide progress loader
      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  // Check response status and handle exception
  dynamic _response(http.Response response) async {
    switch (response.statusCode) {
      // Successfully get api response
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;

      // Bad request need to check url

      case 400:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(response.body)).message,
        );

      // /// if token expire
      // case 401:
      //   LoginModel loginResponseModel= LoginModel.fromJson(GetStorage().read(userName));
      //   var jsonData=await postAPICall(
      //     '${baseUrl}account/session/extend',
      //     {
      //       "refreshToken": loginResponseModel.data!.refreshToken
      //     },
      //   );
      //
      //   RefreshTokenModel refreshTokenModel = RefreshTokenModel.fromJson(jsonData);
      //   return refreshTokenModel;

      // Authorisation token invalid
      case 403:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(response.body)).message,
        );

      // Error occured while Communication with Server
      case 500:
      default:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw FetchDataException(
          'An error occured while communication with server with status code: ${response.statusCode}',
        );
    }
  }
}
