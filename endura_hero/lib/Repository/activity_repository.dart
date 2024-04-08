import 'package:endura_hero/API/api_manager.dart';
import 'package:endura_hero/API/dio_api_manager.dart';
import 'package:endura_hero/Model/get_activity_reponse.dart';
import 'package:endura_hero/Model/user_posted_activity.dart';
import 'package:endura_hero/application/api_strings.dart';
import 'package:endura_hero/application/error_model.dart';

class ActivityRepository {
  final APIManager apiManager;
  final DioAPIManager dioAPIManager;

  ActivityRepository(this.apiManager, this.dioAPIManager);

  Future<GetActivityResponse> getAllActivity({bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
      isLoaderShow: true,
      url: '$developmentUrl/manageActivity/GetAllActivities',
    );

    var response = GetActivityResponse.fromJson(jsonData);
    return response;
  }

  Future<GetUserPostedActivityResponse> getUserPostedActivity(
      {bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
      isLoaderShow: true,
      url: '$developmentUrl/activity/GetAllActivities',
    );

    var response = GetUserPostedActivityResponse.fromJson(jsonData);
    return response;
  }

  Future<ErrorModel> addActivityApi({
    String? rewardId,
    required String activityType,
    required String distance,
    String? route,
    required String duration,
    String? description,
  }) async {
    DateTime currentDate = DateTime.now();
    String formattedDate =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    var jsonData = await apiManager.postAPICall(
      isLoaderShow: true,
      url: '$developmentUrl/activity/AddActivity',
      params: {
        "timestamp": formattedDate,
        "activityType": activityType,
        "distance": distance,
        "duration": duration,
        "description": description,
      },
    );

    var response = ErrorModel.fromJson(jsonData);
    return response;
  }
}
