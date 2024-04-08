import 'package:endurahero_admin/API/api_manager.dart';
import 'package:endurahero_admin/API/dio_api_manager.dart';
import 'package:endurahero_admin/Model/error_model.dart';
import 'package:endurahero_admin/Model/get_activity_reponse.dart';
import 'package:endurahero_admin/Utils/strings.dart';

class ActivityRepository {
  final APIManager apiManager;
  final DioAPIManager dioAPIManager;

  ActivityRepository(this.apiManager, this.dioAPIManager);

  Future<GetActivityResponse> getAllActivity({bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
      isLoaderShow: false,
      url: '$developmentUrl/manageActivity/GetAllActivities',
    );

    var response = GetActivityResponse.fromJson(jsonData);
    return response;
  }

  Future<ErrorModel> addActivityApi({
    required String timestamp,
    // required String username,
    String? rewardId,
    required String activityType,
    required String distance,
    String? route,
    required String duration,
  }) async {
    var jsonData = await apiManager.postAPICall(
      url: '$developmentUrl/manageActivity/AddActivity',
      params: {
        "timestamp": timestamp,
        // "username": username,
        // "rewardId": rewardId,
        "activityType": activityType,
        "distance": distance,
        // "route": route,
        "duration": duration,
      },
    );

    var response = ErrorModel.fromJson(jsonData);
    return response;
  }
}
