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
  String? userId;
  String? rewardId;
  String? activityType;
  // List<Null>? joinedUsers;
  int? distance;
  String? route;
  int? duration;
  String? createdAt;
  int? iV;

  ActivityList(
      {this.sId,
      this.timestamp,
      this.username,
      this.userId,
      this.rewardId,
      this.activityType,
      // this.joinedUsers,
      this.distance,
      this.route,
      this.duration,
      this.createdAt,
      this.iV});

  ActivityList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    timestamp = json['timestamp'];
    username = json['username'];
    userId = json['userId'];
    rewardId = json['rewardId'];
    activityType = json['activityType'];
    // if (json['joinedUsers'] != null) {
    //   joinedUsers = <Null>[];
    //   json['joinedUsers'].forEach((v) {
    //     joinedUsers!.add(new Null.fromJson(v));
    //   });
    // }
    distance = json['distance'];
    route = json['route'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['timestamp'] = timestamp;
    data['username'] = username;
    data['userId'] = userId;
    data['rewardId'] = rewardId;
    data['activityType'] = activityType;
    // if (this.joinedUsers != null) {
    //   data['joinedUsers'] = this.joinedUsers!.map((v) => v.toJson()).toList();
    // }
    data['distance'] = distance;
    data['route'] = route;
    data['duration'] = duration;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
