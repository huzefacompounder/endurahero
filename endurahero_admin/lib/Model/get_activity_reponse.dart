class GetActivityResponse {
  int? status;
  String? message;
  Data? data;
  bool? error;
  String? errShow;

  GetActivityResponse(
      {this.status, this.message, this.data, this.error, this.errShow});

  GetActivityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    errShow = json['errShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    data['errShow'] = errShow;
    return data;
  }
}

class Data {
  List<ActivityList>? activityList;

  Data({this.activityList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ActivityList'] != null) {
      activityList = <ActivityList>[];
      json['ActivityList'].forEach((v) {
        activityList!.add(ActivityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activityList != null) {
      data['ActivityList'] = activityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityList {
  String? sId;
  String? timestamp;
  String? username;
  String? rewardId;
  String? activityType;
  List<String>? joinedUsers;
  String? distance;
  String? route;
  String? duration;
  String? createdAt;
  int? iV;
  String? userId;
  String? role;
  String? activityId;

  ActivityList(
      {this.sId,
      this.timestamp,
      this.username,
      this.rewardId,
      this.activityType,
      this.joinedUsers,
      this.distance,
      this.route,
      this.duration,
      this.createdAt,
      this.iV,
      this.userId,
      this.role,
      this.activityId});

  ActivityList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    timestamp = json['timestamp'];
    username = json['username'];
    rewardId = json['rewardId'];
    activityType = json['activityType'];
    joinedUsers = json['joinedUsers'].cast<String>();
    distance = json['distance'];
    route = json['route'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    userId = json['userId'];
    role = json['role'];
    activityId = json['activityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['timestamp'] = timestamp;
    data['username'] = username;
    data['rewardId'] = rewardId;
    data['activityType'] = activityType;
    data['joinedUsers'] = joinedUsers;
    data['distance'] = distance;
    data['route'] = route;
    data['duration'] = duration;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['userId'] = userId;
    data['role'] = role;
    data['activityId'] = activityId;
    return data;
  }
}
