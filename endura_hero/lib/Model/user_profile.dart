class UserProfileDataResponse {
  int? status;
  String? message;
  GetUserData? data;
  bool? error;

  UserProfileDataResponse({this.status, this.message, this.data, this.error});

  UserProfileDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetUserData.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class GetUserData {
  String? sId;
  String? username;
  String? email;
  String? password;
  String? role;
  List<String>? joinedActivities;
  bool? isVerified;
  bool? isDeactivated;
  String? createdAt;
  String? loggedAt;
  String? updatedAt;
  int? iV;
  String? otp;
  String? profileImage;
  List<String>? claimRewards;

  GetUserData(
      {this.sId,
      this.username,
      this.email,
      this.password,
      this.role,
      this.joinedActivities,
      this.isVerified,
      this.isDeactivated,
      this.createdAt,
      this.loggedAt,
      this.updatedAt,
      this.iV,
      this.otp,
      this.profileImage,
      this.claimRewards});

  GetUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    joinedActivities = json['joinedActivities'].cast<String>();
    isVerified = json['isVerified'];
    isDeactivated = json['isDeactivated'];
    createdAt = json['createdAt'];
    loggedAt = json['loggedAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    otp = json['otp'];
    profileImage = json['profileImage'];
    claimRewards = json['claimRewards'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['joinedActivities'] = joinedActivities;
    data['isVerified'] = isVerified;
    data['isDeactivated'] = isDeactivated;
    data['createdAt'] = createdAt;
    data['loggedAt'] = loggedAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    data['profileImage'] = profileImage;
    data['claimRewards'] = claimRewards;
    return data;
  }
}
