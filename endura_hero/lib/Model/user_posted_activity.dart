class GetUserPostedActivityResponse {
  int? status;
  String? message;
  Data? data;
  bool? error;
  String? errShow;

  GetUserPostedActivityResponse(
      {this.status, this.message, this.data, this.error, this.errShow});

  GetUserPostedActivityResponse.fromJson(Map<String, dynamic> json) {
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
  List<UserPostedActivityList>? activityList;

  Data({this.activityList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ActivityList'] != null) {
      activityList = <UserPostedActivityList>[];
      json['ActivityList'].forEach((v) {
        activityList!.add(UserPostedActivityList.fromJson(v));
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

class UserPostedActivityList {
  String? sId;
  String? timestamp;
  String? username;
  String? userId;
  String? rewardId;
  String? activityType;
  String? profileImage;
  // List<Null>? joinedUsers;
  // List<Null>? likedByUsers;
  // List<Null>? commentByUsers;
  int? distance;
  List<String>? route;
  int? duration;
  String? description;
  String? createdAt;
  int? iV;

  UserPostedActivityList.UserPostedActivityList(
      {this.sId,
      this.timestamp,
      this.username,
      this.userId,
      this.rewardId,
      this.activityType,
      this.profileImage,
      // this.joinedUsers,
      // this.likedByUsers,
      // this.commentByUsers,
      this.distance,
      this.route,
      this.duration,
      this.description,
      this.createdAt,
      this.iV});

  UserPostedActivityList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    timestamp = json['timestamp'];
    username = json['username'];
    userId = json['userId'];
    rewardId = json['rewardId'];
    activityType = json['activityType'];
    profileImage = json['profileImage'];
    // if (json['joinedUsers'] != null) {
    //   joinedUsers = <Null>[];
    //   json['joinedUsers'].forEach((v) {
    //     joinedUsers!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['likedByUsers'] != null) {
    //   likedByUsers = <Null>[];
    //   json['likedByUsers'].forEach((v) {
    //     likedByUsers!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['commentByUsers'] != null) {
    //   commentByUsers = <Null>[];
    //   json['commentByUsers'].forEach((v) {
    //     commentByUsers!.add(new Null.fromJson(v));
    //   });
    // }
    distance = json['distance'];
    route = json['route'].cast<String>();
    duration = json['duration'];
    description = json['description'];
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
    data['profileImage'] = profileImage;
    // if (this.joinedUsers != null) {
    //   data['joinedUsers'] = this.joinedUsers!.map((v) => v.toJson()).toList();
    // }
    // if (this.likedByUsers != null) {
    //   data['likedByUsers'] = this.likedByUsers!.map((v) => v.toJson()).toList();
    // }
    // if (this.commentByUsers != null) {
    //   data['commentByUsers'] =
    //       this.commentByUsers!.map((v) => v.toJson()).toList();
    // }
    data['distance'] = distance;
    data['route'] = route;
    data['duration'] = duration;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
